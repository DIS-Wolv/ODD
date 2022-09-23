/*
* Auteur : Wolv
* Fonction pour créer des AI en garnison dans la zone
*
* Arguments :
* 0: Zone souhaité <Objet>
* 1: Est-ce la zone principale <BOOL>
* 2: Activation du débug dans le chat <BOOL>
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [_zo] call ODD_fnc_createGarnison
* [_zo, true, false] call ODD_fnc_createGarnison
*
* Variable publique :
*/

params ["_zo", ["_action", false]];

// Compte les joueurs
private _human_players = ODD_var_NbPlayer;
// Supprime les clients Headless
private _nbgroup = [];
private _GBuild = [];

if (_action) then {
    // Préparation des variables pour le calcul du nombre de groupe à créer
    _locProx = nearestLocations [position _zo, ODD_var_LocationType, 3000];
    // Récupère les localités à moins de 3km (3000m)
    {
        if (text _x in ODD_var_LocationBlkList) then {
            // Si la localité est dans la liste noire
            _locProx deleteAt _forEachindex;
            // La localité est supprimée de notre liste
        };
    }forEach _locProx;
    // Compte les localités à proximité
    _Buildings = nearestobjects [position _zo, ODD_var_Maison, size _zo select 0];
    // Nombre de maisons dans la localité
    _taille = size _zo select 0;
    // Taille de la zone
    _heure = date select 3;
    // Heure de la journée
    private _loctype = 0;
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
            _loctype = 3;
        };
    }forEach ((text _zo) splitstring " ");
    
    _loctype = (_loctype + random[-1.2, 0, 1.2]) max 0;
    
    _NbGarnison = round((((_human_players + 2 )/ 2) + (_taille / 50) + (4*(_loctype^(1.2))) - (((count _locProx)/ 7) ^ 2) - ((((_heure - 12)^2)/ 48 ) + 3 ) + 4)/3);
    [["Nombre de Garnison sur %1 : %2 groupes", text _zo, _NbGarnison]] call ODD_fnc_log;
    
    _nbgroup resize _NbGarnison;
    
    private _Med = true;
    // Prépare la création d'une caisse médicale
    
    // Récupère tous les batiments a proximité
    _Buildings = nearestobjects [position _zo, ODD_var_Maison, size _zo select 0];
    
    if (count _Buildings < count _nbgroup) then {
        // S'il y a moins de batiments que de groupes
        if (count _Buildings < 10) then {
            _nbgroup resize (count _Buildings - 1);
            // Diminue le nombre de groupes
        }
        else {
            _nbgroup resize (count _Buildings - ((count _Buildings) * 0.1));
            // Diminue le nombre de groupes
        };
    };
    // Au maximum, 90% des maisons sont occupées
    // systemChat(format["Garnison : %1", count _nbgroup]);
    
    // Pour tous les groupes
    {
        private _group = [];
        // Choisi un groupe
        if (floor(random 2) == 0) then {
            _group = selectRandom ODD_var_fireTeam;
        }
        else {
            _group = selectRandom ODD_var_squad;
        };
        if (count _Buildings > 0 ) then {
            // Choisi un batiment aléatoirement
            _GBuild = selectRandom _Buildings;
            //_Buildings = _Buildings - [_Buildings];
            
            // Caisse médicale
            if (_Med and (count _Buildings > 20)) then {
                // S'il y a plus de 20 maisons, et pas de caisse médicale
                _posBox = [position _GBuild select 0, position _GBuild select 1, (position _GBuild select 2) + 2];
                _posBox set[2, 1];
                _box = "ACE_medicalSupplyCrate_advanced" createvehicle _posBox;
                // Place une caisse
                _Med = false;
                // Il n'y a plus besoin de caisse médicale
            };
            
            // Crée le groupe
            _g = [getPos _GBuild, east, _group] call BIS_fnc_spawngroup;
            
            // Ajoute le groupe à la liste des IA de la mission
            ODD_var_MissionIA pushBack _g;
            
            // Ajoute le groupe à la liste des IA en garnison
            ODD_var_GarnisonIA pushBack _g;
            
            _Buildings = _Buildings - [_GBuild];

            {
                _x setVariable ["acex_headless_blacklist", true, true]; // Ajoute l'unité à la liste noire des clients Headless
            } forEach (units _g);   // Pour chaque unité du groupe
            
            sleep 2;

            _tp = false;

            if ((position _GBuild select 2) < 0) then {
                _tp = true;
            }; 
            
            // Place les unités en garnison
            if (round(random 4) == 0) then {
                // 25% de chance que toutes les unités ne soient pas dans le même batiment
                [position _GBuild, nil, units _g, 20, 1, false, _tp] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
            }
            else {
                [position _GBuild, nil, units _g, 20, 2, false, _tp] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
            };
        };
    }forEach _nbgroup;
}
else {
    _NbGarnison = round (2 + _human_players / 2); // Nombre de garnisons sur la zone si ca n'est pas la zone principale

    _nbgroup resize _NbGarnison;
    
    // Récupère tous les batiments à proximité
    _Buildings = nearestobjects [position _zo, ODD_var_Maison, size _zo select 0];
    
    if (count _Buildings < count _nbgroup) then {
        // S'il y a moins de batiments que de groupes
        _nbgroup resize (count _Buildings - 2);
        // Diminue le nombre de groupes
    };
    // Au maximum, toutes les maisons sauf 2 sont occupées 
    
    [["Nombre de Garnison sur %1 : %2 groupes", text _zo, _NbGarnison]] call ODD_fnc_log;

    // Pour tous les groupes nécessitant d'être en granison
    {
        // Choisi un groupe
        private _group = selectRandom ODD_var_fireTeam;
        
        // Choisi un batiment aléatoirement
        _GBuild = selectRandom _Buildings;
        
        // Crée le groupe
        _g = [position _GBuild, east, _group] call BIS_fnc_spawngroup;
        
        // Ajoute le groupe a la liste des IA de la missions
        ODD_var_ZopiA pushBack _g;

        {
            _x setVariable ["acex_headless_blacklist", true, true]; //blacklist l'unit des HC
        } forEach (units _g);   //pour chaque units
        
        sleep(2);
        _tp = false;

        if ((position _GBuild select 2) < 0) then {
            _tp = true;
        }; 
        
        // Place les unités en garnison
        if (round(random 4) == 0) then {
            // 1 / 4 qu'il soit split dans plusieurs batiment
            [position _GBuild, nil, units _g, 20, 1, false, _tp] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        }
        else {
            [position _GBuild, nil, units _g, 20, 2, false, _tp] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        };
        // La fonction de garnison utilisée est celle de ACE
    }forEach _nbgroup;
};
// systemChat("2.fin");
