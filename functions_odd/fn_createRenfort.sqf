/*
* Author: Wolv
* Fonction permetant de d'appeller des renfort dans la zone
*
* Arguments:
* 0: Zone souhaité <Obj>
* 1: Activation du debug dans le chat <BOOL>
*
* Return Value:
* nil
*
* Example:
* [_zo] call WOLV_fnc_createRenfort
* [_zo, true] call WOLV_fnc_createRenfort
*
* Public:
*/
params ["_zo", ["_Debug", false]];
// private _zo = _this select 0;
		//Zone ou il faut envoyer les renfort

private _NbUnitRenfort = 0;

if (CurrentMission == 1) then {
    _textRenfort = ["Des renforts ont été appellé.", "Des renforts sont en approche"];
    [selectRandom _textRenfort] remoteExec ["systemChat", 0];
    	// envoie un message de renfort
    
    private _groups = [];
    
    private _human_players = count(allplayers - entities "HeadlessClient_F");
    // removing Headless Clients
    private _locType = 0;
    private _inf = [];
    
    if (type _zo == locationType select 5) then {
        _locType = 0;
    };
    if (type _zo == locationType select 4) then {
        _locType = 1;
    };
    if (type _zo == locationType select 3) then {
        _locType = 2;
    };
    if (type _zo == locationType select 2) then {
        _locType = 3;
    };
    if (type _zo == locationType select 1) then {
        _locType = 4;
    };
    if (type _zo == locationType select 0) then {
        _locType = 5;
    };
    {
        if (_x in ["military", "airbase", "airfield"]) then {
            _locType = 3;
        };
    }forEach ((text _zo) splitstring " ");
    
    _groups resize random[0, round((_locType/2) + (_human_players/4)), 7];
    
    {
        _group = selectRandom Vehicule;
        while {"brf_o_ard_uaz_dshkm" in _group} do {
            _group = selectRandom Vehicule;
        };
        _groups set[_forEachindex, _group];
        	// definie le vl
    }forEach _groups;
    		// pour tous les groupes
    
    _loc3 = nearestLocations [position _zo, locationType, 3000];
    // Recup les location a - de 3000m
    {
        if (text _x in locationBlklist) then {
            // si dans la liste Noir
            _loc3 deleteAt _forEachindex;
            				// on delete la location de notre liste
        };
    }forEach _loc3;
    		// pas compté celle ou on est
    _loc6 = nearestLocations [position _zo, locationType, 6000];
    // Recup les location a - de 6000m
    {
        if (text _x in locationBlklist) then {
            // si dans la liste Noir
            _loc6 deleteAt _forEachindex;
            				// on delete la location de notre liste
        };
    }forEach _loc6;
    		// !\ pas compté celle ou on est
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
            // ne selectionne que des obj avec des route
            
            // systemChat(str(text (_refloc select _forEachindex)));
        }forEach _refloc;
        
        {
            if (CurrentMission == 1) then {
                _loc = selectRandom _refloc;
                	// choisie un loc random
                
                [["Renfort en approche de %1", text _loc]] call WOLV_fnc_log;
                
                _pos = position _loc getPos [300 * random 1, random 360];
                	// prend un pose random a coté du centre de la loc
                if (count (_pos nearRoads 300) > 0) then {
                    // si il y a des route a coté
                    _pos = position (selectRandom(_pos nearRoads 300));
                    		// choisi la route la plus proche
                };
                
                while {(count nearestTerrainObjects [_pos, ["Rocks", "House"], 20] > 0) or (!(isOnRoad _pos))} do {
                    // si il y a plus de 0 cailloux dans les 10 mettres ou pas sur une route
                    _pos = position _loc getPos [random 300, random 360];
                    // tire une nouvelles position car on veux pas qu'il spawn dans un cailloux
                    if (count (_pos nearRoads 300) > 0) then {
                            // si il y a des route a coté
                        _pos = position (selectRandom (_pos nearRoads 300));
                            // choisi la route la plus proche
                    };
                };
                
                _group = (_groups select _forEachindex);
                		// choisie le groupe
                _g = [_pos, east, _group] call BIS_fnc_spawngroup;
                	// spawn le groupe
                // Ajoute le groupe a la liste des IA de la missions
                ZopiA pushBack _g;

                _NbUnitRenfort = _NbUnitRenfort + count(units _g);
                
                if (!(("brf_o_ard_uaz" in _group) or ("brf_o_ard_uaz_open" in _group))) then {
                    // ajoute du personnel dans les vl
                    _infG = selectRandom squad;
                    _pos set [1, (_pos select 1)+ 3];
                    _inf = [_pos, east, _infG] call BIS_fnc_spawngroup;
                    
                    _NbUnitRenfort = _NbUnitRenfort + count(units _inf);
                    ZOpiA pushBack _inf;

                    //ZopiA pushBack _inf;
                } else {
                    // si UAZ
                    _infG = selectRandom squad;
                    		// choisi une squad
                    _pos set [1, (_pos select 1)+ 3];
                    	// la deplace sur le coté
                    
                    _infG deleteAt (random (count _infG));
                    	// delete 2 gars
                    _infG deleteAt (random (count _infG));
                    
                    _inf = [_pos, east, _infG] call BIS_fnc_spawngroup;
                    // spawn la squad
                    ZopiA pushBack _inf;
                    		// Ajoute le groupe a la liste des IA de la missions

                    _NbUnitRenfort = _NbUnitRenfort + count(units _inf);
                };
                
                sleep 1;
                
                {
                    _x moveInCargo (vehicle (units _g select 0));
                    	// déplace l'unité dans le vl
                }forEach units _inf;
                	// pour chaque unité
                
                sleep ((random 30) + 30);
                
                _posWp1 =[(position _zo getPos [random 200, random 360]), size _zo select 0] call BIS_fnc_nearestroad;
                
                _g addWaypoint [_posWp1, 100, 1];
                	// Waypoint déplacement et dechargement
                [_g, 1] setwaypointBehaviour "AWARE";
                [_g, 1] setwaypointType "TR UNLOAD";
                [_g, 1] setwaypointTimeout [20, 35, 60];
                
                _g addWaypoint [(position _zo getPos [random 200, random 360]), 100, 2];
                [_g, 2] setwaypointType "SAD";
                		// WP Seek and Destroy
                
                _inf addWaypoint [_posWp1, 0, 1];
                	// WP get Out
                [_inf, 1] setwaypointType "GETOUT";
                
                _inf addWaypoint [(position _zo getPos [random 200, random 360]), 50, 2];
                [_inf, 2] setwaypointType "SAD";
                	// WP Seek and Destroy
            };
        } forEach _groups;
    };
};

[["Quantital : Nombre d'unité en Renfort : %1", count _NbUnitRenfort]] call WOLV_fnc_log;

/*
1.	Lors de l'appelle
2.	Combien de grp spawn
3.	quels grp spawn ? (vl / inf ?) 1 groupe
4. 	toutes les locations VALIDE qui sont a + de 2 et - de 5 km
selectionne 1 ou 2
5.	probabilité a def de faire spawn des renfort (depend du nombre de loc)
6.	waypoint

*/