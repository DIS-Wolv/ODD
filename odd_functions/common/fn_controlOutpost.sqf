/*
* Auteur : QuentinN42
* Fonction pour spawn/despawn les units des camps
*
* Arguments :
* 0: Trigger <Obj>
* 1: Activation ou desactivation de la zone
*/

params ["_trigger", ["_state", False], ["_radius", 1000]];

private _radius_cercle = 20;
private _radius_fortification = 25;


private _map = (findDisplay 12 displayCtrl 51);  // récupères le control de ta map.

private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];

if ((typeName _pad) != "SCALAR") then {
	private _textLoc = _pad getVariable ["trig_ODD_var_locName", ""];
	
	_pad setVariable ["trig_ODD_var_OutpostWantState", _state, True];

	private _isActive = _pad getVariable ["trig_ODD_var_OutpostControlActive", False];
	if (!_isActive) then {
		_pad setVariable ["trig_ODD_var_OutpostControlActive", True, True];

		// Debut du spawn
		private _pool = _pad getVariable ["trig_ODD_var_EniPool", 6]; // par defaut 6 groupes
		private _spawned = _pad getVariable ["trig_ODD_var_EniSpawned", []];
		private _posOp = position _pad;
		if (_state) then {
			private _min_nb_to_spawn = 3 min _pool;
			private _max_nb_to_spawn = 7 min _pool;
			private _nb_to_spawn = floor (_min_nb_to_spawn + random (_max_nb_to_spawn - _min_nb_to_spawn + 1));
			_pool = _pool - _nb_to_spawn;

			if (_nb_to_spawn > 1) then {
				private _nb_ai_gar = _pool min (selectRandom [1, 2, 2, 3]);
				private _nb_ai_pat = _nb_to_spawn - _nb_ai_gar;

				// GARNISON
				for "_i" from 0 to _nb_ai_gar - 1 do {
					// Choisit un grp
					private _to_spawn = selectRandom ODD_var_FireTeam;

					// Crée un groupe
					private _grp = [_posOp getPos [10, 0], EAST, _to_spawn] call BIS_fnc_spawnGroup;
					_spawned pushBack _grp;

					// Ajoute les IAs de la garnison à la liste noire des clients Headless
					{
						_x setVariable ["acex_headless_blacklist", True, True];
						_x setVariable ["ODD_var_IsInGarnison", True, True];
					} forEach (units _grp);

					// Met le groupe en garnison
					[_posOp, nil, units _grp, 30, 0, False, True] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; 
					createGuardedPoint [east, _posOp, -1, objNull];
				};

				// PATROUILLE
				for "_i" from 0 to _nb_ai_pat - 1 do {
					// Cree les waypoints
					private _waypoints_nb =  floor random [4, 8, 10];
					private _angle_shift = random 360;
					private _base_dist = _radius_fortification + random 100;
					private _angles = [];
					for "_i" from 0 to _waypoints_nb - 1 do { _angles pushBack ((_i * 360 / _waypoints_nb + _angle_shift) % 360); };
					private _listPos = _angles apply {_posOp getPos[_base_dist, _x]};

					// Choisit un grp
					private _to_spawn = selectRandom ODD_var_FireTeam;

					// Crée un groupe
					private _grp = [(_listPos select 0), EAST, _to_spawn] call BIS_fnc_spawnGroup;
					_spawned pushBack _grp;

					// Assigne des points de passage autour du barrage au groupe
					_grp setFormation "STAG COLUMN";
					_grp setBehaviour "SAFE";
					{
						_grp addWaypoint [_x, 10];
					} forEach _listPos;

					// Defini un "CYCLE" pour continuer indefiniement
					_grp addWaypoint [_listPos select ((count _listPos) - 1), 0];
					(waypoints _grp) select (count (waypoints _grp) - 1) setWaypointType "CYCLE";
				};
			};
		}
		else {
			private _collected = 0;
			{
				{
					if (captive _x) then {
						// les captif ne dispawnent pas
						_collected = _collected + 0.25;
					} else {
						// les vivants dispawnent
						if (alive _x) then {
							_collected = _collected + 1;
						};
						if (lifeState _x == 'INCAPACITATED') then {
							// mais on ignore les comas
							_collected = _collected - 1;
						};
						deleteVehicle _x;
					};
				} forEach (units _x);
			} forEach _spawned;

			// calcul du nombre de groupes à remmetre dans le pool
			if (_collected < 2) then {
				// si ~ tout le monde est mort, on considere la zone comme vide
				_pool = 0;
			} else {
				// sinon on remet les groupes dans le pool
				private _grp_size = count (selectRandom ODD_var_FireTeam);
				private _full_groups = floor (_collected / _grp_size);
				private _leftovers = _collected % _grp_size;
				_pool = _pool + _full_groups;
				if (_leftovers > random _grp_size) then {
					_pool = _pool + 1;
				};
			};
		};
		_pad setVariable ["trig_ODD_var_EniPool", _pool, True];
		_pad setVariable ["trig_ODD_var_EniSpawned", _spawned, True];
		// Fin du spawn

		private _WantState = _pad getVariable ["trig_ODD_var_OutpostWantState", _state];
		_pad setVariable ["trig_ODD_var_OutpostControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_OutpostControl;
		}
	};
};
