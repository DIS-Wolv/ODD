
params [["_marker","marker_1"], ["_fob",fob]];

_marker setMarkerPos (getPos _fob);
sleep 150; 
[_marker] spawn DISCommon_fnc_markers;
