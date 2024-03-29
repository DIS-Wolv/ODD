/*
* Auteur : QuentinN42
* Fonction pour créer un camps pas loin de la position demande
*
* Arguments :
* 0: Zone objectif <position>
* 1: Flavors (cf. fn_varOutpost.sqf) <Liste de str>
*
* Valeur renvoyée :
* position du camp ou [] si erreur
*
* Exemple :
private _created = [position player] call ODDadvanced_fnc_createOutpostAtPos;
if (_created) {
	systemChat "Created.";
} else {
	systemChat "Unable to find a position to spawn the outpost.";
};
*/
params ["_pos", ["_flavors", []]];

// Config
private _radius_cercle = 20;
private _radius_fortification = 25;


/*
 *
 *
 *
 *  I. Preparation des variables, initialisation etc...
 *
 *
 *
 */



// # Validate params and prepare variables
if ({ ! (_x in keys ODD_var_outpost_flavor) } count _flavors > 0) exitWith { systemChat "Error: invalid flavors"; [] };

private _batiments_proba_by_type_matching_flavor = createHashMap;
{_batiments_proba_by_type_matching_flavor set [_x, createHashMap]} forEach keys ODD_var_outpost_bat_types;
{
	private _bat_name = _x;
	private _bat_flavors = _y getOrDefault ["flavor", createHashMap];
	private _selected_flavors = 0;
	private _got_flavors = false;
	private _bat_type = _y get "type";

	// extract flavors for this run
	{
		private _flavor_value = _bat_flavors getOrDefault [(ODD_var_outpost_flavor get _x), -1];
		if (_flavor_value == -1) then {continue;};
		_got_flavors = true;
		_selected_flavors = _selected_flavors + _flavor_value;
	} forEach _flavors;
	// handle default : no flavor matched
	if (!_got_flavors) then {
		_selected_flavors = _bat_flavors getOrDefault [(ODD_var_outpost_flavor get "default"), 1];
	};

	// flavor ponderation depending on bat type
	// this code is cursed, need copy hashmaps to put them after, f*** sqf
	private _centres = _batiments_proba_by_type_matching_flavor get "centre";
	private _cercles = _batiments_proba_by_type_matching_flavor get "cercle";
	private _fortifications = _batiments_proba_by_type_matching_flavor get "fortification";
	switch (_bat_type) do
	{
		case (ODD_var_outpost_bat_types get "centre"): {
			// une chance sur dix de prendre un batiment du centre pour faire des camps plus gros
			_centres insert [[_bat_name, _selected_flavors]];
			_cercles insert [[_bat_name, _selected_flavors/20]];
		};
		case (ODD_var_outpost_bat_types get "cercle"): {
			_cercles insert [[_bat_name, _selected_flavors]];
		};
		case (ODD_var_outpost_bat_types get "fortification"): {
			_fortifications insert [[_bat_name, _selected_flavors]];
		};
		default { systemChat format ["_bat_type '%1' Unknown", _bat_type] };
	};
	_batiments_proba_by_type_matching_flavor set ["centre", _centres];
	_batiments_proba_by_type_matching_flavor set ["cercle", _cercles];
	_batiments_proba_by_type_matching_flavor set ["fortification", _fortifications];
} forEach ODD_var_outpost_batiments;


private _random_batiment = {
	params ["_t"];
	private _batiments_proba = (_batiments_proba_by_type_matching_flavor get _t) toArray params ["_keys", "_values"];
	private _batiments = _batiments_proba select 0;
	private _probas = _batiments_proba select 1;
	private _res = _batiments selectRandomWeighted _probas;
	_res
};



/*
 *
 *
 *
 *  II. Generation des batiments
 *
 *
 *
 */


// # on cree le centre
// 	 on commence par update le centre avec une position ou on peut faire spawn le batiment
private _posOp = _pos findEmptyPosition [12, 150];


if ((count _posOp) == 0) exitWith { [] };

// If we are too close to a road, we dont create the camp
// This will be retried by fn_createOutpostsAroundZo.sqf
private _routes_trop_proches = _posOp nearRoads (_radius_cercle * 2);
if ((count _routes_trop_proches) > 0) exitWith { [] };

// marker pour debug
// _marker = createMarker [(format ["obj P x %1, y %2, z %3", (_posOp select 0), (_posOp select 1), (_posOp select 2)]), _posOp]; 
// _marker setMarkerType "hd_dot";
// _marker setMarkerColor "ColorBlack";
// _marker setMarkerText str _flavors;

private _centre_batiment = (["centre"] call _random_batiment);
//   puis on cree le batiment
private _centre_spawned_object = _centre_batiment createVehicle _posOp;
ODD_var_MissionProps pushBack _centre_spawned_object;

// On l'oriente
private _angle = 0;
private _centre_orientation = (ODD_var_outpost_batiments getOrDefault [_centre_batiment, createHashMap])  getOrDefault ["orientation", -1];
if (_centre_orientation == -1) then {
	_angle = random 360;
} else {
	// Si il y a des routes un peu loin on oriente le camps vers elles
	private _routes_proches = _posOp nearRoads (_radius_fortification * 3);
	if ((count _routes_proches) > 0) then {
		private _distances = _routes_proches apply { _x distance2D _posOp };
		private _d_max = selectMax _distances;
		private _poids = _distances apply { ((_d_max - _x)/_d_max)^2 };
		private _route = _routes_proches selectRandomWeighted _poids;
		// orientation = orentation avec le centre et l'ofset
		private _orientation_avec_le_centre = _route getDir _centre_spawned_object;
		_angle = (_orientation_avec_le_centre + _centre_orientation) % 360;
	} else {
		_angle = random 360;
	};
};
_centre_spawned_object setDir _angle;

{
	private _type = _x select 0;
	private _distance = _x select 1;
	private _to_gen_nb = _x select 2;
	// # on cree les elements
	for "_i" from 0 to _to_gen_nb - 1 do {
		// On choisit un batiment
		private _to_gen_batiment = ([_type] call _random_batiment);
		private _to_gen_orientation = (ODD_var_outpost_batiments getOrDefault [_to_gen_batiment, createHashMap])  getOrDefault ["orientation", -1];

		// on lui trouve une position
		private _to_gen_pos = _posOp getPos [_distance, _i * 360 / _to_gen_nb];
		_to_gen_pos = _to_gen_pos findEmptyPosition [10, 50];
		if ((count _to_gen_pos) != 0) then {
			// si le batiment est trop loin, on skip ce batiment
			if ((_to_gen_pos distance2D _posOp) < _radius_fortification * 1.5) then {
				// si il y a une route pas loin, on skip ce batiment
				if ((count (_to_gen_pos nearRoads 5)) == 0) then {
					// puis on cree le batiment
					private _to_gen_spawned_object = _to_gen_batiment createVehicle _to_gen_pos;
					ODD_var_MissionProps pushBack _to_gen_spawned_object;
					// et on l'oriente suivant ses config
					if (_to_gen_orientation == -1) then {
						// Random orientation
						_to_gen_spawned_object setDir random 360;
					} else {
						// orientation = orentation avec le centre et l'ofset + petit random
						private _petit_random = random [-10, 0, 10];
						private _orientation_avec_le_centre = _centre_spawned_object getDir _to_gen_spawned_object;
						_to_gen_spawned_object setDir (_petit_random + _orientation_avec_le_centre + _to_gen_orientation) % 360;
					};
				};
			};
		};
	};
} forEach [
	["cercle", _radius_cercle, floor random [2, 4, 8]],
	["fortification", _radius_fortification, floor random [4, 8, 10]]
];


// On definit cette zone comme un point d'interet
createGuardedPoint [east, _posOp, -1, objNull];


// Fin
_posOp
