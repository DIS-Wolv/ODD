params[["_loc", [0,0,0]],["_max_dist", 1000],["_varname", nil]];

if (isNil "_varname") exitWith {nil};
if (_loc isEqualTo [0,0,0]) exitWith {nil};

clientOwner publicVariableClient _varname;
private _objs = missionNamespace getVariable _varname;

if (isNil "_objs") exitWith {nil};
if (count _objs <= 0) exitWith {nil};

_objs = _objs apply { [_x distance2D _loc, _x] };
_objs sort true;

private _dist = _objs select 0 select 0;
private _obj = _objs select 0 select 1;

if (_dist > _max_dist) exitWith {nil};

_obj
