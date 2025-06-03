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
* [_zo] call ODDadvanced_fnc_civiesCover
*
* Variable publique :
*/

params ["_unit", "_dist"];
//[format ["moi : %1, dist : %2", _unit, _dist]] remoteExec ["systemChat", 0];

_hidingCivil = ["Acts_CivilHiding_1", "Acts_CivilHiding_2"];

if ((vehicle _unit == _unit) and !(captive _unit)) then {
	private _allVar = allVariables _unit;
	if (!("odd_var_stopped" in _allVar)) then {
		_unit setVariable ["odd_var_stopped", False, True];
	};

	private _gar = _unit getVariable "odd_var_stopped";

	if (_gar == False) then {
		_unit setVariable ["odd_var_stopped", True, True];

		private _g = group _unit;
		for "_i" from count waypoints _g - 1 to 0 step -1 do {
			deleteWaypoint [_g, _i];
		};
		_g setSpeedMode "FULL";

		if (_dist <= 10) then {
			private _a = round (random 10);
			if (_a <= 6) then {
				_unit playAction "Surrender";
				_endAnim = serverTime + (30 + round (random 90));
				waitUntil{
					sleep 1;
					((serverTime >= _endAnim) or (captive _unit))
				};
				_unit switchmove "";
			}
			else {
				[position _unit, nil, [_unit], 15, 2, True, False] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
				sleep 15;
				_unit switchMove (selectRandom _hidingCivil);

				_endAnim = serverTime + (60 + round (random 240));
				waitUntil{
					sleep 1;
					((serverTime >= _endAnim) or (captive _unit))
				};

				_unit switchMove "";
				_unit setUnitPos "UP";
				_unit setUnitPos "AUTO";
				[[_unit]] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf";
				_g setSpeedMode "NORMAL";
			};
		}
		else {
			private _a = round (random 10);
			if (_a <= 8) then {
				[position _unit, nil, [_unit], 20, 2, True, False] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
				sleep 30;
				_unit switchMove (selectRandom _hidingCivil);

				_endAnim = serverTime + (60 + round (random 240));
				waitUntil{
					sleep 1;
					((serverTime >= _endAnim) or (captive _unit))
				};

				_unit switchMove "";
				_unit setUnitPos "UP";
				_unit setUnitPos "AUTO";
				[[_unit]] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf";
				_g setSpeedMode "NORMAL";
			}
			else {
				_unit playAction "Surrender";

				_endAnim = serverTime + (30 + round (random 90));
				waitUntil{
					sleep 1;
					((serverTime >= _endAnim) or (captive _unit))
				};

				_unit switchmove "";
			};
		};

		// [_g, getPos _unit, (((size ODD_var_SelectedArea) select 0)/4)] call BIS_fnc_taskPatrol;

		_unit setVariable ["odd_var_stopped", False, True];
	};
};