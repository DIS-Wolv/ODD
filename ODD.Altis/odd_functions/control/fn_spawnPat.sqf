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
_pos = ASLToATL _pos;

// spawn le groupe
private _group = [_pos, east, _groupClassName] call BIS_fnc_spawngroup;

// donne les WP au groupe
[_group, _loc] spawn ODDcommon_fnc_patrolWaypoint;

// ajoute le groupe a la liste des patrouilles
_group setVariable ["ODD_var_Loc", _loc, True];

{
	private _id = _x addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		[_unit, _killer] call ODDadvanced_fnc_surrender;
		private _aliveGroup = false;
		{
			if ((alive _x) and (!(_x getVariable ["ACE_isUnconscious", false]))) then {
				_aliveGroup = true;
			};
		} forEach units group _unit;
		if (!_aliveGroup) then {
			{
				private _id = _x getVariable ["ODD_var_KilledHandler", -1];
				if (_id != -1) then {
					_x removeEventHandler ["Killed", _id];
				};
				_x setDamage 1;
				[_x] join grpNull;
			} forEach units group _unit;
		};
	}];
	_x setVariable ["ODD_var_KilledHandler", _id, True];
	_x setVariable ["ODD_var_SurrenderHandler", _id, True];
} forEach units _group;

// test pour sortir d'autre groupe de garnison vers patrouilles
private _id = _group addEventHandler ["Deleted", {
	params ["_group"];
	private _loc = _group getVariable ["ODD_var_Loc", objNull];

	// si plus de patrouille, en recrée.
	private _patrolGroup = _loc getVariable ["ODD_var_OccPatrolGroup", []];
	_patrolGroup = _patrolGroup - [_group] - [grpNull];
	_loc setVariable ["ODD_var_OccPatrolGroup", _patrolGroup];

	// bascule des groupes de garnison en patrouille ou crée une nouvelle patrouille
	if ((count _patrolGroup) == 0) then {
		[_loc] call ODDControl_fnc_needPatrol;
		
	 };
}];

_group setVariable ["ODD_var_DeleteHandler", _id, True];

_group;
