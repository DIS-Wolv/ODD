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
// _loc = createLocation [_loc];

// si la localité est récupérée correctement
if ((typeName _loc) != "SCALAR") then {
	// ectriture dans les logs
	private _textLoc = text _loc;
	[["Control Civ : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;

	// enregistrement de l'etat voulu
	_trigger setVariable ["trig_ODD_var_civWantState", _state, True];

	// si le trigeur n'est pas actif
	_isActive = _trigger getVariable ["trig_ODD_var_civIsActive", False];
	
	if (!_isActive) then {
		// activation du trigger
		_trigger setVariable ["trig_ODD_var_civIsActive", True, True];

		// choix du spawn ou despawn
		if (_state) then {
			// récupération des variables
			private _pool = _loc getVariable ["ODD_var_CivActPax", 0];
			private _pos = getPos _loc;
			private _Buildings = nearestobjects [_pos, ODD_var_Houses, size _loc select 0];

			// calcul des variables
			private _nbcivil = _pool;
			private _civil = [];

			// systemChat format ["%1 : civ %2", text _loc, _nbcivil];
			[["%1 : civ %2", text _loc, _nbcivil]] call ODDcommon_fnc_log;

			// spawn des civils
			for "_i" from 1 to _nbcivil do {
				// choix du batiment
				private _selectB = selectrandom _Buildings;
				private _pos = selectRandom ([_selectB] call BIS_fnc_buildingPositions);

				private _groupClassName = selectRandom ODD_var_Civilians;
				private _monGroup = [_pos, civilian, _groupClassName] call BIS_fnc_spawngroup;

				[_monGroup, _loc, 10] call ODDcommon_fnc_patrolWaypoint;

				{
					[_x] call ODDintels_fnc_addInteraction;
					_x addEventHandler ["FiredNear", {
						params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
						[_unit, _distance] spawn ODDadvanced_fnc_civiesCover;
					}];
					_x addEventHandler ["Hit", {
						params ["_unit", "_source", "_damage", "_instigator"];
						if (((side _instigator) == WEST) and ((side _unit) == CIVILIAN)) then {
							[-0.5] call ODDCTI_fnc_updateCivRep;
						};
						if (((side _instigator) == EAST) and ((side _unit) == CIVILIAN)) then {
							[0.25] call ODDCTI_fnc_updateCivRep;
						};
					}];
					_x addEventHandler ["Killed", {
						params ["_unit", "_killer", "_instigator"];
						if (((side _instigator) == WEST) and ((side _unit) == CIVILIAN)) then {
							[-1] call ODDCTI_fnc_updateCivRep;
						};
						if (((side _instigator) == EAST) and ((side _unit) == CIVILIAN)) then {
							[0.5] call ODDCTI_fnc_updateCivRep;
						};
					}];
				} forEach units _monGroup;

				_civil pushBack _monGroup;

				_monGroup setVariable ["ODD_var_location", _loc, True];
			};
			private _nbcivilSpawn = count _civil;
			private _maxPool = _loc getVariable ["ODD_var_CivActPax", 0];
			_loc setVariable ["ODD_var_CivGroup", _civil];
			_loc setVariable ["ODD_var_CivActPax", _maxPool - _nbcivilSpawn];
		}
		else {
			// despawn des garnisons
			private _civOut = _loc getVariable ["ODD_var_CivGroup", []];
			private _countCiv = 0;
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
					_countCiv = _countCiv + 1;
				};
			} forEach _civOut;
			[["%1 : Despawned %2 Civils", text _loc, _countCiv]] call ODDcommon_fnc_log;

			// mise a jours des variable de la localité
			private _civToSpawn = _loc getVariable ["ODD_var_CivActPax", 0];
			_loc setVariable ["ODD_var_CivGroup", []];
			_loc setVariable ["ODD_var_CivActPax", ((_countCiv + _civToSpawn) max 0)];
		};
		

		// correction si l'etat est different de l'etat voulue (si le trigger est activé ou désactivé pendant l'execution du script)
		private _WantState = _trigger getVariable ["trig_ODD_var_civWantState", _state];
		_trigger setVariable ["trig_ODD_var_civIsActive", False, True];
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


