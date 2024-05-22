/*
* Auteur : Wolv
* Fonction pour transféré un groupe de garnison en patrouille
*
* Arguments :
* 0: Groupe <Obj>
*
* Valeur renvoyée :
*
* Exemple:
* [_group] call ODDcontrol_fnc_garToPatrol;
*
*/
params ["_group"];
systemChat "ODDcontrol_fnc_garToPatrol";

private _loc = _group getVariable ["ODD_var_Loc", objNull];
if (isNull _loc) exitWith {};

// active les HC sur les IAs
{
	_x setVariable ["acex_headless_blacklist", False, True]; // Whitelist l'unit des HC
} forEach (units _group);

// retire l'event handlers des grenade
{
	private _id = _x getVariable ["ODD_var_GrenadeHandler", -1];
	if (_id != -1) then {
		_x removeEventHandler ["Fired", _id];
	};
} forEach units _group;

// sort de la garnison 
[units _group] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf";

[_group, _loc] call ODDcommon_fnc_patrolWaypoint;

// met en patrouille le groupe
systemChat "+1 groupe en patrouille";
// [units _group, _loc] call ODDcontrol_fnc_patrol;

