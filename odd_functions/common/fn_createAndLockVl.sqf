/*
 * Auteur : QuentinN42
 * Creer un VL, le lock et lui ajouter les items.
 *
 * Arguments :
 * 1: nom du vehicule
 * 2: position du vehicule
 * 3: orientation du vehicule
 *
 * Valeur renvoyée :
 * le vehicule ou nil si impossible de le faire spawn
 *
 * Exemple:
 * ["C_Van_01_box_F", position player] call ODDcommon_fnc_createAndLockVl;
 * ["C_Van_01_box_F", position player, random 360] call ODDcommon_fnc_createAndLockVl;
*/

// Récupère les arguments
params ["_vl", "_pos", ["_dir", 0]];

// Crée le véhicule
_g = _vl createvehicle _pos;
_g setDir _dir;

// Ajoute un kit de réparation
_g addItemCargoGlobal ["Toolkit", 1]; 
_g setFuel 1;
_g setDamage 0;

// Le lock
[_g, True, True, (random[2, 10, 15])] call ODDcommon_fnc_CtrlVlLock;

ODD_var_MissionProps pushBack _g;

_g
