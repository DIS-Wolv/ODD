/*
* Auteur : Hhaine & Wolv
* Fonction pour mettre les civils en garnison quand on tire a coté
*
* Arguments :
* 0: civil <Obj>
*
* Valeur renvoyée :
*
* Exemple:
* [_zo] call ODD_fnc_civiesCover
*
* Variable publique :
*/

params ["_unit", "_dist"];
//[format ["moi : %1, dist : %2", _unit, _dist]] remoteExec ["systemChat", 0];

if ((vehicle _unit == _unit) and !(captive _unit)) then {
    private _allVar = allVariables _unit;
    if (!("odd_var_stopped" in _allVar)) then {
        _unit setVariable ["odd_var_stopped", false, true];
    };

    private _gar = _unit getVariable "odd_var_stopped";

    if (_gar == false) then {
        _unit setVariable ["odd_var_stopped", true, true];

        private _g = group _unit;
        for "_i" from count waypoints _g - 1 to 0 step -1 do {
            deleteWaypoint [_g, _i];
        };
        _g setSpeedMode "FULL";

        if (_dist <= 10) then {
            private _a = round (random 10);
            if (_a <= 6) then {
                [_unit, 31, false] call zen_modules_fnc_moduleAmbientAnimStart;
                sleep (30 + round (random 90));
                [_unit] call zen_modules_fnc_moduleAmbientAnimEnd;
            }
            else {
                [position _unit, nil, [_unit], 15, 2, true, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
                sleep 15;
                [_unit, 30, false] call zen_modules_fnc_moduleAmbientAnimStart;
                sleep (60 + round (random 240));
                [_unit] call zen_modules_fnc_moduleAmbientAnimEnd;
                _unit setUnitPos "UP";
                _unit setUnitPos "AUTO";
                [[_unit]] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf";
                _g setSpeedMode "NORMAL";
            };
        }
        else {
            private _a = round (random 10);
            if (_a <= 8) then {
                [position _unit, nil, [_unit], 20, 2, true, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
                sleep 30;
                [_unit, 30, false] call zen_modules_fnc_moduleAmbientAnimStart;
                sleep (60 + round (random 240));
                [_unit] call zen_modules_fnc_moduleAmbientAnimEnd;
                _unit setUnitPos "UP";
                _unit setUnitPos "AUTO";
                [[_unit]] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf";
                _g setSpeedMode "NORMAL";
            }
            else {
                [_unit, 31, false] call zen_modules_fnc_moduleAmbientAnimStart;
                sleep (30 + round (random 90));
                [_unit] call zen_modules_fnc_moduleAmbientAnimEnd;
            };
        };

        [_g, getPos _unit, (((size ODD_var_SelectedArea) select 0)/4)] call BIS_fnc_taskPatrol;

        _unit setVariable ["odd_var_stopped", false, true];
    };
};