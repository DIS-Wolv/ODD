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
	_marker = "DIS_mrk_FOB_0";
};

private _pos = MarkerPos _marker;
private _dir = MarkerDir _marker;
private _dh = 0.5;

private _man = getPos fob nearEntities ["Man", 100];

fob setPos _pos;
fob setDir _dir;

usine setPos (_pos getPos [8, (90+_dir)%360]);
usine setDir _dir;

private _posFact = _pos getPos [15, (90+_dir)%360];
_posFact set [2, ((_posFact select 2)+ _dh)];
factory setPos _posFact;
factory setDir (_dir + 180);

private _posArme = _pos getPos [7, (75+_dir)%360];
_posArme set [2, ((_posArme select 2)+ _dh)];
armesFob setPos _posArme;
armesFob setDir (_dir + 43);

private _posMed = _pos getPos [5.5, (57+_dir)%360];
_posMed set [2, ((_posMed select 2)+ _dh)];
medicalFob setPos _posMed;
medicalFob setDir (_dir + 180);

private _posLanc = _pos getPos [3, (46+_dir)%360];
_posLanc set [2, ((_posLanc select 2)+ _dh)];
lanceursFob setPos _posLanc;
lanceursFob setDir (_dir + 330);

{
	if (side _x == WEST) then {
		[fob, _x] call DISCommon_fnc_fastTravel;
	};
} forEach _man;


["marker_1", FOB, False] call DISCommon_fnc_markers;
