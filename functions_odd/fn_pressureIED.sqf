/*
* Author: Wolv
* Fonction de spawn des IEDs
*
* Arguments:
* 0: Zo principale <OBJ>
* 1: Nombre d'IED <INT>
* 2: Distance de la ZO <INT>
*
* Return Value:
* nil
*
* Example:
* [_zo] call ODD_fnc_pressureIED
* [_zo, 2, 4000] call ODD_fnc_pressureIED
*
* Public:
*/
params ["_zo", ["_nb", 2], ["_isDecoy", False], ["_dist", ODD_var_DistanceZO]];

_pos = position _zo; 
private _props = [];
private _IED = [];
_IED resize _nb;

private _trapTypeLand = [];
private _trapTypeUrban = [];

_LocType = ODD_var_LocationType - ['namelocal', 'Hill'];
_nearZO = nearestLocations[position _zo, _LocType, _dist];

_roads = _pos nearRoads _dist;

{
	_posZo = position _x;
	_roadZo = _posZo nearRoads ((size _x select 1));
	_roads = _roads + _roadZo + _roadZo;
} forEach _nearZO;

_roadsFOB = position usine nearRoads 200;

_roads = _roads - _roadsFOB;
{
	_trapRoad = selectRandom _roads;
	_cRoads = roadsConnectedTo _trapRoad;
	while {count _cRoads == 0} do {
		_roads = _roads - [_trapRoad];
		_trapRoad = selectRandom _roads;
		_cRoads = roadsConnectedTo _trapRoad;
	};

	_cRoad = selectRandom _cRoads;

	_dir = _trapRoad getDir _cRoad;

	_roads = _roads - [_trapRoad];

	_trapPos = _trapRoad getPos [(3 + random 2.5), (_dir + 90)]; 
	
	if (_isDecoy) then {
		_trapTypeLand = ODD_var_IEDDecoyLand;
		_trapTypeUrban = ODD_var_IEDDecoyUrban;
	}
	else {
		_trapTypeLand = ODD_var_IEDLand;
		_trapTypeUrban = ODD_var_IEDUrban;
	};

	_trapType = _trapTypeLand + _trapTypeUrban;

	_houses1 = _trapPos nearObjects ["House", 30];
	if (count _houses1 >= 2) then {
		_trapType = _trapType + _trapTypeUrban;
	}
	else {
		_trapType = _trapType + _trapTypeLand;
	};

	_houses2 = _trapPos nearObjects ["House", 70];
	_houses2 = _houses2 - _houses1;
	if (count _houses2 >= 15) then {
		_trapType = _trapType + _trapTypeUrban;
	}
	else {
		_trapType = _trapType + _trapTypeLand;
	};

	_houses3 = _trapPos nearObjects ["House", 150];
	_houses3 = _houses3 - (_houses1 + _houses2);
	if (count _houses3 >= 15) then {
		_trapType = _trapType + _trapTypeUrban;
	}
	else {
		_trapType = _trapType + _trapTypeLand;
	};

	/*_pos = getPos _trapRoad;
	_markerGP = createMarker [(format ["IED x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
	_markerGP setMarkerType "hd_dot"; 
	if (_isDecoy) then {
		_markerGP setMarkerColor "ColorBlue";
	}
	else {
		_markerGP setMarkerColor "ColorOrange";
	};//*/
	
	_trapClass = selectRandom _trapType; 
	
	_trap = createMine[_trapClass, _trapPos, [], 0];
	
	_IED set [_forEachIndex, _trap];

}forEach _IED; //definir nombre

//ODD_var_IED = ODD_var_IED + _IED;
if (_isDecoy) then {
	ODD_var_MissionProps = ODD_var_MissionProps + _IED;
}
else {
	ODD_var_IED = ODD_var_IED + _IED;
	ODD_var_MissionProps = ODD_var_MissionProps + _IED;
};