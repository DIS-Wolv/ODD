/*
* Auteur : QuentinN42
* Fonction pour créer des camps autours d'une ville
*
* Arguments :
* 0: Zone objectif <position>
* 1: Nombre de camps souhaités <INT>
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [_zo] call ODDadvanced_fnc_createOutpostsAroundZo
* [_zo, 2] call ODDadvanced_fnc_createOutpostsAroundZo
*/
params ["_zo", ["_outpost_nb", 4]];

private _offset_angle = random 360;

for "_i" from 0 to _outpost_nb - 1 do {
	private _angle = ((_i * 360 / _outpost_nb) + _offset_angle) % 360;
	private _distance = 500;

	// rotation d'un angle et decalage de _distance
	private _p = _zo getPos [_distance, _angle];

	// marker pour debug
	_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_p select 0), (_p select 1), (_p select 2)]), _p]; 
	_marker setMarkerType "hd_dot";
	_marker setMarkerColor "ColorBlue";

	private _posOpPossible = selectBestPlaces [_p, 150, "meadow + hills - 2*forest - houses", 1, 5];
	systemChat str _posOpPossible;
	private _posOp = (selectRandom _posOpPossible) select 0;

	[_posOp] call ODDadvanced_fnc_createOutpostAtPos;
};
