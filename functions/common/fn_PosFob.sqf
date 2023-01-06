/*
* Auteur : Wolv
* Permet de deplacé la fob a des posistion prédéfinie
*
* Arguments :
* 0: Marker destination
*
* Valeur renvoyée :
* nil
*
* Exemple:
* ["DIS_mrk_FOB_0"] call DISCommon_fnc_PosFob;
*
*/

params ["_marker"];

if (isNil "_marker") then {
	_marker = "DIS_mrk_FOB_1";
};

_pos = MarkerPos _marker;
_dir = MarkerDir _marker;


fob setPos _pos;
fob setDir _dir;

usine setPos (_pos getPos [8, (90+_dir)%360]);
usine setDir _dir;

factory setPos (_pos getPos [15, (90+_dir)%360]);
factory setDir (_dir + 180);

armesFob setPos (_pos getPos [7, (75+_dir)%360]);
armesFob setDir (_dir + 43);

medicalFob setPos (_pos getPos [5.5, (57+_dir)%360]);
medicalFob setDir (_dir + 180);

lanceursFob setPos (_pos getPos [3, (46+_dir)%360]);
lanceursFob setDir (_dir + 330);