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
* [_zo, 2] call ODDadvanced_fnc_roadBlockZO
*
* Variable publique :
*/
params ["_zo", ["_nb", 2]];

private _pos = position _zo; 

private _grad = 0.060;
private _props = [];

_fnc_getDenivler = {
	params ["_pos", ["_area", 20]];
	_posX = _pos select 0; 
	_posY = _pos select 1; 
	
	_minH =  1000; 
	_maxH = -1000; 
	for "_varX" from -_area to _area step 1 do { 
		for "_varY" from -_area to _area step 1 do { 
			_height = getTerrainHeightASL [_posX+_varX, _posY+_varY]; 
			_maxH = _height max _maxH; 
			_minH = _height min _minH; 
		};  
	};  
	
	_denivele = _maxH - _minH;
	_denivele;
};

_nbOp = [];
_nbOp resize _nb;

{
	//*
	_posOp = _pos getPos [random 900, random 360];
	_deniv = [_posOp, 50] call _fnc_getDenivler;
	_objects = count (nearestObjects [_posOp, ["house"], 75, True]);
	_nearRoad = count (_posOp nearRoads 75);
	_i = 0;
	systemChat format ["%1 | %2 | %3 | %4", _i, count (_posOp), _nearRoad, _objects];
	while {((_deniv >= 13) or (_objects >= 3) or (_nearRoad > 1))and (_i < 1000)} do {
		_posOp = _pos getPos [random 900, random 360];
		_deniv = [_posOp, 50] call _fnc_getDenivler;
		_nearRoad = count (_posOp nearRoads 75);
		_objects = count (nearestObjects [_posOp, ["house"], 75, True]);
		_i = _i + 1; 
		systemChat format ["%1 | %2 | %3 | %4", _i, count (_posOp), _nearRoad, _objects];
	};
	//*/

	/*
		_posOp = [_pos, 10, 900, 10, 0, _grad] call BIS_fnc_findSafePos;
		_objects = count (nearestObjects [_posOp, ["house"], 75, True]);
		_nearRoad = count (_posOp nearRoads 75);
		i = 0;
		systemChat format ["%1 | %2 | %3 | %4", i, count (_posOp), _nearRoad, _objects];
		while {((count(_posOp) == 0) or (_objects >= 3) or (_nearRoad > 1)) and (i <= 1000)} do {
			_posOp = [_pos, 10, 900, 10, 0, _grad] call BIS_fnc_findSafePos;
			_nearRoad = count (_posOp nearRoads 75);
			_objects = count (nearestObjects [_posOp, ["house"], 0, True]);
			i = i + 1;
			sleep 0.01;
			systemChat format ["%1 | %2 | %3 | %4", i, count (_posOp), _nearRoad, _objects];
		};
	*/


	_outpost = selectRandom ODD_var_Outpost;
	_props = [_posOp, random 360, _outpost] call BIS_fnc_objectsMapper;

	ODD_var_MissionProps = ODD_var_MissionProps + _props;

	_aCacher = [];
	{
		_closeProps = nearestTerrainObjects [position _x, [], 15];
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


	_marker = createMarker [(format ["Camps P x %1, y %2, z %3", (_posOp select 0), (_posOp select 1), (_posOp select 2)]), _posOp];
	_marker setMarkerType "hd_dot";
	_marker setMarkerColor "ColorPink";

	_nbOp set[_forEachIndex, _marker];
} forEach _nbOp;
publicVariable "ODD_var_MissionProps";
publicVariable "ODD_var_HiddenObjects";

/*
	_roads = _pos nearRoads _dist;
	[["ODD_Quantité : Nombre de Outpost : %1", _nb]] call ODDadvanced_fnc_log;

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

				ODD_var_MissionCheckPoint pushBack _roadPos;

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
				[_gp, _roadPos, 200] call bis_fnc_taskpatrol;
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
*/
