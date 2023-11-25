/*
* Auteur : QuentinN42
* Fonction pour creer des maisons speciales.
*
* Arguments :
* 0: Zone <Objet>
* 1: Est-ce la zone principale <BOOL>
*
* Exemple:
* [_zo, True] call ODDcommon_fnc_initCustomBuildings
* [_zo, False] call ODDcommon_fnc_initCustomBuildings
*/
params ["_zo", ["_est_zo_principale", False]];

private _Buildings = nearestObjects [position _zo, ODD_var_Houses, size _zo select 0];

// Cree les caisses
private _nb_crates = floor((count _Buildings)/100);
if (random 1 < ((count _Buildings)/100 - floor((count _Buildings)/100))) then {
	_nb_crates = _nb_crates + 1;
};
if (_est_zo_principale) then {
	// Pas de caisse dans la zone principale pour ne pas confondre avec les caisses a detruire
	_nb_crates = 0;
};


private _selected_buildings = [];
private _selected_crates = [];
for "_i" from 1 to _nb_crates do {
	private _building = selectRandom _Buildings;
	while {_building in _selected_buildings} do {
		_building = selectRandom _Buildings;
	};
	private _crate_type = selectRandom ODD_var_CratesTypes;
	while {_crate_type in _selected_crates} do {
		_crate_type = selectRandom ODD_var_CratesTypes;
	};

	// Place une caisse
	_posBox = [position _building select 0, position _building select 1, (position _building select 2) + 2];
	_posBox set[2, 1];
	_box = _crate_type createvehicle _posBox;

	ODD_var_Crates pushBack _box;
	ODD_var_MissionProps pushBack _box;
};

_selected_buildings;
 