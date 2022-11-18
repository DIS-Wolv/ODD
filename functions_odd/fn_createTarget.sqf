/*
* Auteur : Wolv
* Fonction pour créer un objectif sur une zone 
*
* Arguments :
* 0: Zone souhaité <Obj>
* 1: Type d'objectif souhaité <INT>
*
* Valeur renvoyée :
* Nom de l'objectif créé
*
* Exemple:
* [_zo] call ODD_fnc_createTarget
* [_zo, _missiontype] call ODD_fnc_createTarget
*
* Variable publique :
*/
params ["_zo", ["_type", -1]];

private _Mission = selectRandom ODD_var_SelectedTarget;
// Choisi une mission aléatoire parmi la lister

[["Mission choisie : %1", _Mission]] call ODD_fnc_log;

if (_type >= 0 and _type < count ODD_var_MissionType) then {
    _Mission = ODD_var_MissionType select _type;
    [["Mission forcé : %1 (%2)", _Mission, _type]] call ODD_fnc_log;
};

_Buildings = [];

while {count _Buildings == 0} do {
    _Buildings = nearestobjects[position _zo, ODD_var_Houses, 200];
    [["Nombre de batiments sur la %1 : %2", text _zo, count _Buildings]] call ODD_fnc_log;
};

ODD_var_Objective = [];
publicVariable "ODD_var_Objective";

_tgBuild = selectRandom _Buildings;

switch (_Mission) do {
    case (ODD_var_MissionType select 0): {        // Mission de destruction d' une caisse
        _posBox = [position _tgBuild select 0, position _tgBuild select 1, (position _tgBuild select 2) + 2];
        // Surélève la caisse de 2m 
        _box = "Box_IED_exp_F" createvehicle _posBox;
        _box setPos _posBox;
        // Crée la caisse et la place dans une maison
        _box additemCargoGlobal ["DemoCharge_Remote_Mag", 2];
        // Ajoute des charges explosives à la caisse
        
        ODD_var_Objective pushBack _box;

        sleep(1);
        // Attend une seconde pour ne pas tuer une AI avec la caisse 
        
        private _group = [];
        
        if ((round random 2) == 0) then {
        // Choisi aléatoirement
            _group = selectRandom ODD_var_Pair;
            // Un groupe de 2 unités
        }
        else {
            _group = selectRandom ODD_var_FireTeam;
            // Un groupe de 4 unité
        };
        _g = [position _tgBuild, east, _group] call BIS_fnc_spawngroup;
        //Crée le groupe pour défendre l'objectif
        
        ODD_var_MainAreaIA pushBack _g;
        // Ajoute le groupe a la liste des IA de la missions

        {
            _x setVariable ["acex_headless_blacklist", true, true]; 
            // Ajoute l'unité à la liste noire des clients headless
        } forEach (units _g);
        // Réitère pour chaque unité du groupe
        
        [position _tgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";

        _task = [true, ["ODD_task_mission", "ODD_task_main"], [format[selectRandom ODD_var_MissionBriefDestroyCrate, text _zo], "Détruire les caisses", "ODdoBJ"], objNull, "CREATED", 2, True, "destroy"] call BIS_fnc_taskCreate;
        // Crée la tâche
    };
    case (ODD_var_MissionType select 1): {        // Mission d'élimination d'une HVT
        private _group = selectRandom ODD_var_HVTKill;
        // Choisi une HVT aléatoire
        
        _group append selectRandom ODD_var_FireTeam;
        // Ajoute 4 unités au groupe de la HVT
        // systemChat(str(_group));
        
        _g = [position _tgBuild, east, _group] call BIS_fnc_spawngroup;
        // Crée le groupe

        ODD_var_MainAreaIA pushBack _g;
        // Ajoute le groupe à la liste des IA de la mission
        ODD_var_Objective pushBack (units _g select 0);
        // systemChat(str(units _g select 0));
        
        ((units _g) select 0) addHandgunItem "hgun_pistol_heavy_02_F";
        if (round random 4 == 1) then {
            // Avec 25% de chance 
            [_g, getPos _tgBuild, 100] call bis_fnc_taskpatrol;
            // Le groupe est en patrouille
        }
        else {
            {
                _x setVariable ["acex_headless_blacklist", true, true]; 
            // Ajoute l'unité à la liste noire des clients headless
            } forEach (units _g);  
        // Réitère pour chaque unité du groupe
            [position _tgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
            // Sinon, le groupe est mis en garnison avec ACE
        };
        
        _task = [true, ["ODD_task_mission", "ODD_task_main"], [format[selectRandom ODD_var_MissionBriefKillHVT, text _zo], "Neutraliser une HVT", "ODdoBJ"], objNull, "CREATED", 2, True, "target"] call BIS_fnc_taskCreate;
        // Crée la tâche
    };
    case (ODD_var_MissionType select 2): {        // Mission de capture d'une HVT
        private _group = selectRandom ODD_var_HVTSecure;
        // Choisi une HVT aléatoire
        
        _group append selectRandom ODD_var_FireTeam;
        // Ajoute 4 unités au groupe de la HVT
        // systemChat(str(_group));
        
        _g = [position _tgBuild, east, _group] call BIS_fnc_spawngroup;
        // Crée le groupe

        ((units _g) select 0) addItemToUniform "Chemlight_yellow";
        
        ODD_var_MainAreaIA pushBack _g;
        // Ajoute le groupe à la liste des IA de la mission
        ODD_var_Objective pushBack (units _g select 0);
        // systemChat(str(units _g select 0));
        
        _hvt = (units _g select 0);

        removeAllWeapons _hvt;
        _hvt addWeapon "hgun_Pistol_heavy_02_F";
        _hvt addHandgunItem "6Rnd_45ACP_Cylinder";
        for "_i" from 0 to (round(random 3)) do {_hvt addMagazine "6Rnd_45ACP_Cylinder";};

        if (round random 4 == 1) then {
            // Avec 25% de chance 
            [_g, getPos _tgBuild, 100] call bis_fnc_taskpatrol;
            // Le groupe est en patrouille
        }
        else {
            {
                _x setVariable ["acex_headless_blacklist", true, true]; 
            // Ajoute l'unité à la liste noire des clients headless
            } forEach (units _g);   
        // Réitère pour chaque unité du groupe
            [position _tgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
            // Sinon, le groupe est mis en garnison avec ACE
        };
        
        _hvt addEventHandler ["Hit", {
            params ["_unit", "_source", "_damage", "_instigator"];
            _hvtSurrenderSound = ["hvtSurrender1", "hvtSurrender2", "hvtSurrender3"];
            _sound = getMissionPath "ODDSound\" + (selectRandom _hvtSurrenderSound) + ".ogg";
            playSound3D [_sound, _unit, false, position _unit, 3, 1, 30];
            [_unit, true] execVM "\z\ace\addons\captives\functions\fnc_setSurrendered.sqf";
        }];

        _task = [true, ["ODD_task_mission", "ODD_task_main"], [format[((selectRandom ODD_var_MissionBriefSecureHVT)+ " Il possède une chemlight jaune."), text _zo, name _hvt], "Capturer une HVT", "ODdoBJ"], objNull, "CREATED", 2, True, "kill"] call BIS_fnc_taskCreate;
        // Crée la tâche
    };
    case (ODD_var_MissionType select 3): {        // Mission de sécurisation de zone
        _task = [true, ["ODD_task_mission", "ODD_task_main"], [format[selectRandom ODD_var_MissionBriefSecureArea, text _zo], "Sécuriser la zone", "ODdoBJ"], objNull, "CREATED", 2, True, "attack"] call BIS_fnc_taskCreate;
        // Crée la tâche
    };
    case (ODD_var_MissionType select 4): {        // Mission de récupération de renseignements
        _intellist = ["Item_SmartPhone", "Item_ItemalivePhoneOld", "Item_MobilePhone", "Item_SatPhone", "land_IPPhone_01_black_F", "land_IPPhone_01_olive_F", "land_IPPhone_01_sand_F", "land_Laptop_F", "land_Laptop_device_F", "land_Laptop_unfolded_F", "land_Laptop_intel_01_F", "land_Laptop_intel_02_F", "land_Laptop_intel_Oldman_F", "land_laptop_03_closed_black_F", "land_Laptop_03_black_F", "land_laptop_03_closed_olive_F", "land_Laptop_03_olive_F", "land_laptop_03_closed_sand_F", "land_Laptop_03_sand_F", "land_Laptop_02_F", "land_Laptop_02_unfolded_F"];
        _posintel = [position _tgBuild select 0, position _tgBuild select 1, (position _tgBuild select 2) + 2];
        _posintel set[2, 1];
        _table = "land_WoodenTable_small_F" createvehicle _posintel;
        _table setDir (getDir _tgBuild);
        ODD_var_MissionProps pushBack _table;
        _posintel = position _table;
        sleep 0.1;
        _posintel set[2, 1.5];
        _intelobj = selectrandom _intellist;
        _intel = _intelobj createvehicle _posintel;
        _intel setPos _posintel;
        // Choisi un appareil dans la liste puis le pose sur un table
        [
            _intel, "<t color='#FF0000'>Recupérer les intels</t>", 	"\A3\Ui_f\data\IGUI\Cfg\Holdactions\holdaction_search_ca.paa",
            "\A3\Ui_f\data\IGUI\Cfg\Holdactions\holdaction_search_ca.paa", "_target distance _this < 3", "true", {}, {}, {
                ODD_var_Objective set[1, false];
                ["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState; publicVariable "ODD_var_Objective"; [(_this select 0)] remoteExec ["removeAllActions", 0, true];
            },
            {}, [], (random[2, 10, 15]), nil, true, true
        ] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
        // Ajoute l'interaction de récupération

        ODD_var_MissionProps pushBack _intel;
        ODD_var_Objective pushBack _intel;
        ODD_var_Objective pushBack true;
        
        sleep(1);
        // Attend une seconde pour ne pas tuer une AI
        
        [true, ["ODD_task_mission", "ODD_task_main"], [format[selectRandom ODD_var_MissionBriefSecureIntel, text _zo], "Récupérer des informations", "ODdoBJ"], objNull, "CREATED", 2, True, "intel"] call BIS_fnc_taskCreate;
        // Crée la tâche
        
        private _group = [];
        if (round (random 2) == 0) then {
        // Choisi aléatoirement
            _group = selectRandom ODD_var_Pair;
            // Un groupe de 2 unités
        }
        else {
            _group = selectRandom ODD_var_FireTeam;
            // Un groupe de 4 unités
        };
        _g = [position _tgBuild, east, _group] call BIS_fnc_spawngroup;
        //Crée le groupe pour défendre l'objectif
        
        ODD_var_MainAreaIA pushBack _g;
        // Ajoute le groupe à la liste des IA de la mission

        {
            _x setVariable ["acex_headless_blacklist", true, true];
            // Ajoute l'unité à la liste noire des clients headless
        } forEach (units _g);  
        // Réitère pour chaque unité du groupe

        [position _tgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
    };
    case (ODD_var_MissionType select 5): {        // Mission de récupération de boites noires
        _pos = position _zo getPos [((size _zo)select 0) * random 1, random 360];
        
        while {(count nearestTerrainObjects [_pos, ["Rocks", "House"], 8] > 0) or ((_pos select 2) < 0)} do {
            // S'il y a des rochers ou des maisons à moins de 8m ou si la position est sous l'eau
            _pos = position _zo getPos [random 800, random 360];
            // Tire une nouvelle position
        };
        
        _helico = "land_Wreck_Heli_Attack_01_F" createvehicle _pos;
        ODD_var_MissionSmokePillar pushBack _pos;
        publicVariable "ODD_var_MissionSmokePillar";
        
        [True] remoteExec ["ODD_fnc_particules", 0];
        [
            _helico, "<t color='#FF0000'>Recupérer les boîtes noires</t>", 	"\A3\Ui_f\data\IGUI\Cfg\Holdactions\holdaction_search_ca.paa",
            "\A3\Ui_f\data\IGUI\Cfg\Holdactions\holdaction_search_ca.paa", "_target distance _this < 4", "true", {}, {}, {
                ODD_var_Objective set [1, false];
                ["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState; publicVariable "ODD_var_Objective";[(_this select 0)] remoteExec ["removeAllActions", 0, true];
            },
            {}, [], (random[10, 20, 30]), nil, true, false
        ] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
        ODD_var_MissionProps pushBack _helico;
        ODD_var_Objective pushBack _helico;
        ODD_var_Objective pushBack true;
        
        _posSmoke = _pos;
        _posSmoke set [1, (_posSmoke select 1) - 3];
        _smoke = "firePlace_burning_F" createvehicle _pos;
        _smoke setPos _pos;
        ODD_var_MissionProps pushBack _smoke;
        
        private _group = selectRandom ODD_var_FireTeam;
        // systemChat(str(_pos));
        _g = [_pos, east, _group] call BIS_fnc_spawngroup;
        
        ODD_var_MainAreaIA pushBack _g;
        // Ajoute le groupe à la liste des IA de la mission
        
        sleep 1;
        [_g, _pos, 150] call bis_fnc_taskpatrol;
        _task = [true, ["ODD_task_mission", "ODD_task_main"], [format[selectRandom ODD_var_MissionBriefBlackBoxes, text _zo], "Récupérer les boîtes noires", "ODdoBJ"], objNull, "CREATED", 2, True, "scout"] call BIS_fnc_taskCreate;
        // Crée la tâche
    };
    case (ODD_var_MissionType select 6): {        // Mission de sauvetage d'un allié
        _task = [true, ["ODD_task_mission", "ODD_task_main"], [format[selectRandom ODD_var_MissionBriefSecureHostages, text _zo], "Sauver le pilote allié", "ODdoBJ"], objNull, "CREATED", 2, True, "meet"] call BIS_fnc_taskCreate;
        // Crée la tâche
        
        private _group = selectRandom ODD_var_Hostages;
        // Choisi un prisonier aléatoire
        
        _g = [position _tgBuild, west, _group] call BIS_fnc_spawngroup;
        // Crée le prisonier

        {
            _x setVariable ["acex_headless_blacklist", true, true];
            // Ajoute l'unité à la liste noire des clients headless
        } forEach (units _g);   
        // Réitère pour chaque unité du groupe

        [position _tgBuild, nil, units _g, 10, 1, false, true] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        // Met le prisonier en garnison
        sleep 1;
        [((units _g) select 0), true, player] execVM "\z\ace\addons\captives\functions\fnc_setHandcuffed.sqf";
        // Bascule le prisonier en captivité ACE
        
        ODD_var_MissionProps pushBack (units _g select 0);
        ODD_var_Objective pushBack (units _g select 0);
        
        _group = selectRandom ODD_var_FireTeam;
        
        _g = [position _tgBuild, east, _group] call BIS_fnc_spawngroup;
        //Crée le groupe pour défendre l'objectif
        ODD_var_MainAreaIA pushBack _g;
        ODD_var_GarnisonnedIA pushBack _g;
        {
            _x setVariable ["acex_headless_blacklist", true, true]; 
            // Ajoute l'unité à la liste noire des clients headless
        } forEach (units _g);   
        // Réitère pour chaque unité du groupe
        
        [position _tgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
    };
    case (ODD_var_MissionType select 7): {        // Mission de sécurisation d'un véhicule ennemi
        _task = [true, ["ODD_task_mission", "ODD_task_main"], [format[selectRandom ODD_var_MissionBriefSecureVehicle, text _zo], "Securiser le véhicule", "ODdoBJ"], objNull, "CREATED", 2, True, "car"] call BIS_fnc_taskCreate;
        // Crée la tâche
        
        _vl = selectRandom ODD_var_SercureVehicles;
        // Choisi un véhicule
        
        _pos = position _tgBuild;
        // Récupère la position pour l'objectif
        
        _dir = getDir _tgBuild;
        _posvl = _pos findEmptyposition [4, 100, _vl];
        
        _g = _vl createvehicle _posvl;
        // Crée le véhicule

        _g addItemCargoGlobal ["Toolkit", 1]; 
        // Ajoute un kit de réparation au véhicule
        
        _g setDir _dir;
        
        sleep 1;
        _g setFuel 1;
        _g setDamage 0;
        
        sleep 2;
        if (!alive _g) then {
        // Si le véhicule a été détruit lors de sa création
            _pos = position _g;
            _posvl = _pos findEmptyposition [4, 100, "B_Heli_Transport_01_F"];
            deletevehicle _g;
            sleep 1;
            _g = _vl createvehicle _posvl;
            //On le recrée
            _g addItemCargoGlobal ["Toolkit", 1];
            _g setDir _dir;
            
            sleep 1;
            _g setFuel 1;
            _g setDamage 0;
        };

        [_g, 2] remoteExec ["lock", (owner _g)];

        [_g, "<t color='#FF0000'>Déverrouiller le véhicule</t>",
        "a3\ui_f\data\igui\cfg\actions\ico_cpt_start_on_ca.paa","a3\ui_f\data\igui\cfg\actions\ico_cpt_start_on_ca.paa",
        "true", "true", {}, {},
        {
            //_target lock 0;
            [_target, 0] remoteExec ["lock", (owner _target)];
        },{}, [], (random[2, 10, 15]), nil, true, true
        ] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
        
        ODD_var_MissionProps pushBack _g;
        ODD_var_Objective pushBack _g;
        
        sleep 1;
        _group = selectRandom ODD_var_FireTeam;
        //Crée un groupe pour défendre l'objectif
        
        _g = [_pos, east, _group] call BIS_fnc_spawngroup;
        ODD_var_MainAreaIA pushBack _g;
        ODD_var_GarnisonnedIA pushBack _g;
        {
            _x setVariable ["acex_headless_blacklist", true, true]; 
            // Ajoute l'unité à la liste noire des clients headless
        } forEach (units _g);   
        // Réitère pour chaque unité du groupe

        [_pos, nil, units _g, 5, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        // Place le groupe en garnison
    };
    case (ODD_var_MissionType select 8): {        // Mission de destruction d'un véhicule ennemi
        _task = [true, ["ODD_task_mission", "ODD_task_main"], [format[selectRandom ODD_var_MissionBriefDestroyVehicle, text _zo], "Détruire le véhicule", "ODdoBJ"], objNull, "CREATED", 2, True, "car"] call BIS_fnc_taskCreate;
        // Crée la tâche
        
        _vl = selectRandom ODD_var_DestroyVehicles;
        // Choisi un véhicule
        
        _pos = position _tgBuild;
        _dir = getDir _tgBuild;
        // Récupère la position pour l'objectif

        _posvl = _pos findEmptyposition [4, 100, _vl];
        _g = _vl createvehicle _posvl;
        // Crée le véhicule

        _g addItemCargoGlobal ["Toolkit", 1]; 
        // Ajoute un kit de réparation au véhicule
        
        _g setDir _dir;
        
        sleep 1;
        _g setFuel 1;
        _g setDamage 0;
        
        sleep 5;
        if (!alive _g) then {
        // Si le véhicule a été détruit lors de sa création
            _pos = position _g;
            _posvl = _pos findEmptyposition [4, 100, "B_Heli_Transport_01_F"];
            deletevehicle _g;
            sleep 1;
            _g = _vl createvehicle _posvl;
            //On le recrée
            _g addItemCargoGlobal ["Toolkit", 1]; 
            // Ajoute un repaire kit
            _g setDir _dir;
            sleep 1;
            _g setFuel 1;
            _g setDamage 0;
        };

        [_g, 2] remoteExec ["lock", (owner _g)];

        [
            _g, "<t color='#FF0000'>Déverrouiller le véhicule</t>",
            "a3\ui_f\data\igui\cfg\actions\ico_cpt_start_on_ca.paa","a3\ui_f\data\igui\cfg\actions\ico_cpt_start_on_ca.paa",
            "true", "true", {}, {},
            {
                _target lock 0;
            },{}, [], (random[2, 10, 15]), nil, true, true
        ] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
        
        ODD_var_MissionProps pushBack _g;
        ODD_var_Objective pushBack _g;
        
        sleep 1;
        _group = selectRandom ODD_var_FireTeam;
        //Crée un groupe pour défendre l'objectif
        
        _g = [_pos, east, _group] call BIS_fnc_spawngroup;
        ODD_var_MainAreaIA pushBack _g;
        ODD_var_GarnisonnedIA pushBack _g;
        {
            _x setVariable ["acex_headless_blacklist", true, true]; 
            // Ajoute l'unité à la liste noire des clients headless
        } forEach (units _g);   
        // Réitère pour chaque unité du groupe
        
        [_pos, nil, units _g, 5, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
        // Place le groupe en garnison
    };
};

_pos = position _zo;

_pos set [0, ((_pos select 0) + ((size _zo) select 0)/2)];
_pos set [1, ((_pos select 1) + ((size _zo) select 0)/2)];

["ODD_task_mission", _pos] call BIS_fnc_taskSetDestination;

publicVariable "ODD_var_Objective";
publicVariable "ODD_var_MissionProps";

_Mission;