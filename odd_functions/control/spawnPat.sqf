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
params ["_loc", ["_build", objNull]];

if (isNil "_loc") exitWith {[["Erreur ODDcontrol_fnc_spawnPat : Aucune localité spécifiée"]] call ODDcommon_fnc_log;};

// choix le group a faire spawn
private _groupClassName = selectRandom ODD_var_Pair;// ODD_var_Squad;

private _pos = getPos _loc;

// spawn le groupe
private _group = [_pos, resistance, _groupClassName] call BIS_fnc_spawngroup;

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
_group addEventHandler ["Empty", {
	params ["_group"];
	systemChat 'Empty eventHandler called.';
	private _loc = _group getVariable ["ODD_var_Loc", objNull];
	systemChat format ["%1 groupe %2", text _loc, groupID _group];
	private _patrolGroup = _loc getVariable ["ODD_var_PatrolGroup", []];
	
	// _patrolGroup = _patrolGroup - _group ca ca fonctionne pas je sais pas pk
	deleteGroup _group;
	_patrolGroup = _patrolGroup - [grpNull];
	_loc setVariable ["ODD_var_PatrolGroup", _patrolGroup, True];
	_patrolGroup = _loc getVariable ["ODD_var_PatrolGroup", []];

	systemChat format ["Patrol sur %1 : %2 (%3)", text _loc, count _patrolGroup, str _patrolGroup];

	// bascule des groupes de garnison en patrouille
	if ((count _patrolGroup) == 0) then {
		systemChat 'No more patrol group in the location.';
		// détermine le nombre de patrouille a créer
		private _garnison = _loc getVariable ["ODD_var_GarnisonGroup", []];
		private _countNewPatrol = 1 + floor random 2;
		_countNewPatrol = _countNewPatrol min (count _garnison);
		systemChat format ["Creating %1 new patrol group.", _countNewPatrol];

		// pour chaque patrouille a créer
		for "_i" from 1 to _countNewPatrol do {
			// choisi un groupe de garnison aléatoirement
			private _garnison = _loc getVariable ["ODD_var_GarnisonGroup", []];
			private _monGroup = selectRandom _garnison;
			_garnison = _garnison - [_monGroup];
			_loc setVariable ["ODD_var_GarnisonGroup", _garnison, True];
			
			// Ajout du groupe a la liste des patrouilles
			_loc setVariable ["ODD_var_PatrolGroup", ((_loc getVariable ["ODD_var_PatrolGroup", []]) + _monGroup), True];

			// le passe en patrouille
			[_monGroup] call compile preprocessFile "odd_functions\control\GarToPatrol.sqf";
		};
	};
}];

_group;
