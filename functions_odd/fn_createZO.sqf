/*
* Author: Wolv
* Fonction permetant de créé une Zone d'opération
*
* Arguments:
* 0: Zone souhaité <STRING>
* 1: Activation du ODD_var_DEBUG dans le chat <BOOL>
*
* Return Value:
* Nom de la localité
*
* Example:
* [] call ODD_fnc_createZO
* [_forceZO, _Debug] call ODD_fnc_createZO
*
* Public:
*/
params [["_forceZO", ""], ["_Debug", false]];

missionNamespace setVariable ["ODD_var_DEBUG", _Debug, True];

private _location = [];
private _SelectSector = [];

if(!isNil "ODD_var_SelectedSector") then {
    {
        if (ODDGUI_var_Secteur select 0 == _x) then {
            _SelectSector pushback (ODDGUI_var_SecteurMarker select 0);
        };
        if (ODDGUI_var_Secteur select 1 == _x) then {
            _SelectSector pushback (ODDGUI_var_SecteurMarker select 1);
        };
        if (ODDGUI_var_Secteur select 2 == _x) then {
            _SelectSector pushback (ODDGUI_var_SecteurMarker select 2);
        };
        if (ODDGUI_var_Secteur select 3 == _x) then {
            _SelectSector pushback (ODDGUI_var_SecteurMarker select 3);
        };
        if (ODDGUI_var_Secteur select 4 == _x) then {
            _SelectSector pushback (ODDGUI_var_SecteurMarker select 4);
        };
        if (ODDGUI_var_Secteur select 5 == _x) then {
            _SelectSector pushback (ODDGUI_var_SecteurMarker select 5);
        };
        if (ODDGUI_var_Secteur select 6 == _x) then {
            _SelectSector pushback (ODDGUI_var_SecteurMarker select 6);
        };
        if (ODDGUI_var_Secteur select 7 == _x) then {
            _SelectSector pushback (ODDGUI_var_SecteurMarker select 7);
        };
        if (ODDGUI_var_Secteur select 8 == _x) then {
            _SelectSector pushback (ODDGUI_var_SecteurMarker select 8);
        };
    } forEach ODD_var_SelectedSector;
    [["Secteur choisi : %1", str _SelectSector]] call ODD_fnc_log;
    {
        _pos = getMarkerPos _x;
        _loc = nearestLocations[_pos, ODD_var_LocationType, 5000];
        _location = (_location - _loc) + _loc; // évite les doublons
    } forEach _SelectSector;
}
else{
    // Recupère toute les villes, villages, Capitales
    _location = nearestLocations[[15000, 15000], ODD_var_LocationType, 30000];
};

[["Nombre de locations : %1", str(count(_location))]] call ODD_fnc_log;

// choisi un ODD_var_Objectif random
private _obj = selectRandom _location;
private _Buildings = nearestobjects[position _obj, ODD_var_Maison, 200];

while {(text _obj in ODD_var_LocationBlkList) or (count _Buildings == 0)} do {
    // tant que on est dans une location intredit ou qu'il y a 0
    _obj = selectRandom _location;
    _Buildings = nearestobjects[position _obj, ODD_var_Maison, 200];
};
	// */

[["Locations choisi : %1", text _obj]] call ODD_fnc_log;

if (_forceZO != "") then {
	{
		if (_forceZO == text _x) then {
			_obj = _x;
		};
	}forEach _location;

    /*
    while {text _obj != _forceZO} do {
        [text _obj] remoteExec ["systemChat", 0];
        _obj = selectRandom _location;
    };
    // */
    [["Locations forcé : %1", text _obj]] call ODD_fnc_log;
};

// Recupère la position de l'ODD_var_Objectif
private _pos = position _obj;

_pos set [0, ((_pos select 0) + ((size _obj) select 0)/2)];
_pos set [1, ((_pos select 1) + ((size _obj) select 0)/2)];

// Ajoute un marker
_marker = createMarker ["ODDOBJ", _pos];
_marker setMarkertype "hd_objective";
_marker setMarkerColor "coloropfor";
_marker setMarkertext "O";

[text _obj] remoteExec ["systemChat", 0];
[["Marquer mis en place"]] call ODD_fnc_log;

// Renvoie la location
_obj