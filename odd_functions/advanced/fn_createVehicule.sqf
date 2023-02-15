/*
* Auteur : Wolv
* Fonction pour créer des véhicules sur une zone
*
* Arguments :
* 0: Zone sur laquelle les véhicules apparaitrons <Objet>
* 1: Est-ce la zone principale <BOOL>
* 2: Est-ce que le vl est en ZO- <BOOL>
*
* Valeur renvoyée :
* Nil
*
* Exemple :
* [_zo] call ODD_fnc_createVehicule
* [_zo, True, False] call ODD_fnc_createVehicule
*
* Variable publique :
*/

params ["_zo", ["_action", False], ["_ZOM", False]];
// Récupère les arguments

private _human_players = ODD_var_PlayerCount; 
// Compte les joueur
private _nbVehicule = [];
private _nbVehiculeLourd = [];

private _loctype = 0;	// ODD_var_LocationType = ['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill'];
switch (type _zo) do {
	case (ODD_var_LocationType select 5): {_loctype = 0;};
	case (ODD_var_LocationType select 4): {_loctype = 1;};
	case (ODD_var_LocationType select 3): {_loctype = 2;};
	case (ODD_var_LocationType select 2): {_loctype = 3;};
	case (ODD_var_LocationType select 1): {_loctype = 4;};
	case (ODD_var_LocationType select 0): {_loctype = 5;};
};
{
	if (_x in ODD_var_LocationMilitaryName) then {
		_locType = 2;
	};
}forEach ((text _zo) splitstring " ");

private _vlModifier = 0;
switch (_loctype) do {
	case 0: { _vlModifier = 1; };
	case 1: { _vlModifier = 1; };
	case 2: { _vlModifier = 1; };
	case 3: { _vlModifier = 2; };
	case 4: { _vlModifier = 2; };
	case 5: { _vlModifier = 2; };
	default { _vlModifier = 0; };
};

if (ODD_var_DEBUG) then {
	[["N'a pas attendu la présence de joueurs hors du PA/FOB pour commencer à créer les véhicules sur %1", text _zo]] call ODD_fnc_log;
}
else {
	waitUntil {
		sleep 1;
		(
			(
				(
					(count (getPos base nearEntities[["SoldierWB"], 300])) +
					// Compte les joueurs à la base
					(count (getPos fob nearEntities[["SoldierWB"], 150]))
					// Compte les joueurs à la FOB
					<= (count(allplayers - entities "HeadlessClient_F") / 2)
				)
				and (ODD_var_CurrentMission == 1 or ODD_var_CurrentMission == 2)
			)
			or (ODD_var_DEBUG)
		)
		//Les véhicules ne spawn qu'une fois les joueurs partis en mission
	};
};

if (ODD_var_CurrentMission == 1 or ODD_var_CurrentMission == 2) then {
	[["Debut du spawn de Vehicule sur : %1", text _zo]] call ODD_fnc_log;
	if (_action) then {

		if (!isNil "ODD_var_SpawnableVehicles") then {
			// Si les véhicules ennemis ne sont pas definis
			[-1, True, False] call ODD_fnc_varEne;
			// Définition des véhicules
			sleep 1;
		};
		
		// Préparation des variables pour le calcul du nombre de groupe à créer
		_locProx = nearestLocations [position _zo, ODD_var_LocationType, 3000]; 
		// Récupère les localités à moins de 3km (3000m)
		{
			if (text _x in ODD_var_BlackistedLocation) then {
			// Si la localité est dans la liste noire
				_locProx deleteAt _forEachIndex;
			// La localité est supprimée de notre liste
			};
		}forEach _locProx;
		// Compte les localités à proximité
		_Buildings = nearestObjects [position _zo, ODD_var_Houses, size _zo select 0];	
		// Nombre de maisons dans la localité
		_taille = size _zo select 0;
		// Taille de la zone
		_heure = date select 3;	
		// Heure de la journée
		
		// Définition du nombre de véhicules
		_nbVl = (round random[0, (_human_players/8), 8]);
		if (ODD_var_Support) then {		
			// S'il y a du support
			if (count (ODD_var_CountSupportVehicles) == 0) then { 
				// Si les véhicules de supports ne sont pas encore partis de la base
				_nbVl = _nbVl + 2;	
				// Ajoute 2 véhicules légers
				_nbVlLourd = round (((random 1) * 1/2 * (_nbVl - 1)) + 1); 		
				// Détermine le nombre de véhicules lourd a créer
				_nbVl = _nbVl - _nbVlLourd;
				_nbVehicule resize _nbVl;
				_nbVehiculeLourd resize _nbVlLourd; 
			}
			else {
				_nbVl = _nbVl + ODD_var_CountSupportVehicles;	
				// Si les véhicules de supports ne sont pas encore partis de la base	
				_nbVlLourd = round (((random 1) * 1/2 * (_nbVl - 1)) + 1); 	
				// Détermine le nombre de véhicules lourd a créer
				_nbVl = _nbVl - _nbVlLourd;
				_nbVehicule resize _nbVl; 
				_nbVehiculeLourd resize _nbVlLourd; 
			};
		}
		else {
			_nbVehicule resize round random[0, (_human_players/8), 8];
		};
		// systemChat(Format["Vehicule : %1", count _nbVehicule]);

		[["Nombre de véhicules sur %1 : %2", text _zo, count(_nbVehicule)]] call ODD_fnc_log;
		
		//Pour tous les groupes
		{
			private _group = selectRandom ODD_var_SpawnableVehicles;
			// Choisi un groupe
			ODD_var_SpawnableVehicles = ODD_var_SpawnableVehicles + (ODD_var_SpawnableVehicles - _group);
			
			if (count ((position _zo) nearRoads 300) > 0) then {
			
				private _road = selectRandom((position _zo) nearRoads 300);
				// Choisi une position aléatoire dans un cercle autour du centre de l'objectif
				_pos = position _zo getPos [800 * random 1, random 360];
				
				
				if (count (_pos nearRoads 300) > 0) then { 		
					// S'il y a des routes à proximité 
					_road = selectRandom(_pos nearRoads 300);	
					// Choisi la route la plus proche
					// systemChat str _road;
					_pos = position (_road);		
				};
				
				
				while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 20] > 0) or (!(isonRoad _pos))} do { 	
					// S'il y a des rochers ou des maisons à moins de 20m ou si la position est sous l'eau
					_pos = position _zo getPos [random 800, random 360];		
					// Tire une nouvelle position
					if (count (_pos nearRoads 300) > 0) then {
						// S'il y a des routes à proximité 
						_pos = position (selectRandom (_pos nearRoads 300) ); 
						// Choisi la route la plus proche
					};
				};
				
				_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
				// Crée le groupe

				ODD_var_IAVehicles pushBack (vehicle ((units _g) select 0));

				{
					ODD_var_MainAreaIA pushBack _x;
				} forEach units _g;
				// Ajoute le groupe à la liste des IA de la mission
				
				
				if (count (_pos nearRoads 300) > 0) then {
				
					_connectedRoad = roadsConnectedTo [_road, False];
					if (count (_connectedRoad) >= 1) then {	// si il y a une route acollé 
						_roadDir = [_road, (_connectedRoad select 0)] call BIS_fnc_DirTo; 
						// Récupère la direction de la route
						
						_roadDir = (_roadDir + ((round (random 2))* 180)) % 360;
						(vehicle (units _g select 0)) setDir _roadDir; 
						// Oriente le véhicule sur l'axe de route
					};
					
				};
				
				if (round (random 1) == 0) then {
					(vehicle (units _g select 0)) engineOn True;
				}
				else {
					(vehicle (units _g select 0)) engineOn False;
				};
				
				// systemChat(str(units _g));
				if ((_group select 0) in ODD_var_TransportVehicles) then {
					_infG = selectRandom ODD_var_Squad;
					_pos set [1,(_pos select 1)+ 3];
					_inf = [_pos, EAST, _infG] call BIS_fnc_spawnGroup;
					ODD_var_MainAreaIA pushBack _inf;
					
					{
						_x moveInCargo (vehicle (units _g select 0));
					}forEach units _inf;
				};
				// Si le véhicule est un transport, on ajoute des AI dedans
			};
			
			sleep 2;
		}forEach _nbVehicule;
		[["ODD_Quantité : Nombre de VL sur la ZO : %1", count _nbVehicule]] call ODD_fnc_log;

		{
			private _group = selectRandom ODD_var_SpawnableHeavyVehicles;
			ODD_var_SpawnableHeavyVehicles = ODD_var_SpawnableHeavyVehicles + (ODD_var_SpawnableHeavyVehicles - _group);
			if (_group in ODD_var_FlyingVehicles) then {
				_corner = [[0,0,500], [30000,0,500], [0,30000,500], [30000,30000,500]];

				_pos = selectRandom _corner;
				_pos getpos[(100 * _forEachIndex), 90];
				_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
				{
					ODD_var_MainAreaIA pushBack _x;
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
				
					private _road = [];
					_pos = position _zo getPos [800 * random 1, random 360];
					// Choisi une position aléatoire dans un cercle autour du centre de l'objectif
					if (count (_pos nearRoads 300) > 0) then {
						// Compte les routes a proximité
						_road = selectRandom(_pos nearRoads 300);	
						// Choisi une route aléatoire sur la zone
						// systemChat str _road;
						_pos = position (_road);		
					};
					
					while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 20] > 0) or (!(isonRoad _pos))} do { 		
						// S'il y a des rochers ou des maisons à moins de 20m ou si la position est n'est pas sur une route
						_pos = position _zo getPos [random 800, random 360]; 	
						// Tire une nouvelle position
						if (count (_pos nearRoads 300) > 0) then { 
							// S'il y a des routes à proximité
							_pos = position (selectRandom (_pos nearRoads 300) ); 
							//choisi la route la plus proche
						};
					};
					
					_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
					// Crée le groupe 

					ODD_var_IAVehicles pushBack (vehicle ((units _g) select 0));

					{
						ODD_var_MainAreaIA pushBack _x;
					} forEach units _g;
					// Ajoute le groupe à la liste des IA de la mission
					
					if (count (_pos nearRoads 300) > 0) then {
					
						_connectedRoad = roadsConnectedTo [_road, False];
						if (count (_connectedRoad) >= 1) then {	// si il y a une route acollé 
							_roadDir = [_road, (_connectedRoad select 0)] call BIS_fnc_DirTo;	
							// Récupère la direction de la route
							
							_roadDir = (_roadDir + ((round (random 2))* 180)) % 360; 
							(vehicle (units _g select 0)) setDir _roadDir; 
							// Oriente le véhicule sur l'axe de route
						};
						
					};
					
					if (round (random 1) == 0) then {
						(vehicle (units _g select 0)) engineOn True;
					}
					else {
						(vehicle (units _g select 0)) engineOn False;
					};
					
					// systemChat(str(units _g));
					if ((_group select 0) in ODD_var_TransportVehicles) then {
						_infG = selectRandom ODD_var_Squad;
						_pos set [1,(_pos select 1)+ 3];
						_inf = [_pos, EAST, _infG] call BIS_fnc_spawnGroup;
						ODD_var_MainAreaIA pushBack _inf;
						
						{
							_x moveInCargo (vehicle (units _g select 0));
						}forEach units _inf;
					};
				};
			};
			sleep 2;
		} forEach _nbVehiculeLourd;
		[["ODD_Quantité : Nombre de VL sur la ZO : %1", count _nbVehiculeLourd]] call ODD_fnc_log;
	}
	else {
		sleep 1;
		if (!isNil "ODD_var_SpawnableVehicles") then {
			// Si les véhicules ennemis ne sont pas definis
			[-1, True, False] call ODD_fnc_varEne;	
			// Définition des véhicules
			sleep 1;
		};

		if (!_ZOM) then{
			_nbVehicule resize (_human_players/4 + _vlModifier);
			if (_human_players <= 7) then {
				_nbVehicule resize (count _nbVehicule - 1);
			};
			// Défini le nombre de véhicules à créer
			_nbVehicule resize 0 max (round random [(count _nbVehicule) - 3, (count _nbVehicule), (count _nbVehicule) + 1]);
			
			[["ODD_Quantité : Nombre de VL sur %1 : %2", text _zo, count(_nbVehicule)]] call ODD_fnc_log;

			//Pour tous les groupes
			{
				private _group = selectRandom ODD_var_SpawnableVehicles;
				// Choisi un groupe
				ODD_var_SpawnableVehicles = ODD_var_SpawnableVehicles + (ODD_var_SpawnableVehicles - _group);
				
				_pos = position _zo getPos [800 * random 1, random 360];
				// Choisi une position aléatoire dans un cercle autour du centre de l'objectif
				
				while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 20] > 0) or ((_pos select 2) < 0 )} do { 		
					// S'il y a des rochers ou des maisons à moins de 20m ou si la position est sous l'eau
					_pos = position _zo getPos [random 800, random 360]; 
					// Tire une nouvelle position
				};
				// systemChat(str(_pos));
				_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
				// Crée le groupe

				ODD_var_IAVehicles pushBack (vehicle ((units _g) select 0));
				
				ODD_var_SecondaryAreasIA pushBack _g;
				// Ajoute le groupe à la liste des IA de la mission
				
				sleep 1;
				[_g, _pos, round (size _zo select 0 * 1.5)] call bis_fnc_taskpatrol;
				// Assigne des points de passage
				
			}forEach _nbVehicule;
		}
		else {
			private _group = selectRandom ODD_var_SpawnableVehicles;
			// Choisi un groupe	
			ODD_var_SpawnableVehicles = ODD_var_SpawnableVehicles + (ODD_var_SpawnableVehicles - _group);
			
			_pos = position (selectrandom (_pos nearRoads 600));
			// Choisi une position aléatoire dans un cercle autour du centre de l'objectif
			
			// systemChat(str(_pos));
			_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
			// Crée le groupe

			ODD_var_IAVehicles pushBack (vehicle ((units _g) select 0));
			
			ODD_var_SecondaryAreasIA pushBack _g;
			// Ajoute le groupe à la liste des IA de la mission
			
			[_g] spawn ODD_fnc_patrolZoM;

		};
		
	};
}
else {
	[["Missions nettoyer, arret de la fonction de spawn de vl sur %1", text _zo]] call ODD_fnc_log;
};
