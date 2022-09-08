

params ["_zo", ["_nb", 2], ["_dist", 4000]];

_pos = position _zo; 
private _props = [];

_LocType = ODD_var_LocationType - ['namelocal', 'Hill'];

_nearZO = nearestLocations[position _zo, _LocType, _dist];

_roads = _pos nearRoads _dist;

_roadsFOB = position usine nearRoads 200;

_roads = _roads - _roadsFOB;

{
	_posZo = position _x;

	_roadZo = _posZo nearRoads ((size _x select 1));
	
	_roads = _roads - _roadZo;

} forEach _nearZO;

{
	_trapRoad = _x; 
	
	_cRoads = roadsConnectedTo _trapRoad;

	_cRoad = selectRandom _cRoads;

	_dir = _trapRoad getDir _cRoad;

	_trapPos = _trapRoad getPos [(3 + random 2.5), _dir + 90]; 
	
	_trapType = ["ACE_IEDLandSmall_Range","ACE_IEDLandBig_Range"]; 	//IED LAND
	
	_trapClass = selectRandom _trapType; 
	
	createMine [_trapClass, _trapPos, [], 0];
}forEach _roads; //definir nombre
