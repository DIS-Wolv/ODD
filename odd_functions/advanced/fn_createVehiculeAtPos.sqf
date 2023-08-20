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
* Exemple in an unscheduled environment :
* [position player, "rhssaf_army_o_t72s"] call ODDadvanced_fnc_createVehiculeAtPos
*
* Exemple in a scheduled environment :
* [position player, "rhssaf_army_o_t72s"] spawn ODDadvanced_fnc_createVehiculeAtPos
*/

// Récupère les arguments
params ["_pos", "_vl"];

// doit etre en unscheduled environment
// https://community.bistudio.com/wiki/canSuspend
if (!canSuspend) exitWith {systemChat "ERREUR : doit etre unscheduled" ; nil};

private _to_gen_pos = _pos findEmptyPosition [1 + (sizeOf _vl), 250, _vl];
if ((count _to_gen_pos) == 0) exitWith { nil };


private _created = [_to_gen_pos, EAST, [_vl]] call BIS_fnc_spawnGroup;
private _vl = vehicle leader _created;
_vl allowDamage false;
uiSleep 0.5;
_vl allowDamage true;
_created setSpeedMode "LIMITED";


_created
