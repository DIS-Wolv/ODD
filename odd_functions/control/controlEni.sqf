
// paramettre
params ["_trigger", ["_state", False], ["_radius", 1000]];

private _loc = _trigger getVariable ["ODD_var_location", -1];
_loc = createLocation [_loc];

// si la localité est récupérée correctement
if ((typeName _loc) != "SCALAR") then {
	// ectriture dans les log
	private _textLoc = text _loc;
	[["Spawned garisons : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;

	_loc setVariable ["ODD_var_prout", 42];

	// enregistrement de l'etat voulu
	_trigger setVariable ["trig_ODD_var_garWantState", _state, True];

	// si le trigeur n'est pas actif
	_isActive = _trigger getVariable ["trig_ODD_var_isActive", False];
	if (!_isActive) then {
		// activation du trigger
		_trigger setVariable ["trig_ODD_var_isActive", True, True];

		// choix du spawn ou despawn
		if (_state) then {
			// récupération des variables
			private _pool = _loc getVariable ["ODD_var_actEni", 0];
			private _pos = getPos _loc;
			private _Buildings = nearestobjects [_pos, ODD_var_Houses, size _loc select 0];

			// calcul des variables
			private _countGarBuildings = count _Buildings;
			private _garnisons = _pool;
			private _patrouilles = 0;
			// calcule du nombre de garnisons et de patrouilles
			if ((_countGarBuildings - 1) < _garnisons) then {
				_garnisons = _countGarBuildings;
				_patrouilles = _garnisons - _countGarBuildings;
			}
			else {
				_patrouilles = 2;
				_garnisons = _garnisons - _patrouilles;
			};

			if (_patrouilles == 0 and _garnisons > 2) then {
				_patrouilles = 2;
				_garnisons = _garnisons - _patrouilles;
			};

			systemChat format ["Loc %3, Garnison %1, Patrouille %2", _garnisons, _patrouilles, text _loc];

			// spawn des garnisons
			private _garOut = [];
			// pour chaque garnison
			for "_i" from 1 to _garnisons do {
				// choisit un batiment
				private _selectedBuilding = selectRandom _Buildings;
				_Buildings = _Buildings - [_selectedBuilding];

				// spawn de la garnison
				// systemChat format ["Garnison %1 : %2", _i, _selectedBuilding];
				private _group = [_loc, _selectedBuilding] call compile preprocessFile "odd_functions\control\spawnGar.sqf";
				// ajoute le groupe à la liste des garnisons
				_garOut pushBack _group;
				
				sleep 0.5;
			};
			_loc setVariable ["ODD_var_GarnisonGroup", _garOut];

			// spwan des patrouilles
			private _patOut = [];
			// pour chaque patrouille
			systemChat format ["Patrouille %1", _patrouilles];
			for "_i" from 1 to _patrouilles do {
				// spawn de la patrouille
				private _group = [_loc] call compile preprocessFile 'odd_functions\control\spawnPat.sqf';
				// ajoute le groupe à la liste des patrouilles
				_patOut pushBack _group;

				sleep 0.5;
			};
			_loc setVariable ["ODD_var_PatrolGroup", _patOut];

			
			// mise a jours des variable de la localité
			_pool = _pool - (count _garOut) - (count _patOut);
			_loc setVariable ["ODD_var_actEni", _pool];
		}
		else {
			[["Despawned garisons : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
			// despawn des garnisons
			private _garOut = _loc getVariable ["ODD_var_GarnisonGroup", []];
			private _countGar = 0;
			// pour chaque garnison
			{
				// despawn du groupe
				private _isAlive = false;
				{
					if (alive _x) then {
						_isAlive = true;
					};
					deleteVehicle _x;
				} forEach units _x; 

				// si le groupe est vivant, on incrémente le compteur
				if (_isAlive) then {
					_countGar = _countGar + 1;
				};
			} forEach _garOut;

			// despawn des patrouilles
			private _patOut = _loc getVariable ["ODD_var_PatrolGroup", []];
			private _countPat = 0;
			// pour chaque patrouilles
			{
				// despawn du groupe
				private _isAlive = false;
				{
					if (alive _x) then {
						_isAlive = true;
					};
					deleteVehicle _x;
				} forEach _x; 

				// si le groupe est vivant, on incrémente le compteur
				if (_isAlive) then {
					_countPat = _countPat + 1;
				};
			} forEach _patOut;

			// mise a jours des variable de la localité
			private _eni = _loc getVariable ["ODD_var_actEni", 0];
			_loc setVariable ["ODD_var_GarnisonGroup", []];
			_loc setVariable ["ODD_var_PatrolGroup", []];
			_loc setVariable ["ODD_var_actEni", (_countPat + _countGar + _eni)];
			[["Despawned %1 garnisons", _countGar]] call ODDcommon_fnc_log;
		};
		

		// correction si l'etat est different de l'etat voulue (si le trigger est activé ou désactivé pendant l'execution du script)
		private _WantState = _trigger getVariable ["trig_ODD_var_garWantState", _state];
		_trigger setVariable ["trig_ODD_var_isActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState, _radius] call compile preprocessFile 'odd_functions\control\controlEni.sqf';
		}
	}
	// si le trigger est actif
	else {
		// ecrit dans les logs
		[["Trigger Activé : %1, semaphore Bloquant", _textLoc]] call ODDcommon_fnc_log;
	};
};

