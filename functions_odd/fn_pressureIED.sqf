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
* [_zo] call ODD_fnc_pressureIED
* [_zo, 2, 4000] call ODD_fnc_pressureIED
*
* Variable publique :
*/
params ["_zo", ["_nb", 2], ["_isDecoy", False], ["_dist", ODD_var_MissionArea]];

_pos = position _zo; 
private _props = [];
private _IED = [];
_IED resize _nb;
private _trapTypeLand = [];
private _trapTypeUrban = [];

_LocType = ODD_var_LocationType - ['namelocal', 'Hill'];
_nearZO = nearestLocations[position _zo, _LocType, _dist];

_roads = _pos nearRoads _dist;

{
	_posZo = position _x;
	_roadZo = _posZo nearRoads ((size _x select 1));
	_roads = _roads + _roadZo + _roadZo + _roadZo;
	// Ajoute plusieurs fois les routes dans les localités (4x plus de chance dans les villes)
} forEach _nearZO;

_roadsFOB = position usine nearRoads 200;
_roads = _roads - _roadsFOB;
// Retire les routes près de l'objet "usine" à la liste

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
			_trap = createMine[_trapExplosiveClass, _trapPos, [], 0];
			_IED set [_forEachIndex, _trap];
			_coverList pushBack _cover;

			_groupPos = _trapPos getPos [10, 0];
			_group = selectRandom ODD_var_Pair;
			_g = [_groupPos, EAST, _group] call BIS_fnc_spawnGroup;
			ODD_var_SecondaryAreasIA pushBack _g;

			private _leader = (units _g) select 0;
			_leader addItemToVest "ACE_Clacker";
			// ajoute le detonateur

			private _boom = createTrigger ["EmptyDetector", _trapPos, true];
			_boom setTriggerArea [5, 5, 0, false, 2];
			_boom setTriggerActivation ["WEST", "PRESENT", false];

			ODD_var_MissionIEDTriggerMan pushBack _leader;
			ODD_var_MissionIED pushBack _trap;
			ODD_var_MissionIEDTrigger pushBack _boom;

			systemChat format ["%1 | %2 | %3", str _trapPos, _leader, _trap];
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

			private _Buildings = nearestobjects [_trapPos, ODD_var_Houses, 30];
			if (count _Buildings >= 3) then {	//si il y a des batiments dans les 30 m
				{
					_x setVariable ["acex_headless_blacklist", true, true]; // Ajoute l'unité à la liste noire des clients Headless
				} forEach (units _g);   // Pour chaque unité du groupe
				[_trapPos, nil, units _g, 30, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
			}
			else {
				_Buildings = nearestobjects [_trapPos, ODD_var_Houses, 100];
				if (count _Buildings >= 3) then {
					{
						_x setVariable ["acex_headless_blacklist", true, true]; // Ajoute l'unité à la liste noire des clients Headless
					} forEach (units _g);   // Pour chaque unité du groupe
					[_trapPos, nil, units _g, 100, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
				}
				else {
					_wpPos = _trapPos getPos [(30 + round random 20), (_dir + 90)];
					_g addWaypoint [_wpPos, 0];
					_g setSpeedMode "FULL";
					sleep 15;
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
	};
	
	// _markerIED set [_forEachindex, 
	// createMarker [(format ["IED x %1, y %2, z %3", (_trapPos select 0), (_trapPos select 1), (_trapPos select 2)]), _trapPos]];
	// (_markerIED select _forEachindex) setMarkerType "hd_dot";
	// (_markerIED select _forEachindex) setMarkerColor "ColorOrange";
}forEach _IED; 

if (_isDecoy) then {
	[["ODD_Quantité : Nombre d'IED non activé placé : %1", count _IED]] call ODD_fnc_log;
	[["ODD_Quantité : Position des IED non activé : %1", str _posIED]] call ODD_fnc_log;
	ODD_var_MissionProps = ODD_var_MissionProps + _coverList;
}
else {
	[["ODD_Quantité : Nombre d'IED activé placé : %1", count _IED]] call ODD_fnc_log;
	[["ODD_Quantité : Position des IED activé : %1", str _posIED]] call ODD_fnc_log;
	ODD_var_MissionProps = ODD_var_MissionProps + _coverList;
};
// Ajoute les IEDs au log
