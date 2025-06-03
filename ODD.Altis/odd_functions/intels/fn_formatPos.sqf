params[["_src", [0,0,0]], ["_dst", [0,0,0]], ["_proba_grid", 0.5]];

private _dist = _src distance2D _dst;
private _angle = _src getDir _dst;

private _msg = "";
if (_proba_grid < random 1) then {
    _msg = [_dist, _angle] call ODDintels_fnc_formatDistAngle;
} else {
    _msg = [_dst] call ODDintels_fnc_formatGrid;
};

_msg
