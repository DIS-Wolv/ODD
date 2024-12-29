/*
* Auteur : Wolv
* Fonction pour controler le spawn et despawn des Crates
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
	// ectriture dans les logs
	private _textLoc = text _loc;
	[["Control Crates : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	systemChat format ["Control Crates : Zone %1 : status %2", _textLoc, _state];

	// enregistrement de l'etat voulu
	_trigger setVariable ["trig_ODD_var_crateWantState", _state, True];

	// si le trigeur n'est pas actif
	_isActive = _trigger getVariable ["trig_ODD_var_crateIsActive", False];
	
	if (!_isActive) then {
		// activation du trigger
		_trigger setVariable ["trig_ODD_var_crateIsActive", True, True];

		// choix du spawn ou despawn
		if (_state) then {
			// récupération des caisses
			private _crates = _loc getVariable ["ODD_var_actCrate", []];
			private _pos = getPos _loc;

			private _spawnedCrates = [];
			{
				// [_crateType, _cratePos]
				// récupération des variables
				private _crateType = _x select 0;
				private _cratePos = _x select 1;

				// création de la caisse
				private _crate = createVehicle [_crateType, _cratePos, [], 0, "CAN_COLLIDE"];
				_crate setVariable ["ODD_var_location", _loc, True];

				// ajout de la caisse dans le tableau
				_spawnedCrates pushBack _crate;
			} forEach _crates;

			// enregistrement des caisses
			_loc setVariable ["ODD_var_spawnedCrate", _spawnedCrates];

		}
		else {
			_spawnedCrates = _loc getVariable ["ODD_var_spawnedCrate", []];

			// tant qu'il y a des IEDs à despawn
			private _crates = [];
			while {count _spawnedCrates > 0} do {
				private _crate = _spawnedCrates select 0;

				// récupération des variables
				private _cratePos = getPosATL _crate;
				_cratePos set[2, ((_cratePos select 2) + 0.5)];
				private _crateType = typeOf _crate;

				// Ajoute la caisse dans le tableau
				private _maCrate = [_crateType, _cratePos];
				_crates pushBack _maCrate;

				// suppression de la caisse
				deleteVehicle _crate;

				_spawnedCrates deleteAt 0;
			};

			_loc setVariable ["ODD_var_spawnedCrate", _spawnedCrates];
			_loc setVariable ["ODD_var_actCrate", _crates];
		};
		
		// correction si l'etat est different de l'etat voulue (si le trigger est activé ou désactivé pendant l'execution du script)
		private _WantState = _trigger getVariable ["trig_ODD_var_crateWantState", _state];
		_trigger setVariable ["trig_ODD_var_crateIsActive", False, True];
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


