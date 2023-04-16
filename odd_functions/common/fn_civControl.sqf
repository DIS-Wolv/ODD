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

params ["_trigger", ["_state", False], ["_radius", 900]];
private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];

if ((typeName _pad) != "SCALAR") then {
	private _zo = _pad getVariable ["trig_ODD_var_loc", -1];
	private _textLoc = _pad getVariable ["trig_ODD_var_padName", ""];
	[["Spawn Civil : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	
	_pad setVariable ["trig_ODD_var_civWantState", _state, True];

	_isActive = _pad getVariable ["trig_ODD_var_civControlActive", False];
	if (!_isActive) then {
		_pad setVariable ["trig_ODD_var_civControlActive", True, True];
		
		// Spawn des civils
		private _varCivil = _pad getVariable ["trig_ODD_var_zoType",""];
		private _spawnCivil = _varCivil select 1;
		private _civils = _pad getVariable ["trig_ODD_var_civ",""];
		private _nbCivil = _civils select 0;
		private _garCivil = _civils select 1;
		private _vlCivil = _civils select 2;
		private _staticVl = _civils select 3;
		private _patGroup = [];
		private _garGroup = [];
		private _vlGroup = [];
		private _pos = position _zo;
		if (_state) then {
			if (_spawnCivil == True) then {
				for "_i" from 0 to _vlCivil do {
					private _vl = [_zo, (_radius/2)] call ODDcommon_fnc_civVehicle;
					_vlGroup pushBack _vl;
				};
				for "_i" from 0 to _staticVl do {
					private _vl = [_zo, (_radius/2)] call ODDcommon_fnc_civVehicleStatic;
					_vlGroup pushBack _vl;
				};
				for "_i" from 0 to _nbCivil do {
					private _pat = [_zo] call ODDcommon_fnc_civPatrol;
					_patGroup pushBack _pat;
				};
				for "_i" from 0 to _garCivil do {
					private _gar = [_zo] call ODDcommon_fnc_civGarnison;
					_garGroup pushBack _gar;
				};
				_pad setVariable ["trig_ODD_var_spawnedCiv",[_patGroup, _garGroup, _vlGroup], True];
			};
		}
		else {
			private _pos = position _zo;
			private _nearMen = _pos nearEntities [["man", "Car", "Air"], _radius];
			{
				if (((side _x) == civilian) and ((group _x) getVariable ["trig_ODD_var_Civ", False])) then {
					deleteVehicle _x;
				};
				if (_x getVariable ["trig_ODD_var_Civ", False]) then {
					deleteVehicle _x;
				};
			} forEach _nearMen;
		};
		// Fin du spawn 

		_WantState = _pad getVariable ["trig_ODD_var_civWantState", _state];
		_pad setVariable ["trig_ODD_var_civControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_civControl;
		}
	};
};