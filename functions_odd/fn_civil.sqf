/*
* Auteur : Wolv
* Fonction pour créer des civils et des véhicules civils sur la zone
*
* Arguments :
* 0: Zone souhaitée <Objet>
* 1: Est-ce la zone principale <BOOL>
* 2: Activation du débug dans le chat <BOOL>
*
* Valeur renvoyée :
* nil
*
* Exemples :
* [_zo] call ODD_fnc_civil
* [_zo, True, False] call ODD_fnc_civil
*
* Variable publique : 
*/
params ["_zo", ["_action", False]];

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
        _locType = 2;
    };
}forEach ((text _zo) splitstring " ");

private _Buildings = nearestobjects [position _zo, ODD_var_Maison, size _zo select 0];
// Nombre de maisons dans la localité

private _nbCivil = 0;
switch (_loctype) do {
    case (5): {_nbCivil = (count _Buildings) / 24;};
    case (4): {_nbCivil = (count _Buildings) / 25;};
    case (3): {_nbCivil = (count _Buildings) / 16;};
    case (2): {_nbCivil = 0;};
    case (1): {_nbCivil = (count _Buildings) / 10;};
};

/*
1. nb de civils :
    selon le type de la localité : <round>
    5 nbbat/24
    4 nbbat/25
    3 nbbat/16
    2 0
    1 nbbat/10
    penser à forcer 0 si negatif
    2. donne la position de la caisse :
    2/nb civils
*/

// systemChat("spawn des ODD_var_Civils");
if (not _action) then {
    _nbCivil = _nbCivil / 2;
};

_nbCivil = (round (0 max _nbCivil));

[["Nombre de Civil sur %1 : %2", text _zo, _nbCivil]] call ODD_fnc_log;
private _g = [];
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
    
    [
        ((units _g)select 0), 
        "<t color='#FF0000'>interoger le civil</t>", 
        "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa",
        "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", 
        "(alive (_target)) and (_target distance _this < 3)", 
        "True",
        {
            [(_this select 0), "PATH"] remoteExec ["disableAI", 2];
            // (_this select 0) disableAI "PATH"
        }, 
        {},
        {
            [(_this select 0), "PATH"] remoteExec ["enableAI", 2];
            // (_this select 0) enableAI "PATH";

            [] remoteExec ["ODD_fnc_intel", 2];
            [(_this select 0)] remoteExec ["removeAllActions"];
        }, {
            // (_this select 0) enableAI "PATH";
            [(_this select 0), "PATH"] remoteExec ["enableAI", 2];
        }, [], (random[2, 10, 15]), nil, True, False
    ] remoteExec ["BIS_fnc_holdActionAdd"];
    
}forEach _civil;

{
    [position ((units _x) select 0), nil, units _x, 100, 1, False, True] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
    // Garnison Ace
    {
        _x setVariable ["acex_headless_blacklist", True, True]; //blacklist l'unit des HC
    } forEach (units _g);   //pour chaque units
} forEach _civil;

sleep 1;
{
    if (random 100 < 80) then {
        [units _x] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf";
        {
            _x setVariable ["acex_headless_blacklist", False, True]; //blacklist l'unit des HC
        } forEach (units _g);   //pour chaque units
    };
} forEach _civil;

// for "_i" from 1 to 3 do
{
    if (random 100 < 35) then {
        _vl = selectRandom ODD_var_CivilsVL;
        // Choisi un véhicule
        
        _GBuild = selectRandom _Buildings;
        _dir = getDir _GBuild;
        if (_dir == 0) then {
            _dir = getDirVisual _GBuild;
        };
        
        _pos = position _GBuild;
        // Récupère la position
        
        _pos = _pos findEmptyposition [3, 100, _vl];
        //, "B_Heli_Transport_01_F"
        
        // _pos = _pos getPos [3, [position _GBuild, _pos] call BIS_fnc_dirto];
        
        _g = _vl createvehicle _pos;
        // Crée le véhicule

        _g addItemCargoGlobal ["Toolkit", 1]; 
        // Ajoute un kit de réparation
        
        _g setDir _dir;
        
        sleep 0.5;
        
        _g setFuel 1;
        
        _g setDamage 0;
        ODD_var_MissionProps pushBack _g;
    };
}forEach _civil; //Sur 80% des civils

if (random 100 < 50 and (count (position _zo nearRoads 600)) > 0) then {
    // Choisi un groupe
    private _group = selectRandom ODD_var_CivilsVL;
    
    _pos = position selectrandom (position _zo nearRoads 600);
    
    // Crée le groupe et le véhicule
    _g = [_pos, civilian, [_group]] call BIS_fnc_spawngroup;
    
    {
        // Le résultat est stocké dans la variable _x
        [
        _x, 
        "<t color='#FF0000'>interoger le civil</t>", 
        "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa",
        "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", 
        "(alive (_target)) and (_target distance _this < 8)", 
        "True",
        {
            [(_this select 0), "PATH"] remoteExec ["disableAI", 2];
            // (_this select 0) disableAI "PATH"
        }, 
        {},
        {
            [(_this select 0), "PATH"] remoteExec ["enableAI", 2];
            // (_this select 0) enableAI "PATH";

            [] remoteExec ["ODD_fnc_intel", 2];
            [(_this select 0)] remoteExec ["removeAllActions"];
        }, {
            // (_this select 0) enableAI "PATH";
            [(_this select 0), "PATH"] remoteExec ["enableAI", 2];
        }, [], (random[2, 10, 15]), nil, True, False
        ] remoteExec ["BIS_fnc_holdActionAdd"];

         ODD_var_MissionCivil pushBack _x;

    } forEach units _g;


    //_g addItemCargoGlobal ["Toolkit", 1]; 

    [_g] spawn ODD_fnc_patrolZoM;

};

publicVariable "ODD_var_MissionCivil";
publicVariable "ODD_var_MissionProps";