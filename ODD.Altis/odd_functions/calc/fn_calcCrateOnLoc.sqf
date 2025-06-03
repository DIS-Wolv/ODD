/*
* Auteur : Wolv
* Fonction pour calculer le nombre de caisses dans une zone
*
* Arguments :
*	_zo : Zone (object)
* 
* Valeur renvoyée :
*	_crates : Nombre de caisses
*   _cratesData : Tableau des caisses
*
* Exemple :
*	[_loc] call ODDCalc_fnc_calcCrateOnLoc
*
* Variable publique :
* 
*/

params ["_zo"];

private _Buildings = nearestObjects [position _zo, ODD_var_Houses, size _zo select 0];

private _nbCrates = floor((count _Buildings)/100);
if (random 1 < ((count _Buildings)/100 - floor((count _Buildings)/100))) then {
	_nbCrates = _nbCrates + 1;
};

private _crates = [];
private _cratesBuilding = [];
for "_i" from 1 to _nbCrates do {
	// choix du batiment
	private _building = selectRandom _Buildings;
	while {_building in _cratesBuilding} do {
		_building = selectRandom _Buildings;
	};
	_cratesBuilding pushBack _building;

	// choix du type de caisse
	private _crateType = selectRandom ODD_var_CratesTypes;

	// position de la caisse
	_cratePos = [position _building select 0, position _building select 1, (position _building select 2) + 2];
	_cratePos set[2, 1];

	private _maCrate = [_crateType, _cratePos];
	_crates pushBack _maCrate;
};


[_nbCrates, _crates]
