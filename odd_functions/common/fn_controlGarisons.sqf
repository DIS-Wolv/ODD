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

params ["_trigger", ["_state", False], ["_radius", 1000]];

private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];

if ((typeName _pad) != "SCALAR") then {
	private _textLoc = _pad getVariable ["trig_ODD_var_locName", ""];
	[["Spawned garisons : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	
	_pad setVariable ["trig_ODD_var_garWantState", _state, True];

	_isActive = _pad getVariable ["trig_ODD_var_garControlActive", False];
	if (!_isActive) then {
		_pad setVariable ["trig_ODD_var_garControlActive", True, True];
		
		// Spawn des patrouilles
		private _zoDefined = _pad getVariable ["trig_ODD_var_zoType", []];
		private _zo = _pad getVariable ["trig_ODD_var_loc", ""];
		private _pos = position _zo;
		private _Buildings = nearestobjects [_pos, ODD_var_Houses, size _zo select 0];
		private _typeZo = type (_zo); //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
		private _zoActivationType = _zoDefined select 0; //[civils, pat, pat+vl, pat+garnison, pat+garnison+chkpt, pat+garnison+vl, pat+garnison+chkpt+vl]
		private _garPool = _pad getVariable ["trig_ODD_var_garisonPool", 25];
		private _garGroup = [];


		_pos = position _pad;
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
					_typeModifier = 1; 
					_batModifier = (count _Buildings) / 14; 
					_playersModifier = _players / 7; 
				}; 
				case (ODD_var_LocationType select 3): { 
					_typeModifier = 3; 
					_batModifier = (count _Buildings) / 12; 
					_playersModifier = _players / 6; 
				}; 
				case (ODD_var_LocationType select 2): { 
					if ((count _Buildings) > 25) then { 
						_typeModifier = 5; 
						_batModifier = (count _Buildings) / 60; 
						} 
					else { 
						_typeModifier = 4; 
						_batModifier = (count _Buildings) / 20; 
					}; 
					_playersModifier = _players / 5; 
				}; 
				case (ODD_var_LocationType select 1): { 
					_typeModifier = 6; 
					_batModifier = (count _Buildings) / 54; 
					_playersModifier = _players / 4; 
				}; 
				case (ODD_var_LocationType select 0): { 
					_typeModifier = 7; 
					_batModifier = (count _Buildings) / 66; 
					_playersModifier = _players / 4; 
				}; 
			}; 
			
			_garOut = _garOut * (_typeModifier + _batModifier + _playersModifier); 
			//_garOut = _garOut * 4;
			// _garOut = _garOut * (_typeModifier + (0.8 * _batModifier) + _playersModifier);
			_garOut = round _garOut;

			_garOut = _garOut min _garPool;
			_garOut = _garOut min (count _Buildings);
			_garOut = _garOut + round (random 1);

			for "_i" from 0 to _garOut do {
				private _gar = [_zo] call ODDcommon_fnc_eniGarison;
				_garGroup pushBack _gar;
			};
			
			[['Quantité Garnison : Spawn %1 : %2 group(s)', (text _zo), _garOut]] call oddcommon_fnc_log;

			_garPool = _garPool - _garOut;
			_pad setVariable ["trig_ODD_var_garisonPool", _garPool, True];
			_pad setVariable ["trig_ODD_var_garisonPoolGroups", _garGroup, True];
		}
		else {
			private _despawnedGar = 0;
			private _garGroup = _pad getVariable ["trig_ODD_var_garisonPoolGroups", []];

			{
				// vérification qu'il sont pas trop proche des joueurs ?
				{
					deleteVehicle _x;
				} forEach units _x;
				_despawnedGar = _despawnedGar + 1;
				_garGroup = _garGroup - [_x];
			} forEach _garGroup;
			_garPool = _garPool + _despawnedGar;

			[['Quantité Garnison : Despawn %1 : %2 group(s)', (text _zo), _despawnedGar]] call oddcommon_fnc_log;

			_pad setVariable ["trig_ODD_var_garisonPool", _garPool, True];
			_pad setVariable ["trig_ODD_var_garisonPoolGroups", _garGroup, True];
		};
		// Fin du spawn 

		_WantState = _pad getVariable ["trig_ODD_var_garWantState", _state];
		_pad setVariable ["trig_ODD_var_garControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_controlGarisons;
		}
	};
};
