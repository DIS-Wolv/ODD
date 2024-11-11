/*
* Auteur : Wolv
* Fonction pour spawn une missions de convois humanitaire
*
* Arguments :
*   _missionID : ID de la mission (int)
*   _zoneID : ID de la zone (int)
*   _vehiculeType : Type de véhicule (array)
*   _vehiculePos : Position des véhicules (array)
*   _vehiculeDir : Direction des véhicules (array)
*   _notification : Notification (bool)
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call ODDMIS_fnc_createBlue;
*
* Variable publique :
* 
*/

params ["_missionID", "_zoneID", "_vehiculeType", "_vehiculePos", "_vehiculeDir", ["_notification",true]];


// On récupère la zone
private _zone = ODD_var_AllLocations select _zoneID;
private _objectifPosition = position _zone;

// On crée la tache
private _MainTaskName = Format["ODD_Task_%1",_missionID];
private _taskPos = _objectifPosition;
[True, _MainTaskName, ["convoi Humanitaire", "convoi Humanitaire", "convoi Humanitaire"], _taskPos, "CREATED", _missionID, _notification, "box"] call BIS_fnc_taskCreate;
// on crée une array pour les subtask
private _subTaskList = [];

// On crée les véhicules
Private _vehiculeObj = [];
{
    // on récup les varriables 
    private _type = _x;
    private _pos = _vehiculePos select _forEachIndex;
    private _dir = _vehiculeDir select _forEachIndex;

    // On crée le véhicule
    private _MonVL = _type createVehicle _pos;
    _MonVL setDir _dir;

    // On ajoute le véhicule à la liste
    _vehiculeObj pushBack _MonVL;

	private _SubTaskName = Format["ODD_Task_%1_%2",_missionID, _forEachIndex];
	[True, [_SubTaskName, _MainTaskName], ["convoi Humanitaire", "convoi Humanitaire", "convoi Humanitaire"], _MonVL, "ASSIGNED", _missionID, false, "car"] call BIS_fnc_taskCreate;
	_subTaskList pushBack _SubTaskName;

	// On ajoute les variables au véhicule
	_MonVL setVariable ["ODDMIS_var_MissionID", _missionID];
	_MonVL setVariable ["ODDMIS_var_SubTaskID", _SubTaskName];
	_MonVL setVariable ["ODDMIS_var_MainTaskID", _MainTaskName];
	_MonVL setVariable ["ODDMIS_var_Destination", _zoneID];
	
	// création de l'event handler réussite de mission
	private _idEngine = _MonVL addEventHandler ["Engine", {
		params ["_vehicle", "_engineState"];
		// Quand on coupe le moteur
		if (!_engineState) then {
			private _Destination = _vehicle getVariable ["ODDMIS_var_Destination", -1];
			private _zoneDest = ODD_var_AllLocations select _Destination;
			private _objectifPosition = position _zoneDest;

			// On regarde si on est arrivé
			if (_vehicle distance2D _objectifPosition < 200) then {
				// on valide la livraison du véhicule
				private _SubTaskName = _vehicle getVariable ["ODDMIS_var_SubTaskID", ""];
				[_SubTaskName, "SUCCEEDED"] call BIS_fnc_taskSetState;

				private _MissionsID = _vehicle getVariable ["ODDMIS_var_MissionID", -1];

				// on enlève le véhicule de la liste des véhicules à arrivé
				private _missionData = ODD_var_ActiveMissions get [_MissionsID, []];
				private _ObjVehicule = _missionData getVariable ["vehicule", -1];
				_ObjVehicule = _ObjVehicule - [_vehicle];
				_missionData setVariable ["vehicule", _ObjVehicule];
				ODD_var_ActiveMissions set [_MissionsID, _missionData];


				// remove les event handler de destruction du véhicule, ...
				private _idEngine = _vehicle getVariable ["ODDMIS_var_idEngine", -1];
				private _idKilled = _vehicle getVariable ["ODDMIS_var_idKilled", -1];
				_vehicle removeEventHandler ["Engine", _idEngine];
				_vehicle removeEventHandler ["Killed", _idKilled];

				// On regarde si tout les véhicules sont arrivé
				// on récupère la tache principale
				private _MainTaskName = _vehicle getVariable ["ODDMIS_var_MainTaskID", "-1"];
				if (_MainTaskName == "-1") then {_MainTaskName = _SubTaskName call BIS_fnc_taskParent;};

				// on récupère les toutes les subtask
				private _SubTasks = _MainTaskName call BIS_fnc_taskChildren;

				// on regarde si toutes les subtask sont fini
				private _AllSubTask = true;
				{
					private _state = _x call BIS_fnc_taskState;
					if (!(_state == "SUCCEEDED" or _state == "FAILED")) then {
						_AllSubTask = false;
					};
				} forEach _SubTasks;

				// si toutes les subtask sont fini
				if (_AllSubTask) then {
					// on valide la tache principale
					[_MissionsID, true] spawn ODDMIS_fnc_EndMission;
				};
			};
		};
	}];

	// création de l'event handler destruction du véhicule
	private _idKilled = _MonVL addEventHandler ["Killed", {
		params ["_vehicle", "_killer", "_instigator"];
		// Quand on détruit le véhicule
		private _SubTaskName = _vehicle getVariable ["ODDMIS_var_SubTaskID", ""];
		[_SubTaskName, "FAILED"] call BIS_fnc_taskSetState;

		private _MissionsID = _vehicle getVariable ["ODDMIS_var_MissionID", -1];
		
		// on enlève le véhicule de la liste des véhicules à arrivé
		private _missionData = ODD_var_ActiveMissions get [_MissionsID, []];
		private _ObjVehicule = _missionData getVariable ["vehicule", -1];
		_ObjVehicule = _ObjVehicule - [_vehicle];
		_missionData setVariable ["vehicule", _ObjVehicule];
		ODD_var_ActiveMissions set [_MissionsID, _missionData];

		// remove les event handler de destruction du véhicule, ...
		private _idEngine = _vehicle getVariable ["ODDMIS_var_idEngine", -1];
		private _idKilled = _vehicle getVariable ["ODDMIS_var_idKilled", -1];
		_vehicle removeEventHandler ["Engine", _idEngine];
		_vehicle removeEventHandler ["Killed", _idKilled];

		// on récupère la tache principale
		private _MainTaskName = _vehicle getVariable ["ODDMIS_var_MainTaskID", "-1"];
		if (_MainTaskName == "-1") then {_MainTaskName = _SubTaskName call BIS_fnc_taskParent;};

		// on récupère les toutes les subtask
		private _SubTasks = _MainTaskName call BIS_fnc_taskChildren;

		private _AllSubTask = true;
		{
			private _state = _x call BIS_fnc_taskState;
			if (!(_state == "SUCCEEDED" or _state == "FAILED")) then {
				_AllSubTask = false;
			};
		} forEach _SubTasks;

		// si toutes les subtask sont fini
		if (_AllSubTask) then {
			// on regarde si c'est des réussite ou des échec
			_SubTasks = _SubTasks apply {_x call BIS_fnc_taskState;};
			if ("SUCCEEDED" in _SubTasks) then {
				// on valide la tache principale
				[_MainTaskName, "SUCCEEDED"] call BIS_fnc_taskSetState;
			} else {
				// on valide la tache principale
				[_MainTaskName, "FAILED"] call BIS_fnc_taskSetState;
			};

			[_MissionsID, false] spawn ODDMIS_fnc_EndMission;
		};
	}];

	// on ajoute les id des event handler au véhicule
	_MonVL setVariable ["ODDMIS_var_idEngine", _idEngine];
	_MonVL setVariable ["ODDMIS_var_idKilled", _idKilled];

} forEach _vehiculeType;

// on Crée l'array des donnée de la mission
private _MissionsData = createHashMap;
_MissionsData set ["id", _missionID];
_MissionsData set ["Type", "convoi Humanitaire"];
_MissionsData set ["zone", _zoneID];
_MissionsData set ["vehicule", _vehiculeObj];
_MissionsData set ["task", _MainTaskName];
_MissionsData set ["subTask", _subTaskList];

// On ajoute la mission à la liste
ODD_var_ActiveMissions set [_missionID, _MissionsData];

