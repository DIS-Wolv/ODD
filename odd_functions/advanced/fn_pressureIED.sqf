/*
* Auteur : Wolv
* Fonction de spawn des IEDs
*
* Arguments :
* 0: Est ce la zone principale <OBJ>
* 1: Nombre d'IED <INT>
* 2: Distance à la sone <INT>
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [_zo] call ODDadvanced_fnc_pressureIED
* [_zo, 2, False, 4000] call ODDadvanced_fnc_pressureIED
*
* Variable publique :
*/
params ["_zo", ["_nb", 2], ["_isDecoy", False], ["_dist", ODD_var_MissionArea]];

_pos = position _zo; 
private _props = [];
private _IED = [];
_IED resize _nb;

_LocType = ODD_var_LocationType - ['namelocal', 'Hill'];
_nearZO = nearestLocations[position _zo, _LocType, _dist];

_roads = _pos nearRoads _dist;

{
	_posZo = position _x;
	_roadZo = _posZo nearRoads ((size _x select 1));
	_roads = _roads + _roadZo + _roadZo + _roadZo + _roadZo;
	// Ajoute plusieurs fois les routes dans les localités (4x plus de chance dans les villes)
} forEach _nearZO;

_roadsFOB = position usine nearRoads 200;
_roads = _roads - _roadsFOB;
// Retire les routes près de l'objet "usine" à la liste

if (count _roads != 0) then {
	_coverList = [];
	_posIED = [];
	_markerIED = [];
	{
		if (ODD_var_CurrentMission == 2) then {
			_trapRoad = selectRandom _roads;
			_cRoads = roadsConnectedTo _trapRoad;
			while {count _cRoads == 0} do {
				_roads = _roads - [_trapRoad];
				_trapRoad = selectRandom _roads;
				_cRoads = roadsConnectedTo _trapRoad;
			};
			// choisie une route à piégée

			_cRoad = selectRandom _cRoads;
			_dir = _trapRoad getDir _cRoad;
			_roads = _roads - [_trapRoad];
			_trapPos = _trapRoad getPos [(3 + random 2.5), (_dir + 90)]; 
			// Défini la position de l'IED sur la routeplus ou moins sur le coté de la route

			_trapCoverClass = selectRandom ODD_var_IEDCover;
			_trapExplosiveClass = selectRandom ODD_var_IEDExplosive;
			// Choisie le cover et l'explosif
			
			_posIED pushBack _trapPos;
			
			if (_isDecoy) then {
				_cover = createVehicle [_trapCoverClass, _trapPos, [], 0, "CAN_COLLIDE"];
				_coverList pushBack _cover;
			}
			else {
				_cover = createVehicle [_trapCoverClass, _trapPos, [], 0/*, "CAN_COLLIDE"*/];
				_trap = createMine[_trapExplosiveClass, (_trapPos getPos [random 1, random 360]), [], 0];
				_IED set [_forEachIndex, _trap];
				_coverList pushBack _cover;

				private _action = floor random 5;
				switch (_action) do {
					case 0: {	// IED détonné radio, brouillable, triggerman ennemi loin
						_groupPos = _trapPos getPos [10, 0];
						_group = selectRandom ODD_var_Pair;
						_g = [_groupPos, EAST, _group] call BIS_fnc_spawnGroup;
						ODD_var_SecondaryAreasIA pushBack _g;

						sleep 1;
						private _leader = (units _g) select 0;
						_leader addItemToVest "ACE_Cellphone";
						// ajoute le detonateur

						private _boom = createTrigger ["EmptyDetector", _trapPos, True];
						_boom setTriggerArea [5, 5, 0, False, 2];
						_boom setTriggerActivation ["WEST", "PRESENT", False];

						ODD_var_MissionIEDTriggerMan pushBack _leader;
						ODD_var_MissionIED pushBack _trap;
						ODD_var_MissionIEDTrigger pushBack _boom;

						// systemChat format ["%1 | %2 | %3", str _trapPos, _leader, _trap];
						_boom setTriggerStatements [
							format [
								"_mamineu = (ODD_var_MissionIED select %1);
								_pos = position _mamineu;
								_brouilleur = nearestObjects [_pos, ['R3F_Brouilleur'], 15];
								_proprio = (ODD_var_MissionIEDTriggerMan select %1);
								this and alive _proprio and lifeState _proprio != 'INCAPACITATED' and (count _brouilleur == 0) and !(captive _proprio);", 
								((count ODD_var_MissionIED) - 1)
							],
							format [
								"_mine = ODD_var_MissionIED select %1;
								_mine setDamage 1;
								_proprio = (ODD_var_MissionIEDTriggerMan select %1);
								_g = group _proprio;
								{
									[units _x] execVM '\z\ace\addons\ai\functions\fnc_unGarrison.sqf';
								} forEach (units _g);
								",
								((count ODD_var_MissionIED) - 1)
							],""
						];

						private _Buildings = nearestobjects [_trapPos, ODD_var_Houses, 150];
						if (count _Buildings >= 3) then {	//si il y a des batiments dans les 150 m
							{
								_x setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
								_x setVariable ["ODD_var_IsInGarnison", True, True];
								_x setUnitPos "DOWN";
							} forEach (units _g);   // Pour chaque unité du groupe
							[_trapPos, nil, units _g, 150, 1, False, False] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
						}
						else {
							_Buildings = nearestobjects [_trapPos, ODD_var_Houses, 300];
							if (count _Buildings >= 3) then {
								{
									_x setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
									_x setVariable ["ODD_var_IsInGarnison", True, True];
									_x setUnitPos "DOWN";
								} forEach (units _g);   // Pour chaque unité du groupe
								[_trapPos, nil, units _g, 300, 1, False, False] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
							}
							else {
								_wpPos = _trapPos getPos [(30 + round random 20), (_dir + 90)];
								{
									_x setPos (_wpPos getPos [2, random 360]);
								} forEach (units _g);
								
								_g setSpeedMode "FULL";
								sleep 5;
								{
									_x setUnitPos "DOWN";
									sleep 1;
									_x disableAI "MOVE";
									sleep 1;
									_x disableAI "all";

									_x addEventHandler ["FiredNear", {
										params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
										_unit enableAI "all";
										_unit setUnitPos "AUTO";
										_unit setSpeedMode "NORMAL";
									}];
								} forEach (units _g);
							};
						};
					};
					case 1: {	// IED détonné radio, brouillable, triggerman civil loin
						_groupPos = _trapPos getPos [10, 0];
						_group = selectRandom ODD_var_Civilians;
						_g = [_groupPos, CIVILIAN, _group] call BIS_fnc_spawnGroup;
						ODD_var_MissionCivilians pushBack _g;
						
						sleep 1;
						private _leader = (units _g) select 0;
						_leader addItemToVest "ACE_Cellphone";
						// ajoute le detonateur

						[_leader, 
							"<t color='#FF0000'>interoger le civil</t>", "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", 
							"(alive (_target)) and (_target distance _this < 3) and (lifeState _target != 'INCAPACITATED')", "True",
							{
								[(_this select 0), "PATH"] remoteExec ["disableAI", 2];
								// (_this select 0) disableAI "PATH"
							}, 
							{},
							{
								[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
								// (_this select 0) enableAI "PATH";

								_msgNon = ["Je ne dirais rien.", "Je ne veux pas vous parler.", "Je ne veux pas vous parler."];
								_msg = selectRandom _msgNon;
								[_msg] remoteExec ["systemChat", 0];
								[(_this select 0)] remoteExec ["removeAllActions", 0, True];
							}, {
								// (_this select 0) enableAI "PATH";
								[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
							}, [], (random[2, 10, 15]), nil, True, False
						] remoteExec ["BIS_fnc_holdActionAdd", 0, True];

						private _boom = createTrigger ["EmptyDetector", _trapPos, True];
						_boom setTriggerArea [5, 5, 0, False, 2];
						_boom setTriggerActivation ["WEST", "PRESENT", False];

						ODD_var_MissionIEDTriggerMan pushBack _leader;
						ODD_var_MissionIED pushBack _trap;
						ODD_var_MissionIEDTrigger pushBack _boom;

						// systemChat format ["%1 | %2 | %3", str _trapPos, _leader, _trap];
						_boom setTriggerStatements [
							format [
								"_mamineu = (ODD_var_MissionIED select %1);
								_pos = position _mamineu;
								_brouilleur = nearestObjects [_pos, ['R3F_Brouilleur'], 15];
								_proprio = (ODD_var_MissionIEDTriggerMan select %1);
								this and alive _proprio and lifeState _proprio != 'INCAPACITATED' and (count _brouilleur == 0) and !(captive _proprio);", 
								((count ODD_var_MissionIED) - 1)
							],
							format [
								"_mine = ODD_var_MissionIED select %1;
								_mine setDamage 1;
								_proprio = (ODD_var_MissionIEDTriggerMan select %1);
								_g = group _proprio;
								{
									[units _x] execVM '\z\ace\addons\ai\functions\fnc_unGarrison.sqf';
								} forEach (units _g);
								",
								((count ODD_var_MissionIED) - 1)
							],""
						];

						private _Buildings = nearestobjects [_trapPos, ODD_var_Houses, 150];
						if (count _Buildings >= 3) then {	//si il y a des batiments dans les 150 m
							{
								_x setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
								_x setVariable ["ODD_var_IsInGarnison", True, True];
							} forEach (units _g);   // Pour chaque unité du groupe
							[_trapPos, nil, units _g, 150, 1, False, False] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
						}
						else {
							_Buildings = nearestobjects [_trapPos, ODD_var_Houses, 300];
							if (count _Buildings >= 3) then {
								{
									_x setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
									_x setVariable ["ODD_var_IsInGarnison", True, True];
								} forEach (units _g);   // Pour chaque unité du groupe
								[_trapPos, nil, units _g, 300, 1, False, False] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
							}
							else {
								_wpPos = _trapPos getPos [(30 + round random 20), (_dir + 90)];
								{
									_x setPos (_wpPos getPos [2, random 360]);
								} forEach (units _g);
								_g setSpeedMode "FULL";
								sleep 5;
								{
									_x setUnitPos "DOWN";
									sleep 1;
									_x disableAI "MOVE";
									sleep 1;
									_x disableAI "all";

									_x addEventHandler ["FiredNear", {
										params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
										_unit enableAI "all";
										_unit setUnitPos "AUTO";
										_unit setSpeedMode "NORMAL";
									}];
								} forEach (units _g);
							};
						};
					};
					case 2: {	// ied détonné par fil, non brouillable, triggerman ennemi proche
						_groupPos = _trapPos getPos [10, 0];
						_group = selectRandom ODD_var_Pair;
						_g = [_groupPos, EAST, _group] call BIS_fnc_spawnGroup;
						ODD_var_SecondaryAreasIA pushBack _g;

						sleep 1;
						private _leader = (units _g) select 0;
						_leader addItemToVest "ACE_Clacker";
						// ajoute le detonateur

						private _boom = createTrigger ["EmptyDetector", _trapPos, True];
						_boom setTriggerArea [5, 5, 0, False, 2];
						_boom setTriggerActivation ["WEST", "PRESENT", False];

						ODD_var_MissionIEDTriggerMan pushBack _leader;
						ODD_var_MissionIED pushBack _trap;
						ODD_var_MissionIEDTrigger pushBack _boom;

						// systemChat format ["%1 | %2 | %3", str _trapPos, _leader, _trap];
						_boom setTriggerStatements [
							format [
								"_mamineu = (ODD_var_MissionIED select %1);
								_pos = position _mamineu;
								_proprio = (ODD_var_MissionIEDTriggerMan select %1);
								this and alive _proprio and lifeState _proprio != 'INCAPACITATED' and !(captive _proprio);", 
								((count ODD_var_MissionIED) - 1)
							],
							format [
								"_mine = ODD_var_MissionIED select %1;
								_fnc_boom = {
									params ['_mine'];
									sleep (50 + random 40);
									_mine setDamage 1;
								};
								[_mine] spawn _fnc_boom;
								_proprio = (ODD_var_MissionIEDTriggerMan select %1);
								_g = group _proprio;
								{
									[units _x] execVM '\z\ace\addons\ai\functions\fnc_unGarrison.sqf';
								} forEach (units _g);
								",
								((count ODD_var_MissionIED) - 1)
							],""
						];

						private _Buildings = nearestobjects [_trapPos, ODD_var_Houses, 30];
						if (count _Buildings >= 3) then {	//si il y a des batiments dans les 150 m
							{
								_x setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
								_x setVariable ["ODD_var_IsInGarnison", True, True];
								_x setUnitPos "DOWN";
							} forEach (units _g);   // Pour chaque unité du groupe
							[_trapPos, nil, units _g, 30, 1, False, False] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
						}
						else {
							_Buildings = nearestobjects [_trapPos, ODD_var_Houses, 150];
							if (count _Buildings >= 3) then {
								{
									_x setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
									_x setVariable ["ODD_var_IsInGarnison", True, True];
									_x setUnitPos "DOWN";
								} forEach (units _g);   // Pour chaque unité du groupe
								[_trapPos, nil, units _g, 150, 1, False, False] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
							}
							else {
								_wpPos = _trapPos getPos [(30 + round random 20), (_dir + 90)];
								{
									_x setPos (_wpPos getPos [2, random 360]);
								} forEach (units _g);
								//_g addWaypoint [_wpPos, 0];
								_g setSpeedMode "FULL";
								sleep 5;
								{
									_x setUnitPos "DOWN";
									sleep 1;
									_x disableAI "MOVE";
									sleep 1;
									_x disableAI "all";

									_x addEventHandler ["FiredNear", {
										params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
										_unit enableAI "all";
										_unit setUnitPos "AUTO";
										_unit setSpeedMode "NORMAL";
									}];
								} forEach (units _g);
							};
						};
					};
					case 3: {	// ied détonné par fil, non brouillable, triggerman civil proche
						_groupPos = _trapPos getPos [10, 0];
						_group = selectRandom ODD_var_Civilians;
						_g = [_groupPos, CIVILIAN, _group] call BIS_fnc_spawnGroup;
						ODD_var_MissionCivilians pushBack _g;

						sleep 1;
						private _leader = (units _g) select 0;
						_leader addItemToVest "ACE_Clacker";
						// ajoute le detonateur
						[_leader, 
							"<t color='#FF0000'>interoger le civil</t>", "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", 
							"(alive (_target)) and (_target distance _this < 3) and (lifeState _target != 'INCAPACITATED')", "True",
							{
								[(_this select 0), "PATH"] remoteExec ["disableAI", 2];
								// (_this select 0) disableAI "PATH"
							}, 
							{},
							{
								[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
								// (_this select 0) enableAI "PATH";

								_msgNon = ["Je ne dirais rien.", "Je ne veux pas vous parler.", "Je ne veux pas vous parler."];
								_msg = selectRandom _msgNon;
								[_msg] remoteExec ["systemChat", 0];
								[(_this select 0)] remoteExec ["removeAllActions", 0, True];
							}, {
								// (_this select 0) enableAI "PATH";
								[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
							}, [], (random[2, 10, 15]), nil, True, False
						] remoteExec ["BIS_fnc_holdActionAdd", 0, True];

						private _boom = createTrigger ["EmptyDetector", _trapPos, True];
						_boom setTriggerArea [5, 5, 0, False, 2];
						_boom setTriggerActivation ["WEST", "PRESENT", False];

						ODD_var_MissionIEDTriggerMan pushBack _leader;
						ODD_var_MissionIED pushBack _trap;
						ODD_var_MissionIEDTrigger pushBack _boom;

						// systemChat format ["%1 | %2 | %3", str _trapPos, _leader, _trap];
						_boom setTriggerStatements [
							format [
								"_mamineu = (ODD_var_MissionIED select %1);
								_pos = position _mamineu;
								_proprio = (ODD_var_MissionIEDTriggerMan select %1);
								this and alive _proprio and lifeState _proprio != 'INCAPACITATED' and !(captive _proprio);", 
								((count ODD_var_MissionIED) - 1)
							],
							format [
								"_mine = ODD_var_MissionIED select %1;
								_fnc_boom = {
									params ['_mine'];
									sleep (50 + random 40);
									_mine setDamage 1;
								};
								[_mine] spawn _fnc_boom;
								_proprio = (ODD_var_MissionIEDTriggerMan select %1);
								_g = group _proprio;
								{
									[units _x] execVM '\z\ace\addons\ai\functions\fnc_unGarrison.sqf';
								} forEach (units _g);
								",
								((count ODD_var_MissionIED) - 1)
							],""
						];

						private _Buildings = nearestobjects [_trapPos, ODD_var_Houses, 30];
						if (count _Buildings >= 3) then {	//si il y a des batiments dans les 150 m
							{
								_x setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
								_x setVariable ["ODD_var_IsInGarnison", True, True];
							} forEach (units _g);   // Pour chaque unité du groupe
							[_trapPos, nil, units _g, 30, 1, False, False] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
						}
						else {
							_Buildings = nearestobjects [_trapPos, ODD_var_Houses, 150];
							if (count _Buildings >= 3) then {
								{
									_x setVariable ["acex_headless_blacklist", True, True]; // Ajoute l'unité à la liste noire des clients Headless
									_x setVariable ["ODD_var_IsInGarnison", True, True];
								} forEach (units _g);   // Pour chaque unité du groupe
								[_trapPos, nil, units _g, 150, 1, False, False] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
							}
							else {
								_wpPos = _trapPos getPos [(30 + round random 20), (_dir + 90)];
								{
									_x setPos (_wpPos getPos [2, random 360]);
								} forEach (units _g);
								//_g addWaypoint [_wpPos, 0];
								_g setSpeedMode "FULL";
								sleep 5;
								{
									_x setUnitPos "DOWN";
									sleep 1;
									_x disableAI "MOVE";
									sleep 1;
									_x disableAI "all";

									_x addEventHandler ["FiredNear", {
										params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
										_unit enableAI "all";
										_unit setUnitPos "AUTO";
										_unit setSpeedMode "NORMAL";
									}];
								} forEach (units _g);
							};
						};
					};
					case 4: {	// ied mine qui explose s'il y a plus de 2 joueurs à portée
						private _boom = createTrigger ["EmptyDetector", _trapPos, True];
						_boom setTriggerArea [7, 7, 0, False, 2];
						_boom setTriggerActivation ["WEST", "PRESENT", False];

						ODD_var_MissionIEDTriggerMan pushBack _boom;
						ODD_var_MissionIED pushBack _trap;
						ODD_var_MissionIEDTrigger pushBack _boom;

						_boom setTriggerStatements [
							format [
								"_mamineu = (ODD_var_MissionIED select %1);
								_cnt = { alive _x and side _x == blufor and _mamineu distance2D _x < 7} count allUnits; 
								this and _cnt >= 2;", ((count ODD_var_MissionIED) - 1)
							],
							format [
								"_mine = ODD_var_MissionIED select %1;
								_mine setDamage 1;", ((count ODD_var_MissionIED) - 1)
							],""
						];
					};
					default {
						[["ODD_BUG : Action IED non prévue : %1", _action]] call ODDcommon_fnc_log;
					};
				}; 
			};
		};
		
		// _markerIED set [_forEachindex, 
		// createMarker [(format ["IED x %1, y %2, z %3", (_trapPos select 0), (_trapPos select 1), (_trapPos select 2)]), _trapPos]];
		// (_markerIED select _forEachindex) setMarkerType "hd_dot";
		// (_markerIED select _forEachindex) setMarkerColor "ColorOrange";
	}forEach _IED; 

	if (_isDecoy) then {
		[["ODD_Quantité : Nombre d'IED non activé placé : %1", count _IED]] call ODDcommon_fnc_log;
		ODD_var_MissionProps = ODD_var_MissionProps + _coverList;
	}
	else {
		[["ODD_Quantité : Nombre d'IED activé placé : %1", count _IED]] call ODDcommon_fnc_log;
		ODD_var_MissionProps = ODD_var_MissionProps + _coverList;
	};
	// Ajoute les IEDs au log
}
else {
	[["ODD_BUG : Il n'y a pas de routes a moins de %1 m  de %2", text _zo, _dist]] call ODDcommon_fnc_log;
};