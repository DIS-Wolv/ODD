

params ["_zo", ["_nb", 2], ["_dist", 4000]];

_pos = position _zo; 
private _props = [];
private _IED = [];
_IED resize _nb;

_LocType = ODD_var_LocationType - ['namelocal', 'Hill'];

_nearZO = nearestLocations[position _zo, _LocType, _dist];

_roads = [];//_pos nearRoads _dist;

{
	_posZo = position _x;

	_roadZo = _posZo nearRoads ((size _x select 1)*1.2);
	
	_roads = _roads + _roadZo;

} forEach _nearZO;

_roadsFOB = position usine nearRoads 200;

_roads = _roads - _roadsFOB;

{
	_trapRoad = selectRandom _roads; 
	
	_cRoads = roadsConnectedTo _trapRoad;

	_cRoad = selectRandom _cRoads;

	_dir = _trapRoad getDir _cRoad;

	_trapPos = _trapRoad getPos [(3 + random 2.5), _dir + 90]; 
	
	_trapType = [ "ACE_IEDUrbanSmall_Range", "ACE_IEDUrbanSmall_Range", "ACE_IEDUrbanBig_Range"]; 	//IED urban
	
	_trapClass = selectRandom _trapType; 
	
	_trap = createMine [_trapClass, _trapPos, [], 0];
	
	_IED set [_forEachIndex, _trap];
}forEach _IED; //definir nombre

ODD_var_IED = ODD_var_IED + _IED;
