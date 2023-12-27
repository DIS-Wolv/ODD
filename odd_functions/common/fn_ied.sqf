/*
* Auteur : Wolv
* Fonction pour spawn les IED
*
* Arguments :
* 0: Cover Type (className) <STRING>
* 1: Cover position (position) <ARRAY>
* 2: Direction du cover (azimut) <INT>
* 3: Explosif Type (className) <STRING>
* 4: Explosif position (position) <ARRAY>
* 5: Type d'ied <INT> (voir le switch)
* 6: TriggerMan Type (className) <ARRAY> /!\ ARRAY et pas STRING
* 7: TriggerMan position (position) <ARRAY>
*
* Valeur renvoyée :
*	cover de l'ied <OBJ>
*
* Exemple:
* [] call ODDcommon_fnc_ied
*
* Variable publique :
*/

params ["_coverType", "_coverPos", "_coverDir", "_exploType", "_exploPos", "_type", "_triggerManType", "_triggerManPos"];

private _cover = _coverType createVehicle _coverPos;
_cover setDir _coverDir;
_cover setVariable ["ODD_var_IED_Type", _type, True];
_cover setVariable ["ODD_var_IED_coverType", _coverType, True];
_cover setVariable ["ODD_var_IED_coverPos", _coverPos, True];
_cover setVariable ["ODD_var_IED_coverDir", _coverDir, True];

// verifier si il faut lock le vl
if (_coverType isKindOf "car") then {
	[_cover, True, True, (random[2, 10, 15])] call ODDcommon_fnc_CtrlVlLock;
};

if (_type >= 0) then {
	private _explo = createMine[_exploType, _exploPos, [], 0];
	_explo setposATL _exploPos;
	_cover setVariable ["ODD_var_IED_Explo", _explo, True];
	_explo setVariable ["ODD_var_IED_ExploType", _exploType, True];
	_explo setVariable ["ODD_var_IED_ExploPos", _exploPos, True];

	switch (_type) do {
		case 0: {	// IED détonné radio, brouillable, triggerman ennemi loin
			// création du triggerMan
			_triggerManGroup = [_triggerManPos, EAST, _triggerManType] call BIS_fnc_spawnGroup;
			_triggerMan = (units _triggerManGroup) select 0;

			// ajout du téléphone au TriggerMan
			_triggerMan addItemToVest "ACE_Cellphone";
			
			// met en place le triggerMan (garnison)
			_triggerMan setPosATL _triggerManPos;
			_triggerMan setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
			_triggerMan setVariable ["ODD_var_IsInGarnison", True, True];
			_triggerMan setUnitPos "DOWN";
			_triggerMan disableAI "PATH";

			// Ajout des interaction d'intérogation
			[_triggerMan, 2] call ODDcommon_fnc_addIntel;
			
			// systemChat str _coverPos;
			private _triggerExplo = createTrigger ["EmptyDetector", _cover, False];
			_triggerExplo setTriggerArea [5, 5, 0, False, 5];
			_triggerExplo setTriggerActivation ["WEST", "PRESENT", False];
			_triggerExplo setTriggerStatements [
				"
				_explo = thisTrigger getVariable ['ODD_var_IED_Explo', ''];
				if (typeName _explo == 'OBJECT') then {
					_cover = _explo getVariable ['ODD_var_IED_Cover', ''];
					if (typeName _cover == 'OBJECT') then {
						_TgMan = _cover getVariable ['ODD_var_IED_TriggerMan', ''];
						if (typeName _TgMan == 'OBJECT') then {
							this and (alive _TgMan) and (lifeState _TgMan != 'INCAPACITATED') and !(captive _TgMan) and (count (nearestObjects [position _explo, ['R3F_Brouilleur'], 15]) == 0)
						} else {
							deleteVehicle thisTrigger;
							False
						}
					} else {
						deleteVehicle thisTrigger;
						False
					}
				} else {
					deleteVehicle thisTrigger;
					False
				}
				",
				"
				_explo = thisTrigger getVariable ['ODD_var_IED_Explo', ''];
				if (typeName _explo == 'OBJECT') then {
					_explo setDamage 1;
					_cover = _explo getVariable ['ODD_var_IED_Cover', ''];
					if (typeName _cover == 'OBJECT') then {
						_TgMan = _cover getVariable ['ODD_var_IED_TriggerMan', ''];
						if (typeName _TgMan == 'OBJECT') then {
							_TgMan enableAI 'PATH';
							_TgMan setUnitPos 'AUTO';
							(group _TgMan) addWaypoint [position _explo, 0];
						};
					};
				};
				deleteVehicle thisTrigger;
				",
				""
			];

			_triggerExplo setVariable ["ODD_var_IED_Explo", _explo, True];			// attache l'explosif au trigger

			// Attache les variable a l'explosif
			_cover setVariable ["ODD_var_IED_TriggerMan", _triggerMan, True];
			_explo setVariable ["ODD_var_IED_Cover", _cover, True];
			_explo setVariable ["ODD_var_IED_Trigger", _triggerExplo, True];
			_cover setVariable ["ODD_var_IED_TriggerManType", _triggerManType, True];
			_cover setVariable ["ODD_var_IED_TriggerManPos", _triggerManPos, True];

		};
		case 1: {	// IED détonné radio, brouillable, triggerman civil loin
			// création du triggerMan
			_triggerManGroup = [_triggerManPos, CIVILIAN, _triggerManType] call BIS_fnc_spawnGroup;
			_triggerMan = (units _triggerManGroup) select 0;

			// ajout du téléphone au TriggerMan
			_triggerMan addItemToVest "ACE_Cellphone";

			// Ajout des interaction d'intérogation
			[_triggerMan, 1] call ODDcommon_fnc_addIntel;
			
			// met en place le triggerMan (garnison)
			_triggerMan setPosATL _triggerManPos;
			_triggerMan setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
			_triggerMan setVariable ["ODD_var_IsInGarnison", True, True];
			_triggerMan setUnitPos "DOWN";
			_triggerMan disableAI "PATH";
			
			// systemChat str _coverPos;
			private _triggerExplo = createTrigger ["EmptyDetector", _cover, False];
			_triggerExplo setTriggerArea [5, 5, 0, False, 5];
			_triggerExplo setTriggerActivation ["WEST", "PRESENT", False];
			_triggerExplo setTriggerStatements [
				"
				_explo = thisTrigger getVariable ['ODD_var_IED_Explo', ''];
				if (typeName _explo == 'OBJECT') then {
					_cover = _explo getVariable ['ODD_var_IED_Cover', ''];
					if (typeName _cover == 'OBJECT') then {
						_TgMan = _cover getVariable ['ODD_var_IED_TriggerMan', ''];
						if (typeName _TgMan == 'OBJECT') then {
							this and (alive _TgMan) and (lifeState _TgMan != 'INCAPACITATED') and !(captive _TgMan) and (count (nearestObjects [position _explo, ['R3F_Brouilleur'], 15]) == 0);
						} else {
							deleteVehicle thisTrigger;
							False
						}
					} else {
						deleteVehicle thisTrigger;
						False
					}
				} else {
					deleteVehicle thisTrigger;
					False
				}
				",
				"
				_explo = thisTrigger getVariable ['ODD_var_IED_Explo', ''];
				if (typeName _explo == 'OBJECT') then {
					_explo setDamage 1;
					_cover = _explo getVariable ['ODD_var_IED_Cover', ''];
					if (typeName _cover == 'OBJECT') then {
						_TgMan = _cover getVariable ['ODD_var_IED_TriggerMan', ''];
						if (typeName _TgMan == 'OBJECT') then {
							_TgMan enableAI 'PATH';
							_TgMan setUnitPos 'AUTO';
							(group _TgMan) addWaypoint [position _explo, 0];
						};
					};
				};
				deleteVehicle thisTrigger;
				",
				""
			];

			_triggerExplo setVariable ["ODD_var_IED_Explo", _explo, True];			// attache l'explosif au trigger

			// Attache les variable a l'explosif
			_cover setVariable ["ODD_var_IED_TriggerMan", _triggerMan, True];
			_explo setVariable ["ODD_var_IED_Cover", _cover, True];
			_explo setVariable ["ODD_var_IED_Trigger", _triggerExplo, True];
			_cover setVariable ["ODD_var_IED_TriggerManType", _triggerManType, True];
			_cover setVariable ["ODD_var_IED_TriggerManPos", _triggerManPos, True];
		};
		case 2: {	// ied détonné par fil, non brouillable, triggerman ennemi proche
			// création du triggerMan
			_triggerManGroup = [_triggerManPos, CIVILIAN, _triggerManType] call BIS_fnc_spawnGroup;
			_triggerMan = (units _triggerManGroup) select 0;

			// ajout du téléphone au TriggerMan
			_triggerMan addItemToVest "ACE_Cellphone";

			// Ajout des interaction d'intérogation
			[_triggerMan, 2] call ODDcommon_fnc_addIntel;
			
			// met en place le triggerMan (garnison)
			_triggerMan setPosATL _triggerManPos;
			_triggerMan setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
			_triggerMan setVariable ["ODD_var_IsInGarnison", True, True];
			_triggerMan setUnitPos "DOWN";
			_triggerMan disableAI "PATH";
			
			// systemChat str _coverPos;
			private _triggerExplo = createTrigger ["EmptyDetector", _cover, False];
			_triggerExplo setTriggerArea [5, 5, 0, False, 5];
			_triggerExplo setTriggerActivation ["WEST", "PRESENT", False];
			_triggerExplo setTriggerStatements [
				"
				_explo = thisTrigger getVariable ['ODD_var_IED_Explo', ''];
				if (typeName _explo == 'OBJECT') then {
					_cover = _explo getVariable ['ODD_var_IED_Cover', ''];
					if (typeName _cover == 'OBJECT') then {
						_TgMan = _cover getVariable ['ODD_var_IED_TriggerMan', ''];
						if (typeName _TgMan == 'OBJECT') then {
							this and (alive _TgMan) and (lifeState _TgMan != 'INCAPACITATED') and !(captive _TgMan);
						} else {
							deleteVehicle thisTrigger;
							False
						}
					} else {
						deleteVehicle thisTrigger;
						False
					}
				} else {
					deleteVehicle thisTrigger;
					False
				}
				",
				"
				_explo = thisTrigger getVariable ['ODD_var_IED_Explo', ''];
				if (typeName _explo == 'OBJECT') then {
					[_explo] spawn {
						params ['_mine'];
						sleep (50 + random 40);
						_mine setDamage 1;
					};
					_cover = _explo getVariable ['ODD_var_IED_Cover', ''];
					if (typeName _cover == 'OBJECT') then {
						_TgMan = _cover getVariable ['ODD_var_IED_TriggerMan', ''];
						if (typeName _TgMan == 'OBJECT') then {
							_TgMan enableAI 'PATH';
							_TgMan setUnitPos 'AUTO';
							(group _TgMan) addWaypoint [position _explo, 0];
						};
					};
				};
				deleteVehicle thisTrigger;
				",
				""
			];

			_triggerExplo setVariable ["ODD_var_IED_Explo", _explo, True];			// attache l'explosif au trigger

			// Attache les variable a l'explosif
			_cover setVariable ["ODD_var_IED_TriggerMan", _triggerMan, True];
			_explo setVariable ["ODD_var_IED_Cover", _cover, True];
			_explo setVariable ["ODD_var_IED_Trigger", _triggerExplo, True];
			_cover setVariable ["ODD_var_IED_TriggerManType", _triggerManType, True];
			_cover setVariable ["ODD_var_IED_TriggerManPos", _triggerManPos, True];
		};
		case 3: {	// ied détonné par fil, non brouillable, triggerman civil proche
			// création du triggerMan
			_triggerManGroup = [_triggerManPos, CIVILIAN, _triggerManType] call BIS_fnc_spawnGroup;
			_triggerMan = (units _triggerManGroup) select 0;

			// ajout du téléphone au TriggerMan
			_triggerMan addItemToVest "ACE_Cellphone";

			// Ajout des interaction d'intérogation
			[_triggerMan, 1] call ODDcommon_fnc_addIntel;
			
			// met en place le triggerMan (garnison)
			_triggerMan setPosATL _triggerManPos;
			_triggerMan setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
			_triggerMan setVariable ["ODD_var_IsInGarnison", True, True];
			_triggerMan setUnitPos "DOWN";
			_triggerMan disableAI "PATH";
			
			// systemChat str _coverPos;
			private _triggerExplo = createTrigger ["EmptyDetector", _cover, False];
			_triggerExplo setTriggerArea [5, 5, 0, False, 5];
			_triggerExplo setTriggerActivation ["WEST", "PRESENT", False];
			_triggerExplo setTriggerStatements [
				"
				_explo = thisTrigger getVariable ['ODD_var_IED_Explo', ''];
				if (typeName _explo == 'OBJECT') then {
					_cover = _explo getVariable ['ODD_var_IED_Cover', ''];
					if (typeName _cover == 'OBJECT') then {
						_TgMan = _cover getVariable ['ODD_var_IED_TriggerMan', ''];
						if (typeName _TgMan == 'OBJECT') then {
							this and (alive _TgMan) and (lifeState _TgMan != 'INCAPACITATED') and !(captive _TgMan);
						} else {
							deleteVehicle thisTrigger;
							False
						}
					} else {
						deleteVehicle thisTrigger;
						False
					}
				} else {
					deleteVehicle thisTrigger;
					False
				}
				",
				"
				_explo = thisTrigger getVariable ['ODD_var_IED_Explo', ''];
				if (typeName _explo == 'OBJECT') then {
					[_explo] spawn {
						params ['_mine'];
						sleep (50 + random 40);
						_mine setDamage 1;
					};
					_cover = _explo getVariable ['ODD_var_IED_Cover', ''];
					if (typeName _cover == 'OBJECT') then {
						_TgMan = _cover getVariable ['ODD_var_IED_TriggerMan', ''];
						if (typeName _TgMan == 'OBJECT') then {
							_TgMan enableAI 'PATH';
							_TgMan setUnitPos 'AUTO';
							(group _TgMan) addWaypoint [position _explo, 0];
						};
					};
				};
				deleteVehicle thisTrigger;
				",
				""
			];

			_triggerExplo setVariable ["ODD_var_IED_Explo", _explo, True];			// attache l'explosif au trigger

			// Attache les variable a l'explosif
			_cover setVariable ["ODD_var_IED_TriggerMan", _triggerMan, True];
			_explo setVariable ["ODD_var_IED_Cover", _cover, True];
			_explo setVariable ["ODD_var_IED_Trigger", _triggerExplo, True];
			_cover setVariable ["ODD_var_IED_TriggerManType", _triggerManType, True];
			_cover setVariable ["ODD_var_IED_TriggerManPos", _triggerManPos, True];
		};
		case 4: {	// ied mine qui explose s'il y a plus de 2 joueurs à portée							

			private _triggerExplo = createTrigger ["EmptyDetector", _cover, False];
			_triggerExplo setTriggerArea [5, 5, 0, False, 5];
			_triggerExplo setTriggerActivation ["WEST", "PRESENT", False];
			_triggerExplo setTriggerStatements [
				"
				this and (count thisList) >= 2
				",
				"
				_explo = thisTrigger getVariable ['ODD_var_IED_Explo', ''];
				if (typeName _explo == 'OBJECT') then {
					_explo setDamage 1;
				};
				deleteVehicle thisTrigger;
				",
				""
			];
			_triggerExplo setVariable ["ODD_var_IED_Explo", _explo, True];			// attache l'explosif au trigger
			_explo setVariable ["ODD_var_IED_Trigger", _triggerExplo, True];
		};
		default {
			[["ODD_BUG : Action IED non prévue : %1", _type]] call ODDcommon_fnc_log;
		};
	};

	// _marker = createMarker [(format ["IED P x %1, y %2, z %3", (_exploPos select 0), (_exploPos select 1), (_exploPos select 2)]), _exploPos]; 
	// _marker setMarkerType "hd_dot";
	// _marker setMarkerColor "colorOPFOR";
	// _marker setMarkerText format["%1", _type];

	ODD_var_MissionIED pushBack _explo;
};

publicVariable "ODD_var_MissionIED";

_cover;





