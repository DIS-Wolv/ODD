/*
* Author: Wolv
* Fonction permettant de selectioné des position pour des roadblock
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
* [_zo] call WOLV_fnc_roadBlockZO
* [_zo, 2, 4000] call WOLV_fnc_roadBlockZO
*
* Public:
*/
params ["_zo", ["_nb", 2], ["_dist", 4000]];

_pos = position _zo; 
private _props = [];

_nearZO = nearestLocations[position _zo, locationtype, _dist];

_roads = _pos nearRoads _dist;
// DELETE route proximité de la FOB

_roadsFOB = position usine nearRoads 200;

_roads = _roads - _roadsFOB;

{
	_posZo = position _x;

	_roadZo = _posZo nearRoads (size _x select 1);
	
	_roads = _roads - _roadZo;

} forEach _nearZO;
// [] call WOLV_fnc_log;

for [{ _i = 0 }, { _i < _nb }, { _i = _i + 1 }] do {
	_road = selectRandom _roads;

	_posr = position _road; 
	
	/*
	_markerGP =	createMarker [(format ["CP ZO+ P x %1, y %2, z %3", (_posr select 0), (_posr select 1), (_posr select 2)]), _posr];
	_markerGP setMarkerType "hd_dot";
	_markerGP setMarkerColor "ColorPink"; /*/

	_roads = _roads - [_road];
	
	_structure = selectRandom RoadBlock;
	
	_connectedRoad = roadsConnectedTo _road;

	if (count(_connectedRoad) >= 2) then{

		_roadPos = getPos _road; 
		//systemChat(str(_roadPos));
		
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
		
		ZopiA pushBack _gp;

		sleep 1;
		
		//lui assigne des waypoint de patrouille
		[_gp, _roadPos, 200] call bis_fnc_taskpatrol;
		createGuardedPoint [east, _roadPos, -1, objNull];

		// Spawn les gars en garnison 
		_gg = [_roadPos, EAST, _groupGar] call BIS_fnc_spawnGroup;
		
		ZopiA pushBack _gg;

		
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
		
	};//*/

};

publicVariable "MissionProps";
publicVariable "ZopiA";
publicVariable "MissionIA";
publicVariable "GarnisonIA";
publicVariable "ObjetHIDE";
