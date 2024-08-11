params ["_unit"];

[
    _unit,
    "<t color='#FF0000'>Interoger " + (name _unit) + "</t>",
    "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa",
    "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa",
    "(alive (_target)) and (_target distance _this < 3) and (lifeState _target != 'INCAPACITATED')",
    "True",
    {
        (_this select 0) disableAI "PATH";
        [(_this select 0), "PATH"] remoteExec ["disableAI", 2];
    },
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        (_this select 0) enableAI "PATH";
        [(_this select 0), "PATH"] remoteExec ["enableAI", 2];

        private _src = nil;
        if ((side (_this select 0)) == opfor) then {_src = "OPFOR";};
        if ((side (_this select 0)) == civilian) then {_src = "CIVIL";};
        if ((side (_this select 0)) == blufor) then {_src = "BLUFOR";};

        // Other sides from https://community.bistudio.com/wiki/Side
        if ((side (_this select 0)) == resistance) then {_src = "OPFOR";};
        if ((side (_this select 0)) == sideEnemy) then {_src = "OPFOR";};
        if ((side (_this select 0)) == sideFriendly) then {_src = "BLUFOR";};

        if (isNil "_src") then {
            [format ["ODDBUG : Unit %1 is not OPFOR or CIVIL", (name (_this select 0))]] remoteExec ["systemChat", 0];
        } else {
            [_src, (_this select 0)] remoteExec ["ODDintels_fnc_maybeGiveIntel", 2];
        };

        [(_this select 0)] remoteExec ["removeAllActions", 0, True];
    }, {
        (_this select 0) enableAI "PATH";
        [(_this select 0), "PATH"] remoteExec ["enableAI", 2];
    }, [], (random[2, 5, 10]), nil, True, False
] call BIS_fnc_holdActionAdd;
