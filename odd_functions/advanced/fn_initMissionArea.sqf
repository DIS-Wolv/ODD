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

private _radRoadBlock = 1500;
private _radOutpost = 1500;
private _radSpawnPatrols = 1400;
private _radIED = 1400;
private _radDisable = 1000;
private _radSpawnCivils = 900;
private _radSpawngarisons = 1000;
private _alt = 1000;
private _radVl = 2000;

{
	private _loc = _x;
	private _pos = position _loc;
	private _triggers = [];
	private _roads = _pos nearRoads (size _loc select 0);
	
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
	// crée les triggers pour spawn/déspawn les civls
	private _civTrigger = createTrigger ["EmptyDetector", _pos, True];
	_triggers pushBack _civTrigger;
	_civTrigger setTriggerArea [_radSpawnCivils, _radSpawnCivils, 0, False, _alt]; 
	_civTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_civTrigger setTriggerStatements ["this",
		Format ["[thisTrigger, True, %1] spawn ODDcommon_fnc_controlCiv;", _radSpawnCivils],
		Format ["[thisTrigger, False, %1] spawn ODDcommon_fnc_controlCiv;", _radSpawnCivils]
	];
	_civTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
	_civTrigger setVariable ["trig_ODD_var_civWantState", False, True];
	_scriptID = [_civTrigger, False] spawn ODDcommon_fnc_controlCiv;


	// utilise les fonctions pour calculer les reserves de patrouilles sur chaque localité	
	private _patrolPool = [_loc,(_loc == _zo)] call ODDcommon_fnc_initPatrol;
	private _patrolLimit = [_loc] call ODDcommon_fnc_LimitPatrols;
	_variablesPad setVariable ["trig_ODD_var_patrols", [_patrolPool,_patrolLimit], True];
	// crée les triggers pour spawn/déspawn les patrouilles
	private _patTrigger = createTrigger ["EmptyDetector", _pos, True];
	_triggers pushBack _patTrigger;
	_patTrigger setTriggerArea [_radSpawnPatrols, _radSpawnPatrols, 0, False, _alt]; 
	_patTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_patTrigger setTriggerStatements ["this",
		Format ["[thisTrigger, True, %1] spawn ODDcommon_fnc_controlPatrols;", _radSpawnPatrols],
		Format ["[thisTrigger, False] spawn ODDcommon_fnc_controlPatrols;", _radSpawnPatrols]
	];
	_patTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
	_variablesPad setVariable ["trig_ODD_var_patWantState", False, True];
	_scriptID = [_patTrigger, False] spawn ODDcommon_fnc_controlPatrols;


	// Customize la location
	private _specialBuildings = [_loc,(_loc == _zo)] call ODDcommon_fnc_initCustomBuildings;
	_variablesPad setVariable ["trig_ODD_var_specialBuildings", _specialBuildings, True];


	// utilise les fonctions pour calculer les reserves de garnison sur chaque localité	
	private _garisonPool = [_loc,(_loc == _zo)] call ODDcommon_fnc_initGarison;
	_variablesPad setVariable ["trig_ODD_var_garisonPool", _garisonPool, True];
	// crée les triggers pour spawn/déspawn les garnisons
	private _garTrigger = createTrigger ["EmptyDetector", _pos, True];
	_triggers pushBack _garTrigger;
	_garTrigger setTriggerArea [_radSpawngarisons, _radSpawngarisons, 0, False, _alt]; 
	_garTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_garTrigger setTriggerStatements ["this",
		Format ["[thisTrigger, True, %1] spawn ODDcommon_fnc_controlGarisons;", _radSpawngarisons],
		Format ["[thisTrigger, False, %1] spawn ODDcommon_fnc_controlGarisons;", _radSpawngarisons]
	];
	_garTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
	_variablesPad setVariable ["trig_ODD_var_gatWantState", False, True];
	_scriptID = [_garTrigger, False] spawn ODDcommon_fnc_controlGarisons;

	// crée le trigger pour spawn/déspawn les vls
	private _VlTrigger = createTrigger ["EmptyDetector", _pos, True]; 
	_triggers pushBack _VlTrigger;
	_VlTrigger setTriggerArea [_radVl, _radVl, 0, False, _alt]; 
	_VlTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_VlTrigger setTriggerStatements ["this",
		Format ["[thisTrigger, True] spawn ODDcommon_fnc_controlVls;", _radVl],
		Format ["[thisTrigger, False] spawn ODDcommon_fnc_controlVls;", _radVl]
	];
	_VlTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
	_variablesPad setVariable ["trig_ODD_var_VlsWantState", False, True];
	_variablesPad setVariable ["trig_ODD_var_loc", _loc, True];
	_scriptID = [_VlTrigger] spawn ODDcommon_fnc_initVls;
	_scriptID = [_VlTrigger, False] spawn ODDcommon_fnc_controlVls;


	// calcule le nombre d'IED sur la zone :
	private _minIED = round (((count _roads) *  1 / 100)) max 0;
	private _maxIED = round ((count _roads) * 4 / 100);
	private _nbIED = round (random (_maxIED - _minIED)) + _minIED;
	_variablesPad setVariable ["trig_ODD_var_nbIED", _nbIED, True];
	private _IEDs = [_loc, _nbIED] call ODDcommon_fnc_initIED;
	_variablesPad setVariable ["trig_ODD_var_IEDs", _IEDs, True];
	// crée le trigger pour spawn/déspawn les IEDS
	private _IEDTrigger = createTrigger ["EmptyDetector", _pos, True]; 
	_triggers pushBack _IEDTrigger;
	_IEDTrigger setTriggerArea [_radIED, _radIED, 0, False, _alt]; 
	_IEDTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_IEDTrigger setTriggerStatements ["this",
		Format ["[thisTrigger, True] spawn ODDcommon_fnc_controlIED;", _radIED],
		Format ["[thisTrigger, False] spawn ODDcommon_fnc_controlIED;", _radIED]
	];
	_IEDTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
	_variablesPad setVariable ["trig_ODD_var_iedWantState", False, True];
	// _scriptID = [_IEDTrigger, False] spawn ODDcommon_fnc_controlIED;


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

		_props = [_posr, _roadDir, _structure] call ODDcommon_fnc_roadBlockAo;
		ODD_var_MissionProps = ODD_var_MissionProps + (_props select 0);

		private _RbTrigger = createTrigger ["EmptyDetector", _posr, True];
		_RbTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];
		_triggers pushBack _RbTrigger;
		_RbTrigger setTriggerArea [_radRoadBlock, _radRoadBlock, 0, False, _alt]; 
		_RbTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
		_RbTrigger setTriggerStatements ["this",
			"[thisTrigger, True] call ODDcommon_fnc_controlRoadBlockAo;",
			"[thisTrigger, False] call ODDcommon_fnc_controlRoadBlockAo;"
		];
		_RbTrigger setVariable ["trig_ODD_var_RbWantState", False, True];
		_scriptID = [_RbTrigger, False] spawn ODDcommon_fnc_controlRoadBlockAo;
		ODD_var_AreaTrigger pushBack _RbTrigger;

		ODD_var_ZonePad pushBack _variablesPad;
	};
} forEach _roadBlock;

// cree les camps
Private _nb_outposts = (round random 8) + 5;
private _outposts = [_zo, _nb_outposts] call ODDcommon_fnc_initOutpost;

{
	_pos = _x select 0;
	_flavors = _x select 1;
	// Cree le pad de controle
	private _pad = "Land_HelipadEmpty_F" createVehicle _pos;
	ODD_var_ZonePad pushBack _pad;

	// crée le trigger pour spawn/déspawn
	private _trigger = createTrigger ["EmptyDetector", _pad, True]; 
	ODD_var_AreaTrigger pushBack _trigger;
	_trigger setTriggerArea [_radOutpost, _radOutpost, 0, False, _alt]; 
	_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_trigger setTriggerStatements ["this",
		"[thisTrigger, True] spawn ODDcommon_fnc_controlOutpost;",
		"[thisTrigger, False] spawn ODDcommon_fnc_controlOutpost;"
	];
	_trigger setVariable ["trig_ODD_var_Pad", _pad, True];
	_pad setVariable ["trig_ODD_var_OutpostWantState", False, True];
} forEach _outposts;
