/*
* Auteur : Wolv
* Fonction pour créer des barrages sur les routes
*
* Arguments :
* 0: Zone objectif <OBJ>
* 1: Nombre de barrages souhaités <INT>
* 2: 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [_zo] call ODDadvanced_fnc_roadBlockZO
* [_zo, 2, 4000] call ODDadvanced_fnc_roadBlockZO
*
* Variable publique :
*/
params ["_zo", ["_nb", 2], ["_dist", 4000]];

_pos = position _zo; 
private _props = [];

_nearZO = nearestLocations[position _zo, ODD_var_LocationType, _dist];

_roads = _pos nearRoads _dist;
[["ODD_Quantité : Nombre de checkpoints Hors ZO : %1", _nb]] call ODDcommon_fnc_log;

_roadsFOB = position usine nearRoads 200;
_roads = _roads - _roadsFOB;
// Retire les routes près de l'objet "usine" à la liste

{
	_posZo = position _x;

	_roadZo = _posZo nearRoads ((size _x select 1) * 3);
	
	_roads = _roads - _roadZo;

} forEach _nearZO;

for [{ _i = 0 }, { _i < _nb }, { _i = _i + 1 }] do {

	if (count _roads >= 1) then {
		_road = selectRandom _roads;
		_posr = position _road; 
		_roads = _roads - [_road];
	
		_structure = selectRandom ODD_var_RoadBlocks;
		_connectedRoad = roadsConnectedTo _road;

		if (count(_connectedRoad) >= 2) then{

			_roadPos = getPos _road; 
			
			_roadDir = [_road, (_connectedRoad select 0)] call BIS_fnc_DirTo;
			_roadDir = (_roadDir + ((round (random 2))* 180)) % 360;
			_props = [_roadPos, _roadDir, _structure] call BIS_fnc_objectsMapper;

			private _variablesPad = "Land_HelipadEmpty_F" createVehicle _roadPos;
			ODD_var_MissionCheckPoint pushBack _variablesPad;

			_aCacher = [];
			{
				_closeProps = nearestTerrainObjects [position _x, [], 10];
				// Récupère les objets proximité de la position voulue pour le barrage
				
				_closeProps = _closeProps - _aCacher;
				_closeProps = _closeProps - _props;	
				
				_aCacher = _aCacher + _closeProps;
				// Défini les objets à cacher sur la position pour acceuillir le checkpoint 
			}forEach _props;

			{
				ODD_var_HiddenObjects pushBack _x;
				_x hideObjectGlobal True;
			}forEach _aCacher;
			// Cache les objets définis

			ODD_var_MissionProps = ODD_var_MissionProps + _props;
			
			_Bat = nearestObjects [_roadPos, ODD_var_Houses, 50];
			
			private _groupGar = [];
			private _groupPat = [];
			
			if (count(_Bat) <= 2) then {
				_groupGar = selectRandom ODD_var_Pair;
				_groupPat = selectRandom ODD_var_Squad;
				
			}
			else {
				if (count(_Bat) <= 4) then {
					_groupGar = selectRandom ODD_var_FireTeam;
					_groupPat = selectRandom ODD_var_FireTeam;
				}
				else {
					_groupGar = selectRandom ODD_var_FireTeam;
					_groupPat = selectRandom ODD_var_Pair;
				};
			};
			
			_gp = [_roadPos, EAST, _groupPat] call BIS_fnc_spawnGroup;
			// Crée le groupe
			
			ODD_var_SecondaryAreasIA pushBack _gp;
			sleep 1;

			_dist = 50 + random 100;
			_listPos = [(_roadPos getPos[_dist, 45]), (_roadPos getPos[_dist, 135]), (_roadPos getPos[_dist, 225]), (_roadPos getPos[_dist, 315])];
			[_listPos] call BIS_fnc_arrayShuffle;
			_gp setFormation "STAG COLUMN";
			_gp setBehaviour "AWARE";
			_gp addWaypoint [(_listPos select 0), 0];
			_gp addWaypoint [(_listPos select 1), 0];
			_gp addWaypoint [(_listPos select 2), 0];
			_gp addWaypoint [(_listPos select 3), 0];
			_gp addWaypoint [(_listPos select 0), 0];
			(waypoints _gp) select (count (waypoints _gp) -1) setWaypointType "CYCLE";

			createGuardedPoint [east, _roadPos, -1, objNull];
			// Ajoute des points de passage au groupe

			_gg = [_roadPos, EAST, _groupGar] call BIS_fnc_spawnGroup;
			// Crée le groupe
			ODD_var_SecondaryAreasIA pushBack _gg;

			{
				_x setVariable ["acex_headless_blacklist", True, True];
				_x setVariable ["ODD_var_IsInGarnison", True, True];
			} forEach (units _gg); 
			// Ajoute les IAs de la garnison à la liste noire des clients Headless

			ODD_var_GarnisonnedIA pushBack _gg;
			
			[_roadPos, nil, units _gg, 20, 0, False, True] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; 
			{ _x disableAI "PATH"; } forEach (units _gg);
			createGuardedPoint [east, _roadPos, -1, objNull];

			_roadsNoCP = (_roadPos nearRoads (50));
			_roads = _roads - _roadsNoCP;
			
		};
	};
};

publicVariable "ODD_var_MissionProps";
publicVariable "ODD_var_SecondaryAreasIA";
publicVariable "ODD_var_MainAreaIA";
publicVariable "ODD_var_GarnisonnedIA";
publicVariable "ODD_var_HiddenObjects";
