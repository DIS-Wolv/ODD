/*
* Auteur : Wolv & Hhaine
* Fonction pour créer un civil en patrouille véhiculée
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
private _group = selectRandom ODD_var_CivilianVehicles;

_road = position selectrandom (_pos nearRoads 600);
// spawn le groupe
private _g = [_road, civilian, _group] call BIS_fnc_spawngroup;
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

_g setSpeedMode "LIMITED";
{
	_x setVariable ["ODD_var_ZOM", True, True];
} forEach (units _g);
//_g addItemCargoGlobal ["Toolkit", 1]; 
[_g] spawn ODDadvanced_fnc_patrolZoM;

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
