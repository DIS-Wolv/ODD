/* argument :
 *		_zo : Zonne d'operation
 *
 */

// recup les argument
//private _zo = _this select 0; 
// systemChat("test");

// sleep 5;
if (CurrentMission == 1) then {
	["Nettoyage de la ZO"] remoteExec ["systemChat", 0];
	CurrentMission = 2;
	publicVariable "CurrentMission";


	// Compte les Joueurs
	private _human_players = count(allPlayers - entities "HeadlessClient_F"); // removing Headless Clients

	{
		_markerN = _x splitString " ";
		
		if ("ODDOBJ" in _markerN) then {
			_pos = getMarkerPos _x;
			
			private _joueurInZO = count (_pos nearEntities[["player"], 5000]); // compte le nombre de soldat West
			// systemChat(str(MissionIA));
			
			while {_joueurInZO != 0} do {
				sleep(5);
				_joueurInZO = count (_pos nearEntities[["player"], 5000]);
				// systemChat(Format["Il y a %1 joueur dans la ZO", _joueurInZO]);
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
			} forEach MissionIA;		//	Pour chaque Groupe
			
			{
				{
					deleteVehicle _x;	// 	delete l'units
				} forEach units _x;		//	pour chaque units du groupe
			} forEach ZoPIA;		//	Pour chaque Groupe
			
			{
				deleteVehicle _x;	// 	delete l'units
			} forEach MissionProps;		//	Pour chaque Group{
			
			// recup tout les objet par terre 
			_Obj = _pos nearSupplies 5000;
			// systemChat(str(_Obj));
			{
				if (!(_x in [factory,medicalFob,lanceursFob,armesFob,repairPont,medical,para,armes,acces,lanceurs,dump,repair,refuel,rearm])) then { 
							// si l'objet est différent des objet sur fob ou sur base
					deleteVehicle _x;	// delete l'objet
				}
			} forEach _Obj;			// pour chaque objet
			
			{
				{
					deleteVehicle _x;	// 	delete l'units
				} forEach units _x;		//	pour chaque units du groupe
			} foreach MissionCivil;
			
			{					//normalement ne devrait pas servir mais on laisse au cas ou 
				deleteVehicle _x;		//supprime le corps
			} forEach alldead;			//pour chaque corps 

			[_pos, false] remoteExec ["WOLV_fnc_particules", 0];
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



