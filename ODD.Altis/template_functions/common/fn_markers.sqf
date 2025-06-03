/*
* Auteur : Wolv
* Permet de deplacer un marker sur la position d'un objet
*
* Arguments :
* 0: STRING - Nom du marker
* 1: OBJECT - Objet
* 2: BOOL - Redo (optionnel) - Si True, le marker sera mis a jour toutes les 150 secondes
*
* Valeur renvoyée :
* nil
*
* Exemple:
* ["DIS_mrk_FOB_0"] call DIS_fnc_markerOnFob;
*
*/
params [["_marker", "marker_1"], ["_fob", fob], ["_redo", True]];

_marker setMarkerPos (getPos _fob);
if (_redo) then {
	sleep 150;
	[_marker] spawn DISCommon_fnc_markers;
};
