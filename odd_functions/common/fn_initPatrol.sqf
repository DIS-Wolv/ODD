/*
* Auteur : Hhaine, Wolv
* Fonction pour calculer la réserve totale de patrouilles dans une zone
*
* Arguments :
* 0: Zone <Objet>
* 1: Est-ce la zone principale <BOOL>
* 2: Activation du débug dans le chat <BOOL>
*
* Valeur renvoyée :
* <ARRAY> [patrolPool, objActive]
*
* Exemple:
* [_zo] call ODDcommon_fnc_initPatrols
* [_zo, True, False] call ODDcommon_fnc_initPatrols
*
* Variable publique :
*/
params ["_zo", ["_obj", False]];

private _patrolPool = 4;
private _typeModifier = 0;
private _proxModifier = 0;
private _objModifier = 0;
private _batModifier = 0;

private _Buildings = nearestobjects [position _zo, ODD_var_Houses, size _zo select 0];

switch (type _zo) do { //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
	case (ODD_var_LocationType select 5): {
		_typeModifier = 3;
		_batModifier = (count buildings) / 5;
	};
	case (ODD_var_LocationType select 4): {
		_typeModifier = 3;
		_batModifier = (count buildings) / 5;
	};
	case (ODD_var_LocationType select 3): {
		_typeModifier = 5;
		_batModifier = (count buildings) / 10;
	};
	case (ODD_var_LocationType select 2): {
		_typeModifier = 7;
		_batModifier = (count buildings) / 20;
	};
	case (ODD_var_LocationType select 1): {
		_typeModifier = 7;
		_batModifier = (count buildings) / 20;
	};
	case (ODD_var_LocationType select 0): {
		_typeModifier = 10;
		_batModifier = (count buildings) / 50;
	};
};
_patrolPool = _patrolPool + _typeModifier + _batModifier;

private _prox = nearestLocations [position _zo, ODD_var_LocationType, 2000];
{
	switch (type _x) do {
		case (ODD_var_LocationType select 5): {_proxModifier = 1;};
		case (ODD_var_LocationType select 4): {_proxModifier = 2;};
		case (ODD_var_LocationType select 3): {_proxModifier = 4;};
		case (ODD_var_LocationType select 2): {_proxModifier = 6;};
		case (ODD_var_LocationType select 1): {_proxModifier = 6;};
		case (ODD_var_LocationType select 0): {_proxModifier = 8;};
	};
	_patrolPool = _patrolPool + _proxModifier;
} forEach _prox;

// Modif avec le nombre de batiments militaires

if (_obj == True) then {
	_objModifier = 3;
};
_patrolPool = _patrolPool + _objModifier; 
__patrolPool = round _patrolPool;

// private _randomizationFloor = 0;
// private _randomizationCeiling = 0;
// _randomizationFloor = random [floor (_patrolPool * 0.8),_patrolPool];
// _randomizationCeiling = random [_patrolPool, _patrolPool * 2];
// _patrolPool = random [_randomizationFloor,_patrolPool,_randomizationCeiling]; 

_patrolPool;
