_locationBlkList = ["", "Kavala Pier", "Fournos", "Agios Minas", "Monisi", "Agios Kosmas", "Cape Makrinos", "Pyrgi", "Sagonisi", "Agios Panagiotis", "Savri", "Cape Drakontas", "Riga", "Spokos", "Amoni", "Amfissa", "Kira", "Bomos", "Synneforos", "Atsalis", "Thronos", "Cape Agrios", "Nychi", "Zeloran", "Cape Zefyris", "Agios Georgios", "Almyra", "Agios andreas", "sideras", "Polemistia", "Skiptro", "Ochrolimni", "Chelonisi", "Didymos", "Mazi"];

{
	deleteMarker(_x);
}foreach allMapMarkers; 

_location = nearestLocations[[15000,15000], ODD_var_LocationType, 30000];
{
	_pos = getpos _x;
	if (!(text _x in _locationBlkList)) then {
		

		_roads = _pos nearRoads (size _x select 0);

		_minIED = round (((count _roads) *  2 / 100)) max 0;
		_maxIED = round ((count _roads) * 5 / 100);
		_rdm = round (random (_maxIED - _minIED)) + _minIED;

		_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
		_marker setMarkerType "hd_objective";
		_marker setMarkerColor "colorBLUFOR";
		_marker setMarkerText format["%1 | %2 | %3 | %4-%5 | %6", _forEachIndex, text _x, count _roads, _minIED, _maxIED, _rdm];

		_markerZ = createMarker [(format ["obj Z x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
		_markerZ setMarkerShape "ELLIPSE";
		_markerZ setMarkerSize [(size _x select 0), (size _x select 0)];
		_markerZ setMarkerAlpha 0.4;
		_markerZ setMarkerColor "colorOPFOR";

		// {
		// 	_posr = position _x;
		// 	_marker = createMarker [(format ["obj R x %1, y %2, z %3", (_posr select 0), (_posr select 1), (_posr select 2)]), _posr]; 
		// 	_marker setMarkerType "hd_dot";
		// 	_marker setMarkerColor "colorOPFOR";
		// } forEach _roads;

	}
	else {
		_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
		_marker setMarkerType "hd_destroy_noShadow";
		_marker setMarkerColor "ColorBlack";
		_marker setMarkerText format["%1 | %2", _forEachIndex, text _x];
	};
} forEach _location;