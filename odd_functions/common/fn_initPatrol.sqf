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

private _randomizationFloor = 0;
private _randomizationCeiling = 0;

switch (type _zo) do {
	case (ODD_var_LocationType select 5): {_typeModifier = 1;};
	case (ODD_var_LocationType select 4): {_typeModifier = 1;};
	case (ODD_var_LocationType select 3): {_typeModifier = 2;};
	case (ODD_var_LocationType select 2): {_typeModifier = 3;};
	case (ODD_var_LocationType select 1): {_typeModifier = 5;};
	case (ODD_var_LocationType select 0): {_typeModifier = 5;};
};
_patrolPool = _patrolPool + _typeModifier;

_prox = nearestLocations [position _zo, ODD_var_LocationType, 2000];
{
	switch (type _x) do {
		case (ODD_var_LocationType select 5): {_proxModifier = 0;};
		case (ODD_var_LocationType select 4): {_proxModifier = 0;};
		case (ODD_var_LocationType select 3): {_proxModifier = 1;};
		case (ODD_var_LocationType select 2): {_proxModifier = 1;};
		case (ODD_var_LocationType select 1): {_proxModifier = 2;};
		case (ODD_var_LocationType select 0): {_proxModifier = 4;};
	};
	_patrolPool = _patrolPool + _proxModifier;
} forEach _prox;

// Modif avec le nombre de batiments militaires

if (_obj == True) then {
	_objModifier = 3;
};
_patrolPool = _patrolPool + _objModifier; 


_randomizationFloor = random [floor (_patrolPool * 0.8),_patrolPool];
_randomizationCeiling = random [_patrolPool, _patrolPool * 2];

_patrolPool = random [_randomizationFloor,_patrolPool,_randomizationCeiling]; 

_patrolPool;
