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
* [_zo] call ODDadvanced_fnc_initPatrol
* [_zo, True, False] call ODDadvanced_fnc_initPatrol
*
* Variable publique :
*/

// récupère la taille de la zone d'opération ODD_var_MissionArea
params ["_zo","_locations"];
private _radSpawnPatrols = 1400;
private _radDisable = 1000;
private _radSpawnCivils = 900;
private _radSpawngarisons = 1000;
private _alt = 1000;

{
	private _loc = _x;
	private _pos = position _loc;
	private _triggers = [];
	
	// crée des hélipads invisibles sur chaque localité autout de l'objectif avec ODD_var_MissionArea 
	private _variablesPad = "Land_HelipadEmpty_F" createVehicle _pos;
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