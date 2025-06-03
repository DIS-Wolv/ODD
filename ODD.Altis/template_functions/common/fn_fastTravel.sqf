/*
* Auteur : Hhaine
* Permet de se TP
*
* Arguments :
* 0: ARRAY - position d'arrivée
* 1: OBJECT - joueur (par défaut : joueur local)
*
* Valeur renvoyée :
* nil
*
* Exemple:
* [player] call DISCommon_fnc_fastTravel;
*
*/

params ["_posFT", ["_player", player]];

private _posFT = getPosASL _posFT;
// Teleport the player to the selected location
private _pos = _posFT getPos [random 1 + 0.5, random 360];
_pos set [2, (_posFT select 2)];
_player setPosASL _pos;
