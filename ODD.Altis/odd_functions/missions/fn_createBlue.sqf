/*
* Auteur : Wolv
* Fonction pour créer une missions dans la zone bleue
*
* Arguments :
*   _zoneID : ID de la zone
*   _missionType : Type de missions
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call ODDMIS_fnc_createBlue;
*
* Variable publique :
* 
*/

params ["_zoneID", "_missionType", "_missionID"];

// debug
systemChat "ODD_CallCreate : Create Blue";
// On récupère la zone
private _zone = ODD_var_AllLocations select _zoneID;

// liste des données de la missions
private _MissionsData = createHashMap;
_MissionsData set ["id", _missionID];
_MissionsData set ["zone", _zoneID];

// debug
private _name = _zone getVariable ["ODD_var_LocName"];
systemChat format ["ODD_CallCreate : Create Blue %1 (%2) : %3", _name, _zoneID, _missionType];

switch (_missionType) do {
	case (ODD_var_MissionTypeBlue select 0): { // Helico Blue
		// code
	};
	case (ODD_var_MissionTypeBlue select 1): { // convoi Humanitaire Blue
		// On récupère la position de l'objectif
		private _objectifPosition = position _zone;

		// On récupère la position pour faire spawn le convoi
		private _BasePosition = position factory;
		// On tire le nombre de véhicule
		private _nbVehicule = 1;//floor(random 3) + 1;
		// Pour chaque véhicule
		private _vehiculePos = [];
		private _vehiculeType = [];
		private _vehiculeDir = [];
		for "_i" from 1 to _nbVehicule do {
			// on tire le type de véhicule
			private _type = selectrandom ODD_var_HumaVehicles;
			_vehiculeType pushBack _type;

			// on trouve une position pour faire spawn le véhicule (pas infaible mais ok pour l'instant) (sinon technique de la route)
			private _spawnPoint = [_BasePosition, 10, 200, 8, 0, 0.2, 0] call BIS_fnc_findSafePos;	//_BasePosition findEmptyPosition [10, 100, _vehiculeType];
			_vehiculePos pushBack _spawnPoint;
		};
		
		private _monArray = [_missionID, _zoneID, _objectifPosition, _vehiculeType, _vehiculePos, _vehiculeDir];


	};
	case (ODD_var_MissionTypeBlue select 2): { // Destruction VL en Zone Blue
		

	};
};

