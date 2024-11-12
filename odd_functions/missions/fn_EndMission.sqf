/*
* Auteur : Wolv
* Fonction pour spawn une missions de convois humanitaire
*
* Arguments :
*   _missionID : ID de la mission (int)
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call ODDMIS_fnc_EndMission;
*
* Variable publique :
* 
*/

params ["_missionID", ["_succes", true]];

private _taskName = Format["ODD_Task_%1",_missionID];

// on termine la mission
if (_succes) then {
    [_taskName, "SUCCEEDED", true] call BIS_fnc_taskSetState;
} else {
    [_taskName, "FAILED", true] call BIS_fnc_taskSetState;
};


// on récupère les données de la mission
private _missionData = ODD_var_ActiveMissions get _missionID;

// on attend un peu
uisleep 10;

// on supprime les taches
private _SubTasks = _taskName call BIS_fnc_taskChildren;
{
    [_x, true, true] call BIS_fnc_deleteTask;
} forEach _SubTasks;
[_taskName, true, true] call BIS_fnc_deleteTask;
// systemChat "test2";


// on supprime les données de la mission
ODD_var_ActiveMissions deleteAt _missionID;

