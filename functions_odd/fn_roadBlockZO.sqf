/*
* Author: Wolv
* Fonction permettant de selectioné des position pour des roadblock
*
* Arguments:
* 0: Zone souhaité <Obj>
* 1: Nombre de roadblock souhaité <INT>
* 2: Activation du debug dans le chat <BOOL>
*
* Return Value:
* nil
*
* Example:
* [_zo] call WOLV_fnc_roadBlockZO
* [_zo, 2, true] call WOLV_fnc_roadBlockZO
*
* Public:
*/
params ["_zo", ["_nb", 2], ["_dist", 4000], ["_Debug", false]];

["Test RoadBlockZO"] remoteExec ["systemChat", 0];

_pos = position _zo; 
private _props = [];

_nearZO = nearestLocations[position _zo, locationtype, _dist];

_roads = _pos nearRoads _dist;

{
	_posZo = position _x;

	_roadZo = _posZo nearRoads (size _x select 1);
	
	_roads = _roads - _roadZo;

} forEach _nearZO;

for [{ _i = 0 }, { _i < _nb }, { _i = _i + 1 }] do {
	_road = selectRandom _roads;

	_posr = position _road; 

	_markerGP =	createMarker [(format ["CP ZO+ P x %1, y %2, z %3", (_posr select 0), (_posr select 1), (_posr select 2)]), _posr];
	_markerGP setMarkerType "hd_dot";
	_markerGP setMarkerColor "ColorPink";

};

