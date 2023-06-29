/*
* Auteur : Wolv
* Fonction pour créer des véhicules sur une zone
*
* Arguments :
* 0: position
* 1: ID du véhicule
*
* Valeur renvoyée :
* Nil
*
* Exemple :
* [position player, "rhssaf_army_o_t72s"] spawn ODDadvanced_fnc_createVehiculeAtPos
*/

// Récupère les arguments
params ["_pos", "_vl"];

// Pas ouf mais marche plus ou mois bien
// lire https://cours.polymtl.ca/inf2610/documentation/notes/chap6.pdf section 6.4.1

// attend le semaphore
waitUntil {(isObjectHidden ODD_var_vls_lock) == false};
// prend le semaphore
ODD_var_vls_lock hideObject true;

private _created = false;
private _to_gen_pos = _pos findEmptyPosition [1 + (sizeOf _vl), 250, _vl];
if ((count _to_gen_pos) != 0) then {
	_created = _vl createVehicle _to_gen_pos;
	_created allowDamage false;
	sleep 0.5;
	_created allowDamage true;
};

// rend le semaphore
ODD_var_vls_lock hideObject false;

_created
