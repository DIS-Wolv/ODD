/*
* Auteur : Wolv
* Fonction pour controler le spawn et despawn des ennemis
*
* Arguments :
*	_trigger : Objet déclencheur
*	_state : Etat voulu du trigger
*	_radius : Rayon de la zone d'action
* 
*
* Exemple :
*	
*
* Variable publique :
* 
*/

// paramettre
params ["_trigger", ["_state", False], ["_radius", 1000]];

private _loc = _trigger getVariable ["ODD_var_location", -1];
_loc = createLocation [_loc];

// si la localité est récupérée correctement
if ((typeName _loc) != "SCALAR") then {
	// ectriture dans les log
	private _textLoc = text _loc;
	[["Control Eni : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	systemChat format ["Control Eni : Zone %1 : status %2", _textLoc, _state];

	// enregistrement de l'etat voulu
	_trigger setVariable ["trig_ODD_var_eniWantState", _state, True];

	// si le trigeur n'est pas actif
	_isActive = _trigger getVariable ["trig_ODD_var_eniIsActive", False];
	if (!_isActive) then {
		// activation du trigger
		_trigger setVariable ["trig_ODD_var_eniIsActive", True, True];

		// choix du spawn ou despawn
		if (_state) then {
			// récupération des variables
			private _pool = _loc getVariable ["ODD_var_OccActEni", 0];
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
				if (_pool > 2) then {
					_patrouilles = 2;
					_garnisons = _garnisons - _patrouilles;
				}
				else {
					_patrouilles = _pool;
				};
				_garnisons = _garnisons - _patrouilles;
			};

			if (_patrouilles == 0 and _garnisons > 2) then {
				_patrouilles = 2;
				_garnisons = _garnisons - _patrouilles;
			};

			[["%3 : Garnison %1, Patrouille %2", _garnisons, _patrouilles, text _loc]] call ODDcommon_fnc_log;

			// spawn des garnisons
			private _garOut = [];
			// pour chaque garnison
			for "_i" from 1 to _garnisons do {
				// choisit un batiment
				private _selectedBuilding = selectRandom _Buildings;
				_Buildings = _Buildings - [_selectedBuilding];

				// spawn de la garnison
				// systemChat format ["Garnison %1 : %2", _i, _selectedBuilding];
				private _group = [_loc, _selectedBuilding] call ODDControl_fnc_spawnGar;
				// ajoute le groupe à la liste des garnisons
				_garOut pushBack _group;
				
				sleep 0.5;
			};
			_loc setVariable ["ODD_var_OccGarnisonGroup", _garOut];

			// spwan des patrouilles
			private _patOut = [];
			// pour chaque patrouille
			// systemChat format ["Patrouille %1", _patrouilles];
			for "_i" from 1 to _patrouilles do {
				// spawn de la patrouille
				private _group = [_loc] call ODDControl_fnc_spawnPat;
				// ajoute le groupe à la liste des patrouilles
				_patOut pushBack _group;

				sleep 0.5;
			};
			_loc setVariable ["ODD_var_OccPatrolGroup", _patOut];

			
			// mise a jours des variable de la localité
			_pool = _pool - (count _garOut) - (count _patOut);
			_loc setVariable ["ODD_var_OccActEni", _pool];
		}
		else {
			// systemChat format ["Despawn %1", _textLoc];
			// despawn des garnisons
			private _garOut = _loc getVariable ["ODD_var_OccGarnisonGroup", []];
			private _countGar = 0;
			// pour chaque garnison
			{
				// despawn du groupe
				private _isAlive = false;
				{
					if ((alive _x) and !(captive _x) and (!(_x getVariable ["ACE_isUnconscious", false])) and !(_x getVariable ['ace_captives_issurrendering', False])) then {
						_isAlive = true;
					};
					deleteVehicle _x;
				} forEach units _x; 

				// si le groupe est vivant, on incrémente le compteur
				if (_isAlive) then {
					_countGar = _countGar + 1;
				};
			} forEach _garOut;
			[["%1 : Despawned %2 Garnisons", text _loc, _countGar]] call ODDcommon_fnc_log;

			// despawn des patrouilles
			private _patOut = _loc getVariable ["ODD_var_OccPatrolGroup", []];
			private _countPat = 0;
			// pour chaque patrouilles
			{
				// supprime l'Event Handler
				private _EHID = _x getVariable ["ODD_var_DeleteHandler", -1];
				if (_EHID != -1) then {
					_x removeEventHandler ["Deleted", _EHID];
				};

				// despawn du groupe
				private _isAlive = false;
				{
					if ((alive _x) and !(captive _x) and (!(_x getVariable ["ACE_isUnconscious", false])) and !(_x getVariable ['ace_captives_issurrendering', False])) then {
						_isAlive = true;
					};
					deleteVehicle _x;
				} forEach units _x; 

				// si le groupe est vivant, on incrémente le compteur
				if (_isAlive) then {
					_countPat = _countPat + 1;
				};
			} forEach _patOut;
			[["%1 : Despawned %2 Patrols", text _loc, _countGar]] call ODDcommon_fnc_log;


			// mise a jours des variable de la localité
			private _eni = _loc getVariable ["ODD_var_OccActEni", 0];
			_loc setVariable ["ODD_var_OccGarnisonGroup", []];
			_loc setVariable ["ODD_var_OccPatrolGroup", []];
			_loc setVariable ["ODD_var_OccActEni", ((_countPat + _countGar + _eni) max 0)];


			// mise a jours de la capture de la zone
			private _tgtEni = _loc getVariable ["ODD_var_OccTgtEni", 2];
			private _actEni = _loc getVariable ["ODD_var_OccActEni", 0];

			if (_actEni/_tgtEni < ODDCTI_var_capturePrc) then {
				[["%1 : Zone capturer", _textLoc]] call ODDcommon_fnc_log;
				_loc setVariable ["ODD_var_isBlue", true];
				_loc setVariable ["ODD_var_isFrontLine", true];
				
				private _nearloc = _loc getVariable ["ODD_var_nearLocations", []];
				{
					_x setVariable ["ODD_var_isFrontLine", true];
					[_x, ODD_var_CTIMarkerInfo] call ODDCTI_fnc_updateMapLocation;
				} forEach _nearloc;

				ODD_var_AllLocationsStateUpdate = False;
				publicVariable "ODD_var_AllLocationsStateUpdate";
			};

			// update du marker : 
			[_loc, ODD_var_CTIMarkerInfo] call ODDCTI_fnc_updateMapLocation;
		};
		

		// correction si l'etat est different de l'etat voulue (si le trigger est activé ou désactivé pendant l'execution du script)
		private _WantState = _trigger getVariable ["trig_ODD_var_eniWantState", _state];
		_trigger setVariable ["trig_ODD_var_eniIsActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState, _radius] call ODDControl_fnc_controlEniPax;
		}
	}
	// si le trigger est actif
	else {
		// ecrit dans les logs
		[["Trigger Activé : %1, semaphore Bloquant", _textLoc]] call ODDcommon_fnc_log;
	};
};


