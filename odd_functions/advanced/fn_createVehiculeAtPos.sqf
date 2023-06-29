/*
* Auteur : QuentinN42
* Fonction pour créer un véhicules a une position donnée
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
if (!canSuspend) exitWith {systemChat "ERREUR : doit etre unscheduled" ; false};

// Pas ouf mais marche plus ou mois bien
// lire https://cours.polymtl.ca/inf2610/documentation/notes/chap6.pdf section 6.4.1

// attend le semaphore
waitUntil {(isObjectHidden ODD_var_vls_lock) == false};
// prend le semaphore
ODD_var_vls_lock hideObject true;

private _created = nil;
private _to_gen_pos = _pos findEmptyPosition [1 + (sizeOf _vl), 250, _vl];
if ((count _to_gen_pos) != 0) then {
	_created = [_to_gen_pos, EAST, [_vl]] call BIS_fnc_spawnGroup;
	private _vl = vehicle leader _created;
	_vl allowDamage false;
	sleep 0.5;
	_vl allowDamage true;
};

// rend le semaphore
ODD_var_vls_lock hideObject false;

_created
