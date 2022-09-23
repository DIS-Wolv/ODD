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
* [] call ODD_fnc_clearZO
* [true] call ODD_fnc_clearZO
*
* Variable publique :
*/
params [];
// sleep 5;
if (ODD_var_CurrentMission == 1) then {
	["Nettoyage de la ZO"] remoteExec ["systemChat", 0];
	ODD_var_CurrentMission = 2;
	publicVariable "ODD_var_CurrentMission";

	if (!ODD_var_GoClear) then {
		waitUntil {
			sleep 2; 
			["En Attente du ODD_var_GoClear"] remoteExec ["systemChat", 0];
			ODD_var_GoClear
		};
		["ODD_var_GoClear ok"] remoteExec ["systemChat", 0];
	};

	// Compte les joueurs
	private _human_players = ODD_var_NbPlayer; // removing Headless Clients

	{
		_markerN = _x splitString " ";
		
		if ("ODDOBJ" in _markerN) then {
			_pos = getMarkerPos _x;
			
			waitUntil {
				sleep 1;
				_joueurInZO = count (_pos nearEntities[["SoldierWB"], 5000]);
				if (ODD_var_Target == ODD_var_TargetTypeName select 6) then {	// Si c'est un prisonier
					_joueurInZO = _joueurInZO - 1;								// Retire le prisonier de la liste
				};
				[["Il y a %1 joueur dans la ZO", _joueurInZO]] call ODD_fnc_log;
				_joueurInZO <= 0
			};


			// Supprime les taches
			// ["Task","CANCELED"] call BIS_fnc_taskSetState;
			["Task"] call BIS_fnc_deleteTask;
			// ["Extract","CANCELED"] call BIS_fnc_taskSetState;
			["Extract"] call BIS_fnc_deleteTask;
			
			// systemChat("nettoyage de la ZO");
			deleteMarker _x;
			{
				{
					deleteVehicle _x;			// Supprime l'unité
				} forEach units _x;				// Pour chaque unité du groupe
			} forEach ODD_var_MissionIA;		// Pour chaque groupe
			
			{
				{
					deleteVehicle _x;			// Supprime l'unité
				} forEach units _x;				// Pour chaque unité du groupe
			} forEach ODD_var_ZopiA;			// Pour chaque groupe
			
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

			_obj = nearestObjects [_pos, ODD_var_SuppressObject, ODD_var_DistanceZO];
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
			} foreach ODD_var_MissionCivil;		// Pour chaque groupe civil
			
			{									// Ne devrait pas servir
				deleteVehicle _x;				// Supprime le cadavre
			} forEach alldead;					// Pour chaque cadavre

			{
				_x hideObjectGlobal false;		// Affiche l'object
			} forEach ODD_var_ObjetHide;		// Pour object caché

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
	ODD_var_CurrentMission = 0;
	publicVariable "ODD_var_CurrentMission";
}
else {
	["Nettoyage impossible"] remoteExec ["systemChat", 0];
};



