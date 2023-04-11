/*
* Auteur : Wolv & Hhaine
* Fonction pour spawn/despawn les garisons dans les localités proches du joueur 
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

params ["_trigger", ["_state", False], ["_radius", 1100]];
// systemChat 'prout 1';
private _loc = _trigger getVariable ["trig_ODD_var_Pad", -1];
// systemChat "caca a";
if ((typeName _loc) != "SCALAR") then {
	private _textLoc = _loc getVariable ["trig_ODD_var_locName", ""];
	[["Spawned garisons : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	
	_loc setVariable ["trig_ODD_var_garWantState", _state, True];

	_isActive = _loc getVariable ["trig_ODD_var_garControlActive", False];
	if (!_isActive) then {
		_loc setVariable ["trig_ODD_var_garControlActive", True, True];
		
		// Spawn des patrouilles
		private _zoDefined = _loc getVariable ["trig_ODD_var_zoType", []];
		private _zo = _loc getVariable ["trig_ODD_var_loc", ""];
		private _pos = position _zo;
		private _Buildings = nearestobjects [_pos, ODD_var_Houses, size _zo select 0];
		private _typeZo = type (_zo); //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
		private _zoActivationType = _zoDefined select 0; //[civils, pat, pat+vl, pat+garnison, pat+garnison+chkpt, pat+garnison+vl, pat+garnison+chkpt+vl]

		// systemChat "caca b";
		_pos = position _loc;
		private _garOut = 0;

		
	if (_state) then {
		switch (_zoActivationType) do {
			case 0: {_garOut = 0};
			case 1: {_garOut = 0;};
			case 3: {_garOut = 1;};
			case 4: {_garOut = 1;};
			case 5: {_garOut = 0.8;};
			case 6: {_garOut = 0.9;};
		};

		switch (type _x) do { //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
			case (ODD_var_LocationType select 5): {
				_typeModifier = 1;
				_batModifier = (count _Buildings) / 8;
				_playersModifier = _players / 7;
			};
			case (ODD_var_LocationType select 4): {
				_typeModifier = 1;
				_batModifier = (count _Buildings) / 10;
				_playersModifier = _players / 7;
			};
			case (ODD_var_LocationType select 3): {
				_typeModifier = 3;
				_batModifier = (count _Buildings) / 14;
				_playersModifier = _players / 6;
			};
			case (ODD_var_LocationType select 2): {
				if ((count _Buildings) > 25) then {
					_typeModifier = 5;
					_batModifier = (count _Buildings) / 64;
				}
				else {
					_typeModifier = 4;
					_batModifier = (count _Buildings) / 24;
				};
				_playersModifier = _players / 5;
			};
			case (ODD_var_LocationType select 1): {
				_typeModifier = 5;
				_batModifier = (count _Buildings) / 64;
				_playersModifier = _players / 4;
			};
			case (ODD_var_LocationType select 0): {
				_typeModifier = 6;
				_batModifier = (count _Buildings) / 72;
				_playersModifier = _players / 4;
			};
		};
		_garOut = _garOut * (_typeModifier + _batModifier + _playersModifier);
			};
			_garOut = _garOut * (_typeModifier + (0.8 * _batModifier) + _playersModifier);
			_garOut = round _garOut;
			private _garPool = _loc getVariable ["trig_ODD_var_garison", []];
			private _garGroup = [];
			_garOut = _garOut min _garPool;
			_garOut = _garOut + round (random 1);
			// systemChat "caca c";
			for "_i" from 0 to _garOut do {
				private _gar = [_loc] call ODDcommon_fnc_eniGarison;
				_garGroup pushBack _gar;
			};
			_loc setVariable ["trig_ODD_var_spawnedGar",_garGroup, True];
			_garPool = _garPool - _garOut;
			_loc setVariable ["trig_ODD_var_garison", _garPool, True];
		}
		else {
			private _nearMen = _pos nearEntities ["man", _radius];
			private _spawedGar = _loc getVariable ["trig_ODD_var_spawnedGar",[]];
			private _despawnedGar = 0;
			{
				if ((side _x) == east and ((group _x) getVariable ["trig_ODD_var_Pat", False])) then {
					{
						deleteVehicle _x;
					} forEach units (group _x);
					if ((group _x) in _spawedGar) then {
						_spawedGar = _spawedGar - (group _x);
						_despawnedGar = _despawnedGar + 1;
					};
				};
			} forEach _nearMen;
			_garPool = _garPool + _despawnedGar; // /!\ les patrouilles spawn sur la location a et despawn sur la location b ne sont pas réajoutées à la _patPool !!!!!
			_loc setVariable ["trig_ODD_var_spawnedGar", _spawedGar, True];
		};
		// Fin du spawn 

		_WantState = _loc getVariable ["trig_ODD_var_garWantState", _state];
		_loc setVariable ["trig_ODD_var_garControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_garisonsControl;
		}
	};
};
