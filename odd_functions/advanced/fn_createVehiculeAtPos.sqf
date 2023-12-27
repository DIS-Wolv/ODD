/*
* Auteur : QuentinN42
* Fonction pour créer un véhicule a une position donnée
*
* Arguments :
* 0: position
* 1: ID du véhicule
*
* Valeur renvoyée :
* groupe du vehicle si créé, false sinon
*
* Exemple in a scheduled environment :
* [position player, "rhssaf_army_o_t72s", east] spawn ODDadvanced_fnc_createVehiculeAtPos;
* [position player, "C_Tractor_01_F", civilian] spawn ODDadvanced_fnc_createVehiculeAtPos;
*/

// Récupère les arguments
params ["_pos", "_vl", "_side", ["_angle", 0], ["_max_range", 250]];

// doit etre en unscheduled environment
// https://community.bistudio.com/wiki/canSuspend
if (!canSuspend) exitWith {systemChat "ERREUR : doit etre scheduled" ; nil};

// Pas ouf mais marche plus ou mois bien
// lire https://cours.polymtl.ca/inf2610/documentation/notes/chap6.pdf section 6.4.1

// attend le semaphore
waitUntil {uiSleep 0.1; (isObjectHidden ODD_var_vls_lock) == false};
// prend le semaphore
ODD_var_vls_lock hideObject true;

private __v = _vl createVehicle [100, 100, 200];  // pour pouvoir conaitre la taille du vehicule
private _bbr = boundingBoxReal __v;
private _size = 2 + selectMax [
    abs ((_bbr select 0) select 0),
    abs ((_bbr select 0) select 1),
    abs ((_bbr select 1) select 0),
    abs ((_bbr select 1) select 1)
];
private _to_gen_pos = [0, 0, 0];
for "_i" from 1 to 20 do {
    _tmp = [_pos, 1, 150, _size, 0, 20, 0, [], [[0, 0, 0],[0, 0, 0]]] call BIS_fnc_findSafePos;
    if ((_tmp distance _pos) < (_to_gen_pos distance _pos)) then {
        _to_gen_pos = _tmp;
    }
};
deleteVehicle __v;

private _created = [[100, 200, 100], _side, [_vl]] call BIS_fnc_spawnGroup;
private _vl = vehicle leader _created;
_vl allowDamage false;
_vl setdir _angle;
_vl setPos (_to_gen_pos getPos [0, 0]);
uiSleep 1;
_vl allowDamage true;
_created setSpeedMode "LIMITED";

// rend le semaphore
ODD_var_vls_lock hideObject false;

_created
