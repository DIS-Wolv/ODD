/*
* Auteur : Wolv
* Fonction pour controler le spawn et despawn des vehicules ennemis
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
	[["Control EniVeh : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	// systemChat format ["Control EniVeh : Zone %1 : status %2", _textLoc, _state];

	// enregistrement de l'etat voulu
	_trigger setVariable ["trig_ODD_var_eniVLWantState", _state, True];

	// si le trigeur n'est pas actif
	_isActive = _trigger getVariable ["trig_ODD_var_eniVLIsActive", False];
	if (!_isActive) then {
		// activation du trigger
		_trigger setVariable ["trig_ODD_var_eniVLIsActive", True, True];

		// choix du spawn ou despawn
		if (_state) then {
			// récupération des variables
			private _pool = _loc getVariable ["ODD_var_OccActEniVeh", 0];
			private _pos = getPos _loc;

			private _roads = _pos nearRoads 1000;
			private _actVeh = [];

			_pool = _pool - [[""]]; // suprime les vehicules vides
			
			// spawn des véhicules
			{
				// choisis une route aléatoire
				private _road = selectRandom _roads;
				_roads = _roads - [_road];

				// récupère la direction de la route
				private _SpawnPos = getPos _road;
				private _croad = roadsConnectedTo _road;
				if (count _croad == 0) then {
					_croad = _road nearRoads 10;
				};
				private _dir = _road getDir (selectRandom _croad);

				// spawn du groupe
				private _group = [_SpawnPos, east, _x] call BIS_fnc_spawngroup;

				// récupère le vehicule
				private _vl = vehicle ((units _group) select 0);

				// aligne le vl sur la route
				_vl setDir _dir;

				// Event Handler si le vehicule est detruit avec une des charges explosives spécifiées, il explose 100% des cas
				_vl addEventHandler ["Explosion", {
					params ["_vehicle", "_damage", "_source"];
					systemChat format ["Vehicle %1 was destroyed by |%2| with %3 dmg", _vehicle, typeOf _source, _damage];
					private _exploBoumBoum = ["SatchelCharge_Remote_Ammo", "DemoCharge_Remote_Ammo"];

					if (typeOf _source in _exploBoumBoum) then {
						_vehicle setDamage 1;
						_vehicle removeAllEventHandlers "Explosion";
					};
				}];

				// ajoute a la liste des vls de la missions 
				ODD_var_IAVehicles pushBack _vl;

				// ajoute le groupe a la liste des vls sortie
				_actVeh pushBack _group;
				_group setVariable ["ODD_var_Loc", _loc, True];
				
				// Event Handler si le groupe est vide, le retire de la liste des garnisons
				_group addEventHandler ["Empty", {
					params ["_group"];
					private _loc = _group getVariable ["ODD_var_Loc", objNull];
					if (isNull _loc) exitWith {};

					// retire le groupe de la liste des garnisons
					private _groupList = _loc getVariable ["ODD_var_OccVehGroup", []];
					_groupList = _groupList - [_group];
					_loc setVariable ["ODD_var_OccVehGroup", _groupList];
				}];

				// Event handler sur les soldat du groupe
				{
					private _id = _x addEventHandler ["Killed", {
						params ["_unit", "_killer", "_instigator", "_useEffects"];
						[_unit, _killer] call ODDadvanced_fnc_surrender;
						private _aliveGroup = false;
						{
							if ((alive _x) and (!(_x getVariable ["ACE_isUnconscious", false]))) then {
								_aliveGroup = true;
							};
						} forEach units group _unit;
						if (!_aliveGroup) then {
							{
								private _id = _x getVariable ["ODD_var_KilledHandler", -1];
								if (_id != -1) then {
									_x removeEventHandler ["Killed", _id];
								};
								_x setDamage 1;
								[_x] join grpNull;
							} forEach units group _unit;
						};
					}];
					_x setVariable ["ODD_var_KilledHandler", _id, True];
					_x setVariable ["ODD_var_SurrenderHandler", _id, True];

				} forEach units _group;

			} forEach _pool;
			
			_actVeh = _actVeh - [""] - [[""]] - [objNull];

			_loc setVariable ["ODD_var_OccActEniVeh", []];
			_loc setVariable ["ODD_var_OccVehGroup", _actVeh];
		}
		else {
			// despawn des vehicules
			private _actVeh = _loc getVariable ["ODD_var_OccVehGroup", []];
			private _newpool = [];
			{
				private _isPaxAlive = false;
				private _vl = objNull;
				{
					if ((_x != vehicle _x) and !([vehicle _x] call ODDcommon_fnc_isTagged)) then {
						_vl = vehicle _x;
					};
					if ((alive _x) and !(captive _x) and (!(_x getVariable ["ACE_isUnconscious", false])) and !(_x getVariable ['ace_captives_issurrendering', False])) then {
						_isPaxAlive = true;
					};
					deleteVehicle _x;
				} forEach units _x;

				if (isNull _vl and _isPaxAlive == True) then { // si les soldats sont sortis du véhicule mais en vie 
					_loc setVariable ["ODD_var_OccActEni", ((_loc getVariable ["ODD_var_OccActEni", 0]) + 1)]; // les passe garnison/patrouille
				}
				else {
					_newpool pushBack [(typeOf _vl)];
					deleteVehicle _vl;
				};
			} forEach _actVeh;

			private _pool = _loc getVariable ["ODD_var_OccActEniVeh", []];
			_pool = _pool + _newpool;
			_pool = _pool - [""]; // suprime les vehicules vides
			_loc setVariable ["ODD_var_OccActEniVeh", _pool];
			_loc setVariable ["ODD_var_OccVehGroup", []];

			ODD_var_IAVehicles = ODD_var_IAVehicles - [objNull];
		};
		

		// correction si l'etat est different de l'etat voulue (si le trigger est activé ou désactivé pendant l'execution du script)
		private _WantState = _trigger getVariable ["trig_ODD_var_eniVLWantState", _state];
		_trigger setVariable ["trig_ODD_var_eniVLIsActive", False, True];
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


