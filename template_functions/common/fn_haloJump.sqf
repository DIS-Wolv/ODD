params ["_player"];
private _coord2D = [0,0,0];
private _coordZ = [0,0,0];

// Get the marker
{
	private _markerHalo = (markerText _x splitString " ");
	if ("DZ" in _markerHalo) then {
		if (parseNumber (_markerHalo select 1) != 0) then {
			_coord2D = getMarkerPos _x;
			_coordZ = [0,0,parseNumber (_markerHalo select 1)];
		};
	};
} forEach allMapMarkers;

// Calculate the position and teleport the player
private _posHalo = _coord2D vectorAdd _coordZ;
if (_posHalo isEqualTo [0,0,0]) then {
	systemChat "Pas de zone de saut, définissez une zone de saut";
	sleep 10;
	hintSilent "";
} else {
	_player setPosASL _posHalo;
	hintSilent "Teleported to DZ";
};