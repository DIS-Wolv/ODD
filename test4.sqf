_location = nearestLocations[[15000,15000], ['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill'], 30000];

{
	// Current result is saved in variable _x
	_pos = getpos _x;

	_markerG = createMarker [(format ["obj Z x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
	_markerG setMarkerShape "ELLIPSE";
	_markerG setMarkerSize [(size _x select 0), (size _x select 0)];
	_markerG setMarkerBrush "SolidBorder";
	_markerG setMarkerAlpha 0.4; 
	_markerG setMarkerColor "colorOPFOR";

	_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
	_marker setMarkerType "hd_objective";
	_marker setMarkerColor "colorOPFOR";
	_marker setMarkerText format["%1 : [%2, %3] | %4", text _x, (size _x select 0), (size _x select 1), _forEachIndex];

} forEach _location;
