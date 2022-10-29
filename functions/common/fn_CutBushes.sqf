/*
* Cut all bushes x m around the player.
*
* Arguments :
* 0: player
* 1: temps d'action
* 2: distance
*
* Valeur renvoyée :
* nil
*
* Exemple:
* [player] call cutbushes.sqf
*
* Variable publique :
* ODD_var_HiddenObjects
*/

// Récupère les arguments
params ["_p", ["_temps", 5], ["_distance", 2]];

_args = [position _p, ["BUSH"], _distance];
_objs = nearestTerrainObjects _args;

[_temps, [_objs], {
	params ["_objs"];
	if (isNil "ODD_var_HiddenObjects") then {
		ODD_var_HiddenObjects = [];
	};
	{
		_x hideObjectGlobal true;
		ODD_var_HiddenObjects pushBack _x;
	} forEach (_objs select 0);
	publicvariable "ODD_var_HiddenObjects";
}, {}] call ace_common_fnc_progressBar;
