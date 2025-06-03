/*
* Auteur : Wolv
* Fonction pour spawn une missions de contre attaque
*
* Arguments :
*   _missionID : ID de la mission (int)
*   _zoneID : ID de la zone (int)
*   _vagues : Type de véhicule (array) [_vagues1, _vagues2, _vagues3]
*   	_vague : Enemy present dans les vagues (array) [_group, _vlTerrestre, _vlAerien]
*   _notification : Notification (bool)
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call ODDMIS_fnc_buildCounterAttack;
*
* Variable publique :
* 
*/

params ["_missionID", "_zoneID", "_vagues", ["_notification",true]];


// On récupère la zone
private _zone = ODD_var_AllLocations select _zoneID;
private _objectifPosition = position _zone;

// On crée la tache
private _MainTaskName = Format["ODD_Task_%1",_missionID];
private _taskPos = _objectifPosition;
[True, _MainTaskName, ["Contre Attaque", "Contre Attaque", "Contre Attaque"], _taskPos, "CREATED", _missionID, _notification, "defend"] call BIS_fnc_taskCreate;

// on crée une array pour les subtask
private _subTaskList = [];
private _IdScriptVague = [];

// on choisie la direction de la contre attaque 
private _loc = ODD_var_AllLocations select _zoneID;
private _nearloc = [];
{
	if ((_x distance _loc < 5000) and ((_x getVariable ["ODD_var_isBlue", false]) == false)) then {
		_nearloc pushBack _x;
	};
} forEach ODD_var_AllLocations;

if (count _nearloc == 0) exitWith {["Aucune zone ennemie a proximité"] call ODDcommon_fnc_log;};

private _Attackloc = _nearloc select (floor random count _nearloc);
private _posFromAttack = position _Attackloc;
systemChat str (_Attackloc getVariable ["ODD_var_LocName",""]);

{
	// générer le noms des taches
	private _SubTaskName = Format["ODD_Task_%1_%2", _missionID, _forEachIndex];
	_subTaskList pushBack _SubTaskName;

	private _timmer = (_forEachindex * 180) + ((random 45) + 15);

	// spawn des différentes vagues, elle sont executé apres un timer
	private _thisVague = [_x, _posFromAttack, _taskPos, _missionID, _forEachIndex, _timmer] execVM 'odd_functions\missions\fn_createVagues.sqf';

	_IdScriptVague pushBack _thisVague;
} forEach _vagues;

private _MissionsData = createHashMap;
_MissionsData set ["id", _missionID];
_MissionsData set ["Type", "Contre Attaque"];
_MissionsData set ["zone", _zoneID];
_MissionsData set ["Vagues", _vagues];
_MissionsData set ["IdScriptVague", _IdScriptVague];
_MissionsData set ["taskPos", _taskPos];
_MissionsData set ["task", _MainTaskName];
_MissionsData set ["subTask", _subTaskList];

// On ajoute la mission à la liste
ODDMIS_var_ActiveMissions set [_missionID, _MissionsData];
