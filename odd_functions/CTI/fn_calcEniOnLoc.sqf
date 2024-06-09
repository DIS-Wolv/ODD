/*
* Auteur : Wolv
* Fonction pour calculer le nombre d'ennemis dans une zone
*
* Arguments :
*	_zo : Zone (object)
* 
* Valeur renvoyée :
*	_enemies : Nombre d'ennemis
*
* Exemple :
*	
*
* Variable publique :
* 
*/

params ["_zo"];
private _enemies = 4;
private _typeModifier = 0;
private _proxModifier = 0;
private _batModifier = 0;
private _nbplayer = 9;

private _Buildings = nearestObjects [position _zo, ODD_var_Houses, size _zo select 0];

_nbplayerModifier = 0;
// systemChat format ["_zo : %1", text _zo];
_typeZo = type _zo;
// systemChat format ["_typeZo : %1", _typeZo];
_enemies = 1;
switch (_typeZo) do { //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
	case (ODD_var_LocationType select 5): {
		_typeModifier = 1;
		_batModifier = (count _Buildings) / 8;
		_nbplayerModifier = _nbplayer / 7;
	};
	case (ODD_var_LocationType select 4): {
		_typeModifier = 1;
		_batModifier = (count _Buildings) / 14;
		_nbplayerModifier = _nbplayer / 7;
	};
	case (ODD_var_LocationType select 3): {
		_typeModifier = 3;
		_batModifier = (count _Buildings) / 12;
		_nbplayerModifier = _nbplayer / 6;
	};
	case (ODD_var_LocationType select 2): {
		if ((count _Buildings) > 25) then {
			_typeModifier = 5;
			_batModifier = (count _Buildings) / 50;
			}
		else {
			_typeModifier = 4;
			_batModifier = (count _Buildings) / 20;
		};
		_nbplayerModifier = _nbplayer / 5;
	};
	case (ODD_var_LocationType select 1): {
		_typeModifier = 6;
		_batModifier = (count _Buildings) / 40;
		_nbplayerModifier = _nbplayer / 4;
	};
	case (ODD_var_LocationType select 0): {
		_typeModifier = 7;
		_batModifier = (count _Buildings) / 66;
		_nbplayerModifier = _nbplayer / 4;
	};
};
if ([_zo] call ODDCommon_fnc_isMillitary) then {
	_typeModifier = _typeModifier + 1;
	_batModifier = _batModifier + 0.5;
};
_enemies = _enemies * (_typeModifier + _batModifier + _nbplayerModifier);
// systemChat format ["_enemies : %1 * (%2 + %3 + %4)", _enemies, _typeModifier, _batModifier, _nbplayerModifier];

private _prox = _zo getVariable ["ODD_var_nearLocations", []];
{
	switch (type _x) do {	//['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
		case (ODD_var_LocationType select 5): {_proxModifier = 0.2;};
		case (ODD_var_LocationType select 4): {_proxModifier = 0.5;};
		case (ODD_var_LocationType select 3): {_proxModifier = 0.6;};
		case (ODD_var_LocationType select 2): {_proxModifier = 1;};
		case (ODD_var_LocationType select 1): {_proxModifier = 1.2;};
		case (ODD_var_LocationType select 0): {_proxModifier = 2;};
	};
	if ([_x] call ODDCommon_fnc_isMillitary) then {
		_proxModifier = _proxModifier + 0.2;
	};
	_enemies = _enemies + _proxModifier;
} forEach _prox;

_enemies = round _enemies;
_enemies;

