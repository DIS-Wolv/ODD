/*
* Auteur : Wolv
* Fonction pour spawn une missions vague d'enemies de contre attaque
*
* Arguments :
*   _vagueInfo : Enemy present dans les vagues (array) [_group, _vlTerrestre, _vlAerien]
*   _posFromAttack : Position de l'attaque base (array)
*   _missionID : ID de la mission (int)
*   _subMissionID : ID de la sub mission (int)
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call ODDMIS_fnc_buildCreateVagues;
*
* Variable publique :
* 
*/

params ["_vagueInfo", "_posFromAttack", "_posAttack", "_missionID", "_subMissionID", "_timmer"];

// définir les timers
//waitUntil {sleep 1; true};
systemChat format ["Vagues : %1 | %2 s", _subMissionID, _timmer];
uiSleep _timmer;
systemChat format ["Vagues %1 partie", _subMissionID];

// on récup les varriables 
private _MesGroups = _vagueInfo select 0;
private _MesVlTerrestre = _vagueInfo select 1;
private _MesVlAerien = _vagueInfo select 2;

_wpCycle = _posAttack getPos [0, 0];

private _MainTaskName = Format["ODD_Task_%1",_missionID];
private _SubTaskName = Format["ODD_Task_%1_%2", _missionID, _subMissionID];

private _MaVagues = [];

if (count _MesGroups > 0) then {
	private _TruckDriver = [];

	// On crée l'infantrie
	private _GroupList = [];
	{
		// on récup les varriables
		private _groupType = _x;

		// créate spawn position
		private _mesRoads = _posFromAttack nearRoads 500;

		private _spawnPos = position (selectrandom _mesRoads);
		_spawnPos = _posFromAttack findEmptyPosition [15, 500]; // good failover but try to find a better way maybe on road ????

		// Variable type de camions
		// private _allTruckType = [["brf_o_ard_ural"],["brf_o_ard_zil131"],["brf_o_ard_zil131_open"]];
		private _truckType = selectRandom ODD_var_TransportVehicles; // to change ? ODD_var_TransportVehicles ? 

		//spawn camion  
		private _truck = [_spawnPos, resistance, _truckType] call BIS_fnc_spawngroup;
		private _vl = vehicle ((units _truck) select 0); 

		// On crée le groupe
		private _cargopos = _spawnPos getpos [10, 0];
		private _group = [_cargopos, resistance, _groupType] call BIS_fnc_spawngroup;

		// on charge le groupe dans le camion
		{
			_x moveInCargo _vl;
		} forEach units _group; 

		_TruckDriver pushBack _truck;

		_vl setVariable ["Cargo", _group];

		// On ajoute les variables au groupe
		_group setVariable ["ODDMIS_var_MissionID", _missionID];
		_truck setVariable ["ODDMIS_var_MissionID", _missionID];

		// On ajoute le groupe à la liste
		_GroupList pushBack _group;
	} forEach _MesGroups;

	private _Trucker = (_TruckDriver select 0);
	_TruckDriver join _Trucker;

	{_x setVariable ["crewType", 0];} forEach _TruckDriver;

	_Trucker setBehaviour "SAFE";
	_Trucker setSpeedMode "LIMITED";
	_Trucker setFormation "COLUMN";

	_wp = _Trucker addWaypoint [_posAttack, 10];
	[_Trucker, 1] setWaypointCompletionRadius 400;
	_wp setWaypointType "MOVE";

	_wp setWaypointStatements ["true",Format["
		private _Trucker = group this;
		{
			private _vl = vehicle _x;
			
			private _cargo = _vl getVariable 'Cargo';
			
			{
				doGetOut _x;
				unassignVehicle _x;
			} forEach units _cargo;

			_cargo setBehaviour 'COMBAT';
			_cargo setSpeedMode 'AUTO';

			{
				deleteWaypoint _x;
			} forEach waypoints _cargo;

			_wp = _cargo addWaypoint [(%1 getPos [5, 90]), 10];
			_wp setWaypointType 'SAD';

			_wpCycle = _cargo addWaypoint [(%1 getPos [5, 180]), 2];
			_wpCycle setWaypointType 'CYCLE';
				
		} forEach units _Trucker;

		_CallBack = {
			params ['_group'];
			uiSleep 20;
			_wpBack = _group addWaypoint [%2, 10];
			_wpBack setWaypointType 'MOVE';
		};
		[_Trucker] spawn _CallBack;

	", _posAttack, _posFromAttack]];
};



if (count _MesVlTerrestre > 0) then {
	// On crée les véhicules terrestres
	private _VehTerList = [];
	{
		// on récup les varriables
		private _vehiculeType = _x;
		private _spawnPos = _posFromAttack findEmptyPosition [20, 500];

		// systemChat str _vehiculeType;

		// On crée le véhicule
		private _MonVL = [_spawnPos, resistance, _vehiculeType] call BIS_fnc_spawngroup;

		// On ajoute les variables au véhicule
		_MonVL setVariable ["ODDMIS_var_MissionID", _missionID];

		_wpMove = _MonVL addWaypoint [(_posAttack getPos [5, 0]), 0];
		_wpMove setWaypointType "MOVE";

		_wpSAD = _MonVL addWaypoint [(_posAttack getPos [5, 90]), 1];
		_wpSAD setWaypointType "SAD";

		_wpCycle = _MonVL addWaypoint [(_posAttack getPos [5, 180]), 2];
		_wpCycle setWaypointType "CYCLE";

		// On ajoute le véhicule à la liste
		_VehTerList pushBack _MonVL;

	} forEach _MesVlTerrestre;
	{_x setVariable ["crewType", 1];} forEach _VehTerList;
};

if (count _MesVlAerien > 0) then {
	// On crée les véhicules aériens
	private _VehAirList = [];
	{
		// on récup les varriables
		private _vehiculeType = _x;
		private _spawnPos = _posFromAttack findEmptyPosition [20, 500];

		// On crée le véhicule
		private _MonVL = [_spawnPos, resistance, _vehiculeType] call BIS_fnc_spawngroup;

		// On ajoute les variables au véhicule
		_MonVL setVariable ["ODDMIS_var_MissionID", _missionID];

		_wpMove = _MonVL addWaypoint [(_posAttack getPos [5, 0]), 0];
		_wpMove setWaypointType "MOVE";

		_wpSAD = _MonVL addWaypoint [(_posAttack getPos [5, 90]), 1];
		_wpSAD setWaypointType "SAD";

		_wpCycle = _MonVL addWaypoint [(_posAttack getPos [5, 180]), 2];
		_wpCycle setWaypointType "CYCLE";

		// On ajoute le véhicule à la liste
		_VehAirList pushBack _MonVL;
	} forEach _MesVlAerien;
};

