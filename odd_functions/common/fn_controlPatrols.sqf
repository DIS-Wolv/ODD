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
params ["_trigger", ["_state", False], ["_radius", 1400]];

private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];

if ((typeName _pad) != "SCALAR") then {
	private _textLoc = _pad getVariable ["trig_ODD_var_locName", ""];
	[["Spawn patrol : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	
	_pad setVariable ["trig_ODD_var_patWantState", _state, True];

	_isActive = _pad getVariable ["trig_ODD_var_patControlActive", False];
	if (!_isActive) then {
		_pad setVariable ["trig_ODD_var_patControlActive", True, True];
		
		// Spawn des patrouilles
		private _pat = _pad getVariable ["trig_ODD_var_patrols", []];
		private _patPool = _pat select 0;
		private _patLimit = _pat select 1;
		private _zoDefined = _pad getVariable ["trig_ODD_var_zoType", []];
		private _zo = _pad getVariable ["trig_ODD_var_loc", ""];
		private _pos = position _zo;
		private _Buildings = nearestobjects [_pos, ODD_var_Houses, size _zo select 0];
		private _typeZo = type (_zo); //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
		private _zoActivationType = _zoDefined select 0; //[civils, pat, pat+vl, pat+garnison, pat+garnison+chkpt, pat+garnison+vl, pat+garnison+chkpt+vl]

		_pos = position _pad;
		private _patOut = 0;

		if (_state) then {
			switch (_zoActivationType) do {
				case 0: {_patOut = 0};
				case 1: {_patOut = 1.2;};
				case 3: {_patOut = 0.7;};
				case 4: {_patOut = 1;};
				case 5: {_patOut = 0.7;};
				case 6: {_patOut = 0.8;};
			};

			private _players = (playersNumber west);
			private _playersModifier = 0;
			private _typeModifier = 0;
			private _batModifier = 0;

			switch (_typeZo) do { //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
				case (ODD_var_LocationType select 5): {
					_typeModifier = -1;
					_batModifier = (count _Buildings) / 8;
					_playersModifier = _players / 7;
				};
				case (ODD_var_LocationType select 4): {
					_typeModifier = 0;
					_batModifier = (count _Buildings) / 10;
					_playersModifier = _players / 7;
				};
				case (ODD_var_LocationType select 3): {
					_typeModifier = 1;
					_batModifier = (count _Buildings) / 14;
					_playersModifier = _players / 6;
				};
				case (ODD_var_LocationType select 2): {
					if ((count _Buildings) > 25) then {
						_typeModifier = 3;
						_batModifier = (count _Buildings) / 62;
					}
					else {
						_typeModifier = 4;
						_batModifier = (count _Buildings) / 15;
					};
					_playersModifier = _players / 5;
				};
				case (ODD_var_LocationType select 1): {
					_typeModifier = 4;
					_batModifier = (count _Buildings) / 58;
					_playersModifier = _players / 6;
				};
				case (ODD_var_LocationType select 0): {
					_typeModifier = 3;
					_batModifier = (count _Buildings) / 92;
					_playersModifier = _players / 5;
				};
			};
			_patOut = _patOut * (_typeModifier + _batModifier + _playersModifier);
			_patOut = round _patOut;
			private _patGroup = [];
			_patOut = _patOut min _patLimit;
			_patOut = _patOut min _patPool;
			_patOut = _patOut + round (random 1);
			for "_i" from 0 to _patOut do {
				private _pat = [_zo] call ODDcommon_fnc_eniPatrol;
				_patGroup pushBack _pat;
			};
			_pad setVariable ["trig_ODD_var_spawnedPat",_patGroup, True];
			_patPool = _patPool - _patOut;
			_pad setVariable ["trig_ODD_var_patrols", [_patPool,_patLimit], True];
		}
		else {
			private _nearMen = _pos nearEntities ["man", _radius];
			private _spawedPat = _pad getVariable ["trig_ODD_var_spawnedPat",[]];
			private _despawnedPat = 0;
			{
				if ((side _x) == east and ((group _x) getVariable ["trig_ODD_var_Pat", False])) then {
					{
						deleteVehicle _x;
					} forEach units (group _x);
					if ((group _x) in _spawedPat) then {
						_spawedPat = _spawedPat - [(group _x)];
						_despawnedPat = _despawnedPat + 1;
					};
				};
			} forEach _nearMen;
			_patPool = _patPool + _despawnedPat; // /!\ les patrouilles spawn sur la location a et despawn sur la location b ne sont pas réajoutées à la _patPool !!!!!
			_pad setVariable ["trig_ODD_var_spawnedPat", _spawedPat, True];
		};
		// Fin du spawn 

		_WantState = _pad getVariable ["trig_ODD_var_patWantState", _state];
		_pad setVariable ["trig_ODD_var_patControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_controlPatrols;
		}
	};
};
