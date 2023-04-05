/*
* Auteur : Wolv & Hhaine
* Fonction pour créer un civil en patrouille
*
* Arguments :
* 0: Hélipad attaché à la localité <Obj>
*
* Valeur renvoyée :
*
* Exemple:
* [_loc] call ODDcommon_fnc_civPatrol;
*
* Variable publique :
*/
params ["_loc"];
private _pos = position _loc;
private _zo = nearestLocation [_pos,""];
private _Buildings = nearestobjects [_pos, ODD_var_Houses, size _zo select 0];
private _group = selectRandom ODD_var_Civilians;

// choisi un batiment aléatoirement
private _GBuild = selectRandom _Buildings;
// spawn le groupe
private _g = [getPos _GBuild, civilian, _group] call BIS_fnc_spawngroup;
// ODD_var_MissionCivilians pushBack _g;

[
	((units _g)select 0), 
	"<t color='#FF0000'>interoger le civil</t>", 
	"\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa",
	"\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", 
	"(alive (_target)) and (_target distance _this < 3) and (lifeState _target != 'INCAPACITATED')", 
	"True",
	{
		[(_this select 0), "PATH"] remoteExec ["disableAI", 2];
		// (_this select 0) disableAI "PATH"
	}, 
	{},
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
		// (_this select 0) enableAI "PATH";

		[1, _target] remoteExec ["ODDadvanced_fnc_intel", 2, True];
		[(_this select 0)] remoteExec ["removeAllActions", 0, True];
	}, {
		// (_this select 0) enableAI "PATH";
		[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
	}, [], (random[2, 5, 10]), nil, True, False
] remoteExec ["BIS_fnc_holdActionAdd", 0, True];

[position ((units _g) select 0), nil, units _g, 100, 1, False, True] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
sleep 1;
[units _g] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf";

{
	_x addEventHandler ["FiredNear", {
		params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
		[_unit, _distance] spawn ODDadvanced_fnc_civiesCover;
	}];
	_x addEventHandler ["Hit", {
		params ["_unit", "_source", "_damage", "_instigator"];
		if (((side _instigator) == WEST) and ((side _unit) == CIVILIAN)) then {
			ODD_var_CivilianReputation = ODD_var_CivilianReputation - 1;
		};
	}];
}forEach units _g;
