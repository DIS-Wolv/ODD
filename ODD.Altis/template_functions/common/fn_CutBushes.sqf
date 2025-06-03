/*
* Auteur : Number42 & Wolv
* Cut all bushes x m around the player.
*
* Arguments :
* 0: player
*
* Exemple:
* [player] call DISCommon_fnc_CutBushes;      // Cut
* [nil, True] call DISCommon_fnc_CutBushes;   // Reset
*
* Variable publique :
* DISCommon_var_HiddenObject
* DISCommon_var_DestroyedObject
*/
params [["_p", nil], ["_reset", False]];

if (isNil "DISCommon_var_DestroyedObject") then {
	[{
		if (isNil "DISCommon_var_DestroyedObject") then {
			DISCommon_var_DestroyedObject = [];
		};
		publicVariable "DISCommon_var_DestroyedObject";
	}] remoteExec ["call", 2];
};
if (isNil "DISCommon_var_HiddenObject") then {
	[{
		if (isNil "DISCommon_var_HiddenObject") then {
			DISCommon_var_HiddenObject = [];
		};
		publicVariable "DISCommon_var_HiddenObject";
	}] remoteExec ["call", 2];
};

if (_reset) then {
	{
		[_x, False] remoteExec ["hideObjectGlobal", 2]
	} forEach DISCommon_var_HiddenObject;
	{
		[_x, 0] remoteExec ["setDamage", 2]
	} forEach DISCommon_var_DestroyedObject;
} else {
	private _distance = 3;
	private _args = [position _p, ["BUSH"], _distance];
	// Select only bushes that are not already destroyed
	private _objs = (nearestTerrainObjects _args) select {!(_x in DISCommon_var_HiddenObject)};;
	private _temps = 2 * (count _objs);
	[
		_temps,
		[_objs],
		{
			params ["_objs"];
			[_objs] spawn {
				params ["_objs"];
				{
					[_x, 1] remoteExec ["setDamage", 2];
					DISCommon_var_DestroyedObject pushBack _x;
				} forEach (_objs select 0);
				publicvariable "DISCommon_var_DestroyedObject";
				sleep 3;
				{
					[_x, True] remoteExec ["hideObjectGlobal", 2];
					DISCommon_var_HiddenObject pushBack _x;
				} forEach (_objs select 0);
				publicvariable "DISCommon_var_HiddenObject";
			};
		},
		{}
	] call ace_common_fnc_progressBar;
};
