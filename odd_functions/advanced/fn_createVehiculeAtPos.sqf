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
params ["_pos", "_vl", "_side"];

// doit etre en unscheduled environment
// https://community.bistudio.com/wiki/canSuspend
if (!canSuspend) exitWith {systemChat "ERREUR : doit etre scheduled" ; nil};

private _to_gen_pos = _pos findEmptyPosition [1 + (sizeOf _vl), 250, _vl];
if ((count _to_gen_pos) == 0) exitWith { nil };


private _created = [_to_gen_pos, _side, [_vl]] call BIS_fnc_spawnGroup;
private _vl = vehicle leader _created;
// Si les VLs explosent toujours, décommenter les lignes suivantes
// Et trouver comment etre sur que le allow damage est bien remis a true 
// _vl allowDamage false;
// uiSleep 0.5;
// _vl allowDamage true;
_created setSpeedMode "LIMITED";


_created
