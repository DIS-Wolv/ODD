/*
* Auteur : Wolv
* Fonction pour appeller des renforts dans la zone
*
* Arguments :
* 0: Zone souhaitée <Objet>
* 1: Activation du débug dans le chat <BOOL>
*
* Valeur renvoyée :
* nil
*
* Exemple:
* [_zo] call ODD_fnc_createRenfort
*
* Variable publique :
*/
params ["_zo"];

private _NbUnitRenfort = 0;

if (ODD_var_CurrentMission == 1) then {
    _textRenfort = ["Des renforts ont été appellés.", "Des renforts sont en approche !"];
    [selectRandom _textRenfort] remoteExec ["systemChat", 0];
    	// Message d'annonce des renforts
    
    private _groups = [];
    
    private _human_players = ODD_var_PlayerCount;
    // Retire les clients headless
    private _locType = 0;
    switch (type _zo) do {
		case (ODD_var_LocationType select 5): { _locType = 0;};
		case (ODD_var_LocationType select 4): { _locType = 1;};
		case (ODD_var_LocationType select 3): { _locType = 2;};
		case (ODD_var_LocationType select 2): { _locType = 3;};
		case (ODD_var_LocationType select 1): { _locType = 4;};
		case (ODD_var_LocationType select 0): { _locType = 5;};
	};

    {
        if (_x in ["military", "airbase", "airfield"]) then {
            _locType = 3;
        };
    }forEach ((text _zo) splitstring " ");
    
    private _inf = [];
    
    _groups resize random[0, round((_locType/2) + (_human_players/4)), 7];
    
    {
        _group = selectRandom ODD_var_SpawnableVehicles;
        while {"brf_o_ard_uaz_dshkm" in _group} do {
            _group = selectRandom ODD_var_SpawnableVehicles;
        };
        ODD_var_SpawnableVehicles = ODD_var_SpawnableVehicles + (ODD_var_SpawnableVehicles - _group);
        _groups set[_forEachindex, _group];
        	// Défini le véhicule
    }forEach _groups;
    		// Pour tous les groupes
    
    _loc3 = nearestLocations [position _zo, ODD_var_LocationType, 3000];
    // Récupère les localités à moins de 3km (3000m)
    {
        if (text _x in ODD_var_BlackistedLocation) then {
            // Si la localité est dans la liste noire
            _loc3 deleteAt _forEachindex;
            // La localité est supprimée de notre liste
        };
    }forEach _loc3;
    _loc6 = nearestLocations [position _zo, ODD_var_LocationType, 6000];
    // Récupère les localités à moins de 6km (6000m)
    {
        if (text _x in ODD_var_BlackistedLocation) then {
            // Si la localité est dans la liste noire
            _loc6 deleteAt _forEachindex;
            // La localité est supprimée de notre liste
        };
    }forEach _loc6;
    _loc36 = _loc6 - _loc3;
    
    if (count(_loc36) > 0) then {
        _refloc = [];
        _refloc resize (1 + (round random 1));
        
        {
            _rdmloc = selectRandom _loc36;
            _pos = position _rdmloc;
            while {(count (_pos nearRoads 300) == 0) and (count(_pos nearEntities[["SoldierWB"], 2000]) == 0)} do {
                _rdmloc = selectRandom _loc36;
                _pos = position _rdmloc;
            };
            _refloc set[_forEachindex, _rdmloc];
            // Selectionne uniquement les localités entre 3 et 6km avec une route
            
            // systemChat(str(text (_refloc select _forEachindex)));
        }forEach _refloc;
        
        {
            if (ODD_var_CurrentMission == 1) then {
                _loc = selectRandom _refloc;
                	// Choisi une localité aléatoire
                
                [["Renfort en approche de %1", text _loc]] call ODD_fnc_log;
                
                _pos = position _loc getPos [300 * random 1, random 360];
                	// Choisi une position aléatoire dans un cercle autour du centre de l'objectif
                if (count (_pos nearRoads 300) > 0) then {
                    // Cherche une route à 300m de la position choisie
                    _pos = position (selectRandom(_pos nearRoads 300));
                    	// Redéfini la position sur cette route
                };
                
                while {(count nearestTerrainObjects [_pos, ["Rocks", "House"], 20] > 0) or (!(isOnRoad _pos))} do {
                    // S'il y a des rochers ou des maisons à proximité ou si la position n'est pas sur une route
                    _pos = position _loc getPos [random 300, random 360];
                    // Choisi une nouvelle position
                    if (count (_pos nearRoads 300) > 0) then {
                    // Cherche une route à 300m de la position choisie
                        _pos = position (selectRandom (_pos nearRoads 300));
                        // Redéfini la position sur cette route
                    };
                };
                
                _group = (_groups select _forEachindex);
                // Choisi un groupe
                _g = [_pos, east, _group] call BIS_fnc_spawngroup;
                // Crée le groupe
                ODD_var_SecondaryAreasIA pushBack _g;
                // Ajoute le groupe à la liste des IA de la missions

                _NbUnitRenfort = _NbUnitRenfort + count(units _g);
                
                if (!(("brf_o_ard_uaz" in _group) or ("brf_o_ard_uaz_open" in _group))) then {
                    _infG = selectRandom ODD_var_Squad;
                    _pos set [1, (_pos select 1)+ 3];
                    _inf = [_pos, east, _infG] call BIS_fnc_spawngroup;
                    // Ajoute des AI dans les véhicules
                    _NbUnitRenfort = _NbUnitRenfort + count(units _inf);
                    ODD_var_SecondaryAreasIA pushBack _inf;
                }
                else {
                    // Si le véhicule est un UAZ
                    _infG = selectRandom ODD_var_Squad;
                    // Choisi un groupe
                    _pos set [1, (_pos select 1)+ 3];
                    // Déplace sur le coté
                    
                    _infG deleteAt (random (count _infG));
                    // Suppirme 2 unités du groupe 
                    _infG deleteAt (random (count _infG));
                    
                    _inf = [_pos, east, _infG] call BIS_fnc_spawngroup;
                    // Crée le groupe
                    ODD_var_SecondaryAreasIA pushBack _inf;
                    // Ajoute le groupe à la liste des IA de la mission

                    _NbUnitRenfort = _NbUnitRenfort + count(units _inf);
                };
                sleep 1;
                
                {
                    _x moveInCargo (vehicle (units _g select 0));
                    // Déplace une unité dans le véhicule
                }forEach units _inf;
                	// Pour chaque unité
                
                sleep ((random 30) + 30);
                
                _posWp1 =[(position _zo getPos [random 200, random 360]), size _zo select 0] call BIS_fnc_nearestroad;
                
                _g addWaypoint [_posWp1, 100, 1];
                // Crée un point de passage pour que le véhicule se rende sur zone et y débarque l'infanterie
                [_g, 1] setwaypointBehaviour "AWARE";
                [_g, 1] setwaypointType "TR UNLOAD";
                [_g, 1] setwaypointTimeout [20, 35, 60];
                
                _g addWaypoint [(position _zo getPos [random 200, random 360]), 100, 2];
                [_g, 2] setwaypointType "SAD";
                // Crée un point de passage "recherche et destruction" pour le véhicule
                
                _inf addWaypoint [_posWp1, 0, 1];
                // Crée un point de passage pour que l'infanterie débarque
                [_inf, 1] setwaypointType "GETOUT";
                
                _inf addWaypoint [(position _zo getPos [random 200, random 360]), 50, 2];
                [_inf, 2] setwaypointType "SAD";
                // Crée un point de passage "recherche et destruction" pour l'infanterie
            };
        } forEach _groups;
    };
};

[["ODD_Quantité : Nombre d'unité en Renfort : %1", _NbUnitRenfort]] call ODD_fnc_log;
