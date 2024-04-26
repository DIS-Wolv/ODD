/*
* Auteur : Wolv & Hhaine
* Fonction pour faire spawn et dispawn les road block hors des villes + les soldat dessus.
*
* Arguments :
* 0: Trigger <Obj>
* 1: Activation ou desactivation de la zone
*
* Valeur renvoyée :
*
* Exemple:
* [_trigger, True] call ODDcommon_fnc_controlRoadBlockAo
*
* Variable publique :
*/

params ["_trigger", ["_state", False]];
private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];

if ((typeName _pad) != "SCALAR") then {
	_pad setVariable ["trig_ODD_var_RbWantState", _state, True];

	_isActive = _pad getVariable ["trig_ODD_var_RbControlActive", False];
	if (!_isActive) then {
		_pad setVariable ["trig_ODD_var_RbControlActive", True, True];
		
		// Spawn 
		private _pos = _pad getVariable ["trig_ODD_var_RoadPos", []];
		private _dir = _pad getVariable ["trig_ODD_var_RoadDir", 0];
		private _struct = _pad getVariable ["trig_ODD_var_Structure", []];

		if (_state) then {
			private _pool = _pad getVariable ["trig_ODD_var_EniPool", 0];

			// tirage des groupes
			private _Bat = nearestObjects [_pos, ODD_var_Houses, 50];
			private _groupGar = [];
			private _groupPat = [];
			if (count(_Bat) <= 2) then {
				_groupGar = selectRandom ODD_var_Pair;
				_groupPat = selectRandom ODD_var_Squad;
				
			}
			else {
				if (count(_Bat) <= 4) then {
					_groupGar = selectRandom ODD_var_FireTeam;
					_groupPat = selectRandom ODD_var_FireTeam;
				}
				else {
					_groupGar = selectRandom ODD_var_FireTeam;
					_groupPat = selectRandom ODD_var_Pair;
				};
			};

			if (_pool <= count _groupGar) then {
				_groupPat = [];
				_groupGar resize _pool;
			}
			else {
				if ((_pool - count _groupGar) <= (count _groupPat)) then {
					_groupPat resize (_pool - count _groupGar);
				};
			};

			// groupe de garnison
			if ((count _groupGar) > 0) then {
				_gg = [_pos, EAST, _groupGar] call BIS_fnc_spawnGroup;
				{
					_x setVariable ["acex_headless_blacklist", True, True];
					_x setVariable ["ODD_var_IsInGarnison", True, True];
				} forEach (units _gg);
				[_pos, nil, units _gg, 20, 0, False, True] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
				_pad setVariable ["trig_ODD_var_Gar", units _gg, True];

				{
					private _id = _x addEventHandler["Killed", 
						{ 
							params ["_unit", "_killer"]; 
							[_unit, _killer] call ODDadvanced_fnc_surrender;
						}
					];
					_x setVariable ["ODD_var_SurrenderHandler", _id, True];
					// EH pour secure Area ?

					_x addEventHandler ["Fired", {
						params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
						[_unit, _weapon, _projectile] spawn {
							params ["_unit", "_weapon", "_projectile"];
							sleep 1;
							if (_weapon == "Throw" and (_projectile distance _unit) < 5) then {
								deleteVehicle _projectile;
							};
						};
					}];
				}forEach units _gg;
			};

			// groupe de patrouille
			if ((count _groupPat) > 0) then {
				_gp = [_pos, EAST, _groupPat] call BIS_fnc_spawnGroup;
				_dist = 50 + random 100;
				_listPos = [(_pos getPos[_dist, 45]), (_pos getPos[_dist, 135]), (_pos getPos[_dist, 225]), (_pos getPos[_dist, 315])];
				[_listPos] call BIS_fnc_arrayShuffle;
				_gp setFormation "STAG COLUMN";
				_gp setBehaviour "AWARE";
				_gp addWaypoint [(_listPos select 0), 0];
				_gp addWaypoint [(_listPos select 1), 0];
				_gp addWaypoint [(_listPos select 2), 0];
				_gp addWaypoint [(_listPos select 3), 0];
				_gp addWaypoint [(_listPos select 0), 0];
				(waypoints _gp) select (count (waypoints _gp) -1) setWaypointType "CYCLE";
				_pad setVariable ["trig_ODD_var_Pat", units _gp, True];

				{
					private _id = _x addEventHandler["Killed", 
						{ 
							params ["_unit", "_killer"]; 
							[_unit, _killer] call ODDadvanced_fnc_surrender;
						}
					];
					_x setVariable ["ODD_var_SurrenderHandler", _id, True];
					// EH pour secure Area ?

					_x addEventHandler ["Fired", {
						params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
						[_unit, _weapon, _projectile] spawn {
							params ["_unit", "_weapon", "_projectile"];
							sleep 1;
							if (_weapon == "Throw" and (_projectile distance _unit) < 5) then {
								deleteVehicle _projectile;
							};
						};
					}];
				}forEach units _gp;
			};

			_pool = _pool - ((count _groupGar) + (count _groupPat));
			_pad setVariable ["trig_ODD_var_EniPool", _pool, True];
		}
		else {
			private _props = _pad getVariable ["trig_ODD_var_Props", []];
			private _hideObject = _pad getVariable ["trig_ODD_var_HideObject", []];
			private _pat = _pad getVariable ["trig_ODD_var_Pat", []];
			private _gar = _pad getVariable ["trig_ODD_var_Gar", []];
			private _pool = _pad getVariable ["trig_ODD_var_EniPool", 0];
			private _nbGar = 0;
			private _nbPat = 0;

			{
				if ((_x distance2D _pos) <= 200) then {
					if (alive _x) then {
						_nbPat = _nbPat + 1;
					};
					deleteVehicle _x;
				};
			} forEach _pat;
			{
				if ((_x distance2D _pos) <= 200) then {
					if (alive _x) then {
						_nbGar = _nbGar + 1;
					};
					deleteVehicle _x;
				};
			} forEach _gar;

			_pool = _pool + _nbGar + _nbPat;
			_pad setVariable ["trig_ODD_var_EniPool", _pool, True];
		};
		// Fin du spawn 

		_WantState = _pad getVariable ["trig_ODD_var_RbWantState", _state];
		_pad setVariable ["trig_ODD_var_RbControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_controlCiv;
		}
	};
};