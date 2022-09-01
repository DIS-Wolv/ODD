/*
* Author: Wolv
* Fonction permetant de crée des garde en garnison dans la zone
*
* Arguments:
* 0: Zone souhaité <Obj>
* 1: Es ce la zone principale <BOOL>
* 2: Activation du ODD_var_DEBUG dans le chat <BOOL>
*
* Return Value:
* nil
*
* Example:
* [_zo] call ODD_fnc_createGarnison
* [_zo, true, false] call ODD_fnc_createGarnison
*
* Public:
*/

params ["_zo", ["_action", false], ["_Debug", false]];

// Compte les Joueurs
private _human_players = ODD_var_NbPlayer;
// removing Headless Clients
private _nbgroup = [];
private _GBuild = [];

if (_action) then {
    // préparation des variables pour le calcule du nombre de groupe
    _locProx = nearestLocations [position _zo, ODD_var_LocationType, 3000];
    // Recup les location a - de 3000m
    {
        if (text _x in ODD_var_LocationBlkList) then {
            // si dans la liste Noir
            _locProx deleteAt _forEachindex;
            // on delete la location de notre liste
        };
    }forEach _locProx;
    // !\ pas compté celle ou on est
    _Buildings = nearestobjects [position _zo, ODD_var_Maison, size _zo select 0];
    // Nombre de odd_var_maison dans la localité
    _taille = size _zo select 0;
    // Taille de la Zone
    _heure = date select 3;
    // heure de la journée
    private _loctype = 0;
    if (type _zo == ODD_var_LocationType select 5) then {
        _loctype = 0;
    };
    if (type _zo == ODD_var_LocationType select 4) then {
        _loctype = 1;
    };
    if (type _zo == ODD_var_LocationType select 3) then {
        _loctype = 2;
    };
    if (type _zo == ODD_var_LocationType select 2) then {
        _loctype = 3;
    };
    if (type _zo == ODD_var_LocationType select 1) then {
        _loctype = 4;
    };
    if (type _zo == ODD_var_LocationType select 0) then {
        _loctype = 5;
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
    // definie qu'il faut faire spawn une caisse
    
    // Recupère tout les batiments a proximité
    _Buildings = nearestobjects [position _zo, ODD_var_Maison, size _zo select 0];
    
    if (count _Buildings < count _nbgroup) then {
        // Si il y a peux de batiment
        if (count _Buildings < 10) then {
            _nbgroup resize (count _Buildings - 1);
            // diminue le nombre de groupe
        } else {
            _nbgroup resize (count _Buildings - ((count _Buildings) * 0.1));
            // diminue le nombre de groupe
        };
    };
    // */ Le but est qu'il y n'est pas 15 groupes en garnison dans 5 odd_var_maison sur des petits obj avec beaucoup de joueurs
    // systemChat(format["Garnison : %1", count _nbgroup]);
    
    // Pour tout les groupes nessaire
    {
        private _group = [];
        // choisi un groupe
        if (floor(random 2) == 0) then {
            _group = selectRandom ODD_var_fireTeam;
        } else {
            _group = selectRandom ODD_var_squad;
        };
        // choisi un batiment aléatoirement
        _GBuild = selectRandom _Buildings;
        
        // caisse med
        if (_Med and (count _Buildings > 20)) then {
            // si plus de 20 odd_var_maison, et pas de caisse
            _posBox = [position _GBuild select 0, position _GBuild select 1, (position _GBuild select 2) + 2];
            _posBox set[2, 1];
            _box = "ACE_medicalSupplyCrate_advanced" createvehicle _posBox;
            // pose une caisse
            _Med = false;
            // definie que la caisse a spawn
        };
        
        // spawn le groupe
        _g = [getPos _GBuild, east, _group] call BIS_fnc_spawngroup;
        
        // Ajoute le groupe a la liste des IA de la missions
        ODD_var_MissionIA pushBack _g;
        
        // Ajoute le groupe a la liste des IA en garnison
        ODD_var_GarnisonIA pushBack _g;
        
        _Buildings = _Buildings - [_GBuild];
        
        /*
        if (!(isnil "HC1")) then {
            // systemChat "HC1 présent";
            _HCID = owner HC1;
            
            _g setgroupOwner _HCID;
            {
                _x setowner _HCID;
            } forEach (units _g);
        };
        //*/

        {
            _x setVariable ["acex_headless_blacklist", true, true]; //blacklist l'unit des HC
        } forEach (units _g);   //pour chaque units
        
        sleep 2;

        _tp = false;

        if ((position _GBuild select 2) < 0) then {
            _tp = true;
        }; 
        
        // met en garnison
        if (round(random 4) == 0) then {
            // 1 / 4 qu'il soit split dans plusieurs batiment
            [position _GBuild, nil, units _g, 20, 1, false, _tp] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        } else {
            [position _GBuild, nil, units _g, 20, 2, false, _tp] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        };
        
        // {
            // _x disableAI "PATH";
        // } forEach (units _g);
        // [getPos _GBuild, nil, units _g, 100, 1, false, false] remoteExec ["\z\ace\addons\ai\functions\fnc_garrison.sqf", 0];
        // Garnison Ace
        // ["YoutV2"] remoteExec ["systemChat"];
        // systemChat("Garnison");
    }forEach _nbgroup;
    
    /*
    sleep 30;
    // _clientID = owner _someobject;
    {
        if (_x == (ODD_var_GarnisonIA select 0)) then {
            [position ((units _x) select 0), nil, units _x, 20, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
            // Garnison Ace
        } else {
            {
                [position ((units _x) select 0), nil, units _x, 100, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
                // Garnison Ace
            }forEach units _x;
        };
    }forEach ODD_var_GarnisonIA;
    // */
} else {
    _NbGarnison = round (2 + _human_players / 2);

    _nbgroup resize _NbGarnison;
    // remplacé la fonction
    
    // Recupère tout les batiments a proximité
    _Buildings = nearestobjects [position _zo, ODD_var_Maison, size _zo select 0];
    
    if (count _Buildings < count _nbgroup) then {
        // Si il y a peux de batiment
        _nbgroup resize (count _Buildings - 2);
        // diminue le nombre de groupe
    };
    // Le but est qu'il y n'est pas 15 groupes en garnison dans 5 odd_var_maison sur des petits obj avec beaucoup de joueurs
    
    [["Nombre de Garnison sur %1 : %2 groupes", text _zo, _NbGarnison]] call ODD_fnc_log;

    // Pour tout les groupes nessaire
    {
        // choisi un groupe
        private _group = selectRandom ODD_var_fireTeam;
        
        // choisi un batiment aléatoirement
        _GBuild = selectRandom _Buildings;
        
        // spawn le groupe
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
        
        // met en garnison
        if (round(random 4) == 0) then {
            // 1 / 4 qu'il soit split dans plusieurs batiment
            [position _GBuild, nil, units _g, 20, 1, false, _tp] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        } else {
            [position _GBuild, nil, units _g, 20, 2, false, _tp] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        };
        // Garnison Ace
    }forEach _nbgroup;
};
// systemChat("2.fin");

/*
{
	_x setVariable ["acex_headless_blacklist", true, true];
} forEach (units _g);//*/