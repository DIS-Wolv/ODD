/*
* Auteur : Hhaine, Wolv
* Fonction pour assigner le nombre de patrouilles, garnisons et véhicules en réserve dans une zone. 
*
* Arguments :
* 0: Centre de la zone (localité de l'objectif) <Objet>
* 1: arrays de localités autour
*
* Valeur renvoyée :
* <ARRAY> [patrolPool, objActive]
*
* Exemple:
* [_zo, _location] call ODDadvanced_fnc_initMissionArea
*
* Variable publique :
*/
// récupère la taille de la zone d'opération ODD_var_MissionArea
params ["_zo","_locations"];

private _radRoadBlock = 1000;
private _radSpawnPatrols = 1400;
private _radDisable = 1000;
private _radSpawnCivils = 900;
private _radSpawngarisons = 1000;
private _alt = 1000;
private _radVl = 2000;

{
	private _loc = _x;
	private _pos = position _loc;
	private _triggers = [];
	
	// crée des hélipads invisibles sur chaque localité autout de l'objectif avec ODD_var_MissionArea 
	private _variablesPad = "Land_HelipadEmpty_F" createVehicle _pos;
	if (_loc == _zo) then {
		ODD_var_SelectedAreaPad = _variablesPad;
	};

	_variablesPad setVariable ["trig_ODD_var_locName", text _loc, True];
	_variablesPad setVariable ["trig_ODD_var_loc", _loc, True];

	// utilise une fonction pour déterminer l'état de la zone 
	private _mod = 0;
	private _zoType = [_loc, _mod] call ODDcommon_fnc_defineZo;
	_mod = _zoType select 2;
	_zoType resize 2;
	if ((_loc == _zo) and ((_zoType select 0) < 3)) then { //si Zone principale force de tout
		_zoType set [0, 5];
	};
	_variablesPad setVariable ["trig_ODD_var_zoType", _zoType, True];

	// utilise les fonctions pour calculer le nombre et la composition des civils
	private _civils = [_loc] call ODDcommon_fnc_initCivils;
	_variablesPad setVariable ["trig_ODD_var_civ",_civils, True];

	// utilise les fonctions pour calculer les reserves de patrouilles sur chaque localité	
	private _patrolPool = [_loc,(_loc == _zo)] call ODDcommon_fnc_initPatrol;
	private _patrolLimit = [_loc] call ODDcommon_fnc_LimitPatrols;
	_variablesPad setVariable ["trig_ODD_var_patrols", [_patrolPool,_patrolLimit], True];

	// utilise les fonctions pour calculer les reserves de garnison sur chaque localité	
	private _garisonPool = [_loc,(_loc == _zo)] call ODDcommon_fnc_initGarison;
	_variablesPad setVariable ["trig_ODD_var_garison", _garisonPool, True];

	// utilise les fonctions pour calculer les reserves de VL
	// private _VlPool = [_loc,(_loc == _zo)] call ODDcommon_fnc_initGarison;
	// _variablesPad setVariable ["trig_ODD_var_vl", _VlPool, True];

	// crée les triggers pour spawn/déspawn les civls
	private _civTrigger = createTrigger ["EmptyDetector", _pos, True];
	_triggers pushBack _civTrigger;
	_civTrigger setTriggerArea [_radSpawnCivils, _radSpawnCivils, 0, False, _alt]; 
	_civTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_civTrigger setTriggerStatements ["this",
		Format ["[thisTrigger, True, %1] spawn ODDcommon_fnc_civControl;", _radSpawnCivils],
		Format ["[thisTrigger, False, %1] spawn ODDcommon_fnc_civControl;", _radSpawnCivils]
	];
	_civTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
	_civTrigger setVariable ["trig_ODD_var_civWantState", False, True];
	_scriptID = [_civTrigger, False] spawn ODDcommon_fnc_civControl;

	// crée les triggers pour spawn/déspawn les patrouilles
	private _patTrigger = createTrigger ["EmptyDetector", _pos, True];
	_triggers pushBack _patTrigger;
	_patTrigger setTriggerArea [_radSpawnPatrols, _radSpawnPatrols, 0, False, _alt]; 
	_patTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_patTrigger setTriggerStatements ["this",
		Format ["[thisTrigger, True, %1] spawn ODDcommon_fnc_patrolsControl;", _radSpawnPatrols],
		Format ["[thisTrigger, False] spawn ODDcommon_fnc_patrolsControl;", _radSpawnPatrols]
	];
	_patTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
	_variablesPad setVariable ["trig_ODD_var_patWantState", False, True];
	_scriptID = [_patTrigger, False] spawn ODDcommon_fnc_patrolsControl;

	// crée les triggers pour spawn/déspawn les garnisons
	private _garTrigger = createTrigger ["EmptyDetector", _pos, True];
	_triggers pushBack _garTrigger;
	_garTrigger setTriggerArea [_radSpawngarisons, _radSpawngarisons, 0, False, _alt]; 
	_garTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_garTrigger setTriggerStatements ["this",
		Format ["[thisTrigger, True, %1] spawn ODDcommon_fnc_garisonsControl;", _radSpawngarisons],
		Format ["[thisTrigger, False, %1] spawn ODDcommon_fnc_garisonsControl;", _radSpawngarisons]
	];
	_garTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
	_variablesPad setVariable ["trig_ODD_var_patWantState", False, True];
	_scriptID = [_garTrigger, False] spawn ODDcommon_fnc_garisonsControl;

	// crée le trigger pour spawn/déspawn les vls
	// private _VlTrigger = createTrigger ["EmptyDetector", _pos, True]; 
	// _triggers pushBack _LocTrigger;
	// _VlTrigger setTriggerArea [_radVl, _radVl, 0, False, _alt]; 
	// _VlTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	// _VlTrigger setTriggerStatements ["this",
	// 	Format ["[thisTrigger, True] spawn ODDcommon_fnc_vlsControl;", _radVl],
	// 	Format ["[thisTrigger, False] spawn ODDcommon_fnc_vlsControl;", _radVl]
	// ];
	// _VlTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
	// _variablesPad setVariable ["trig_ODD_var_VlWantState", False, True];
	// _scriptID = [_VlTrigger, False] spawn ODDcommon_fnc_vlsControl;

	// crée les triggers pour activer/désactiver les AIs
	private _LocTrigger = createTrigger ["EmptyDetector", _pos, True]; 
	_triggers pushBack _LocTrigger;
	_LocTrigger setTriggerArea [_radDisable, _radDisable, 0, False, _alt]; 
	_LocTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_LocTrigger setTriggerStatements ["this",
		Format ["[thisTrigger, True] spawn ODDadvanced_fnc_areaControl;", _radDisable],
		Format ["[thisTrigger, False] spawn ODDadvanced_fnc_areaControl;", _radDisable]
	];
	_LocTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
	_variablesPad setVariable ["trig_ODD_var_WantState", False, True];
	_scriptID = [_LocTrigger, False] spawn ODDadvanced_fnc_areaControl;

	// log les hélipads et les triggers dans le fichier var
	ODD_var_ZonePad pushBack _variablesPad;
	ODD_var_AreaTrigger = ODD_var_AreaTrigger + _triggers;
} forEach _locations;
// crée et assigne a chaque hélipad une variable contenant les valeurs de reserve pour la zone


// cree les checkpoint hors des localité
private _roadBlock = [];
private _triggers = [];
Private _nbRoadBlock = (round random 8) + 3;
_roadBlock resize _nbRoadBlock;

private _dist = ODD_var_MissionArea;
private _pos = position _zo;
Private _roads = _pos nearRoads _dist;
[["ODD_Quantité : Nombre de checkpoints Hors ZO : %1", _nbRoadBlock]] call ODDcommon_fnc_log;

// supprime les routes trop dans les villes
Private _nearZO = nearestLocations[position _zo, ODD_var_LocationType, _dist];
{
	_posZo = position _x;
	_roadZo = _posZo nearRoads ((size _x select 1) * 4);
	_roads = _roads - _roadZo;
} forEach _nearZO;

// supprime les routes trop proches de ponts
Private _bridge = [];
{
	_bt = _pos nearObjects [_x, 30000];
	_bridge = _bridge + _bt;
} forEach ODD_var_BridgeType;
{
	_roadBridge = (position _x) nearRoads 30;
	_roads = _roads - _roadBridge;
} forEach _bridge;

{
	if (count _roads >= 1) then { // si la route est sur un pont /!\
		_road = selectRandom _roads;	// choisi une route random
		_posr = position _road; 		// recup sa position

		private _variablesPad = "Land_HelipadEmpty_F" createVehicle _posr;
		// ODD_var_MissionCheckPoint pushBack _variablesPad;
		_variablesPad setVariable ["trig_ODD_var_RoadPos", _posr, True];
		_variablesPad setVariable ["trig_ODD_var_EniPool", 8, True];
		_roadBlock set [_forEachIndex, _variablesPad];

		_nearroads = _posr nearRoads 50;
		_roads = _roads - [_road] - _nearroads; 	// supprime la route et les routes proche de la liste

		private _roadDir = 0; // récupe la direction de la route
		_connectedRoad = roadsConnectedTo _road;
		if ((count _connectedRoad) >= 1) then {
			_roadDir = [_road, (_connectedRoad select 0)] call BIS_fnc_DirTo;
			_roadDir = (_roadDir + ((round (random 2))* 180)) % 360;
		};
		_variablesPad setVariable ["trig_ODD_var_RoadDir", _roadDir, True];

		_structure = selectRandom ODD_var_RoadBlocks;
		_variablesPad setVariable ["trig_ODD_var_Structure", _structure, True];

		private _RbTrigger = createTrigger ["EmptyDetector", _posr, True];
		_RbTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
		_triggers pushBack _RbTrigger;
		_RbTrigger setTriggerArea [_radRoadBlock, _radRoadBlock, 0, False, _alt]; 
		_RbTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
		_RbTrigger setTriggerStatements ["this",
			"[thisTrigger, True] call ODDcommon_fnc_roadBlockAoControl;",
			"[thisTrigger, False] call ODDcommon_fnc_roadBlockAoControl;"
		];
		_RbTrigger setVariable ["trig_ODD_var_RbWantState", False, True];
		_scriptID = [_RbTrigger, False] spawn ODDcommon_fnc_roadBlockAoControl;
	};
} forEach _roadBlock;
ODD_var_AreaTrigger = ODD_var_AreaTrigger + _triggers;
