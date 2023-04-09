/*
* Auteur : Wolv & Hhaine
* Fonction pour activé et désactivé les IA en patrouilles dans les zones quand on est a coté
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

params ["_trigger", ["_state", False], ["_radius", 1600]];
private _loc = _trigger getVariable ["trig_ODD_var_Pad", -1];
// systemChat "prout a";

if ((typeName _loc) != "SCALAR") then {
	private _textLoc = _loc getVariable ["trig_ODD_var_locName", ""];
	[["Spawn patrol : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	
	_loc setVariable ["trig_ODD_var_patWantState", _state, True];

	_isActive = _loc getVariable ["trig_ODD_var_patControlActive", False];
	if (!_isActive) then {
		_loc setVariable ["trig_ODD_var_patControlActive", True, True];
		
		// Spawn des patrouilles
		private _zoDefined = _loc getVariable ["trig_ODD_var_zoType", []];
		private _zo = _loc getVariable ["trig_ODD_var_loc", ""];
		private _typeZo = type (_zo); //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
		private _zoActivationType = _zoDefined select 0; //[civils, pat, pat+vl, pat+garnison, pat+garnison+chkpt, pat+garnison+vl, pat+garnison+chkpt+vl]
		private _pat = _loc getVariable ["trig_ODD_var_patrols", []];
		private _patPool = _pat select 0;
		private _patLimit = _pat select 1;
		// systemChat "prout b";
		_pos = position _loc;
		private _patOut = 0;

		if (_state) then {
			switch (_zoActivationType) do {
				case 0: {_patOut = 0};
				case 1: {_patOut = 2;};
				case 3: {_patOut = 0.5;};
				case 4: {_patOut = 1;};
				case 5: {_patOut = 0.7;};
				case 6: {_patOut = 0.8;};
				case 7: {};
			};

			private _players = (playersNumber west);
			private _playersModifier = 0;
			private _typeModifier = 0;
			private _batModifier = 0;
			switch (_typeZo) do { //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
				case (ODD_var_LocationType select 5): {
					_typeModifier = 1;
					_batModifier = (count _Buildings) / 6;
					_playersModifier = _players / 7;
				};
				case (ODD_var_LocationType select 4): {
					_typeModifier = 2;
					_batModifier = (count _Buildings) / 8;
					_playersModifier = _players / 7;
				};
				case (ODD_var_LocationType select 3): {
					_typeModifier = 4;
					_batModifier = (count _Buildings) / 12;
					_playersModifier = _players / 6;
				};
				case (ODD_var_LocationType select 2): {
					_typeModifier = 6;
					_batModifier = (count _Buildings) / 24;
					_playersModifier = _players / 5;
				};
				case (ODD_var_LocationType select 1): {
					_typeModifier = 6;
					_batModifier = (count _Buildings) / 24;
					_playersModifier = _players / 5;
				};
				case (ODD_var_LocationType select 0): {
					_typeModifier = 7;
					_batModifier = (count _Buildings) / 60;
					_playersModifier = _players / 4;
				};
			};
			_patOut = _patOut * (_typeModifier + _batModifier + _playersModifier);

			_patOut = _patOut min _patLimit;
			for "_i" from 0 to _patOut do {
				private _pat = [_loc] call ODDcommon_fnc_eniPatrol;
				_patGroup pushBack _pat;
			};
			_loc setVariable ["trig_ODD_var_spawnedPat",_patGroup, True];





			// if (_spawnCivil == True) then {
			// 	for "_i" from 0 to _nbCivil do {
			// 		private _pat = [_loc] call ODDcommon_fnc_civPatrol;
			// 		_patGroup pushBack _pat;
			// 	};
			// 	for "_i" from 0 to _garCivil do {
			// 		private _gar = [_loc] call ODDcommon_fnc_civGarnison;
			// 		_garGroup pushBack _gar;
			// 	};
			// 	for "_i" from 0 to _vlCivil do {
			// 		private _vl = [_loc] call ODDcommon_fnc_civVehicle;
			// 		_vlGroup pushBack _vl;
			// 	};
			// 	_loc setVariable ["trig_ODD_var_spawnedCiv",[_patGroup, _garGroup, _vlGroup], True];
			// };
		}
		else {
			private _nearMen = _pos nearEntities ["man", _radius];
			{
				if ((side _x) == east) then { // + patrouille
					deleteVehicle _x;
				};
				
			} forEach _nearMen;
		};
		// Fin du spawn 

		_WantState = _loc getVariable ["trig_ODD_var_patWantState", _state];
		_loc setVariable ["trig_ODD_var_patControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_civControl;
		}
	};
};