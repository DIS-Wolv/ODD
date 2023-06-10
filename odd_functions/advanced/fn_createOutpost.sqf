/*
* Auteur : Wolv
* Fonction pour créer des barrages sur les routes
*
* Arguments :
* 0: Zone objectif <OBJ>
* 1: Nombre de barrages souhaités <INT>
* 2: 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [_zo] call ODDadvanced_fnc_roadBlockZO
* [_zo, 2] call ODDadvanced_fnc_roadBlockZO
*
* Variable publique :
*/
params ["_zo", ["_nb", 2]];

private _pos = position _zo; 

private _grad = 0.060;
private _props = [];

private _fnc_getDenivler = {
	/* Return the diff between the lowest and highest point on a square
	 * from param1 - parm2 and param1 + parm2
	 */
	params ["_pos", ["_area", 20]];
	_posX = _pos select 0; 
	_posY = _pos select 1; 
	
	_minH =  1000; 
	_maxH = -1000; 
	for "_varX" from -_area to _area step 1 do { 
		for "_varY" from -_area to _area step 1 do { 
			_height = getTerrainHeightASL [_posX+_varX, _posY+_varY]; 
			_maxH = _height max _maxH; 
			_minH = _height min _minH; 
		};  
	};  
	
	_denivele = _maxH - _minH;
	_denivele;
};

_nbOp = [];
_nbOp resize _nb;

{
	_posOp = _pos getPos [random 900, random 360];
	_deniv = [_posOp, 50] call _fnc_getDenivler;
	_objects = count (nearestObjects [_posOp, ["house"], 75, True]);
	_nearRoad = count (_posOp nearRoads 75);
	_i = 0;
	systemChat format ["%1 | %2 | %3 | %4", _i, count (_posOp), _nearRoad, _objects];
	while {((_deniv >= 13) or (_objects >= 3) or (_nearRoad > 1))and (_i < 1000)} do {
		_posOp = _pos getPos [random 900, random 360];
		_deniv = [_posOp, 50] call _fnc_getDenivler;
		_nearRoad = count (_posOp nearRoads 75);
		_objects = count (nearestObjects [_posOp, ["house"], 75, True]);
		_i = _i + 1; 
		systemChat format ["%1 | %2 | %3 | %4", _i, count (_posOp), _nearRoad, _objects];
	};

	// Ajouter le spawn de l'outpost

	// Debug camp pos
	_marker = createMarker [(format ["Camps P x %1, y %2, z %3", (_posOp select 0), (_posOp select 1), (_posOp select 2)]), _posOp];
	_marker setMarkerType "hd_dot";
	_marker setMarkerColor "ColorPink";

	_nbOp set[_forEachIndex, _marker];
} forEach _nbOp;
publicVariable "ODD_var_MissionProps";
