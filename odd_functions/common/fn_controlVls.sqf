/*
* Auteur : QuentinN42
* Fonction pour spawn/despawn les VLs
*
* Arguments :
* 0: Trigger <Obj>
* 1: Activation ou desactivation de la zone
*/

params ["_trigger", ["_state", False], ["_radius", 1000]];

private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];
private _pos = position _pad;
private _roads = _pos nearRoads 500;

if ((typeName _pad) != "SCALAR") then {
	private _textLoc = _pad getVariable ["trig_ODD_var_locName", ""];

	_pad setVariable ["trig_ODD_var_VlsWantState", _state, True];

	private _isActive = _pad getVariable ["trig_ODD_var_VlsControlActive", False];
	if (!_isActive) then {
		_pad setVariable ["trig_ODD_var_VlsControlActive", True, True];

		// Debut du spawn
		private _pool = _pad getVariable ["trig_ODD_var_VlsPool", []];
		private _spawned = _pad getVariable ["trig_ODD_var_VlsSpawned", []];
		if (_state) then {
			// spawn
			private _new_pool = [];
			{
				private _grp = [_pos findEmptyPosition [10, 700], _x, east] call ODDadvanced_fnc_createVehiculeAtPos;
				if (isNil "_grp") then {
					// erreur de spawn
					_new_pool pushBack _x;
				} else {
					// spawn reussi
					_spawned pushBack _grp;
					_grp setBehaviour "SAFE";
					for "_i" from 1 to 4 do {
						private _wai_pos = position selectRandom _roads;
						_grp addWaypoint [_wai_pos, -1];

						if (_i == 4) then {
							_grp addWaypoint [_wai_pos, -1];
							(waypoints _grp) select 5 setWaypointType "CYCLE";
						};
					};
				};
			} forEach _pool;
			_pool = _new_pool;
		} else {
			// despawn
			private _collected = [];
			{
				private _lead = leader _x;
				if (isNull _lead) then {
					// Plus personne dans le groupe
				} else {
					private _vl = vehicle _lead;
					if (isNull _vl) then {
						// Plus de vehicule
					} else {
						if (damage _vl > 0.5) then {
							// On ne conserve pas le vehicule
						} else {
							// On remet le vehicule dans le pool
							_collected pushBack typeOf _vl;
						};
						// On detruit le vehicule
						deleteVehicle _vl;
					};
				};

				// Delete tout les unit du groupe
				{
					deleteVehicle _x;
				} forEach units _x;
			} forEach _spawned;
			if (count _collected == 0) then {
				_pool = [];
			};
			_spawned = [];
			_pool = _pool + _collected;
		};
		_pad setVariable ["trig_ODD_var_VlsPool", _pool, True];
		_pad setVariable ["trig_ODD_var_VlsSpawned", _spawned, True];
		// Fin du spawn

		private _WantState = _pad getVariable ["trig_ODD_var_VlsWantState", _state];
		_pad setVariable ["trig_ODD_var_VlsControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_controlVls;
		}
	};
};
