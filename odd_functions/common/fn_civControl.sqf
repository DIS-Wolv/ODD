/*
* Auteur : Wolv & Hhaine
* Fonction pour activé et désactivé les IA dans les zone quand on est pas a coté
*
* Arguments :
* 0: Trigger <Obj>
* 1: Activation ou desactivation de la zone
*
* Valeur renvoyée :
*
* Exemple:
* [_trigger, True] call ODDadvanced_fnc_areaControl
*
* Variable publique :
*/

params ["_trigger", ["_state", False], ["_radius", 1400]];
// systemChat "prout a";
private _loc = _trigger getVariable ["trig_ODD_var_Pad", -1];

if ((typeName _loc) != "SCALAR") then {
	private _textLoc = _loc getVariable ["trig_ODD_var_locName", ""];
	[["Spawn Civil : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	
	_loc setVariable ["trig_ODD_var_civWantState", _state, True];

	_isActive = _loc getVariable ["trig_ODD_var_civControlActive", False];
	if (!_isActive) then {
		_loc setVariable ["trig_ODD_var_civControlActive", True, True];
		
		// Spawn des civils
		// systemChat "prout b";
		private _varCivil = _loc getVariable ["trig_ODD_var_zoType",""];
		private _spawnCivil = _varCivil select 1;
		private _civils = _loc getVariable ["trig_ODD_var_civ",""];
		private _nbCivil = _civils select 0;
		private _garCivil = _civils select 1;
		private _vlCivil = _civils select 2;
		private _patGroup = [];
		private _garGroup = [];
		private _vlGroup = [];
		_pos = position _loc;
		if (_state) then {
			if (_spawnCivil == True) then {
				for "_i" from 0 to _nbCivil do {
					private _pat = [_loc] call ODDcommon_fnc_civPatrol;
					_patGroup pushBack _pat;
				};
				for "_i" from 0 to _garCivil do {
					private _gar = [_loc] call ODDcommon_fnc_civGarnison;
					_garGroup pushBack _gar;
				};
				for "_i" from 0 to _vlCivil do {
					private _vl = [_loc] call ODDcommon_fnc_civVehicle;
					_vlGroup pushBack _vl;
				};
				_loc setVariable ["trig_ODD_var_spawnedCiv",[_patGroup, _garGroup, _vlGroup], True];
			};
		}
		else {
			private _nearMen = _pos nearEntities ["man", _radius];
			{
				if ((side _x) == civilian) then {
					deleteVehicle _x;
				};
				
			} forEach _nearMen;
		};
		// Fin du spawn 

		_WantState = _loc getVariable ["trig_ODD_var_civWantState", _state];
		_loc setVariable ["trig_ODD_var_civControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_civControl;
		}
	};
};