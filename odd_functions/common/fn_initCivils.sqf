/*
* Auteur : Hhaine, Wolv
* Fonction pour choisir le nombre et la composition des civils
*
* Arguments :
* 0: Zone <Objet>
*
* Valeur renvoyée :
* <ARRAY> [patrouille, garnisons, véhicules]
*
* Exemple:
* [_zo] call ODDcommon_fnc_initPatrols
* [_zo, True, False] call ODDcommon_fnc_initPatrols
*
* Variable publique :
*/

params [_loc];
private _loctype = 0;
private _nbCivil = 0;
private _garCivil = 0;
private _vlCivil = 0;
private _Buildings = nearestobjects [position _loc, ODD_var_Houses, size _loc select 0];
// Nombre de maisons dans la localité

switch (type _loc) do {
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
		_nbCivil = (count _Buildings) / 24;
		_garCivil = (count _Buildings) / 32;
		_vlCivil = (count _Buildings) / 60;
	};
	case (4): {
		_nbCivil = (count _Buildings) / 25;
		_garCivil = (count _Buildings) / 30;
		_vlCivil = 2 max ((count _Buildings) / 40);
		};
	case (3): {
		_nbCivil = (count _Buildings) / 16;
		_garCivil = (count _Buildings)/ 18;
		_vlCivil = 1 max ((count _Buildings)/ 20);
		};
	case (2): {
		_nbCivil = (count _Buildings) / 12;
		_garCivil = (count _Buildings) / 15;
		_vlCivil = 1 max ((count _Buildings) / 15);
		};
	case (1): {
		_nbCivil = (count _Buildings) / 10;
		_garCivil = (count _Buildings) / 10;
		_vlCivil = 1 max ((count _Buildings) / 15);
		};
};

[_nbCivil,_garCivil,_vlCivil];