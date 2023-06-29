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
* [position player, "rhssaf_army_o_t72s"] call ODDadvanced_fnc_createVehiculeAtPos
*/

// Récupère les arguments
params ["_pos", "_vl"];

// if (isNil "ODD_VL_LOCK") then { ODD_VL_LOCK = 0; };
// while {ODD_VL_LOCK != 0} do { sleep 0.1; };
// ODD_VL_LOCK = 1;
// publicVariable "ODD_VL_LOCK";


private _created = nil;
private _to_gen_pos = _pos findEmptyPosition [1 + (sizeOf _vl), 250, _vl];
if ((count _to_gen_pos) != 0) then {
	_created = _vl createVehicle _to_gen_pos;
};

// ODD_VL_LOCK = 0;
_created
