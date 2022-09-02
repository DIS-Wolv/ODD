/*
* Author: Wolv
* Fonction permetant de faire spawn des ODD_var_Civils et vehicule sur la zone souhaité
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
* [_zo] call ODD_fnc_civil
* [_zo, true, false] call ODD_fnc_civil
*
* Public:
*/
params ["_zo", ["_action", false], ["_Debug", false]];

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

private _Buildings = nearestobjects [position _zo, ODD_var_Maison, size _zo select 0];
// Nombre de odd_var_maison dans la localité

private _nbCivil = 0;
if (_loctype == 5) then {
    _nbCivil = (count _Buildings) / 24;
};
if (_loctype == 4) then {
    _nbCivil = (count _Buildings) / 25;
};
if (_loctype == 3) then {
    _nbCivil = (count _Buildings) / 16;
};
if (_loctype == 2) then {
    _nbCivil = 0;
};
if (_loctype == 1) then {
    _nbCivil = (count _Buildings) / 10;
};
/*
1. nb de ODD_var_Civils :
selon le type : round
5 (capital) nb batiment/24
4 nbbat/25
3 nbbat/8
2 0
1 nbbat / 10
pensé a forcé 0 si negatif
2. donne la position de la caisse :
2/nb ODD_var_Civils
*/

// systemChat("spawn des ODD_var_Civils");
if (not _action) then {
    _nbCivil = _nbCivil / 2;
};

_nbCivil = (round (0 max _nbCivil));

[["Nombre de Civil sur %1 : %2", text _zo, _nbCivil]] call ODD_fnc_log;

private _civil = [];
_civil resize (_nbCivil);
{
    // choisi un groupe
    private _group = selectRandom ODD_var_Civils;
    
    // choisi un batiment aléatoirement
    _GBuild = selectRandom _Buildings;
    
    // spawn le groupe
    _g = [getPos _GBuild, civilian, _group] call BIS_fnc_spawngroup;
    _civil set[_forEachindex, _g];
    
    ODD_var_MissionCivil pushBack _g;
    
    sleep 0.5;
    
    [
        ((units _g)select 0), 
        "<t color='#FF0000'>interoger le civil</t>", 
        "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa",
        "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", 
        "(alive (_target)) and (_target distance _this < 3)", 
        "true",
        {
            [(_this select 0), "PATH"] remoteExec ["disableAI", 2];
            // (_this select 0) disableAI "PATH"
        }, 
        {},
        {
            [(_this select 0), "PATH"] remoteExec ["enableAI", 2];
            // (_this select 0) enableAI "PATH";

            _localID = clientOwner;
            [_localID] remoteExec ["publicVariableClient 'ODD_var_TargetTypeName';", 0];
            [_localID] remoteExec ["publicVariableClient 'ODD_var_Objectif';", 0];
            
            private _markerPool = ["Contact_circle1", "Contact_circle2", "Contact_circle3", "Contact_circle4", "Contact_pencilTask1", "Contact_pencilTask2",
            "Contact_pencilTask3", "Contact_pencilCircle1", "Contact_pencilCircle2", "Contact_pencilCircle3"];
            private _colorPool = ["ColorBlack", "ColorRed", "ColorBrown", "Colororange", "ColorBlue", "colorcivilian"];
            
            if (round (random 1) == 0) then {
                systemChat ("J'ai des info.");
                private _daytime = daytime;
                private _hours = floor _daytime;
                private _minutes = floor ((_daytime - _hours) * 60);
                private _seconds = floor ((((_daytime - _hours) * 60) - _minutes) * 60);
                private _pos = [0,0,0];
                if (ODD_var_Target == ODD_var_TargetTypeName select 2) then {
                    _pos = position (units (ODD_var_Objectif select 0) select 0);
                }
                else {
                    _pos = position (ODD_var_Objectif select 0);
                };
                
                _marker = createMarker [format["ODDTG %1:%2, %3", _hours, _minutes, _seconds], _pos];
                _marker setMarkertype (selectRandom _markerPool);
                _marker setMarkerColor (selectRandom _colorPool);
                _marker setMarkertext format["Objectif à %1:%2", _hours, _minutes];
            } else {
                systemChat ("J'ai pas d'info.");
            };
            [(_this select 0)] remoteExec ["removeAllActions"];
        }, {
            // (_this select 0) enableAI "PATH";
            [(_this select 0), "PATH"] remoteExec ["enableAI", 2];
        }, [], (random[2, 10, 15]), nil, true, false
    ] remoteExec ["BIS_fnc_holdActionAdd"];
    
}forEach _civil;

sleep 2;
{
    [position ((units _x) select 0), nil, units _x, 100, 1, false, true] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
    // Garnison Ace
} forEach _civil;

sleep 2;
{
    [units _x] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf";
} forEach _civil;

// for "_i" from 1 to 3 do
{
    /*
    _roads = position _zo nearRoads 300;
    _road = selectRandom _roads;
    
    _pos = position _road;
    
    _GBuild = selectRandom _Buildings;
    
    _roadDir = 0;
    _connectedRoad = roadsConnectedto [_road, false];
    if (count (_connectedRoad) >= 1) then {
        // si il y a une route acollÃ©
        _roadDir = [_road, (_connectedRoad select 0)] call BIS_fnc_Dirto;
        // recup la direction
        
        _roadDir = (_roadDir + ((round (random 2))* 180)) % 360;
        // + 0 ou + 180 Â°
    };
    
    _vl = selectRandom ODD_var_CivilsVL;
    
    _pos = _pos getPos [6, (_roadDir + 90 + ((round (random 2))* 180)) % 360];
    
    _pos = _pos findEmptyposition [0, 100, _vl];
    
    _g = _vl createvehicle _pos;
    
    // _g setDir _roadDir;
    
    // _g = [_pos, _roadDir, _group, EMPTY] call BIS_fnc_spawnvehicle;
    // sleep 1;
    // deletevehicle (units (_g select 0) select 0);
    // */
    
    _vl = selectRandom ODD_var_CivilsVL;
    // choisie un vl
    
    _GBuild = selectRandom _Buildings;
    _dir = getDir _GBuild;
    if (_dir == 0) then {
        _dir = getDirVisual _GBuild;
    };
    
    _pos = position _GBuild;
    // recup la pos
    
    _pos = _pos findEmptyposition [3, 100, _vl];
    //, "B_Heli_Transport_01_F"
    
    // _pos = _pos getPos [3, [position _GBuild, _pos] call BIS_fnc_dirto];
    
    _g = _vl createvehicle _pos;
    // créé le VL

    _g addItemCargoGlobal ["Toolkit", 1]; 
    // Ajoute un repaire kit
    
    _g setDir _dir;
    
    sleep 0.5;
    
    _g setFuel 1;
    
    _g setDamage 0;
    ODD_var_MissionProps pushBack _g;
}forEach _civil; //Sur 80 % des gars, pas tous

publicVariable "ODD_var_MissionCivil";
publicVariable "ODD_var_MissionProps";