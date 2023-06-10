{
    deleteMarker(_x);
}foreach allMapMarkers; 
private _zo = nearestLocations[position player, ['NameCityCapital','NameCity','NameVillage','Name','NameLocal','Hill'], 1000] select 0;

// variable globales
[] call ODDadvanced_fnc_varOutpost;


{
    deleteVehicle(_x);
} foreach nearestObjects [position _zo, keys ODD_var_outpost_batiments, 2000];


// debut func
// ### params
private _flavors = ["Medevac"];
private _pos = position _zo;
private _outpost_nb = 5;
// ### params



if ({ ! (_x in keys ODD_var_outpost_flavor) } count _flavors > 0) exitWith { systemChat "Error: invalid flavors"; };



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
			_centres insert [[_bat_name, _selected_flavors]];
		};
		case (ODD_var_outpost_bat_types get "cercle"): {
			_cercles insert [[_bat_name, _selected_flavors]];
			// une chance sur dix de prendre un batiment du centre pour faire des camps plus gros
			_centres insert [[_bat_name, _selected_flavors/10]];
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
private _batiments_proba = _batiments_proba_by_type_matching_flavor get "centre";
private _tot = 0;
{
	_tot = _tot + _y;
} forEach _batiments_proba;
systemChat str (_batiments_proba get "Land_Medevac_HQ_V1_F");
systemChat str _tot;
/**/


// systemChat str (["fortification"] call _random_batiment);


// /*
private _offset_angle = random 360;
for "_i" from 0 to _outpost_nb - 1 do {
	private _angle = ((_i * 360 / _outpost_nb) + _offset_angle) % 360;
	private _distance = 500;

	// rotation d'un angle et decalage de _distance
	private _p = _pos getPos [_distance, _angle];
	private _posOpPossible = selectBestPlaces [_p, 150, "meadow + hills - 2*forest - houses", 1, 5];

	private _posOp = (selectRandom _posOpPossible) select 0;

	// generation du camp :

	// # on cree le centre
	private _centre_batiment = (["centre"] call _random_batiment);
	// 	 on commence par update le centre avec une position ou on peut faire spawn le batiment
    private _new_posOp = _posOp findEmptyPosition [12, 150];
	if ((count _new_posOp) != 0) then {
		_posOp = _new_posOp;
		//   puis on cree le batiment
		private _centre_spawned_object = _centre_batiment createVehicle _posOp;
		_centre_spawned_object setDir random 360;

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
					//   puis on cree le batiment
					private _to_gen_spawned_object = _to_gen_batiment createVehicle _to_gen_pos;
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
		} forEach [["cercle", 20, floor random [2, 4, 8]], ["fortification", 30, floor random [4, 8, 10]]];

		// marker pour debug
		_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_posOp select 0), (_posOp select 1), (_posOp select 2)]), _posOp]; 
		_marker setMarkerType "hd_dot";
		_marker setMarkerColor "ColorBlack";
		_marker setMarkerText str _i;
	};
};
/**/
