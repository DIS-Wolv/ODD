/*
* Auteur : Hhaine, Wolv
* Fonction pour définir le type (composition de la force) sur une zone.
*
* Arguments :
* 0: Localité <Objet>
* 1: mod <int>
*
* Valeur renvoyée :
* <Array> [<int> type pour la zo, <bool> civils]
*
* [civils, pat, pat+vl, pat+garnison, pat+garnison+chkpt, pat+garnison+vl, pat+garnison+chkpt+vl]
*
* Exemple:
* [_zo] call ODDcommon_fnc_defineZo
*
* Variable publique :
*/

params [_loc, _mod];
private _zoType = 0;
private _civ = True;

private _loctype = 0;
switch (type _zo) do {
	case (ODD_var_LocationType select 5): {_loctype = 0;};
	case (ODD_var_LocationType select 4): {_loctype = 1;};
	case (ODD_var_LocationType select 3): {_loctype = 2;};
	case (ODD_var_LocationType select 2): {_loctype = 3;};
	case (ODD_var_LocationType select 1): {_loctype = 4;};
	case (ODD_var_LocationType select 0): {_loctype = 5;};
};

if (_zo in ODD_var_LocationMilitaryName) then {
	_locType = 10;
};

private _action = (random (100 - _mod)) + _mod;

if (_action < 0) then {
	_action = 0;
};

switch (_loctype) do {
	case (0): {		// hill
		if (_action <= 75) then {
			_mod = _mod - 1;
			_zoType = 0;
		};
		if (_action > 75 and _action <= 90) then {
			_mod = _mod + 1;
			_zoType = 1;
		};
		if (_action > 90) then {
			_mod = _mod + 1;
			_zoType = 2;
		};
	};
	case (1): {		// namelocal
		if (_action <= 65) then {
			_mod = _mod - 1;
			_zoType = 0;
		};
		if (_action > 65 and _action <= 75) then {
			_mod = _mod + 1;
			_zoType = 1;
		};
		if (_action > 75) then {
			_mod = _mod + 1;
			_zoType = 3;
		};
	};
	case (2): {		// name
		if (_action <= 45) then {
			_mod = _mod - 1;
			_zoType = 0;
		};
		if (_action > 45 and _action <= 50) then {
			_mod = _mod + 1;
			_zoType = 1;
		};
		if (_action > 50 and _action <= 75) then {
			_mod = _mod + 1;
			_zoType = 3;
		};
		if (_action > 75 and _action <= 90) then {
			_mod = _mod + 1;
			_zoType = 4;
		};
		if (_action > 90) then {
			_mod = _mod + 1;
			_zoType = 5;
		};
	};
	case (3): {		// nameVillage
		if (_action <= 40) then {
			_mod = _mod - 1;
			_zoType = 0;
		};
		if (_action > 40 and _action <= 50) then {
			_mod = _mod + 1;
			_zoType = 1;
		};
		if (_action > 50 and _action <= 70) then {
			_mod = _mod + 1;
			_zoType = 3;
		};
		if (_action > 70 and _action <= 90) then {
			_mod = _mod + 1;
			_zoType = 4;
		};
		if (_action > 90) then {
			_mod = _mod + 1;
			_zoType = 5;
		};
	};
	case (4): {		// nameCity
		if (_action <= 30) then {
			_mod = _mod - 1;
			_zoType = 0;
		};
		if (_action > 30 and _action <= 35) then {
			_mod = _mod + 1;
			_zoType = 1;
		};
		if (_action > 35 and _action <= 65) then {
			_mod = _mod + 1;
			_zoType = 3;
		};
		if (_action > 65 and _action <= 85) then {
			_mod = _mod + 1;
			_zoType = 4;
		};
		if (_action > 85) then {
			_mod = _mod + 1;
			_zoType = 5;
		};
	};
	case (5): {		// nameCityCapital
		if (_action <= 30) then {
			_mod = _mod - 1;
			_zoType = 0;
		};
		if (_action > 30 and _action <= 35) then {
			_mod = _mod + 1;
			_zoType = 1;
		};
		if (_action > 35 and _action <= 55) then {
			_mod = _mod + 1;
			_zoType = 3;
		};
		if (_action > 55 and _action <= 85) then {
			_mod = _mod + 1;
			_zoType = 4;
		};
		if (_action > 85 and _action <= 95) then {
			_mod = _mod + 1;
			_zoType = 5;
		};
		if (_action > 95) then {
			_mod = _mod + 1;
			_zoType = 6;
		};
	};
	case (10): {	// military
		if (_action <= 40) then {
			_mod = _mod - 1;
			_zoType = 0;
		};
		if (_action > 40 and _action <= 50) then {
			_mod = _mod + 1;
			_zoType = 7;
		};
		if (_action > 50 and _action <= 60) then {
			_mod = _mod + 1;
			_zoType = 3;
		};
		if (_action > 60 and _action <= 80) then {
			_mod = _mod + 1;
			_zoType = 4;
		};
		if (_action > 80) then {
			_mod = _mod + 1;
			_zoType = 5;
		};
	_civ = False;
	};
};

[_zoType,_civ,_mod];