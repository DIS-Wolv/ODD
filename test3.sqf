_locationBlkList = ["", "Kavala Pier", "Fournos", "Agios Minas", "Monisi", "Agios Kosmas", "Cape Makrinos", "Pyrgi", "Sagonisi", "Agios Panagiotis", "Savri", "Cape Drakontas", "Riga", "Spokos", "Amoni", "Amfissa", "Kira", "Bomos", "Synneforos", "Atsalis", "Thronos", "Cape Agrios", "Nychi", "Zeloran", "Cape Zefyris", "Agios Georgios", "Almyra", "Agios andreas", "sideras", "Polemistia", "Skiptro", "Ochrolimni", "Chelonisi", "Didymos", "Mazi"];

{
	deleteMarker(_x);
}foreach allMapMarkers; 

_location = nearestLocations[[15000,15000], ODD_var_LocationType, 30000];
{
	_pos = getpos _x;
	if (!(text _x in _locationBlkList)) then {
		_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
		_marker setMarkerType "hd_objective";
		_marker setMarkerColor "colorOPFOR";
		_marker setMarkerText format["%1 | %2", text _x, _forEachIndex];
	}
	else {
		_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
		_marker setMarkerType "hd_destroy_noShadow";
		_marker setMarkerColor "ColorBlack";
		_marker setMarkerText format["%1 | %2", text _x, _forEachIndex];
	};
} forEach _location;