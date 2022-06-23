/*
* Author: Wolv
* Fonction coeur des ODD.
*
* Arguments:
* 0: type de missions souhaité numéro du type de missions <inT>
* 1: Nom de la localité souhaité <strinG>
* 2: Activation ou pas des ZO+ <BOOL>
* 3: Activation du debug dans le chat <BOOL>
*
* Return Value:
* nil
*
* Example:
* [] call WOLV_fnc_missions
* [2, "Kavala", false, true] call WOLV_fnc_missions
*
* Public:
*/
params [["_missiontype", -1], ["_forceZO", ""], ["_ZOP", true], ["_Debug", false]];

call WOLV_fnc_var;

// systemChat("init ODD");
if (CurrentMission == 0) then {
    private _future = servertime + 6;
    // 5;
    ["Génération d'une mission"] remoteExec ["systemChat", 0];
    CurrentMission = 2;
    publicVariable "CurrentMission";
    // Choix d'un Lieux objectif
    private _zo = [_forceZO, _Debug] call WOLV_fnc_createZO;
    // private _diff = [_zo] call _Calcdifficulty
    // systemChat(str(_diff));
    
    // Choix d'une missions
    private _target = [_zo, _missiontype, _Debug] call WOLV_fnc_createTarget;
    
    [_zo, true, _Debug] call WOLV_fnc_civil;
    
    [_zo, true, _Debug] call WOLV_fnc_createGarnison;
    
    [_zo, true, _Debug] call WOLV_fnc_createPatrol;
    
    [_zo, true, _Debug] call WOLV_fnc_createVehicule;
    
    [_zo, 2, true, _Debug] call WOLV_fnc_roadBlock;
    
    if (_ZOP) then {
        // Ajouté des location a proximité ou il y aurai des patrouilles
        // toute les loc a proximité
        private _location = nearestLocations[position _zo, locationtype, 4000];
        private _closeLoc = nearestLocations[position _zo, locationtype, 800];
        _location = _location - [_zo];
        _location = _location - _closeLoc;
        // location = location entre 800 et 5000 m
        
        private _i = 0;
        while {_i < count(_location)} do {
            private _Buildings = nearestobjects[position (_location select _i), Maison, 200];
            if ((text (_location select _i) in locationBlklist) or (count _Buildings == 0)) then {
                _location = _location - [_location select _i];
            } else {
                _i = _i + 1;
            };
        };
        // degage les locations indésirable
        
        // choix des locations a activation
        _nbloc = round random [0, (count(_location)*3/5), count(_location)];
        // on prend entre 0 et toute les loc a poximité centré sur 2/5
        
        while {count(_location) > _nbloc} do {
            // tant que trop de loc
            _location = (_location) - [(selectRandom _location)];
            // - 1 loc random // distance2D ???
        };
        
        if (_Debug) then {
            [format["Nombre de ZO+ : %1", _nbloc]] remoteExec ["systemChat", 0];
        };
        
        {
            if (_Debug) then {
                [format["ZO+ %1 : %2", _forEachindex, text _x]] remoteExec ["systemChat", 0];
            };
            // *
            _action = round random 4;
            // random en 0 et 2
            if (_action == 0) then {};
            // si 0 fait rien
            if (_action == 1) then {
                // si 1
                [_x, false, _Debug] call WOLV_fnc_createPatrol;
                // patrouilles
            };
            if (_action == 2) then {
                // si 2
                [_x, false, _Debug] call WOLV_fnc_createPatrol;
                // patrouilles
                
                _nbCheckPoint = round random 4;
                [_x, _nbCheckPoint, false, _Debug] call WOLV_fnc_roadBlock;
                // RoadBlock
            };
            if (_action == 3) then {
                // si 3
                [_x, false, _Debug] call WOLV_fnc_createPatrol;
                // patrouilles
                
                [_x, false] call WOLV_fnc_createGarnison;
                // garnison
            };
            // */
            
            [_x, false, _Debug] call WOLV_fnc_civil;
            // a chaque fois Civil
        }forEach _location;
        // */	// pour toute les ZO+ activé
    };
    
    {
        // normalement ne devrait pas servir mais on laisse au cas ou (sert a dégagé les gars mort au spawn)
        deletevehicle _x;
        // supprime le corps
    } forEach allDead;
    // pour chaque corps
    
    waitUntil {
        servertime >= _future
    };
    timeStart = servertime;
    ["Mission Générée"] remoteExec ["systemChat", 0];
    CurrentMission = 1;
    publicVariable "CurrentMission";
    publicVariable "Objectif";
    publicVariable "MissionProps";
    publicVariable "GarnisonIA";
    publicVariable "MissionIA";
    publicVariable "ZOpiA";
    publicVariable "timeStart";
    private _NextTick = servertime + 60;
    
    _nbIa = [_Debug] call WOLV_fnc_countIA;
    
    ["Task", "ASSIGNED", true] call BIS_fnc_tasksetState;
    
    _BaseIa = _nbIa;
    private _Renfort = true;
    private _nbItt = 0;
    
    if (_Debug) then {
        ["Mission Lancée"] remoteExec ["systemChat", 0];
    } else {
        waitUntil{
            sleep 1;
            count (position _zo nearEntities[["SoldierWB"], 1000]) >= 1
        };
    };
    
    timeZO = servertime;
    publicVariable "timeZO";
    
    // update + souvent la liste des objectifs
    
    if (_target == TargettypeName select 0) then {
        // obj est une caisse a detruire
        while {(count (magazineCargo (Objectif select 0)) != 0) and (CurrentMission == 1)} do {
            // tant que la caisse comporte des explosif (donc pas explosé)
            // sleep 60;
            private _NextTick = servertime + 60;
            
            call WOLV_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call WOLV_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call WOLV_fnc_garbageCollector;
            
            waitUntil {
                sleep 1;
                (!((count (magazineCargo (Objectif select 0)) != 0) and (CurrentMission == 1))) or servertime > _NextTick
            };
        };
        
        sleep(1);
        ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
        // tache accomplie
    };
    
    if (_target == TargettypeName select 1) then {
        // obj est un HVT
        // systemChat(format["HVT en vie : %1, captif : %2", str(alive (Objectif select 0)), str(!(captive (Objectif select 0)))]);
        while {(alive (Objectif select 0) and !(captive (Objectif select 0))) and (CurrentMission == 1)} do {
            // tant que la cible est et en vie et libre
            _NextTick = servertime + 60;
            
            call WOLV_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call WOLV_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call WOLV_fnc_garbageCollector;
            
            waitUntil {
                ((alive (Objectif select 0) and !(captive (Objectif select 0))) and (CurrentMission == 1)) == false or servertime > _NextTick
            };
        };
        sleep(1);
        ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
        // tache accomplie
    };
    
    if (_target == TargettypeName select 2) then {
        // obj est une zone a securizé
        _seuil = round (_BaseIa / 20);
        
        if (_Debug) then {
            [format["Progression de l'objectif : %1 / %2", _nbIa, _seuil]] remoteExec ["systemChat", 0];
        };
        
        while {(_nbIa > _seuil) and (CurrentMission == 1)} do {
            // tant qu'il y as plus de 10 IA
            // sleep 60;
            _NextTick = servertime + 60;
            
            call WOLV_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call WOLV_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call WOLV_fnc_garbageCollector;
            
            waitUntil {
                ((_nbIa > _seuil) and (CurrentMission == 1)) == false or servertime > _NextTick
            };
        };
        sleep(1);
        ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
        // tache accomplie
    };
    
    if ((_target == TargettypeName select 3) or (_target == TargettypeName select 4)) then {
        // obj est un intel ou un Helico
        while {(Objectif select 1) and (CurrentMission == 1)} do {
            private _NextTick = servertime + 60;
            
            call WOLV_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call WOLV_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call WOLV_fnc_garbageCollector;
            
            waitUntil {
                ((Objectif select 1) and (CurrentMission == 1)) == false or servertime > _NextTick
            };
        };
        sleep(1);
        ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
        // tache accomplie
    };
    
    if (_target == TargettypeName select 5) then {
        // obj est un Prisonier
        while {((!(fob in nearestobjects[(Objectif select 0), [], 50])) and (alive (Objectif select 0))) and (CurrentMission == 1)} do {
            // tant que la cible est captive
            _NextTick = servertime + 60;
            
            call WOLV_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call WOLV_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call WOLV_fnc_garbageCollector;
            
            waitUntil {
                (((!(fob in nearestobjects[(Objectif select 0), [], 50])) and (alive (Objectif select 0))) and (CurrentMission == 1)) == false or servertime > _NextTick
            };
            // systemChat(format["HVT en vie : %1, captif : %2", str(alive (Objectif select 0)), str(!(captive (Objectif select 0)))]);
            // fait rien
        };
        
        sleep(1);
        if (alive (Objectif select 0)) then {
            ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
            // tache accomplie
        } else {
            ["Task", "FAILED"] call BIS_fnc_tasksetState;
            // tache échoué
        };
    };
    
    if (_target == TargettypeName select 6) then {
        // obj vl
        while {((!(fob in nearestobjects[(Objectif select 0), [], 50])) and (alive (Objectif select 0))) and (CurrentMission == 1)} do {
            // tant que la cible est pas detruite
            _NextTick = servertime + 60;
            
            call WOLV_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call WOLV_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call WOLV_fnc_garbageCollector;
            
            waitUntil {
                (((!(fob in nearestobjects[(Objectif select 0), [], 50])) and (alive (Objectif select 0))) and (CurrentMission == 1)) == false or servertime > _NextTick
            };
        };
        
        sleep(1);
        if (alive (Objectif select 0)) then {
            ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
            // tache accomplie
        } else {
            ["Task", "FAILED"] call BIS_fnc_tasksetState;
            // tache échoué
        };
    };
    
    timeObj = servertime;
    publicVariable "timeObj";
    
    sleep(5);
    
    if (CurrentMission == 1) then {
        // cree la tache retour base
        _task = [true, "Extract", ["Rentrez a la base", "RTB", "RTB"], objNull, "ASSIGNED", 2] call BIS_fnc_taskCreate;
        ["Extract", "move"] call BIS_fnc_tasksettype;
        sleep(1);
        
        waitUntil {
            sleep 1;
            (count (getPos base nearEntities[["SoldierWB"], 150])) +	// nb joueur Base +
            (count (getPos fob nearEntities[["SoldierWB"], 150])) 		// nb joueur FOB
            >= count(allplayers - entities "HeadlessClient_F") 			// < nb joueur total (donc quand tout le monde sur base / FOB stop la boucle)
        };
        
        ["Extract", "SUCCEEDED"] call BIS_fnc_tasksetState;
        // Valide la tache
        
        timeEnd = servertime;
        publicVariable "timeEnd";
        
        // sleep(2);
        // Attend 2 s
        private _DebutNettoyage = servertime + 30;
        
        waitUntil {
            servertime > _DebutNettoyage
        };
        
        [_Debug] call WOLV_fnc_clearZO;
        // nettoye la ZO
    };
} else {
    ["Une mission est déjà en cours"] remoteExec ["systemChat", 0];
};

// player setPosASL position _zo;
// Affiche la Missions
// systemChat(_target);