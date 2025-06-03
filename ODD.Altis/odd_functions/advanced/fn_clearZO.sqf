/*
* Auteur : Wolv
* Fonction pour nettoyer la zone
*
* Arguments :
* 0: Activation du débug dans le chat <BOOL>
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODDadvanced_fnc_clearZO
* [True] call ODDadvanced_fnc_clearZO
*
* Variable publique :
*/
params [["_zo", ODD_var_SelectedArea]];
sleep 5;
if (ODD_var_CurrentMission == 1) then {
	// ["Nettoyage de la ZO"] remoteExec ["systemChat", 0];
	[True, ["ODD_task_clear", "ODD_task_main"], ["Retournez sur le porte avion pour les soins et le débriefing.", "Nettoyage de la mission", ""], objNull, "ASSIGNED", -1, True, "use"] call BIS_fnc_taskCreate;
	ODD_var_CurrentMission = 3;
	publicVariable "ODD_var_CurrentMission";

	_pos = position _zo;
	
	if (!ODD_var_GoClear) then {
		waitUntil {
			sleep 2; 
			["En Attente du ODD_var_GoClear"] remoteExec ["systemChat", 0];
			ODD_var_GoClear
		};
		["ODD_var_GoClear ok"] remoteExec ["systemChat", 0];
	};

	// Compte les joueurs
	private _human_players = ODD_var_PlayerCount; // removing Headless Clients
	
	waitUntil {
		sleep 1;
		_joueurInZO = {(_x distance2D _pos) < 5000} count allPlayers;
		if (ODD_var_SelectedMissionType == ODD_var_MissionType select 6) then {	// Si c'est un prisonier
			_joueurInZO = _joueurInZO - 1;								// Retire le prisonier de la liste
		};
		[["Il y a %1 joueur dans la ZO", _joueurInZO]] call ODDcommon_fnc_log;
		_joueurInZO <= 0
	};

	[nil, True] spawn DISCommon_fnc_CutBushes;
	// Supprime les taches
	// ["ODD_task_Brief"] call BIS_fnc_deleteTask;
	// ["ODD_task_mission"] call BIS_fnc_deleteTask;
	// ["ODD_task_Extract"] call BIS_fnc_deleteTask;
	
	{
		deleteVehicle _x;					// Supprime le Trigger
	} forEach ODD_var_MissionIEDTrigger;	// pour chaque trigger IED

	{
		deleteVehicle _x;					// Supprime le Trigger
	} forEach ODD_var_AreaTrigger;			// pour chaque trigger de Zone

	{
		ODD_var_AreaTrigger = ODD_var_AreaTrigger - [_x];
		deleteVehicle _x;
	} forEach ODD_var_AreaTrigger;


	{
		{
			deleteVehicle _x;			// Supprime l'unité
		} forEach units _x;				// Pour chaque unité du groupe
	} forEach ODD_var_MainAreaIA;		// Pour chaque groupe
	
	{
		{
			deleteVehicle _x;			// Supprime l'unité
		} forEach units _x;				// Pour chaque unité du groupe
	} forEach ODD_var_SecondaryAreasIA;			// Pour chaque groupe
	
	{
		deleteVehicle _x;				// Supprime l'unité
	} forEach ODD_var_MissionProps;		// Pour chaque unité du groupe
	
	// recup tout les objet par terre 
	_Supplies = _pos nearSupplies 5000;
	{
		if (!(_x in [factory,medicalFob,lanceursFob,armesFob,repairPont,medical,para,armes,acces,lanceurs,dump,repair,refuel,rearm])) then { 
										// Si ce n'est pas un objet de la fob ou de la base
			private _distance = fob distance _x;
			if (_distance > 100) then {
				deleteVehicle _x;		// Supprime l'objet
			};
		};
	} forEach _Supplies;						// Pour chaque objet

	_obj = nearestObjects [_pos, ODD_var_DeleteObjects, ODD_var_MissionArea];
	{
		private _distance = (fob distance _x) min (base distance _x);
		if (_distance > 100) then {
			deleteVehicle _x;		// Supprime l'objet
		};
	}forEach _obj;
	
	{
		{
			deleteVehicle _x;			// Supprime l'unité
		} forEach units _x;				// Pour chaque unité du groupe
	} foreach ODD_var_MissionCivilians;		// Pour chaque groupe civil
	
	{									// Ne devrait pas servir
		deleteVehicle _x;				// Supprime le cadavre
	} forEach alldead;					// Pour chaque cadavre

	{
		_x hideObjectGlobal False;		// Affiche l'object
	} forEach ODD_var_HiddenObjects;	// Pour object caché
	ODD_var_HiddenObjects = [];

	{
		deleteVehicle _x;
	} forEach ODD_var_ZonePad;
	ODD_var_ZonePad = [];

	ODD_var_Outposts = [];
	ODD_var_intel_interogation_data = createHashMap;

	{
		deleteVehicle _x;
	} forEach ODD_var_MissionCheckPoint;
	ODD_var_MissionCheckPoint = [];

	ODD_var_MissionSmokePillar = [];
	publicVariable "ODD_var_MissionSmokePillar";
	[False] remoteExec ["ODDadvanced_fnc_particules", 0];

	{
		deleteMarker _x;
	} forEach ODD_var_IntelMarker;
	ODD_var_IntelMarker = [];
	
	sleep 5;

	// ["Clear OK"] remoteExec ["systemChat", 0];
	// ["ODD_task_clear"] call BIS_fnc_deleteTask;
	["ODD_task_clear", "SUCCEEDED"] call BIS_fnc_tasksetState;
	sleep 1;
	["ODD_task_main"] call BIS_fnc_deleteTask;
	ODD_var_CurrentMission = 0;
	publicVariable "ODD_var_CurrentMission";
	[] call ODDdata_fnc_var;
	//["DIS_mrk_FOB_0"] call DISCommon_fnc_PosFob;
}
else {
	["Nettoyage impossible"] remoteExec ["systemChat", 0];
};



