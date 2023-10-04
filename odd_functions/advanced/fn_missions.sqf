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
* [2, <Kavala>, False, True] call ODDadvanced_fnc_missions
*
* Variable publique :
*/
params [["_missiontype", -1], ["_forceZO", ""], ["_ZOP", True], ["_FacForce", -1]];

// [] call ODDdata_fnc_var;
[_FacForce, False, True] call ODDdata_fnc_varEne;

// if (isNil "ODD_var_Pair") then {
// 	ODD_var_SelectedFaction = -1;
// 	[ODD_var_SelectedFaction, True] call ODDdata_fnc_varEne;
// 	[ODD_var_SelectedFaction, False, True] remoteExec ["ODDdata_fnc_varEne", 2];
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
		_mrkfob = ["DIS_mrk_FOB_0", "DIS_mrk_FOB_1", "DIS_mrk_FOB_2", "DIS_mrk_FOB_3"];
		_mrkfob = [_mrkfob, [getPos ODD_var_SelectedArea], { _input0 distance2D getMarkerPos(_x) }, "DESCEND"] call BIS_fnc_sortBy;
		private _i = 0;
		while {(isNil (_mrkfob select _i)) and !(_i < count _mrkfob)} do {
			_i = _i + 1;
		};
		if (!(isNil (_mrkfob select _i))) then {
			[_mrkfob select _i] call DISCommon_fnc_PosFob;
		};

		[["Déplacement de la FOB vers le marker %1", _mrkfob select 0]] call ODDcommon_fnc_log;
	};
	
	ODD_var_SelectedMissionType = [ODD_var_SelectedArea, _missiontype] call ODDadvanced_fnc_createTarget;
	// Choisi le type de mission via la fonction ODDadvanced_fnc_createTarget
	
	[ODD_var_SelectedArea, 2, True] call ODDadvanced_fnc_roadBlock;
	
	[ODD_var_SelectedArea, True] spawn ODDadvanced_fnc_createVehicule; 
	// Spawn est utilisé pour ne pas spawn les véhicules tant que les joueurs ne sont pas partis en mission
	
	private _location = nearestLocations[position ODD_var_SelectedArea, ODD_var_LocationType, ODD_var_MissionArea];
	// Ajoute toutes les localités a proximité de la zone objectif (proximité définie dans fn_var.sqf ligne 136)
	private _closeLoc = nearestLocations[position ODD_var_SelectedArea, ODD_var_LocationType, 500];
	_location = _location - _closeLoc;
	// Filtre les localités pour ne pas prendre celles trop proche de l'objectif
	_location = _location + [ODD_var_SelectedArea];

	private _i = 0;
	while {_i < count(_location)} do {
		private _Buildings = nearestobjects[position (_location select _i), ODD_var_Houses, 200, True];
		if ((text (_location select _i) in ODD_var_BlackistedLocation) or (count _Buildings == 0)) then {
			_location = _location - [_location select _i];
		}
		else {
			_i = _i + 1;
		};
	};
	// Supprime les localités indésirables 
	
	[["Nombre de ZO+ : %1", count(_location)]] call ODDcommon_fnc_log;

	[ODD_var_SelectedArea, _location] call ODDadvanced_fnc_initMissionArea;
	/* // ajoute de la gestion des vl dans le initMissionArea
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
	} forEach _location; //*/

	Private _nbCheckpoint = (round random 5) + 2;
	// [ODD_var_SelectedArea, _nbCheckpoint, ODD_var_MissionArea] call ODDadvanced_fnc_roadBlockZO; 
	// Ajout de checkpoints hors des localités

	/* IED géré dans InitMissionArea
	private _action = round random 100;
	if (_action <= 75) then {
		// 75% de chance que la mission comporte des IEDs
		_nbIED = 25 + round random 20;
		// Crée entre 25 et 45 IEDs
		[ODD_var_SelectedArea, _nbIED] spawn ODDadvanced_fnc_pressureIED;
		_nbDecoy = 5 + round random 10;
		// Crée entre 5 et 15 IEDs qui n'exploseront pas
		[ODD_var_SelectedArea, _nbDecoy, True] spawn ODDadvanced_fnc_pressureIED;
	}
	else {
		_nbIED = 10 + round random 10;
		// Crée entre 10 et 15 IEDs
		[ODD_var_SelectedArea, _nbIED] spawn ODDadvanced_fnc_pressureIED;
		_nbDecoy = 5 + round random 10;
		// Crée entre 10 et 20 IEDs qui n'exploseront pas
		[ODD_var_SelectedArea, _nbDecoy, True] spawn ODDadvanced_fnc_pressureIED;
	};
	*/

	{
		deletevehicle _x;
	} forEach allDead;
	// Permet de supprimer les unités qui auraient été dértuites lors de leur création

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

	
}
else {
	["Une mission est déjà en cours"] remoteExec ["systemChat", 0];
};
