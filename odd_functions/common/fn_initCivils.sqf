/*
* Auteur : Hhaine, Wolv
* Fonction pour choisir le nombre et la composition des civils
*
* Arguments :
* 0: Localités en zo <array>
*
* Valeur renvoyée :
* <ARRAY> [patrouille, garnisons, véhicules]
*
* Exemple:
* [_zo] call ODDcommon_fnc_initCivils
* [_zo, True, False] call ODDcommon_fnc_initCivils
* Variable publique :
*/

params ["_loc"];
private _loctype = 0;
private _nbCivil = 1;
private _garCivil = 1;
private _vlCivil = 0;
private _Buildings = nearestobjects [position _loc, ODD_var_Houses, size _loc select 0];
// Nombre de maisons dans la localité

switch (type _loc) do {		//['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
	case (ODD_var_LocationType select 5): {_loctype = 0;};
	case (ODD_var_LocationType select 4): {_loctype = 1;};
	case (ODD_var_LocationType select 3): {_loctype = 2;};
	case (ODD_var_LocationType select 2): {_loctype = 3;};
	case (ODD_var_LocationType select 1): {_loctype = 4;};
	case (ODD_var_LocationType select 0): {_loctype = 5;};
};

{
	if (_x in ODD_var_LocationMilitaryName) then {
		_locType = 10;
	};
}forEach ((text _loc) splitstring " ");

switch (_loctype) do {
	case (10): {
		_nbCivil = 0;
		_garCivil = 0;
		_vlCivil = 0;
	};
	case (5): {
		_nbCivil = _nbCivil + (count _Buildings) / 34;
		_garCivil = _garCivil + (count _Buildings) / 38;
		_vlCivil = _vlCivil + (count _Buildings) / 82;
	};
	case (4): {
		_nbCivil = (_nbCivil + (count _Buildings) / 22) min 11;
		_garCivil = (_garCivil + (count _Buildings) / 30) min 10;
		_vlCivil = (_vlCivil + (count _Buildings) / 50) min 3;
	};
	case (3): {
		_nbCivil = (_nbCivil + (count _Buildings) / 14) min 14;
		_garCivil = (_garCivil + (count _Buildings)/ 16) min 11;
		_vlCivil = (_vlCivil + (count _Buildings)/ 24) min 4;
	};
	case (2): {
		_nbCivil = _nbCivil + (count _Buildings) / 12;
		_garCivil = _garCivil + (count _Buildings) / 15;
		private _action = random 2;
		if (_action > 1) then {
			_vlCivil = _vlCivil + (count _Buildings) / 15;
		} else {
			_vlCivil = 0;
		};
	};
	case (1): {
		_nbCivil = _nbCivil + (count _Buildings) / 10;
		_garCivil = _garCivil + (count _Buildings) / 10;
		if (_action > 1) then {
			_vlCivil = _vlCivil + (count _Buildings) / 15;
		} else {
			_vlCivil = 0;
		};
	};
};

_nbCivil = round _nbCivil;
_garCivil = round _garCivil;
_vlCivil = round _vlCivil;

[_nbCivil,_garCivil,_vlCivil];