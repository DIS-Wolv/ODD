/*
* Author: Wolv
* Fonction permetant de créé un odd_var_objectif sur une zone 
*
* Arguments:
* 0: Zone souhaité <Obj>
* 1: Type d'odd_var_objectif souhaité <INT>
* 2: Activation du ODD_var_DEBUG dans le chat <BOOL>
*
* Return Value:
* Nom de l'odd_var_objectif créé
*
* Example:
* [_zo] call ODD_fnc_createTarget
* [_zo, _missiontype, _Debug] call ODD_fnc_createTarget
*
* Public:
*/
params ["_zo", ["_type", -1], ["_Debug", false]];

// Choisis une missions random
private _Mission = selectRandom ODD_var_SelectedTarget;

[["Mission choisi : %1", _Mission]] call ODD_fnc_log;

// ODD_var_DEBUG => force le type de missions
if (_type >= 0 and _type < count ODD_var_TargetTypeName) then {
    _Mission = ODD_var_TargetTypeName select _type;
    [["Mission forcé : %1 (%2)", _Mission, _type]] call ODD_fnc_log;
};

_Buildings = [];

while {count _Buildings == 0} do {
    _Buildings = nearestobjects[position _zo, ODD_var_Maison, 200];
    [["Nombre de Batiment sur la %1 : %2", text _zo, count _Buildings]] call ODD_fnc_log;
};

ODD_var_Objectif = [];
publicVariable "ODD_var_Objectif";

_tgBuild = selectRandom _Buildings;

switch (_Mission) do {
    case (ODD_var_TargetTypeName select 0): {       // Caisses
        _posBox = [position _tgBuild select 0, position _tgBuild select 1, (position _tgBuild select 2) + 2];
        
        // Cree la caisses
        _box = "Box_IED_exp_F" createvehicle _posBox;
        _box setPos _posBox;
            // la position 2 mettre plus haut
        _box additemCargoGlobal ["DemoCharge_Remote_Mag", 2];
            // Ajoute des charges explo
        
        ODD_var_Objectif pushBack _box;
        
    
        // attent 1s
        sleep(1);
            // pour pas tuer un gars avec la caisses
        
        private _group = [];
        
        if ((round random 2) == 0) then {
            _group = selectRandom ODD_var_pair;
            // choisi un groupe de 2
        } else {
            _group = selectRandom ODD_var_fireTeam;
            // choisi un groupe de 4
        };
        // spawn 2 gars pour defendre
        _g = [position _tgBuild, east, _group] call BIS_fnc_spawngroup;
        
        // Ajoute le groupe a la liste des IA de la missions
        ODD_var_MissionIA pushBack _g;
        
        // met en garnison
        /*
        if (!(isnil "HC1")) then {
            [["HC1 présent"]] call ODD_fnc_log;
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
        
        [position _tgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";

        // cree la tache
        _task = [true, "Task", [format[selectRandom ODD_var_TextCaisse, text _zo], "Détruire les caisses", "ODdoBJ"], objNull, "CREATED", 2] call BIS_fnc_taskCreate;
        ["Task", "destroy"] call BIS_fnc_tasksettype;
    };
    case (ODD_var_TargetTypeName select 1): {       // HVT
        // choisi une HVT random
        private _group = selectRandom ODD_var_HVT;
        
        // ajoute au groupe de la HVT 4 gars en protection
        _group append selectRandom ODD_var_fireTeam;
        // systemChat(str(_group));
        
        // spawn le groupe
        _g = [position _tgBuild, east, _group] call BIS_fnc_spawngroup;
        
        // Ajoute le groupe a la liste des IA de la missions
        ODD_var_MissionIA pushBack _g;
        ODD_var_Objectif pushBack (units _g select 0);
        // systemChat(str(units _g select 0));
        
        ((units _g) select 0) addHandgunItem "hgun_pistol_heavy_02_F";
        if (round random 4 == 1) then {
            // met en patrioulle
            [_g, getPos _tgBuild, 100] call bis_fnc_taskpatrol;
        } else {
            // met en garnison
            /*
            if (!(isnil "HC1")) then {
                [["HC1 présent"]] call ODD_fnc_log;
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
            [position _tgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
            // Garnison Ace
        };
        
        
        // cree la tache
        _task = [true, "Task", [format[selectRandom ODD_var_TextHVT, text _zo], "Neutraliser une HVT", "ODdoBJ"], objNull, "CREATED", 2] call BIS_fnc_taskCreate;
        ["Task", "kill"] call BIS_fnc_tasksettype;
    };
    case (ODD_var_TargetTypeName select 2): {       // Secure Area
        // cree la tache
        _task = [true, "Task", [format[selectRandom ODD_var_TextSecure, text _zo], "Sécuriser la zone", "ODdoBJ"], objNull, "CREATED", 2] call BIS_fnc_taskCreate;
        ["Task", "attack"] call BIS_fnc_tasksettype;
    };
    case (ODD_var_TargetTypeName select 3): {       // intel
        _intellist = ["Item_SmartPhone", "Item_ItemalivePhoneOld", "Item_MobilePhone", "Item_SatPhone", "land_IPPhone_01_black_F", "land_IPPhone_01_olive_F", "land_IPPhone_01_sand_F", "land_Laptop_F", "land_Laptop_device_F", "land_Laptop_unfolded_F", "land_Laptop_intel_01_F", "land_Laptop_intel_02_F", "land_Laptop_intel_Oldman_F", "land_laptop_03_closed_black_F", "land_Laptop_03_black_F", "land_laptop_03_closed_olive_F", "land_Laptop_03_olive_F", "land_laptop_03_closed_sand_F", "land_Laptop_03_sand_F", "land_Laptop_02_F", "land_Laptop_02_unfolded_F"];
        
        _posintel = [position _tgBuild select 0, position _tgBuild select 1, (position _tgBuild select 2) + 2];
        
        _posintel set[2, 1];
        _table = "land_WoodenTable_small_F" createvehicle _posintel;
        _table setDir (getDir _tgBuild);
        ODD_var_MissionProps pushBack _table;
        _posintel = position _table;
        sleep 0.1;
        _posintel set[2, 1.5];
        
        _intel = "land_Laptop_F" createvehicle _posintel;
        _intel setPos _posintel;
        // la position 2 mettre plus haut

        /*_intel addAction ["<t color='#FF0000'>Recupérer les intels</t>", {
            ODD_var_Objectif set[1, false];
            deletevehicle (_this select 0);
            }];
        //*/
        
        [
            _intel, "<t color='#FF0000'>Recupérer les intels</t>", 	"\A3\Ui_f\data\IGUI\Cfg\Holdactions\holdaction_search_ca.paa",
            "\A3\Ui_f\data\IGUI\Cfg\Holdactions\holdaction_search_ca.paa", "_target distance _this < 3", "true", {}, {}, {
                ODD_var_Objectif set[1, false];
                ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState; publicVariable "ODD_var_Objectif"; [(_this select 0)] remoteExec ["removeAllActions"];
            },
            {}, [], (random[2, 10, 15]), nil, true, true
        ] remoteExec ["BIS_fnc_holdActionAdd"];

        ODD_var_MissionProps pushBack _intel;
        ODD_var_Objectif pushBack _intel;
        ODD_var_Objectif pushBack true;
        // systemChat(str(ODD_var_Objectif));
        

        // attent 1s
        sleep(1);
            // pour pas tuer un gars avec la caisses
        
        // cree la tache
        [true, "Task", [format[selectRandom ODD_var_TextIntel, text _zo], "Récupérer des informations", "ODdoBJ"], objNull, "CREATED", 2] call BIS_fnc_taskCreate;
        ["Task", "intel"] call BIS_fnc_tasksettype;
        
        private _group = [];
        if (round (random 2) == 0) then {
            _group = selectRandom ODD_var_pair;
            // choisi un groupe de 2
        } else {
            _group = selectRandom ODD_var_fireTeam;
            // choisi un groupe de 4
        };
        // spawn 2 gars pour defendre
        _g = [position _tgBuild, east, _group] call BIS_fnc_spawngroup;
        
        // Ajoute le groupe a la liste des IA de la missions
        ODD_var_MissionIA pushBack _g;

        {
            _x setVariable ["acex_headless_blacklist", true, true]; //blacklist l'unit des HC
        } forEach (units _g);   //pour chaque units
        
        // met en garnison
        // [_g, getPos _tgBuild] execVM "\x\cba\addons\ai\fnc_waypointgarrison.sqf";
        [position _tgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
    };
    case (ODD_var_TargetTypeName select 4): {       // Helico
        _pos = position _zo getPos [((size _zo)select 0) * random 1, random 360];
        
        while {(count nearestTerrainObjects [_pos, ["Rocks", "House"], 8] > 0) or ((_pos select 2) < 0)} do {
            // si il y a plus de 0 cailloux dans les 10 mettres ou position sous l'eau
            _pos = position _zo getPos [random 800, random 360];
            // tire une nouvelles position car on veux pas qu'il spawn dans un cailloux
        };
        
        _helico = "land_Wreck_Heli_Attack_01_F" createvehicle _pos;

        ODD_var_ParticuleList pushBack _pos;

        publicVariable "ODD_var_ParticuleList";
        
        [True] remoteExec ["ODD_fnc_particules", 0];
        
        /* _helico addAction ["<t color='#FF0000'>Recupérer les boîtes noires</t>", {
            ODD_var_Objectif set[1, false];
        }];//*/
        [
            _helico, "<t color='#FF0000'>Recupérer les boîtes noires</t>", 	"\A3\Ui_f\data\IGUI\Cfg\Holdactions\holdaction_search_ca.paa",
            "\A3\Ui_f\data\IGUI\Cfg\Holdactions\holdaction_search_ca.paa", "_target distance _this < 4", "true", {}, {}, {
                ODD_var_Objectif set [1, false];
                ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState; publicVariable "ODD_var_Objectif";[(_this select 0)] remoteExec ["removeAllActions"];
            },
            {}, [], (random[10, 20, 30]), nil, true, false
        ] remoteExec ["BIS_fnc_holdActionAdd"];
        ODD_var_MissionProps pushBack _helico;
        ODD_var_Objectif pushBack _helico;
        ODD_var_Objectif pushBack true;
        
        private _group = [];
        if ((round random 2) == 0) then {
            _group = selectRandom ODD_var_pair;
            // choisi un groupe de 2
        } else {
            _group = selectRandom ODD_var_fireTeam;
            // choisi un groupe de 4
        };
        // spawn 2 gars pour defendre
        _g = [position _tgBuild, east, _group] call BIS_fnc_spawngroup;
        
        // Ajoute le groupe a la liste des IA de la missions
        ODD_var_MissionIA pushBack _g;
        
        _posSmoke = _pos;
        _posSmoke set [1, (_posSmoke select 1) - 3];
        _smoke = "firePlace_burning_F" createvehicle _pos;
        _smoke setPos _pos;
        ODD_var_MissionProps pushBack _smoke;
        // ODD_var_MissionProps pushBack _smoke;
        
        private _group = selectRandom ODD_var_fireTeam;
        
        // systemChat(str(_pos));
        // spawn le groupe
        _g = [_pos, east, _group] call BIS_fnc_spawngroup;
        
        // Ajoute le groupe a la liste des IA de la missions
        ODD_var_MissionIA pushBack _g;
        
        sleep 1;
        
        // cree la tache
        _task = [true, "Task", [format[selectRandom ODD_var_TextHelico, text _zo], "Récupérer les boîtes noires", "ODdoBJ"], objNull, "CREATED", 2] call BIS_fnc_taskCreate;
        ["Task", "heli"] call BIS_fnc_tasksettype;
        
        [_g, _pos, 150] call bis_fnc_taskpatrol;
    };
    case (ODD_var_TargetTypeName select 5): {       // Save Prisoniers
        // cree la tache
        _task = [true, "Task", [format[selectRandom ODD_var_TextPrisoniers, text _zo], "Sauver le pilote allié", "ODdoBJ"], objNull, "CREATED", 2] call BIS_fnc_taskCreate;
        ["Task", "scout"] call BIS_fnc_tasksettype;
        
        // choisi une Prisonier random
        private _group = selectRandom ODD_var_Otage;
        
        // spawn un gars
        _g = [position _tgBuild, west, _group] call BIS_fnc_spawngroup;
        // ((units _g) select 0) setCaptive 1;

        {
            _x setVariable ["acex_headless_blacklist", true, true]; //blacklist l'unit des HC
        } forEach (units _g);   //pour chaque units

        //passe en prisonier
        [position _tgBuild, nil, units _g, 10, 1, false, true] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
            // Garnison Ace
        sleep 1;
        [((units _g) select 0), true, player] execVM "\z\ace\addons\captives\functions\fnc_setHandcuffed.sqf";
                    // captif ace
        
        ODD_var_MissionProps pushBack (units _g select 0);
        ODD_var_Objectif pushBack (units _g select 0);
        
        // cree un groupe en protection
        _group = selectRandom ODD_var_fireTeam;
        
        _g = [position _tgBuild, east, _group] call BIS_fnc_spawngroup;
        ODD_var_MissionIA pushBack _g;
        ODD_var_GarnisonIA pushBack _g;
        /*
        if (!(isnil "HC1")) then {
            [["HC1 présent"]] call ODD_fnc_log;
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
        
        [position _tgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        // Garnison Ace
    };
    case (ODD_var_TargetTypeName select 6): {       // Secure VL
        // cree la tache
        _task = [true, "Task", [format[selectRandom ODD_var_TextSecureVL, text _zo], "Securiser le véhicule", "ODdoBJ"], objNull, "CREATED", 2] call BIS_fnc_taskCreate;
        ["Task", "car"] call BIS_fnc_tasksettype;
        
        _vl = selectRandom ODD_var_tgVehicule;
        // choisie un vl
        
        // recupère les route proche du centre de l'odd_var_objectif
        // _roads = position _zo nearRoads 300;
        // _road = selectRandom _roads;
            //choisi une route random
        
        _pos = position _tgBuild;
            // recup la pos
        
        _dir = getDir _tgBuild;
        
        // _pos = _pos getPos [5, (_dir + 90 + ((round (random 2))* 180)) % 360];
            //pose le vl sur le coté
        
        _posvl = _pos findEmptyposition [4, 100, _vl];
        //, "B_Heli_Transport_01_F"
        
        // _posVl = _pos;
        // _posVl set[3, (_posVl select 3) + 2];
        
        // _posvl = _posvl getPos [2, [_pos, _posvl] call BIS_fnc_dirto];
        
        _g = _vl createvehicle _posvl;
        // créé le VL

        _g addItemCargoGlobal ["Toolkit", 1]; 
        // Ajoute un repaire kit
        
        _g setDir _dir;
        
        sleep 0.5;
        _g setFuel 1;
        _g setDamage 0;
        
        sleep 2;
        if (!alive _g) then {
            _pos = position _g;
            
            deletevehicle _g;
            
            sleep 1;
            
            _g = _vl createvehicle _posvl;
            // créé le VL

            _g addItemCargoGlobal ["Toolkit", 1]; 
            // Ajoute un repaire kit
            
            _g setDir _dir;
            
            sleep 0.5;
            _g setFuel 1;
            _g setDamage 0;
        };
        
        ODD_var_MissionProps pushBack _g;
        ODD_var_Objectif pushBack _g;
        
        sleep 1;
        // cree un groupe en protection
        _group = selectRandom ODD_var_fireTeam;
        
        _g = [_pos, east, _group] call BIS_fnc_spawngroup;
        ODD_var_MissionIA pushBack _g;
        ODD_var_GarnisonIA pushBack _g;
        /*
        if (!(isnil "HC1")) then {
            [["HC1 présent"]] call ODD_fnc_log;
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
        
        [_pos, nil, units _g, 5, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        // Garnison Ace
    };
    case (ODD_var_TargetTypeName select 7): {       // Destroy VL
        //["TEST NOUVELLE MISSIONS"] remoteExec ["systemChat", 0]; 
        // cree la tache
        _task = [true, "Task", [format[selectRandom ODD_var_TextDestroyVL, text _zo], "Détruire le véhicule", "ODdoBJ"], objNull, "CREATED", 2] call BIS_fnc_taskCreate;
        ["Task", "car"] call BIS_fnc_tasksettype;
        
        _vl = selectRandom oDD_var_tgVehicule;
        // choisie un vl
        
        // recupère les route proche du centre de l'odd_var_objectif
        // _roads = position _zo nearRoads 300;
        // _road = selectRandom _roads;
            //choisi une route random
        
        _pos = position _tgBuild;
            // recup la pos
        
        _dir = getDir _tgBuild;
        
        // _pos = _pos getPos [5, (_dir + 90 + ((round (random 2))* 180)) % 360];
            //pose le vl sur le coté
        
        _posvl = _pos findEmptyposition [4, 100, _vl];
        //, "B_Heli_Transport_01_F"
        
        // _posVl = _pos;
        // _posVl set[3, (_posVl select 3) + 2];
        
        // _posvl = _posvl getPos [2, [_pos, _posvl] call BIS_fnc_dirto];
        
        _g = _vl createvehicle _posvl;
        // créé le VL

        _g addItemCargoGlobal ["Toolkit", 1]; 
        // Ajoute un repaire kit
        
        _g setDir _dir;
        
        sleep 0.5;
        _g setFuel 1;
        _g setDamage 0;
        
        sleep 2;
        if (!alive _g) then {
            _pos = position _g;
            
            deletevehicle _g;
            
            sleep 1;
            
            _g = _vl createvehicle _posvl;
            // créé le VL

            _g addItemCargoGlobal ["Toolkit", 1]; 
            // Ajoute un repaire kit
            
            _g setDir _dir;
            
            sleep 0.5;
            _g setFuel 1;
            _g setDamage 0;
        };
        
        ODD_var_MissionProps pushBack _g;
        ODD_var_Objectif pushBack _g;
        
        sleep 1;
        // cree un groupe en protection
        _group = selectRandom ODD_var_fireTeam;
        
        _g = [_pos, east, _group] call BIS_fnc_spawngroup;
        ODD_var_MissionIA pushBack _g;
        ODD_var_GarnisonIA pushBack _g;
        /*
        if (!(isnil "HC1")) then {
            [["HC1 présent"]] call ODD_fnc_log;
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
        
        [_pos, nil, units _g, 5, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        // Garnison Ace
    };
};

publicVariable "ODD_var_Objectif";
publicVariable "ODD_var_MissionProps";
// */

// Renvoie le type de missions
_Mission