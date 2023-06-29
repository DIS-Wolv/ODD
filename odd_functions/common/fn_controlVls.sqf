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
			{
				private _vl = [position _pad, _x] call ODDadvanced_fnc_createVehiculeAtPos;
				_spawned pushBack _vl;
			} forEach _pool;
		}
		else {
			// despawn
			private _collected = [];
			{
				if (alive _x) then {
					_collected pushBack _x;
					deleteVehicle _x;
				};
			} forEach _spawned;
			_spawned = [];
			_pool = _pool + _collected;
		};
		systemChat "vv";
		systemChat str _pool;
		systemChat str _spawned;
		systemChat "^^";
		_pad setVariable ["trig_ODD_var_VlsPool", _pool, True];
		_pad setVariable ["trig_ODD_var_VlsSpawned", _spawned, True];
		// Fin du spawn

		private _WantState = _pad getVariable ["trig_ODD_var_VlsWantState", _state];
		_pad setVariable ["trig_ODD_var_VlsControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_OutpostControl;
		}
	};
};
