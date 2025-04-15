/*
* Auteur : Wolv
* Fonction pour controler le spawn et despawn des IEDs
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
	// ecriture dans les logs
	private _textLoc = text _loc;
	[["Control IEDs : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	// systemChat format ["Control IEDs : Zone %1 : status %2", _textLoc, _state];

	// enregistrement de l'etat voulu
	_trigger setVariable ["trig_ODD_var_iedWantState", _state, True];

	// si le trigeur n'est pas actif
	_isActive = _trigger getVariable ["trig_ODD_var_iedIsActive", False];
	
	if (!_isActive) then {
		// activation du trigger
		_trigger setVariable ["trig_ODD_var_iedIsActive", True, True];

		// choix du spawn ou despawn
		if (_state) then {
			// récupération des variables
			private _IEDs = _loc getVariable ["ODD_var_actIED", []];
			private _pos = getPos _loc;

			private _spawnedIEDs = [];
			// spawn des IEDs
			{
				//[_coverPos, _coverDir, _coverClass, _exploPos, _exploClass, _isDecoy]
				// récupération des variables
				private _coverPos = _x select 0;
				private _coverDir = _x select 1;
				private _coverClass = _x select 2;
				private _exploPos = _x select 3;
				private _exploClass = _x select 4;
				private _isDecoy = _x select 5;

				// création du cover
				private _cover = createVehicle [_coverClass, _coverPos, [], 0, "CAN_COLLIDE"];
				_cover setDir _coverDir;

				// ajout du trigger de déclenchement
				if (!_isDecoy) then {
					// création de l'explosif
					private _explo = createMine  [_exploClass, _exploPos, [], 0]; //, "CAN_COLLIDE"
					_explo setDir _coverDir;

					// création des variables
					_nbBlue = round((random 2) + 1);
					_timer = 0;
					if (_nbBlue == 1) then {
						_timer = round((random 30) + 45);
					}
					else {
						_timer = round((random 30));
					};

					// création du trigger
					private _triggerExplo = createTrigger ["EmptyDetector", _cover, False];
					_triggerExplo setTriggerArea [5, 5, 0, False, 5];
					_triggerExplo setTriggerActivation ["WEST", "PRESENT", False];
					_triggerExplo setTriggerStatements [
						format["this and (count thisList) >= %1", _nbBlue],
						Format["_explo = thisTrigger getVariable ['ODD_var_IED_Explo', ''];
						if (typeName _explo == 'OBJECT') then {
							[_explo, %1] spawn {
								_thisExplo = _this select 0;
								_thisTimer = _this select 1;
								sleep _thisTimer;
								_thisExplo setDamage 1;
							};
						};
						_cover = thisTrigger getVariable ['ODD_var_IED_Cover', ''];
						_cover setVariable ['ODD_var_IED_IsDecoy', True, True];
						deleteVehicle thisTrigger;
						",_timer],""
					];

					_triggerExplo setVariable ["ODD_var_IED_Explo", _explo, True];			// attache l'explosif au trigger
					_triggerExplo setVariable ["ODD_var_IED_Cover", _cover, True];			// attache le cover au trigger
					_explo setVariable ["ODD_var_IED_Trigger", _triggerExplo, True];
					_explo setVariable ["ODD_var_IED_Cover", _cover, True];
					_cover setVariable ["ODD_var_IED_Trigger", _triggerExplo, True];
					_cover setVariable ["ODD_var_IED_Explo", _explo, True];
					_cover setVariable ["ODD_var_IED_ExploClass", _exploClass, True];
				};
				// ajout des variables
				_cover setVariable ["ODD_var_IED_IsDecoy", _isDecoy, True];
				_cover setVariable ["ODD_var_Loc", _loc, True];
				
				_spawnedIEDs pushBack _cover;
			} forEach _IEDs;

			// enregistrement des IEDs
			_loc setVariable ["ODD_var_spawnedIEDs", _spawnedIEDs];
		}
		else {
			// récupération des IEDs spawnés
			_spawnedIEDs = _loc getVariable ["ODD_var_spawnedIEDs", []];

			// tant qu'il y a des IEDs à despawn
			private _IEDs = [];
			while {count _spawnedIEDs > 0} do {
				// récupération des objets
				private _cover = _spawnedIEDs select 0;

				// si il a pas explosé ou si c'est pas un leurre
				private _explo = _cover getVariable ["ODD_var_IED_Explo", objNull];
				private _isDecoy = _cover getVariable ["ODD_var_IED_IsDecoy", False];
				if (!_isDecoy) then {
					// suppression du trigger
					private _trigger = _cover getVariable ["ODD_var_IED_Trigger", objNull];
					deleteVehicle _trigger;
				};

				// récupération des variables
				private _coverPos = getPos _cover;
				private _coverDir = getDir _cover;
				private _coverClass = typeOf _cover;
				private _exploPos = getPos _explo;
				// vue que c'est une mine je peux pas récupérer le type de mine
				// private _exploClass = typeOf _explo;
				private _exploClass = _cover getVariable ["ODD_var_IED_ExploClass", ""];

				// save des variables
				_thisIED = [_coverPos, _coverDir, _coverClass, _exploPos, _exploClass, _isDecoy];
				_IEDs pushBack _thisIED;
				
				// suppression des objets
				deleteVehicle _cover;
				deleteVehicle _explo;

				_spawnedIEDs deleteAt 0;
			};

			_loc setVariable ["ODD_var_spawnedIEDs", _spawnedIEDs];
			_loc setVariable ["ODD_var_actIED", _IEDs];

		};
		

		// correction si l'etat est different de l'etat voulue (si le trigger est activé ou désactivé pendant l'execution du script)
		private _WantState = _trigger getVariable ["trig_ODD_var_iedWantState", _state];
		_trigger setVariable ["trig_ODD_var_iedIsActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState, _radius] call ODDControl_fnc_controlCiv;
		}
		
	}
	// si le trigger est actif
	else {
		// ecrit dans les logs
		[["Trigger Activé : %1, semaphore Bloquant", _textLoc]] call ODDcommon_fnc_log;
	};
	
};


