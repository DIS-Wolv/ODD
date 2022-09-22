/*
* Author: Wolv
* Fonction permetant de créé des vehicule sur la zone souhaité
*
* Arguments:
* 0: Zone souhaité <Obj>
* 1: Es ce la zone principale <BOOL>
* 2: es ce que le vl est en ZO-
*
* Return Value:
* Nil
*
* Example:
* [_zo] call ODD_fnc_createVehicule
* [_zo, true, false] call ODD_fnc_createVehicule
*
* Public:
*/

// recup les argument
params ["_zo", ["_action", false], ["_ZOM", False]];

// Compte les Joueurs
private _human_players = ODD_var_NbPlayer; // removing Headless Clients
private _nbVehicule = [];
private _nbVehiculeLourd = [];

waitUntil {
	sleep 1;
	(
		(count (getPos base nearEntities[["SoldierWB"], 300])) +	// nb joueur Base +
		(count (getPos fob nearEntities[["SoldierWB"], 150])) 		// nb joueur FOB
		<= (count(allplayers - entities "HeadlessClient_F") / 2) 	// < nb joueur total (donc quand tout le monde est hors base / FOB stop la boucle)
	)// or (ODD_var_CurrentMission != 1 )								// arrete l'attente si la mission est arrété 
};

[["Debut du spawn de Vehicule sur : %1", text _zo]] call ODD_fnc_log;

if (ODD_var_CurrentMission == 1) then {
	if (_action) then {

		if (!isNil "ODD_var_VehiculeSel") then {	//si les vl enemie sont pas definie
			[-1, true, false] call ODD_fnc_varEne;	//les definie
			sleep 1;
		};
		
		//préparation des variables pour le calcule du nombre de groupe
		_locProx = nearestLocations [position _zo, ODD_var_LocationType, 3000]; //Recup les location a - de 3000m 
		{
			if (text _x in ODD_var_LocationBlkList) then {		//si dans la liste Noir 
				_locProx deleteAt _forEachIndex;				//on delete la location de notre liste 
			};
		}forEach _locProx;		// /!\ pas compté celle ou on est 
		_Buildings = nearestObjects [position _zo, ODD_var_Maison, size _zo select 0];	//Nombre de odd_var_maison dans la localité
		_taille = size _zo select 0;		// Taille de la Zone
		_heure = date select 3;		// heure de la journé
		
		//definie le nombre de vl
		_nbVl = (round random[0, (_human_players/8), 8]);
		if (ODD_var_support) then {		//si support
			if (count (ODD_var_VlSupport) == 0) then { //support pas detecté hors base ajoute 2 vl
				_nbVl = _nbVl + 2;										
				_nbVlLourd = round (((random 1) * 1/2 * (_nbVl - 1)) + 1); 		// prend entre 1 et 1/2 du nombre de vl
				_nbVl = _nbVl - _nbVlLourd;
				_nbVehicule resize _nbVl;
				_nbVehiculeLourd resize _nbVlLourd; 
			}
			else {
				_nbVl = _nbVl + ODD_var_VlSupport;		//sinon ajoute le nombre de vl de support 
				_nbVlLourd = round (((random 1) * 1/2 * (_nbVl - 1)) + 1); 		// prend entre 1 et 1/2 du nombre de vl
				_nbVl = _nbVl - _nbVlLourd;
				_nbVehicule resize _nbVl; 
				_nbVehiculeLourd resize _nbVlLourd; 
			};
		}
		else {
			_nbVehicule resize round random[0, (_human_players/8), 8];
		};
		// systemChat(Format["Vehicule : %1", count _nbVehicule]);
		//_nbVehicule resize 5;

		[["Nombre de Vehicule sur %1 : %2", text _zo, count(_nbVehicule)]] call ODD_fnc_log;
		
		//Pour tout les groupes nessaire 
		{
			// choisi un groupe	
			private _group = selectRandom ODD_var_VehiculeSel;
			ODD_var_VehiculeSel = ODD_var_VehiculeSel + (ODD_var_VehiculeSel - _group);
			
			if (count ((position _zo) nearRoads 300) > 0) then {
			
				private _road = selectRandom((position _zo) nearRoads 300);
				// choisi une position rdm dans un cercle autour du centre de l'obj
				_pos = position _zo getPos [800 * random 1, random 360];
				
				
				if (count (_pos nearRoads 300) > 0) then { 		//si il y a des route a coté 
					_road = selectRandom(_pos nearRoads 300);	//choisi la route la plus proche
					// systemChat str _road;
					_pos = position (_road);		
				};
				
				
				while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 20] > 0) or (!(isonRoad _pos))} do { 		// si il y a plus de 0 cailloux dans les 10 mettres ou position sous l'eau
					_pos = position _zo getPos [random 800, random 360];		//tire une nouvelles position car on veux pas qu'il spawn dans un cailloux
					if (count (_pos nearRoads 300) > 0) then { 		//si il y a des route a coté 
						_pos = position (selectRandom (_pos nearRoads 300) );			//choisi la route la plus proche
					};
				};
				
				//spawn le groupe
				_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
				//Ajoute le groupe a la liste des IA de la missions
				{
					ODD_var_MissionIA pushBack _x;
				} forEach units _g;
				
				
				if (count (_pos nearRoads 300) > 0) then {
				
					_connectedRoad = roadsConnectedTo [_road, false];
					if (count (_connectedRoad) >= 1) then {	// si il y a une route acollé 
						_roadDir = [_road, (_connectedRoad select 0)] call BIS_fnc_DirTo;	// recup la direction 
						
						_roadDir = (_roadDir + ((round (random 2))* 180)) % 360; 			// + 0 ou + 180 °
						(vehicle (units _g select 0)) setDir _roadDir;				//set la direction
					};
					
				};
				
				if (round (random 1) == 0) then {
					(vehicle (units _g select 0)) engineOn true;
				}
				else {
					(vehicle (units _g select 0)) engineOn false;
				};
				
				// systemChat(str(units _g));
				if ((_group select 0) in ODD_var_VehiculeTransport) then {	// ajout d'autre ouraux/oural ?
					_infG = selectRandom ODD_var_squad;
					_pos set [1,(_pos select 1)+ 3];
					_inf = [_pos, EAST, _infG] call BIS_fnc_spawnGroup;
					ODD_var_MissionIA pushBack _inf;
					
					{
						_x moveInCargo (vehicle (units _g select 0));
					}forEach units _inf;
				};
			};
			
			sleep 2;
			
			//lui assigne des waypoint de patrouille
			// [_g, _pos, round (size _zo select 0 * 1.5)] call bis_fnc_taskpatrol;
			
		}forEach _nbVehicule;
		[["Quantital : Nombre de VL sur la ZO : %1", count _nbVehicule]] call ODD_fnc_log;
		{
			private _group = selectRandom ODD_var_VehiculeLourdSel;
			ODD_var_VehiculeLourdSel = ODD_var_VehiculeLourdSel + (ODD_var_VehiculeLourdSel - _group);
			if (_group in ODD_var_VehiculeVollant) then {
				/*_pos = position _zo getPos [800 * random 1, random 360];
				_pos set [200, 2];	//*/
				_corner = [[0,0,500], [30000,0,500], [0,30000,500], [30000,30000,500]];

				_pos = selectRandom _corner;
				_pos getpos[(100 * _forEachIndex), 90];
				_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
				{
					ODD_var_MissionIA pushBack _x;
				} forEach units _g;

				_pos = _pos getpos[100,180];
				_pos set [2, 300];
				_wp = _g addWaypoint [_pos, 0];
				_wp setWaypointType "HOLD";
				_wp setWaypointTimeout [(5*60), (15*60), (25*60)];

				_pos = (position _zo getpos[((random 1) * 2000) + 3000, random 360]);
				_pos set [2, 300];
				_wp = _g addWaypoint [_pos, 0]; // 1er WP dans anneaux 3-5 km
				_pos = (position _zo getpos[((random 1) * 2000) + 1000, random 360]);
				_pos set [2, 300];
				_wp = _g addWaypoint [_pos, 0];	// 2e WP dans anneau de 2-3 km
				_pos = (position _zo getpos[((random 1) * 200), random 360]);
				_pos set [2, 300];
				_wp = _g addWaypoint [_pos, 0];
				_wp setWaypointType "SAD";
			}
			else {
				if (count ((position _zo) nearRoads 300) > 0) then {
				
					private _road = selectRandom((position _zo) nearRoads 300);
					// choisi une position rdm dans un cercle autour du centre de l'obj
					_pos = position _zo getPos [800 * random 1, random 360];
					if (count (_pos nearRoads 300) > 0) then { 		//si il y a des route a coté 
						_road = selectRandom(_pos nearRoads 300);	//choisi la route la plus proche
						// systemChat str _road;
						_pos = position (_road);		
					};
					
					while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 20] > 0) or (!(isonRoad _pos))} do { 		// si il y a plus de 0 cailloux dans les 10 mettres ou position sous l'eau
						_pos = position _zo getPos [random 800, random 360];		//tire une nouvelles position car on veux pas qu'il spawn dans un cailloux
						if (count (_pos nearRoads 300) > 0) then { 		//si il y a des route a coté 
							_pos = position (selectRandom (_pos nearRoads 300) );			//choisi la route la plus proche
						};
					};
					
					//spawn le groupe
					_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
					//Ajoute le groupe a la liste des IA de la missions
					{
						ODD_var_MissionIA pushBack _x;
					} forEach units _g;
					
					if (count (_pos nearRoads 300) > 0) then {
					
						_connectedRoad = roadsConnectedTo [_road, false];
						if (count (_connectedRoad) >= 1) then {	// si il y a une route acollé 
							_roadDir = [_road, (_connectedRoad select 0)] call BIS_fnc_DirTo;	// recup la direction 
							
							_roadDir = (_roadDir + ((round (random 2))* 180)) % 360; 			// + 0 ou + 180 °
							(vehicle (units _g select 0)) setDir _roadDir;				//set la direction
						};
						
					};
					
					if (round (random 1) == 0) then {
						(vehicle (units _g select 0)) engineOn true;
					}
					else {
						(vehicle (units _g select 0)) engineOn false;
					};
					
					// systemChat(str(units _g));
					if ((_group select 0) in ODD_var_VehiculeTransport) then {
						_infG = selectRandom ODD_var_squad;
						_pos set [1,(_pos select 1)+ 3];
						_inf = [_pos, EAST, _infG] call BIS_fnc_spawnGroup;
						ODD_var_MissionIA pushBack _inf;
						
						{
							_x moveInCargo (vehicle (units _g select 0));
						}forEach units _inf;
					};
				};
			};
			sleep 2;
		} forEach _nbVehiculeLourd;
		[["Quantital : Nombre de VL sur la ZO : %1", count _nbVehiculeLourd]] call ODD_fnc_log;
	}
	else {
		sleep 1;
		if (!isNil "ODD_var_VehiculeSel") then {	//si les vl enemie sont pas definie
			[-1, true, false] call ODD_fnc_varEne;	//les definie
			sleep 1;
		};

		if (!_ZOM) then{
			//Calule le nombre de groupe
			_nbVehicule resize round random[0,(_human_players/8),8];
			//systemChat(Format["Vehicule : %1", count _nbVehicule]);
			[["Quantital : Nombre de VL sur %1 : %2 groupes", text _zo, count(_nbVehicule)]] call ODD_fnc_log;

			//Pour tout les groupes nessaire 
			{
				// choisi un groupe	
				private _group = selectRandom ODD_var_VehiculeSel;
				ODD_var_VehiculeSel = ODD_var_VehiculeSel + (ODD_var_VehiculeSel - _group);
				
				// choisi une position rdm dans un cercle autour du centre de l'obj
				_pos = position _zo getPos [800 * random 1, random 360];
				
				while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 20] > 0) or ((_pos select 2) < 0 )} do { 		// si il y a plus de 0 cailloux dans les 10 mettres ou position sous l'eau
					_pos = position _zo getPos [random 800, random 360];		//tire une nouvelles position car on veux pas qu'il spawn dans un cailloux
				};
				// systemChat(str(_pos));
				//spawn le groupe
				_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
				
				//Ajoute le groupe a la liste des IA de la missions
				ODD_var_ZopiA pushBack _g;
				
				sleep 1;
				//lui assigne des waypoint de patrouille
				[_g, _pos, round (size _zo select 0 * 1.5)] call bis_fnc_taskpatrol;
				
			}forEach _nbVehicule;
		}
		else {
			// choisi un groupe	
			private _group = selectRandom ODD_var_VehiculeSel;
			ODD_var_VehiculeSel = ODD_var_VehiculeSel + (ODD_var_VehiculeSel - _group);
			
			// choisi une position rdm dans un cercle autour du centre de l'obj
			_pos = position (selectrandom (_pos nearRoads 600));
			
			// systemChat(str(_pos));
			//spawn le groupe
			_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
			
			//Ajoute le groupe a la liste des IA de la missions
			ODD_var_ZopiA pushBack _g;
			
			[_g] spawn ODD_fnc_patrolZoM;

		};
		
	};
};