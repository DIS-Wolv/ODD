/*
* Author: Wolv
* Fonction permettant de crée des roadblock
*
* Arguments:
* 0: Zone souhaité <Obj>
* 1: Nombre de roadblock souhaité <INT>
* 2: Activation du debug dans le chat <BOOL>
*
* Return Value:
* nil
*
* Example:
* [_zo] call ODD_fnc_roadBlock
* [_zo, 2, true] call ODD_fnc_roadBlock
*
* Public:
*/
params ["_zo", ["_nb", 2], ["_action", false], ["_Debug", false]];

//forcé l'apparition

private _NbCP = _nb;

_pos = position _zo; 
private _props = [];

[["Nombre de Checkpoint sur %1 : %2", text _zo, _nb]] call ODD_fnc_log;

_roads = (_pos nearRoads ((size _zo select 0)*1.5)) -(_pos nearRoads (size _zo select 1));

while {(_NbCP > 0) and (count(_roads) > 0)} do {
	_road = selectRandom _roads;
	_roads = _roads - [_road];
	
	_structure = selectRandom RoadBlock;
	
	_connectedRoad = roadsConnectedTo _road;

	if (count(_connectedRoad) >= 2) then{

		_roadPos = getPos _road; 
		//systemChat(str(_roadPos));
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
		_objects = count (nearestObjects [_input, [], 20, true]);
		
		if (_denivele < 4 and _objects < 10) then{
			_roadDir = [_road, (_connectedRoad select 0)] call BIS_fnc_DirTo;
			_roadDir = (_roadDir + ((round (random 2))* 180)) % 360;
			_props = [_roadPos, _roadDir, _structure] call BIS_fnc_objectsMapper;

			_aCacher = [];
			{
				_closeProps = nearestTerrainObjects [position _x, [], 10];		//recupère les objects proximité 
				
				_closeProps = _closeProps - _aCacher;	// supprime les objects deja a cacher
				_closeProps = _closeProps - _props;		// supprime les objects du checkpoint 
				
				_aCacher = _aCacher + _closeProps;		// ajoute les objects dans la liste a cahcher
				
			}forEach _props;		//pour tout les props du checkpoint

			{
				ObjetHIDE pushBack _x;		// ajoute les objects a caché
				_x hideObjectGlobal true;	// cache les objets
			}forEach _aCacher;	//pour toute les objects a caché 



			
			MissionProps = MissionProps + _props;
			
			_Bat = nearestObjects [_roadPos, Maison, 50];
			
			private _groupGar = [];
			private _groupPat = [];
			
			if (count(_Bat) <= 2) then {
				_groupGar = selectRandom pair;
				_groupPat = selectRandom Squad;
				
			}
			else{
				if (count(_Bat) <= 4) then {
					_groupGar = selectRandom fireTeam;
					_groupPat = selectRandom fireTeam;
				}
				else {
					_groupGar = selectRandom fireTeam;
					_groupPat = selectRandom pair;
				};
			};
			
			//spawn le groupe
			_gp = [_roadPos, EAST, _groupPat] call BIS_fnc_spawnGroup;
			
			if(_action) then {
				//Ajoute le groupe a la liste des IA de la missions
				MissionIA pushBack _gp;
			}
			else {
				ZopiA pushBack _gp;
			};
			
			sleep 1;
			
			//lui assigne des waypoint de patrouille
			[_gp, _roadPos, 200] call bis_fnc_taskpatrol;
			createGuardedPoint [east, _roadPos, -1, objNull];


			// Spawn les gars en garnison 
			_gg = [_roadPos, EAST, _groupGar] call BIS_fnc_spawnGroup;
			
			if(_action) then {
				//Ajoute le groupe a la liste des IA de la missions
				MissionIA pushBack _gg;
			}
			else {
				ZopiA pushBack _gg;
			};
			
			if (!(IsNil "HC1")) then {
				// systemChat "HC1 présent";
				_HCID = owner HC1;

				_g setGroupOwner _HCID;
				{ _x setOwner _HCID; } forEach (units _g);
			};

			GarnisonIA pushBack _gg;
			
			[_roadPos, nil, units _gg, 20, 0, false, true] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; // Garnison Ace
			{ _x disableAI "PATH"; } forEach (units _gg);
			createGuardedPoint [east, _roadPos, -1, objNull];
			
			_NbCP = _NbCP - 1;
			
			//[myObject, true] remoteExec ["hideObjectGlobal", 2];
			//InPolygon ? https://community.bistudio.com/wiki/inPolygon
			
			_roadsNoCP = (_roadPos nearRoads (50));
			_roads = _roads - _roadsNoCP;
		};
	};
	
};

publicVariable "MissionProps";
publicVariable "ZopiA";
publicVariable "MissionIA";
publicVariable "GarnisonIA";
publicVariable "ObjetHIDE";


