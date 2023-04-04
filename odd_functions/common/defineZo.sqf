
		private _mod = 0;
		{
			[_x, False] call ODDadvanced_fnc_civil;
			private _loctype = 0;
			switch (type _x) do {
				case (ODD_var_LocationType select 5): {_loctype = 0;};
				case (ODD_var_LocationType select 4): {_loctype = 1;};
				case (ODD_var_LocationType select 3): {_loctype = 2;};
				case (ODD_var_LocationType select 2): {_loctype = 3;};
				case (ODD_var_LocationType select 1): {_loctype = 4;};
				case (ODD_var_LocationType select 0): {_loctype = 5;};
			};
			{
				if (_x in ODD_var_LocationMilitaryName) then {
					_locType = 10;
				};
			}forEach ((text _x) splitstring " ");

			private _action = (random (100 - _mod)) + _mod;

			if (_action < 0) then {
				_action = 0;
			};

			switch (_loctype) do {
				case (0): {		// hill
					if (_action <= 75) then {
						_mod = _mod - 1;
					};
					if (_action > 75 and _action <= 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (1): {		// namelocal
					if (_action <= 65) then {
						_mod = _mod - 1;
					};
					if (_action > 65 and _action <= 75) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 75) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (2): {		// name
					if (_action <= 45) then {
						_mod = _mod - 1;
					};
					if (_action > 45 and _action <= 50) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 50 and _action <= 75) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 75 and _action <= 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_nbCheckPoint = round random 3;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (3): {		// nameVillage
					if (_action <= 40) then {
						_mod = _mod - 1;
					};
					if (_action > 40 and _action <= 50) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 50 and _action <= 70) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 70 and _action <= 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_nbCheckPoint = round random 2;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 90) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (4): {		// nameCity
					if (_action <= 30) then {
						_mod = _mod - 1;
					};
					if (_action > 30 and _action <= 35) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 35 and _action <= 65) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 65 and _action <= 85) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_nbCheckPoint = round random 4;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 85) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (5): {		// nameCityCapital
					if (_action <= 30) then {
						_mod = _mod - 1;
					};
					if (_action > 30 and _action <= 35) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 35 and _action <= 55) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 55 and _action <= 85) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_nbCheckPoint = round random 5;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 85 and _action <= 95) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
					if (_action > 95) then {
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_nbCheckPoint = round random 4;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						[_x, False] call ODDadvanced_fnc_civil;
						_mod = _mod + 1;
					};
				};
				case (10): {	// military
					if (_action <= 40) then {
						_mod = _mod - 1;
					};
					if (_action > 40 and _action <= 50) then {
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						_mod = _mod + 1;
					};
					if (_action > 50 and _action <= 60) then {
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_createPatrol;
						_mod = _mod + 1;
					};
					if (_action > 60 and _action <= 80) then {
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_createPatrol;
						_nbCheckPoint = round random 3;
						[_x, _nbCheckPoint, False] call ODDadvanced_fnc_roadBlock;
						_mod = _mod + 1;
					};
					if (_action > 80) then {
						[_x, False] call ODDadvanced_fnc_createGarnisonV2;
						[_x, False] call ODDadvanced_fnc_createPatrol;
						[_x, True, True] spawn ODDadvanced_fnc_createVehicule;
						_mod = _mod + 1;
					};
				};
			};
			[["ZO+ %1 : %2, niveau : %3", _forEachindex, text _x, _loctype]] call ODDcommon_fnc_log;