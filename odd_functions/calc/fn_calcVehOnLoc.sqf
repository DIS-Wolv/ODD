/*
* Auteur : Wolv
* Fonction pour calculer le nombre d'ennemis dans une zone
*
* Arguments :
*	_zo : Zone (object)
* 
* Valeur renvoyée :
*	_vl : Nombre d'ennemis
*
* Exemple :
*	[_loc] call ODDCalc_fnc_calcVehOnLoc
*
* Variable publique :
* 
*/

params ["_zo"];
private _vl = 1;
private _typeModifier = 0;
private _proxModifier = 0;

private _Buildings = nearestObjects [position _zo, ODD_var_Houses, size _zo select 0];

_nbplayerModifier = 0;
// systemChat format ["_zo : %1", text _zo];
_typeZo = type _zo;
// systemChat format ["_typeZo : %1", _typeZo];
_vl = 1;
switch (_typeZo) do { //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
	case (ODD_var_LocationType select 5): {
		_typeModifier = 0.2;
	};
	case (ODD_var_LocationType select 4): {
		_typeModifier = 0.3;

	};
	case (ODD_var_LocationType select 3): {
		_typeModifier = 1;
	};
	case (ODD_var_LocationType select 2): {
		_typeModifier = 1.5;
	};
	case (ODD_var_LocationType select 1): {
		_typeModifier = 1;
	};
	case (ODD_var_LocationType select 0): {
		_typeModifier = 2;
	};
};
if ([_zo] call ODDCommon_fnc_isMillitary) then {
	_typeModifier = _typeModifier + 0.5;
};
_vl = _vl * (_typeModifier);
// systemChat format ["_vl : %1 * (%2 + %3 + %4)", _vl, _typeModifier, _nbplayerModifier];

private _prox = _zo getVariable ["ODD_var_nearLocations", []];
{
	switch (type _x) do {	//['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
		case (ODD_var_LocationType select 5): {_proxModifier = _proxModifier + 0.01;};
		case (ODD_var_LocationType select 4): {_proxModifier = _proxModifier + 0.025;};
		case (ODD_var_LocationType select 3): {_proxModifier = _proxModifier + 0.05;};
		case (ODD_var_LocationType select 2): {_proxModifier = _proxModifier + 0.1;};
		case (ODD_var_LocationType select 1): {_proxModifier = _proxModifier + 0.1;};
		case (ODD_var_LocationType select 0): {_proxModifier = _proxModifier + 0.2;};
	};
	if ([_x] call ODDCommon_fnc_isMillitary) then {
		_proxModifier = _proxModifier + 0.1;
	};
} forEach _prox;
_vl = _vl + _proxModifier;

// _marker = _zo getVariable ["ODD_var_marker", objNull];
// _marker setMarkerText format ["VL : %1 = (%2 + %3 + %4) + %5", _vl, _typeModifier, _nbplayerModifier, _proxModifier];
// _marker setMarkerText (str _vl);

_vl = round _vl;
_vl;

