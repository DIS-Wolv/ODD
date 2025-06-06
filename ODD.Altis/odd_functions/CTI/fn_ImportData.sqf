/*
* Auteur : Wolv
* Fonction pour importé les donnée de la mission
*
* Arguments :
*	0 : Donnée a importé (Array)
* 
* Valeur renvoyée :
*
* Exemple :
* 	[_data] call ODDCTI_fnc_ImportData
*
* Variable publique :
* 
*/

params [["_data", createHashMap]];

// la save ne doit être fait que sur le serveur
if (!isServer) exitWith {true;};
// si la variable n'existe pas on a rien a save
if (isNil "ODD_var_INITMAP") exitWith {[["Import sur mission non init"]] call ODDcommon_fnc_log;};

[["Set des variables début"]] call ODDcommon_fnc_log;
// si ce n'est pas un hashmap on le transforme
if (typeName _data != "HASHMAP") then {
	_data = createHashMapFromArray _data;
};

// on récupère les données des zones
private _locData = _data get "LocData";

if (!isNil "_locData") then {
	// si ce n'est pas un hashmap on le transforme
	if (typeName _locData != "HASHMAP") then {
		_locData = createHashMapFromArray _locData;
	};
	private _locOffset = 0;

	// on applique les données a chaque location de la map
	{
		[["Set des variables debut %1", (text _x)]] call ODDcommon_fnc_log;
		// récupération des données dans l'array
		private _maLocData = _locData get (_forEachIndex - _locOffset);
		// si ce n'est pas un hashmap on le transforme
		if (typeName _maLocData != "HASHMAP") then {
			_maLocData = createHashMapFromArray _maLocData;
		};
		
		// si l'object existe pas on le skip
		if (_maLocData get "ODD_var_LocName" != text _x) then {
			[["Pas de données pour %1", (text _x)]] call ODDcommon_fnc_log;
			_locOffset = _locOffset + 1;
		} 
		else {
			

			// liste des variable a set
			private _varToSet = [
				"ODD_var_OccActEniVeh",
				"ODD_var_OccTgtEniVeh",
				"ODD_var_CivActPax",
				"ODD_var_CivTgtPax",
				"ODD_var_OccActEni",
				"ODD_var_OccTgtEni",
				"ODD_var_tgtCrate",
				"ODD_var_actCrate",
				"ODD_var_tgtIED",
				"ODD_var_actIED",
				"ODD_var_OccPrcRecrut",
				"ODD_var_OccRecrutVeh",
				"ODD_var_isBlue",
				"ODD_var_isFrontLine"
			];
			// si la si la variable existe on la set
			if(!isNil "_maLocData") then {
				private _maLoc = _x;
				{
					private _value = _maLocData get _x;
					if (!isNil "_value") then {
						_maLoc setVariable [_x, _value];
					};

				} forEach _varToSet;
			};
			[_x, ODD_var_CTIMarkerInfo] call ODDCTI_fnc_updateMapLocation;
			[["Set des variables ok %1", (text _x)]] call ODDcommon_fnc_log;
		};
	} forEach ODD_var_AllLocations;
};

// on récupère les données des missions
private _id = _data get "ODDMIS_var_MissionID";
if (!isNil "_id") then {
	ODDMIS_var_MissionID = _id;
};
private _completedMissions = _data get "ODDMIS_var_CompletedMissions";
if (!isNil "_completedMissions") then {
	ODDMIS_var_CompletedMissions = _completedMissions;
};
private _missionsData = _data get "ODDMIS_var_ActiveMissions";
if (!isNil "_missionsData") then{
	{
		private _mission = _missionsData get _x;
		private _type = _mission get "Type";
		switch _type do {
			case "convoi Humanitaire" : {
				// récupération des données dans l'array
				private _missionID = _mission get "id";
				private _zoneID = _mission get "zone";
				private _vehiculeType = _mission get "VlType";
				private _vehiculePos = _mission get "VlPos";
				private _vehiculeDir = _mission get "VlDir";
				// on crée la mission
				[_missionID, _zoneID, _vehiculeType, _vehiculePos, _vehiculeDir, False] spawn ODDMIS_fnc_buildHumanitaire;
			};
		};
		
	} forEach _missionsData;
};



// on récupère les données des object
private _objectData = _data get "ObjectData";
if (!isNil "_objectData") then {
	// si ce n'est pas un hashmap on le transforme
	if (typeName _objectData != "HASHMAP") then {
		_objectData = createHashMapFromArray _objectData;
	};
	// pour chaque object sauvegardé
	{
		// si l'object existe
		if(!isNil _x) then {
			// récupération des données dans l'array
			private _value = (_objectData get _x);

			// si ce n'est pas un hashmap on le transforme
			if (typeName _value != "HASHMAP") then {
				_value = createHashMapFromArray _value;
			};
			// set des variable
			private _MonObj = call compile _x;
			private _dir = _value get "dir";
			private _pos = _value get "pos";

			private _offset = 0.2;
			if (_MonObj isKindOf "static") then {
				_offset = 0;
			};
			_pos = [(_pos select 0), (_pos select 1), (_pos select 2) + _offset];


			_MonObj setDir _dir;
			_MonObj setPosASL _pos;
		};
	} forEach (keys _objectData);
};

// on récupère les données des variables globales
ODD_var_CivilianReputation = _data get "ODD_var_CivilianReputation";
ODD_var_CTIMarkerInfo = _data get "ODD_var_CTIMarkerInfo";
ODD_var_ProgressDate = _data get "ODD_var_ProgressDate";
// ca marche pas mais pk ?
// _varToSet = ["ODD_var_CivilianReputation","ODD_var_CTIMarkerInfo","ODD_var_ProgressDate"];
// {
// 	private _value = _data get _x;
// 	if (!isNil "_value") then {
// 		_x = _value;
// 	};
// } forEach _varToSet;


private _date = _data get "ODD_var_DateTime";
setDate _date;

sleep 1;
[ODD_var_CTIMarkerInfo] call ODDCTI_fnc_updateMap;
[["Set des variables OK"]] call ODDcommon_fnc_log;

