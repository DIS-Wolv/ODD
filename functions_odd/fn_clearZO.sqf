/*
* Author: Wolv
* Fonction permetant de nettoyer la zone
*
* Arguments:
* 0: Activation du debug dans le chat <BOOL>
*
* Return Value:
* nil
*
* Example:
* [] call ODD_fnc_clearZO
* [true] call ODD_fnc_clearZO
*
* Public:
*/
params [["_Debug", false]];
// sleep 5;
if (CurrentMission == 1) then {
	["Nettoyage de la ZO"] remoteExec ["systemChat", 0];
	CurrentMission = 2;
	publicVariable "CurrentMission";

	if (!ODD_var_GoClear) then {
		waitUntil {
			sleep 2; 
			["En Attente du ODD_var_GoClear"] remoteExec ["systemChat", 0];
			ODD_var_GoClear
		};
		["ODD_var_GoClear ok"] remoteExec ["systemChat", 0];
	};

	// Compte les Joueurs
	private _human_players = count(allPlayers - entities "HeadlessClient_F"); // removing Headless Clients

	{
		_markerN = _x splitString " ";
		
		if ("ODDOBJ" in _markerN) then {
			_pos = getMarkerPos _x;
			
			waitUntil {
				sleep 1;
				_joueurInZO = count (_pos nearEntities[["SoldierWB"], 5000]);
				[["Il y a %1 joueur dans la ZO", _joueurInZO]] call ODD_fnc_log;
				_joueurInZO == 0
			};


			//supprime les taches
			// ["Task","CANCELED"] call BIS_fnc_taskSetState;
			["Task"] call BIS_fnc_deleteTask;
			// ["Extract","CANCELED"] call BIS_fnc_taskSetState;
			["Extract"] call BIS_fnc_deleteTask;
			
			// systemChat("nettoyage de la ZO");
			deleteMarker _x;
			{
				{
					deleteVehicle _x;	// 	delete l'units
				} forEach units _x;		//	pour chaque units du groupe
			} forEach ODD_var_MissionIA;		//	Pour chaque Groupe
			
			{
				{
					deleteVehicle _x;	// 	delete l'units
				} forEach units _x;		//	pour chaque units du groupe
			} forEach ODD_var_ZopiA;		//	Pour chaque Groupe
			
			{
				deleteVehicle _x;	// 	delete l'units
			} forEach ODD_var_MissionProps;		//	Pour chaque Group{
			
			// recup tout les objet par terre 
			_Obj = _pos nearSupplies 5000;
			// systemChat(str(_Obj));
			{
				if (!(_x in [factory,medicalFob,lanceursFob,armesFob,repairPont,medical,para,armes,acces,lanceurs,dump,repair,refuel,rearm])) then { 
							// si l'objet est différent des objet sur fob ou sur base
					private _distance = fob distance _x;
					if (_distance > 100) then {
						deleteVehicle _x;	// delete l'objet
					};
				};
			} forEach _Obj;			// pour chaque objet
			
			{
				{
					deleteVehicle _x;	// 	delete l'units
				} forEach units _x;		//	pour chaque units du groupe
			} foreach ODD_var_MissionCivil;
			
			{					//normalement ne devrait pas servir mais on laisse au cas ou 
				deleteVehicle _x;		//supprime le corps
			} forEach alldead;			//pour chaque corps 

			{
				_x hideObjectGlobal false;		//affiche l'object
			} forEach ODD_var_ObjetHide;			//pour object caché

			ODD_var_ParticuleList = [];
			publicVariable "ODD_var_ParticuleList";
			[False] remoteExec ["ODD_fnc_particules", 0];
		}
		else {
			if ("ODDTG" in _markerN) then { deleteMarker _x; };
		};
		
	}forEach allMapMarkers;
	sleep 5;

	["Clear OK"] remoteExec ["systemChat", 0];
	CurrentMission = 0;
	publicVariable "CurrentMission";
}
else {
	["Nettoyage impossible"] remoteExec ["systemChat", 0];
};



