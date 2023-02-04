/*
* Auteur : Wolv
* Fonction pour créer des barrages sur les routes à proximité d'une localité
*
* Arguments :
* 0: Zone souhaitée <OBJ>
* 1: Nombre de roadblock souhaités <INT>
* 2: Les IAs du checkpoint font parti de la zone principale <BOOL> 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [_zo] call ODD_fnc_roadBlock
* [_zo, 2, True] call ODD_fnc_roadBlock
*
* Variable publique :
*/
params ["_zo", ["_nb", 2], ["_action", False]];

private _NbCP = _nb;

_pos = position _zo; 
private _props = [];

[["Nombre de Checkpoint sur %1 : %2", text _zo, _nb]] call ODD_fnc_log;

_roads = (_pos nearRoads ((size _zo select 0)*1.5)) -(_pos nearRoads (size _zo select 1));

while {(_NbCP > 0) and (count(_roads) > 0)} do {
	_road = selectRandom _roads;
	_roads = _roads - [_road];
	
	_structure = selectRandom ODD_var_RoadBlocks;
	
	_connectedRoad = roadsConnectedTo _road;

	if (count(_connectedRoad) >= 2) then{

		_roadPos = getPos _road; 
		_input = [_roadPos select 0, _roadPos select 1]; 
	 
		_posX = _input select 0; 
		_posY = _input select 1; 
		
		_minH =  1000; 
		_maxH = -1000; 
		for "_varX" from -20 to 20 step 1 do { 
			for "_varY" from -20 to 20 step 1 do { 
				_height = getTerrainHeightASL [_posX+_varX, _posY+_varY]; 
				_maxH = _height max _maxH; 
				_minH = _height min _minH; 
			};  
		};  
		
		_denivele = _maxH - _minH; 
		_objects = count (nearestObjects [_input, [], 20, True]);
		
		if (_denivele < 4 and _objects < 10) then{
			_roadDir = [_road, (_connectedRoad select 0)] call BIS_fnc_DirTo;
			_roadDir = (_roadDir + ((round (random 2))* 180)) % 360;
			_props = [_roadPos, _roadDir, _structure] call BIS_fnc_objectsMapper;

			ODD_var_MissionCheckPoint pushBack _roadPos;

			_aCacher = [];
			{
				_closeProps = nearestTerrainObjects [position _x, [], 10];
				// Récupère les objets proximité de la position voulue pour le barrage
				
				_closeProps = _closeProps - _aCacher;
				_closeProps = _closeProps - _props;
				_aCacher = _aCacher + _closeProps;
			}forEach _props;
			// Défini les objets à cacher sur la position pour acceuillir le checkpoint 

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
			// Crée un groupe
			
			if (_action) then {
				ODD_var_MainAreaIA pushBack _gp;
			}
			else {
				ODD_var_SecondaryAreasIA pushBack _gp;
			};
			// Ajoute le groupe à la liste des IAs de la mission
			
			sleep 1;
			
			_dist = 50;
			_listPos = [(_pos getPos[_dist, 45]), (_pos getPos[_dist, 135]), (_pos getPos[_dist, 225]), (_pos getPos[_dist, 315])];
			[_listPos] call BIS_fnc_arrayShuffle;
			_gp addWaypoint [(_listPos select 0), 0];
			_gp addWaypoint [(_listPos select 1), 0];
			_gp addWaypoint [(_listPos select 2), 0];
			_gp addWaypoint [(_listPos select 3), 0];
			_gp addWaypoint [(_listPos select 0), 0];
			(waypoints _gp) select (count (waypoints _gp) -1) setWaypointType "CYCLE";

			createGuardedPoint [east, _roadPos, -1, objNull];
			// Assigne des points de passage autour du barrage au groupe

			_gg = [_roadPos, EAST, _groupGar] call BIS_fnc_spawnGroup;
			// Crée un groupe pour la garnison du barrage
			
			if (_action) then {
				ODD_var_MainAreaIA pushBack _gg;
			}
			else {
				ODD_var_SecondaryAreasIA pushBack _gg;
			};
			// Ajoute le groupe à la liste des IAs de la mission
			
			{
				_x setVariable ["acex_headless_blacklist", True, True]; 
			} forEach (units _gg);
			// Ajoute les IAs de la garnison à la liste noire des clients Headless

			ODD_var_GarnisonnedIA pushBack _gg;
			
			[_roadPos, nil, units _gg, 20, 0, False, True] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; 
			// Met le groupe en garnison
			createGuardedPoint [east, _roadPos, -1, objNull];
			
			if (count _props >= 1) then {
				_NbCP = _NbCP - 1;
			};
			
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
