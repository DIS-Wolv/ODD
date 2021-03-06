/*
* Author: Wolv
* Fonction permetant de créé une Zone d'opération
*
* Arguments:
* 0: Zone souhaité <STRING>
* 1: Activation du debug dans le chat <BOOL>
*
* Return Value:
* Nom de la localité
*
* Example:
* [] call WOLV_fnc_createZO
* [_forceZO, _Debug] call WOLV_fnc_createZO
*
* Public:
*/
params [["_forceZO", ""], ["_Debug", false]];

// Recupère toute les villes, villages, Capitales
private _location = nearestLocations[[15000, 15000], locationtype, 30000];

if (_Debug) then {
    [format["Nombre de locations : %1", str(count(_location))]] remoteExec ["systemChat", 0];
};

// choisi un objectif random
private _obj = selectRandom _location;
private _Buildings = nearestobjects[position _obj, Maison, 200];

while {(text _obj in locationBlklist) or (count _Buildings == 0)} do {
    // tant que on est dans une location intredit ou qu'il y a 0
    _obj = selectRandom _location;
    _Buildings = nearestobjects[position _obj, Maison, 200];
};
	// */

if (_Debug) then {
    [format["Locations choisi : %1", text _obj]] remoteExec ["systemChat", 0];
};

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
    if (_Debug) then {
        [format["Locations forcé : %1", text _obj]] remoteExec ["systemChat", 0];
    };
};

// Recupère la position de l'objectif
private _pos = position _obj;

_pos set [0, ((_pos select 0) + ((size _obj) select 0)/2)];
_pos set [1, ((_pos select 1) + ((size _obj) select 0)/2)];

// Ajoute un marker
_marker = createMarker ["ODDOBJ", _pos];
_marker setMarkertype "hd_objective";
_marker setMarkerColor "coloropfor";
_marker setMarkertext "O";

[text _obj] remoteExec ["systemChat", 0];
if (_Debug) then {
    ["Marquer mis en place"] remoteExec ["systemChat", 0];
};

// Renvoie la location
_obj