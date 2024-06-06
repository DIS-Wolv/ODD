/*
* Auteur : Wolv
* Fonction pour spawn les patrouilles dans une localités
*
* Arguments :
* 0: Localité <Obj>
*
* Valeur renvoyée :
*
* Exemple:
* [_loc] call ODDcontrol_fnc_spawnPat;
*
*/
params ["_loc",["_pos", [0,0,0]]];

if (isNil "_loc") exitWith {[["Erreur ODDcontrol_fnc_spawnPat : Aucune localité spécifiée"]] call ODDcommon_fnc_log;};

// choix le group a faire spawn
private _groupClassName = selectRandom ODD_var_FireTeam;

if (_pos isEqualto [0,0,0]) then {
	_pos = getPos _loc;
};

// spawn le groupe
private _group = [_pos, east, _groupClassName] call BIS_fnc_spawngroup;

// donne les WP au groupe
[_group, _loc] call ODDcommon_fnc_patrolWaypoint;

// ajoute le groupe a la liste des patrouilles
_group setVariable ["ODD_var_Loc", _loc, True];

{
	private _id = _x addEventHandler["Killed", 
		{
			params ["_unit", "_killer"];
			[_unit, _killer] call ODDadvanced_fnc_surrender;
		}
	];
	_x setVariable ["ODD_var_SurrenderHandler", _id, True];
} forEach units _group;

// test pour sortir d'autre groupe de garnison vers patrouilles
_group addEventHandler ["Deleted", {
	params ["_group"];
	private _loc = _group getVariable ["ODD_var_Loc", objNull];

	private _patrolGroup = _loc getVariable ["ODD_var_PatrolGroup", []];
	// systemChat format ["Groups : %1", _patrolGroup];
	_patrolGroup = _patrolGroup - [_group] - [grpNull];
	// systemChat format ["Groups : %1", _patrolGroup];
	_loc setVariable ["ODD_var_PatrolGroup", _patrolGroup];

	// systemChat format ["Patrol sur %1 : %2 (%3)", text _loc, count _patrolGroup, str _patrolGroup];

	// bascule des groupes de garnison en patrouille
	if ((count _patrolGroup) == 0) then {
		[_loc] call compile preprocessFile "odd_functions\control\needPatrol.sqf";
		
	 };
}];

_group;
