/*
* Auteur : Wolv
* Fonction pour créer et gérer les missions des ODD.
*
* Arguments :
* 0: Type de mission souhaitée (numéro du type de mission) <INT>
* 1: Nom de la localité si forcée <STRING>
* 2: Détermine s'il faut des zones secondaires ou non <BOOL>
* 3: Index de la faction <INT>
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODDadvanced_fnc_missions
* [2, "Kavala", False, True] call ODDadvanced_fnc_missions
*
* Variable publique :
*/
params [["_missiontype", -1], ["_forceZO", ""], ["_ZOP", True], ["_FacForce", -1]];

// [] call ODDadvanced_fnc_var;
[_FacForce, False, True] call ODDadvanced_fnc_varEne;

// if (isNil "ODD_var_Pair") then {
// 	ODD_var_SelectedFaction = -1;
// 	[ODD_var_SelectedFaction, True] call ODDadvanced_fnc_varEne;
// 	[ODD_var_SelectedFaction, False, True] remoteExec ["ODDadvanced_fnc_varEne", 2];
// 	ODD_var_SelectedTarget = ODD_var_MissionType;
// 	publicVariable "ODD_var_SelectedTarget";
// 	ODD_var_SelectedSector = [];
// 	publicVariable "ODD_var_SelectedSector";
// };

if (isNil "ODD_var_PlayerCount") then {
	ODD_var_PlayerCount = (playersNumber west);
};
if (isNil "ODD_var_DEBUG") then {
	ODD_var_DEBUG = False;
};
if (isNil "ODD_var_MissionArea") then {
	ODD_var_MissionArea = 4000;
	[["ODD_var_MissionArea Init dans fn_MISSION"]] call ODDcommon_fnc_log;
};


if (ODD_var_CurrentMission == 0) then {
	[True, "ODD_task_main", ["Une mission est en cours. Attendez les ordres du chef de groupe.", "Opération Dynamique de la DIS", ""], objNull, "ASSIGNED", -1, True, "use"] call BIS_fnc_taskCreate;
	sleep 1;
	[True, ["ODD_task_Brief", "ODD_task_main"], ["Mission en cours de création. Mettez vos bouchons anti-bruit, rejoignez votre chef d'équipe et rassemblez vous autour du chef de groupe pour recevoir les ordres !", "Début du briefing", ""], (position base), "ASSIGNED", -1, True, "meet"] call BIS_fnc_taskCreate;
	sleep 1;
	private _future = servertime + 6;
	// ["Génération d'une mission"] remoteExec ["systemChat", 0];
	ODD_var_CurrentMission = 2;
	publicVariable "ODD_var_CurrentMission";

	private _zo = [_forceZO] call ODDadvanced_fnc_createZO;
	// Choisi la localité via la fonction ODDadvanced_fnc_createZO
	ODD_var_SelectedArea = _zo;
	publicVariable "ODD_var_SelectedArea";

	if (((position FOB) distance2D (position ODD_var_SelectedArea)) <= 4500) then {
		_mrkfob = ["DIS_mrk_FOB_0", "DIS_mrk_FOB_1", "DIS_mrk_FOB_2"];
		_mrkfob = [_mrkfob, [getPos _zo], { _input0 distance2D getMarkerPos(_x) }, "DESCEND"] call BIS_fnc_sortBy;
		[_mrkfob select 0] call DISCommon_fnc_PosFob;
		[["Déplacement de la FOB vers le marker %1", _mrkfob select 0]] call ODDcommon_fnc_log;
	};
	
	ODD_var_SelectedMissionType = [_zo, _missiontype] call ODDadvanced_fnc_createTarget;
	// Choisi le type de mission via la fonction ODDadvanced_fnc_createTarget
	
	[_zo, True] call ODDadvanced_fnc_civil;
	
	[_zo, True] call ODDadvanced_fnc_createGarnisonV2;
	
	[_zo, True] call ODDadvanced_fnc_createPatrol;
	
	[_zo, 2, True] call ODDadvanced_fnc_roadBlock;
	
	[_zo, True] spawn ODDadvanced_fnc_createVehicule; 
	// Spawn est utilisé pour ne pas spawn les véhicules tant que les joueurs ne sont pas partis en mission
	
	private _location = nearestLocations[position _zo, ODD_var_LocationType, ODD_var_MissionArea];
	// Ajoute toutes les localités a proximité de la zone objectif (proximité définie dans fn_var.sqf ligne 136)
	private _closeLoc = nearestLocations[position _zo, ODD_var_LocationType, 500];
	_location = _location - [_zo];
	// Supprime la zone objectif de la liste des zones secondaire potentielles
	_location = _location - _closeLoc;
	// Filtre les localités pour ne pas prendre celles trop proche de l'objectif
	if (_ZOP) then {

		private _i = 0;
		while {_i < count(_location)} do {
			private _Buildings = nearestobjects[position (_location select _i), ODD_var_Houses, 200];
			if ((text (_location select _i) in ODD_var_BlackistedLocation) or (count _Buildings == 0)) then {
				_location = _location - [_location select _i];
			}
			else {
				_i = _i + 1;
			};
		};
		// Supprime les localités indésirables 
		
		[["Nombre de ZO+ : %1", count(_location)]] call ODDcommon_fnc_log;

		private _mod = 0;
		{
			[_x, False] call ODDadvanced_fnc_civil;
			private _loctype = 0;
			switch (type _x) do {
				case (ODD_var_LocationType select 5): {_loctype = 0;};
				case (ODD_var_LocationType select 4): {_loctype = 1;};
				case (ODD_var_LocationType select 3): {_loctype = 2;};
				case (ODD_var_LocationType select 2): {_loctype = 3;};
				case (ODD_var_LocationType select 1): {_loctype = 4;};
				case (ODD_var_LocationType select 0): {_loctype = 5;};
			};
			{
				if (_x in ODD_var_LocationMilitaryName) then {
					_locType = 10;
				};
			}forEach ((text _x) splitstring " ");

			private _action = (random (100 - _mod)) + _mod;

			if (_action < 0) then {
				_action = 0;
			};

			switch (_loctype) do {
				case (0): {		// hill
					if (_action <= 75) then {
						_mod = _mod - 1;
					};
					if (_action > 75 and _action <= 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (1): {		// namelocal
					if (_action <= 65) then {
						_mod = _mod - 1;
					};
					if (_action > 65 and _action <= 75) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 75) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (2): {		// name
					if (_action <= 45) then {
						_mod = _mod - 1;
					};
					if (_action > 45 and _action <= 50) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 50 and _action <= 75) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 75 and _action <= 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_nbCheckPoint = round random 3;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (3): {		// nameVillage
					if (_action <= 40) then {
						_mod = _mod - 1;
					};
					if (_action > 40 and _action <= 50) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 50 and _action <= 70) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 70 and _action <= 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_nbCheckPoint = round random 2;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (4): {		// nameCity
					if (_action <= 30) then {
						_mod = _mod - 1;
					};
					if (_action > 30 and _action <= 35) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 35 and _action <= 65) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 65 and _action <= 85) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_nbCheckPoint = round random 4;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 85) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (5): {		// nameCityCapital
					if (_action <= 30) then {
						_mod = _mod - 1;
					};
					if (_action > 30 and _action <= 35) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 35 and _action <= 55) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 55 and _action <= 85) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_nbCheckPoint = round random 5;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 85 and _action <= 95) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 95) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_nbCheckPoint = round random 4;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (10): {	// military
					if (_action <= 40) then {
						_mod = _mod - 1;
					};
					if (_action > 40 and _action <= 50) then {
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_mod = _mod + 1;
					};
					if (_action > 50 and _action <= 60) then {
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_createPatrol;
						_mod = _mod + 1;
					};
					if (_action > 60 and _action <= 80) then {
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_createPatrol;
						_nbCheckPoint = round random 3;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						_mod = _mod + 1;
					};
					if (_action > 80) then {
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						_mod = _mod + 1;
					};
				};
			};
			[["ZO+ %1 : %2, niveau : %3", _forEachindex, text _x, _loctype]] call ODDcommon_fnc_log;
		} forEach _location;

		Private _nbCheckpoint = (round random 5) + 2;
		[_zo, _nbCheckpoint, ODD_var_MissionArea] call ODDadvanced_fnc_roadBlockZO; 
		// Ajout de checkpoints hors des localités

		private _action = round random 100;
		if (_action <= 75) then {
			// 75% de chance que la mission comporte des IEDs
			_nbIED = 25 + round random 30;
			// Crée entre 20 et 40 IEDs
			[_zo, _nbIED] spawn ODDadvanced_fnc_pressureIED;
			_nbDecoy = 25 + round random 30;
			// Crée entre 25 et 55 IEDs qui n'exploseront pas
			[_zo, _nbDecoy, True] spawn ODDadvanced_fnc_pressureIED;
		}
		else {
			_nbIED = 5 + round random 10;
			// Crée entre 5 et 15 IEDs
			[_zo, _nbIED] spawn ODDadvanced_fnc_pressureIED;
			_nbDecoy = 10 + round random 10;
			// Crée entre 10 et 20 IEDs qui n'exploseront pas
			[_zo, _nbDecoy, True] spawn ODDadvanced_fnc_pressureIED;
		}; 
	};

	{
		deletevehicle _x;
	} forEach allDead;
	// Permet de supprimer les unités qui auraient été dértuites lors de leur création

	{
		{
			private _id = _x addEventHandler["Killed", 
				{ 
					params ["_unit", "_killer"]; 
					[_unit, _killer] call ODDadvanced_fnc_surrender;
				}
			];
			_x setVariable ["ODD_var_SurrenderHandler", _id, True];
		}forEach units _x;
	} forEach ODD_var_MainAreaIA; 
	// Ajoute la possibilité qu'une unité se rende sur la zone objectif

	{
		{
			private _id = _x addEventHandler ["Killed", 
				{ 
					params ["_unit", "_killer"]; 
					[_unit, _killer] call ODDadvanced_fnc_surrender;
				}
			];
			_x setVariable ["ODD_var_SurrenderHandler", _id, True];
		}forEach units _x;
	} forEach ODD_var_SecondaryAreasIA;	
	// Ajoute la possibilité qu'une unité se rende sur une zone secondaire

	{
		{
			_x addEventHandler ["FiredNear", {
				params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
				[_unit, _distance] spawn ODDadvanced_fnc_civiesCover;
			}];

			_x addEventHandler ["Hit", {
				params ["_unit", "_source", "_damage", "_instigator"];
				if (((side _instigator) == WEST) and ((side _unit) == CIVILIAN)) then {
					ODD_var_CivilianReputation = ODD_var_CivilianReputation - 1;
				};
			}];
		}forEach units _x;
	} forEach ODD_var_MissionCivilians;

	_location = _location + [_zo];
	{
		_radA = 1200;
		_alt = 1000;
		_loc = _x;
		private _LocTrigger = createTrigger ["EmptyDetector", position _loc, True]; 
		_LocTrigger setTriggerArea [_radA, _radA, 0, False, _alt]; 
		_LocTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
		
		_LocTrigger setTriggerStatements ["this",
		"
			[thisTrigger, True] spawn ODDadvanced_fnc_areaControl;
		",
		"
			[thisTrigger, False] spawn ODDadvanced_fnc_areaControl;
		"
		];
		_pos = position _loc;
		_markerZ = "Land_HelipadEmpty_F" createVehicle _pos;
		_markerZ setVariable ["trig_ODD_var_locName", text _loc, True];

		_LocTrigger setVariable ["trig_ODD_var_loc", _markerZ, True];

		_markerZ setVariable ["trig_ODD_var_WantState", False, True];
		_scriptID = [_LocTrigger, False] spawn ODDadvanced_fnc_areaControl;

		ODD_var_ZonePad pushBack _markerZ;

		ODD_var_AreaTrigger pushBack _LocTrigger;
	} forEach _location;

	[["ODD_Quantité : Nombre de Pax sur la zone objectif : %1", count ODD_var_MainAreaIA]] call ODDcommon_fnc_log;
	[["ODD_Quantité : Nombre de Pax en zones secondaire : %1", count ODD_var_SecondaryAreasIA]] call ODDcommon_fnc_log;
	[["ODD_Quantité : Nombre de Pax en garnison : %1", count ODD_var_GarnisonnedIA]] call ODDcommon_fnc_log;
	[["ODD_Quantité : Nombre de civils : %1", count ODD_var_MissionCivilians]] call ODDcommon_fnc_log;
	[["ODD_Quantité : Nombre de props : %1", count ODD_var_MissionProps]] call ODDcommon_fnc_log;
	[["ODD_Quantité : Nombre de props local a chaque joueur : %1", count ODD_var_MissionSmokePillar]] call ODDcommon_fnc_log;
	[["ODD_Quantité : Missions générée pour %1 joueurs avec %2 joueurs présents", ODD_var_PlayerCount, (playersNumber west)]] call ODDcommon_fnc_log;
	[["ODD_Quantité : Support détécté %1", ODD_var_Support]] call ODDcommon_fnc_log;
	if (ODD_var_Support) then {
		[["ODD_Quantité : Nombre de véhicules de support des joueurs : %1", ODD_var_CountSupportVehicles]] call ODDcommon_fnc_log;
	};

	waitUntil {
		sleep 1;
		servertime >= _future
	};
	ODD_var_TimeStart = servertime;
	//["Mission générée"] remoteExec ["systemChat", 0];
	ODD_var_CurrentMission = 1;
	publicVariable "ODD_var_CurrentMission";
	publicVariable "ODD_var_Objective";
	publicVariable "ODD_var_MissionProps";
	publicVariable "ODD_var_GarnisonnedIA";
	publicVariable "ODD_var_MainAreaIA";
	publicVariable "ODD_var_SecondaryAreasIA";
	publicVariable "ODD_var_TimeStart";
	publicVariable "ODD_var_SelectedMissionType";
	private _NextTick = servertime + 60;
	
	private _nbIa = [] call ODDadvanced_fnc_countIA;
	
	private _BaseIa = _nbIa;
	private _Renfort = True;
	private _nbItt = 0;



	["ODD_task_Brief", "SUCCEEDED"] call BIS_fnc_tasksetState;

	sleep 5;

	["ODD_task_mission", "ASSIGNED", True] call BIS_fnc_tasksetState;
	[["Mission lancée"]] call ODDcommon_fnc_log;
	if (ODD_var_DEBUG) then {
		[["N'a pas attendu la présence de joueurs sur zone pour commencer à vérifier les conditions de l'objectif"]] call ODDcommon_fnc_log;
	}
	else {
		waitUntil{
			sleep 60;
			count (position _zo nearEntities[["SoldierWB"], 1000]) >= 1
		};
	};
	
	ODD_var_TimeZO = servertime;
	publicVariable "ODD_var_TimeZO";
	
	switch (ODD_var_SelectedMissionType) do {
		case (ODD_var_MissionType select 0): {		  // L'objectif est de détruire des caisses
			while {(count (magazineCargo (ODD_var_Objective select 0)) != 0) and (ODD_var_CurrentMission == 1)} do {
				private _NextTick = servertime + 60;
				// Vérification toutes les minutes que la caisse n'est pas vide
				call ODDadvanced_fnc_sortieGarnison;
				
				_nbIa = [] call ODDadvanced_fnc_countIA;
				
				_Renfort = [_Renfort, _nbIa, _BaseIa] call ODDadvanced_fnc_testRenfort;
				
				_nbItt = _nbItt + 1;
				// [_nbItt] call ODDadvanced_fnc_garbageCollector;
				
				waitUntil {
					sleep 10;
					(!((count (magazineCargo (ODD_var_Objective select 0)) != 0) and (ODD_var_CurrentMission == 1))) or servertime > _NextTick
				};
			};
			
			sleep(1);
			["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState;
			// La tâche est accomplie
		};
		case (ODD_var_MissionType select 1): {	   // L'objectif est de tuer une HVT
			while {((alive (ODD_var_Objective select 0) and (ODD_var_CurrentMission == 1)))} do {
				// Vérification toutes les minutes que la cible est en vie
				_NextTick = servertime + 60;
				
				call ODDadvanced_fnc_sortieGarnison;
				
				_nbIa = [] call ODDadvanced_fnc_countIA;
				
				_Renfort = [_Renfort, _nbIa, _BaseIa] call ODDadvanced_fnc_testRenfort;
				
				_nbItt = _nbItt + 1;
				// [_nbItt] call ODDadvanced_fnc_garbageCollector;
				
				waitUntil {
					sleep 10;
					(!((alive (ODD_var_Objective select 0) and (ODD_var_CurrentMission == 1))) or servertime > _NextTick)
				};
			};
			sleep(1);
			["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState;
			// La tâche est accomplie
		};
		case (ODD_var_MissionType select 2): {	   // L'objectif est de capturer une HVT
			while {((((!((fob in nearestobjects[(ODD_var_Objective select 0), [], 50]) or (base in nearestobjects[(ODD_var_Objective select 0), [], 50]))) and (alive (ODD_var_Objective select 0))) and (ODD_var_CurrentMission == 1)))} do {
				// Vérification toutes les minutes que la cible n'est pas à la base ou à la fob et qu'elle est toujours en vie
				_NextTick = servertime + 60;
				
				call ODDadvanced_fnc_sortieGarnison;
				
				_nbIa = [] call ODDadvanced_fnc_countIA;
				
				_Renfort = [_Renfort, _nbIa, _BaseIa] call ODDadvanced_fnc_testRenfort;
				
				_nbItt = _nbItt + 1;
				// [_nbItt] call ODDadvanced_fnc_garbageCollector;
				
				waitUntil {
					sleep 10;
					(!((((!((fob in nearestobjects[(ODD_var_Objective select 0), [], 50]) or (base in nearestobjects[(ODD_var_Objective select 0), [], 50]))) and (alive (ODD_var_Objective select 0))) and (ODD_var_CurrentMission == 1))) or servertime > _NextTick)
				};
			};
			sleep(1);
			if (alive (ODD_var_Objective select 0)) then {
				["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState;
			}else {
				["ODD_task_mission", "FAILED"] call BIS_fnc_tasksetState;
			};
			// La tâche est accomplie ou non selon l'état de santé de la HVT
		};
		case (ODD_var_MissionType select 3): {	   // L'objectif est une zone à sécuriser
			private _seuil = (round (_BaseIa / 20)) + 1;
			ODD_var_Objective = ODD_var_MainAreaIA;
			publicVariable "ODD_var_Objective";
			
			while {(_nbIa > _seuil) and (ODD_var_CurrentMission == 1)} do {
				// Vérification toutes les minutes que la qu'il y a plus d'IA que le seuil défini
				_NextTick = servertime + 60;
				
				call ODDadvanced_fnc_sortieGarnison;
				
				_nbIa = [] call ODDadvanced_fnc_countIA;
				
				_Renfort = [_Renfort, _nbIa, _BaseIa] call ODDadvanced_fnc_testRenfort;
				
				_nbItt = _nbItt + 1;
				// [_nbItt] call ODDadvanced_fnc_garbageCollector;

				[["Progression de l'objectif : %1 / %2", _nbIa, _seuil]] call ODDcommon_fnc_log;
				
				{
					if (isNull(_x)) then {
						ODD_var_Objective = ODD_var_Objective - [_x];
					};
					// Ajout de la gestion des catpifs, inconscients et fuyards
				}forEach ODD_var_Objective;
				publicVariable "ODD_var_Objective";

				waitUntil {
					sleep 10;
					_nbIa = [] call ODDadvanced_fnc_countIA;
					((_nbIa > _seuil) and (ODD_var_CurrentMission == 1)) == False or servertime > _NextTick
				};
			};
			sleep(1);
			["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState;
			// La tâche est accomplie
		};
		case (ODD_var_MissionType select 4);
		case (ODD_var_MissionType select 5): {	   // L'objectif sont des informations ou des boites noires
			while {(ODD_var_Objective select 1) and (ODD_var_CurrentMission == 1)} do {
				private _NextTick = servertime + 60;
				
				call ODDadvanced_fnc_sortieGarnison;
				
				_nbIa = [] call ODDadvanced_fnc_countIA;
				
				_Renfort = [_Renfort, _nbIa, _BaseIa] call ODDadvanced_fnc_testRenfort;
				
				_nbItt = _nbItt + 1;
				// [_nbItt] call ODDadvanced_fnc_garbageCollector;
				
				waitUntil {
					sleep 10;
					((ODD_var_Objective select 1) and (ODD_var_CurrentMission == 1)) == False or servertime > _NextTick
				};
			};
			sleep(1);
			["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState;
			// La tâche est accomplie
		};
		case (ODD_var_MissionType select 6): {	   // L'objectif est un prisonier
			while {((!((fob in nearestobjects[(ODD_var_Objective select 0), [], 50]) or (base in nearestobjects[(ODD_var_Objective select 0), [], 50]))) and (alive (ODD_var_Objective select 0))) and (ODD_var_CurrentMission == 1)} do {
				// Vérification toutes les minutes que le prisonier n'est pas à la base ou à la fob et qu'il est toujours en vie
				_NextTick = servertime + 60;
				
				call ODDadvanced_fnc_sortieGarnison;
				
				_nbIa = [] call ODDadvanced_fnc_countIA;
				
				_Renfort = [_Renfort, _nbIa, _BaseIa] call ODDadvanced_fnc_testRenfort;
				
				_nbItt = _nbItt + 1;
				// [_nbItt] call ODDadvanced_fnc_garbageCollector;
				
				waitUntil {
					sleep 10;
					(((!((fob in nearestobjects[(ODD_var_Objective select 0), [], 50]) or (base in nearestobjects[(ODD_var_Objective select 0), [], 50]))) and (alive (ODD_var_Objective select 0))) and (ODD_var_CurrentMission == 1)) == False or servertime > _NextTick
				};
			};
			
			sleep(1);
			if (alive (ODD_var_Objective select 0)) then {
				["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState;
			}
			else {
				["ODD_task_mission", "FAILED"] call BIS_fnc_tasksetState;
			};
			// La tâche est accomplie ou non selon l'état de santé du prisonier
		};
		case (ODD_var_MissionType select 7): {	   // L'objectif est de sécuriser un véhicule
			while {
				((((!((fob in nearestobjects[(ODD_var_Objective select 0), [], 50]) or (base in nearestobjects[(ODD_var_Objective select 0), [], 50]))) and (alive (ODD_var_Objective select 0))) and (ODD_var_CurrentMission == 1)))
			} do {
				// Vérification toutes les minutes que le prisonier n'est pas à la base ou à la fob et qu'il n'est pas détruit
				_NextTick = servertime + 60;
				
				call ODDadvanced_fnc_sortieGarnison;
				
				_nbIa = [] call ODDadvanced_fnc_countIA;
				
				_Renfort = [_Renfort, _nbIa, _BaseIa] call ODDadvanced_fnc_testRenfort;
				
				_nbItt = _nbItt + 1;
				// [_nbItt] call ODDadvanced_fnc_garbageCollector;
				
				waitUntil {
					sleep 10;
					(((((!((fob in nearestobjects[(ODD_var_Objective select 0), [], 50]) or (base in nearestobjects[(ODD_var_Objective select 0), [], 50]))) and (alive (ODD_var_Objective select 0))) and (ODD_var_CurrentMission == 1))) or (servertime > _NextTick))
				};
			};
			
			sleep(1);
			if (alive (ODD_var_Objective select 0)) then {
				["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState;
			}
			else {
				["ODD_task_mission", "FAILED"] call BIS_fnc_tasksetState;
			};
			// La tâche est accomplie ou non selon l'état de santé du prisonier
		};
		case (ODD_var_MissionType select 8): {	   // L'objectif est de détruire un véhicule
			while {
				((alive (ODD_var_Objective select 0)) and (ODD_var_CurrentMission == 1))
			} do {
				// Vérification toutes les minutes que la cible n'a pas été détruite
				_NextTick = servertime + 60;
				
				call ODDadvanced_fnc_sortieGarnison;
				
				_nbIa = [] call ODDadvanced_fnc_countIA;
				
				_Renfort = [_Renfort, _nbIa, _BaseIa] call ODDadvanced_fnc_testRenfort;
				
				_nbItt = _nbItt + 1;
				// [_nbItt] call ODDadvanced_fnc_garbageCollector;
				
				waitUntil {
					sleep 10;
					(!((alive (ODD_var_Objective select 0)) and (ODD_var_CurrentMission == 1)) or (servertime > _NextTick))
				};
			};
			
			sleep(1);
			["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState;
			// La tâche est accomplie
		};

	};

	[] call ODDadvanced_fnc_TrigCreateRtb;
	
}
else {
	["Une mission est déjà en cours"] remoteExec ["systemChat", 0];
};
