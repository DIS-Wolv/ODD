
params [["_marker", "marker_1"], ["_fob", fob], ["_redo", True]];

_marker setMarkerPos (getPos _fob);
if (_redo) then {
	sleep 150;
	[_marker] spawn DISCommon_fnc_markers;
};