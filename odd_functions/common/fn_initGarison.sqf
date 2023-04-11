/*
* Auteur : Hhaine, Wolv
* Fonction pour calculer la réserve totale de garisons dans une zone
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
* [_zo] call ODDcommon_fnc_initGarison
* [_zo, True, False] call ODDcommon_fnc_initGarison
*
* Variable publique :
*/
params ["_zo", ["_obj", False]];

private _garisonPool = 4;
private _typeModifier = 0;
private _proxModifier = 0;
private _objModifier = 0;
private _batModifier = 0;

private _Buildings = nearestObjects [position _zo, ODD_var_Houses, size _zo select 0];

switch (type _zo) do { //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
	case (ODD_var_LocationType select 5): {
		_typeModifier = 0;
		_batModifier = (count _Buildings) / 3;
	};
	case (ODD_var_LocationType select 4): {
		_typeModifier = 5;
		_batModifier = (count _Buildings) / 5;
	};
	case (ODD_var_LocationType select 3): {
		_typeModifier = 5;
		_batModifier = (count _Buildings) / 10;
	};
	case (ODD_var_LocationType select 2): {
		_typeModifier = 6;
		_batModifier = (count _Buildings) / 15;
	};
	case (ODD_var_LocationType select 1): {
		_typeModifier = 7;
		_batModifier = (count _Buildings) / 15;
	};
	case (ODD_var_LocationType select 0): {
		_typeModifier = 10;
		_batModifier = (count _Buildings) / 20;
	};
};
_garisonPool = _garisonPool + _typeModifier + _batModifier;

private _prox = nearestLocations [position _zo, ODD_var_LocationType, 2000];
{
	switch (type _x) do {
		case (ODD_var_LocationType select 5): {_proxModifier = 0;};
		case (ODD_var_LocationType select 4): {_proxModifier = 0.5;};
		case (ODD_var_LocationType select 3): {_proxModifier = 0.6;};
		case (ODD_var_LocationType select 2): {_proxModifier = 1;};
		case (ODD_var_LocationType select 1): {_proxModifier = 1.2;};
		case (ODD_var_LocationType select 0): {_proxModifier = 2;};
	};
	_garisonPool = _garisonPool + _proxModifier;
} forEach _prox;

// Modif avec le nombre de batiments militaires

if (_obj == True) then {
	_objModifier = 3;
};
_garisonPool = _garisonPool + _objModifier; 
_garisonPool = round _garisonPool;

// private _randomizationFloor = 0;
// private _randomizationCeiling = 0;
// _randomizationFloor = random [floor (_garisonPool * 0.8),_garisonPool];
// _randomizationCeiling = random [_garisonPool, _garisonPool * 2];
// _garisonPool = random [_randomizationFloor,_garisonPool,_randomizationCeiling]; 

//[_typeModifier,_batModifier,(_garisonPool - (_typeModifier + _batModifier + 4)),_garisonPool];
_garisonPool;
