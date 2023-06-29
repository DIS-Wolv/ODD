/*
* Auteur : QuentinN42
* Fonction pour spawn/despawn les VLs
*
* Arguments :
* 0: Trigger <Obj>
* 1: Activation ou desactivation de la zone
*/

params ["_trigger", ["_state", False], ["_radius", 1000]];

private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];

if ((typeName _pad) != "SCALAR") then {
	private _textLoc = _pad getVariable ["trig_ODD_var_locName", ""];

	_pad setVariable ["trig_ODD_var_VlsWantState", _state, True];

	private _isActive = _pad getVariable ["trig_ODD_var_VlsControlActive", False];
	if (!_isActive) then {
		_pad setVariable ["trig_ODD_var_VlsControlActive", True, True];

		// Debut du spawn
		private _pool = _pad getVariable ["trig_ODD_var_VlsPool", []];
		private _spawned = _pad getVariable ["trig_ODD_var_VlsSpawned", []];
		if (_state) then {
			private _min_nb_to_spawn = 2 min _pool;
			private _max_nb_to_spawn = 5 min _pool;
			private _nb_to_spawn = floor (_min_nb_to_spawn + random (_max_nb_to_spawn - _min_nb_to_spawn + 1));
			_pool = _pool - _nb_to_spawn;

			if (_nb_to_spawn > 1) then {
				// PATROUILLE
				for "_i" from 0 to _nb_to_spawn - 1 do {
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
					private _grp = [(_listPos select 0) findEmptyPosition [2, 50], EAST, _to_spawn] call BIS_fnc_spawnGroup;
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
						if (lifeState _x != 'INCAPACITATED') then {
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
		_pad setVariable ["trig_ODD_var_VlsPool", _pool, True];
		_pad setVariable ["trig_ODD_var_VlsSpawned", _spawned, True];
		// Fin du spawn

		private _WantState = _pad getVariable ["trig_ODD_var_VlsWantState", _state];
		_pad setVariable ["trig_ODD_var_VlsControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_OutpostControl;
		}
	};
};
