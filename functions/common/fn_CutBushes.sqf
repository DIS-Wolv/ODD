/*
* Cut all bushes x m around the player.
*
* Arguments :
* 0: player
* 1: temps d'action
* 2: distance
* 3: Hide : True detruit les buissons, False "répare" les buissons
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
params ["_p", ["_temps", 5], ["_distance", 2], ["_state", True]];

if (isNil "DISCommon_var_DestroyObject") then {
	[{
		if (isNil "DISCommon_var_DestroyObject") then {
			DISCommon_var_DestroyObject = [];
		};
		publicVariable "DISCommon_var_DestroyObject";
	}] remoteExec ["call", 2];
};

if (_state) then {
	_args = [position _p, ["BUSH"], _distance];
	_objs = nearestTerrainObjects _args;

	[_temps, [_objs], {
		params ["_objs"];
		{
			[_x, 1] remoteExec ["setDamage", 2];
			DISCommon_var_DestroyObject pushBack _x;
		} forEach (_objs select 0);
		publicvariable "DISCommon_var_DestroyObject";
	}, {}] call ace_common_fnc_progressBar;
}
else {
	if (!isNil "DISCommon_var_DestroyObject") then {
		{
			[_x, 0] remoteExec ["setDamage", 2];
		} foreach DISCommon_var_DestroyObject;
		DISCommon_var_DestroyObject = [];
		publicvariable "DISCommon_var_DestroyObject";
	};
};
