/*
* Author: Wolv
* Fonction coeur des ODD.
*
* Arguments:
* 0: type de missions souhaité numéro du type de missions <inT>
* 1: Nom de la localité souhaité <strinG>
* 2: Activation ou pas des ZO+ <BOOL>
* 3: Activation du ODD_var_DEBUG dans le chat <BOOL>
*
* Return Value:
* nil
*
* Example:
* [] call ODD_fnc_missions
* [2, "Kavala", false, true] call ODD_fnc_missions
*
* Public:
*/
params [["_missiontype", -1], ["_forceZO", ""], ["_ZOP", true], ["_Debug", false], ["_FacForce", -1]];

if(isNil "ODD_var_NbPlayer") then {
    ODD_var_NbPlayer = (playersNumber west);
};

if (isNil "ODD_var_TargetTypeName") then {
    [] call ODD_fnc_var;
};

if (isNil "ODD_var_DEBUG") then {
    ODD_var_DEBUG = False;
};

//ODD_var_DEBUG = _Debug;
//publicVariable "ODD_var_DEBUG";

if (ODD_var_DEBUG) then { 
    [_FacForce, false, true] call ODD_fnc_varEne;
};

ODD_var_DistanceZO = 4000;

// systemChat("init ODD");
if (ODD_var_CurrentMission == 0) then {
    private _future = servertime + 6;
    // 5;
    ["Génération d'une mission"] remoteExec ["systemChat", 0];
    ODD_var_CurrentMission = 2;
    publicVariable "ODD_var_CurrentMission";
    // Choix d'un Lieux odd_var_objectif
    private _zo = [_forceZO, _Debug] call ODD_fnc_createZO;
    // private _diff = [_zo] call _Calcdifficulty
    // systemChat(str(_diff));
    
    // Choix d'une missions
    ODD_var_Target = [_zo, _missiontype, _Debug] call ODD_fnc_createTarget;
    
    [_zo, true, _Debug] call ODD_fnc_civil;
    
    [_zo, true, _Debug] call ODD_fnc_createGarnison;
    
    [_zo, true, _Debug] call ODD_fnc_createPatrol;
    
    [_zo, 2, true, _Debug] call ODD_fnc_roadBlock;
    
    [_zo, true, _Debug] spawn ODD_fnc_createVehicule;  //car on attend que les joueurs parte de la FOB/Base
    
    if (_ZOP) then {
        // Ajouté des location a proximité ou il y aurai des patrouilles
        // toute les loc a proximité
        private _location = nearestLocations[position _zo, ODD_var_LocationType, ODD_var_DistanceZO];
        private _closeLoc = nearestLocations[position _zo, ODD_var_LocationType, 800];
        _location = _location - [_zo];
        _location = _location - _closeLoc;
        // location = location entre 800 et 5000 m
        
        private _i = 0;
        while {_i < count(_location)} do {
            private _Buildings = nearestobjects[position (_location select _i), ODD_var_Maison, 200];
            if ((text (_location select _i) in ODD_var_LocationBlkList) or (count _Buildings == 0)) then {
                _location = _location - [_location select _i];
            } else {
                _i = _i + 1;
            };
        };
        // degage les locations indésirable
        
        // choix des locations a activation
        _nbloc = round random [0, (count(_location)*3/5), count(_location)];
        // on prend entre 0 et toute les loc a poximité centré sur 2/5
        
        _nbloc = 4 min _nbloc;
        
        while {count(_location) > _nbloc} do {
            // tant que trop de loc
            _location = (_location) - [(selectRandom _location)];
            // - 1 loc random // distance2D ???
        };

        [["Nombre de ZO+ : %1", _nbloc]] call ODD_fnc_log;
        
        {
            [["ZO+ %1 : %2", _forEachindex, text _x]] call ODD_fnc_log;
            // *
            _action = round random 4;
            // random en 0 et 2
            if (_action == 0) then {};
            // si 0 fait rien
            if (_action == 1) then {
                // si 1
                [_x, false, _Debug] call ODD_fnc_createPatrol;
                // patrouilles
            };
            if (_action == 2) then {
                // si 2
                [_x, false, _Debug] call ODD_fnc_createPatrol;
                // patrouilles
                
                _nbCheckPoint = round random 4;
                [_x, _nbCheckPoint, false, _Debug] call ODD_fnc_roadBlock;
                // RoadBlock
            };
            if (_action == 3) then {
                // si 3
                [_x, false, _Debug] call ODD_fnc_createPatrol;
                // patrouilles
                
                [_x, false] call ODD_fnc_createGarnison;
                // garnison
            };
            // */
            
            [_x, false, _Debug] call ODD_fnc_civil;
            // a chaque fois Civil
        }forEach _location;
        // */	// pour toute les ZO+ activé

        [_zo, 4, ODD_var_DistanceZO] call ODD_fnc_roadBlockZO; // ajout de checkpoint hors des ZO +
    };

    {
        // normalement ne devrait pas servir mais on laisse au cas ou (sert a dégagé les gars mort au spawn)
        deletevehicle _x;
        // supprime le corps
    } forEach allDead;
    // pour chaque corps
    
    [["Quantital : Nombre de Pax sur la ZO : %1", count ODD_var_MissionIA]] call ODD_fnc_log;
    [["Quantital : Nombre de Pax en ZO+ : %1", count ODD_var_ZopiA]] call ODD_fnc_log;
    [["Quantital : Nombre de Pax en Garnison : %1", count ODD_var_GarnisonIA]] call ODD_fnc_log;
    [["Quantital : Nombre de ODD_var_Civils : %1", count ODD_var_MissionCivil]] call ODD_fnc_log;
    [["Quantital : Nombre de Props : %1", count ODD_var_MissionProps]] call ODD_fnc_log;
    [["Quantital : Nombre de LocalProps (par joueur) : %1", count ODD_var_ParticuleList]] call ODD_fnc_log;
    [["Quantital : Missions Généré pour %1 joueurs", ODD_var_NbPlayer]] call ODD_fnc_log;
    [["Quantital : Support détécté %1", ODD_var_support]] call ODD_fnc_log;
    if (ODD_var_support) then {
        [["Quantital : Support détécté %1", ODD_var_VlSupport]] call ODD_fnc_log;
    };

    waitUntil {
        sleep 1;
        servertime >= _future
    };
    ODD_var_TimeStart = servertime;
    ["Mission Générée"] remoteExec ["systemChat", 0];
    ODD_var_CurrentMission = 1;
    publicVariable "ODD_var_CurrentMission";
    publicVariable "ODD_var_Objectif";
    publicVariable "ODD_var_MissionProps";
    publicVariable "ODD_var_GarnisonIA";
    publicVariable "ODD_var_MissionIA";
    publicVariable "ODD_var_ZopiA";
    publicVariable "ODD_var_TimeStart";
    publicVariable "ODD_var_Target";
    private _NextTick = servertime + 60;
    
    _nbIa = [_Debug] call ODD_fnc_countIA;
    
    ["Task", "ASSIGNED", true] call BIS_fnc_tasksetState;
    
    _BaseIa = _nbIa;
    private _Renfort = true;
    private _nbItt = 0;
    
    [["Mission Lancée"]] call ODD_fnc_log;
    if (_Debug) then {
        [["Skip de lattente des joueurs sur obj"]] call ODD_fnc_log;
    } else {
        waitUntil{
            sleep 1;
            count (position _zo nearEntities[["SoldierWB"], 1000]) >= 1
        };
    };
    
    ODD_var_TimeZO = servertime;
    publicVariable "ODD_var_TimeZO";
    
    // update + souvent la liste des objectifs

    [format["%1 | %2", ODD_var_Target, (ODD_var_TargetTypeName select 7)]] remoteExec ["systemChat", 0];
    
    if (ODD_var_Target == ODD_var_TargetTypeName select 0) then {
        // obj est une caisse a detruire
        while {(count (magazineCargo (ODD_var_Objectif select 0)) != 0) and (ODD_var_CurrentMission == 1)} do {
            // tant que la caisse comporte des explosif (donc pas explosé)
            // sleep 60;
            private _NextTick = servertime + 60;
            
            call ODD_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call ODD_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call ODD_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call ODD_fnc_garbageCollector;
            
            waitUntil {
                sleep 1;
                (!((count (magazineCargo (ODD_var_Objectif select 0)) != 0) and (ODD_var_CurrentMission == 1))) or servertime > _NextTick
            };
        };
        
        sleep(1);
        ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
        // tache accomplie
    };
    
    if (ODD_var_Target == ODD_var_TargetTypeName select 1) then {
        // obj est un HVT
        // systemChat(format["HVT en vie : %1, captif : %2", str(alive (ODD_var_Objectif select 0)), str(!(captive (ODD_var_Objectif select 0)))]);
        while {(alive (ODD_var_Objectif select 0) and !(captive (ODD_var_Objectif select 0))) and (ODD_var_CurrentMission == 1)} do {
            // tant que la cible est et en vie et libre
            _NextTick = servertime + 60;
            
            call ODD_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call ODD_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call ODD_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call ODD_fnc_garbageCollector;
            
            waitUntil {
                sleep 1;
                ((alive (ODD_var_Objectif select 0) and !(captive (ODD_var_Objectif select 0))) and (ODD_var_CurrentMission == 1)) == false or servertime > _NextTick
            };
        };
        sleep(1);
        ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
        // tache accomplie
    };
    
    if (ODD_var_Target == ODD_var_TargetTypeName select 2) then {
        // obj est une zone a securizé
        _seuil = round (_BaseIa / 20);
        ODD_var_Objectif = ODD_var_MissionIA;
        publicVariable "ODD_var_Objectif";
        
        while {(_nbIa > _seuil) and (ODD_var_CurrentMission == 1)} do {
            // tant qu'il y as plus de 20% IA
            // sleep 60;
            _NextTick = servertime + 60;
            
            call ODD_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call ODD_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call ODD_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call ODD_fnc_garbageCollector;

            [["Progression de l'objectif : %1 / %2", _nbIa, _seuil]] call ODD_fnc_log;
            
            {
                if (isNull(_x)) then {
                    ODD_var_Objectif = ODD_var_Objectif - [_x];
                }
            }forEach ODD_var_Objectif;
            publicVariable "ODD_var_Objectif";

            waitUntil {
                sleep 1;
                _nbIa = [_Debug] call ODD_fnc_countIA;
                ((_nbIa > _seuil) and (ODD_var_CurrentMission == 1)) == false or servertime > _NextTick
            };
        };
        sleep(1);
        ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
        // tache accomplie
    };
    
    if ((ODD_var_Target == ODD_var_TargetTypeName select 3) or (ODD_var_Target == ODD_var_TargetTypeName select 4)) then {
        // obj est un intel ou un Helico
        while {(ODD_var_Objectif select 1) and (ODD_var_CurrentMission == 1)} do {
            private _NextTick = servertime + 60;
            
            call ODD_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call ODD_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call ODD_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call ODD_fnc_garbageCollector;
            
            waitUntil {
                sleep 1;
                ((ODD_var_Objectif select 1) and (ODD_var_CurrentMission == 1)) == false or servertime > _NextTick
            };
        };
        sleep(1);
        ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
        // tache accomplie
    };
    
    if (ODD_var_Target == ODD_var_TargetTypeName select 5) then {
        // obj est un Prisonier
        while {((!(fob in nearestobjects[(ODD_var_Objectif select 0), [], 50])) and (alive (ODD_var_Objectif select 0))) and (ODD_var_CurrentMission == 1)} do {
            // tant que la cible est captive
            _NextTick = servertime + 60;
            
            call ODD_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call ODD_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call ODD_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call ODD_fnc_garbageCollector;
            
            waitUntil {
                sleep 1;
                (((!(fob in nearestobjects[(ODD_var_Objectif select 0), [], 50])) and (alive (ODD_var_Objectif select 0))) and (ODD_var_CurrentMission == 1)) == false or servertime > _NextTick
            };
            // systemChat(format["HVT en vie : %1, captif : %2", str(alive (ODD_var_Objectif select 0)), str(!(captive (ODD_var_Objectif select 0)))]);
            // fait rien
        };
        
        sleep(1);
        if (alive (ODD_var_Objectif select 0)) then {
            ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
            // tache accomplie
        } else {
            ["Task", "FAILED"] call BIS_fnc_tasksetState;
            // tache échoué
        };
    };
    
    if (ODD_var_Target == ODD_var_TargetTypeName select 6) then {
        // obj vl secure
        while {
            ((((!((fob in nearestobjects[(ODD_var_Objectif select 0), [], 50]) or (base in nearestobjects[(ODD_var_Objectif select 0), [], 50]))) and (alive (ODD_var_Objectif select 0))) and (ODD_var_CurrentMission == 1)))
        } do {
            // tant que la cible est pas detruite
            _NextTick = servertime + 60;
            
            call ODD_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call ODD_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call ODD_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call ODD_fnc_garbageCollector;
            
            waitUntil {
                sleep 1;
                (((((!((fob in nearestobjects[(ODD_var_Objectif select 0), [], 50]) or (base in nearestobjects[(ODD_var_Objectif select 0), [], 50]))) and (alive (ODD_var_Objectif select 0))) and (ODD_var_CurrentMission == 1))) or (servertime > _NextTick))
            };
        };
        
        sleep(1);
        if (alive (ODD_var_Objectif select 0)) then {
            ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
            // tache accomplie
        } else {
            ["Task", "FAILED"] call BIS_fnc_tasksetState;
            // tache échoué
        };
    };

    if (ODD_var_Target == ODD_var_TargetTypeName select 7) then {
        // obj vl destroy

        ["TEST NOUVELLE MISSIONS FLOW 2"] remoteExec ["systemChat", 0];
        while {
            ((alive (ODD_var_Objectif select 0)) and (ODD_var_CurrentMission == 1))
        } do {
            // tant que la cible est pas detruite
            _NextTick = servertime + 60;
            
            call ODD_fnc_sortieGarnison;
            
            _nbIa = [_Debug] call ODD_fnc_countIA;
            
            _Renfort = [_Renfort, _nbIa, _BaseIa] call ODD_fnc_testrenfort;
            
            _nbItt = _nbItt + 1;
            [_nbItt, _Debug] call ODD_fnc_garbageCollector;
            
            waitUntil {
                sleep 1;
                (!((alive (ODD_var_Objectif select 0)) and (ODD_var_CurrentMission == 1)) or (servertime > _NextTick))
            };
        };
        
        sleep(1);
        ["Task", "SUCCEEDED"] call BIS_fnc_tasksetState;
        // tache accomplie

    };
    
    ODD_var_TimeObj = servertime;
    publicVariable "ODD_var_TimeObj";
    
    sleep(5);
    
    if (ODD_var_CurrentMission == 1) then {
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
        
        ODD_var_TimeEnd = servertime;
        publicVariable "ODD_var_TimeEnd";
        
        // sleep(2);
        // Attend 2 s
        private _DebutNettoyage = servertime + 30;
        
        waitUntil {
            sleep 1;
            servertime > _DebutNettoyage
        };
        
        [_Debug] call ODD_fnc_clearZO;
        // nettoye la ZO
    };
} else {
    ["Une mission est déjà en cours"] remoteExec ["systemChat", 0];
};

// player setPosASL position _zo;
// Affiche la Missions
// systemChat(ODD_var_Target);