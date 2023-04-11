/*
* Auteur : Hhaine, Wolv
* Fonction pour assigner le nombre de patrouilles, garnisons et véhicules en réserve dans une zone. 
*
* Arguments :
* 0: Centre de la zone (localité de l'objectif) <Objet>
* 1: arrays de localités autour
* 2: Activation du débug dans le chat <BOOL>
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
// systemChat "prout 0";
private _radSpawnPatrols = 1600;
private _radDisable = 1000;
private _radSpawnCivils = 1400;
private _radSpawngarisons = 1100;
private _alt = 1000;

{
	_loc = _x;
	_pos = position _loc;
	
	// crée des hélipads invisibles sur chaque localité autout de l'objectif avec ODD_var_MissionArea 
	private _variablesPad = "Land_HelipadEmpty_F" createVehicle _pos;
	_variablesPad setVariable ["trig_ODD_var_locName", text _loc, True];
	_variablesPad setVariable ["trig_ODD_var_loc", _loc, True];
	// utilise une fonction pour déterminer l'état de la zone 
	private _mod = 0;
	private _zoType = [_loc, _mod] call ODDcommon_fnc_defineZo;
	_mod = _zoType select 2;
	_zoType resize 2;
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
	private _garisonLimit = [_loc] call ODDcommon_fnc_LimitGarison;
	_variablesPad setVariable ["trig_ODD_var_garison", [_garisonPool,_garisonLimit], True];

	// crée les triggers pour spawn/déspawn les civls
	private _civTrigger = createTrigger ["EmptyDetector", _pos, True]; 
	_civTrigger setTriggerArea [_radSpawnCivils, _radSpawnCivils, 0, False, _alt]; 
	_civTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_civTrigger setTriggerStatements ["this",
	"
		[thisTrigger, True] spawn ODDcommon_fnc_civControl;
	",
	"
		[thisTrigger, False] spawn ODDcommon_fnc_civControl;
	"
	];
	_civTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];

	_civTrigger setVariable ["trig_ODD_var_civWantState", False, True];
	_scriptID = [_civTrigger, False] spawn ODDcommon_fnc_civControl;

	// crée les triggers pour spawn/déspawn les patrouilles
	private _patTrigger = createTrigger ["EmptyDetector", _pos, True]; 
	_patTrigger setTriggerArea [_radSpawnPatrols, _radSpawnPatrols, 0, False, _alt]; 
	_patTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_patTrigger setTriggerStatements ["this",
	"
		[thisTrigger, True] spawn ODDcommon_fnc_patrolsControl;
	",
	"
		[thisTrigger, False] spawn ODDcommon_fnc_patrolsControl;
	"
	];
	_patTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];

	_variablesPad setVariable ["trig_ODD_var_patWantState", False, True];
	_scriptID = [_patTrigger, False] spawn ODDcommon_fnc_patrolsControl;

	// crée les triggers pour spawn/déspawn les garnisons
	private _garTrigger = createTrigger ["EmptyDetector", _pos, True]; 
	_garTrigger setTriggerArea [_radSpawngarisons, _radSpawngarisons, 0, False, _alt]; 
	_garTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_garTrigger setTriggerStatements ["this",
	"
		[thisTrigger, True] spawn ODDcommon_fnc_garisonControl;
	",
	"
		[thisTrigger, False] spawn ODDcommon_fnc_garisonControl;
	"
	];
	_garTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];

	_variablesPad setVariable ["trig_ODD_var_patWantState", False, True];
	_scriptID = [_garTrigger, False] spawn ODDcommon_fnc_garisonControl;

	// log les hélipads et les triggers dans le fichier var
	ODD_var_ZonePad pushBack _variablesPad;
	ODD_var_AreaTrigger pushBack _LocTrigger;

	// crée les triggers pour activer/désactiver les AIs
	private _LocTrigger = createTrigger ["EmptyDetector", _pos, True]; 
	_LocTrigger setTriggerArea [_radDisable, _radDisable, 0, False, _alt]; 
	_LocTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_LocTrigger setTriggerStatements ["this",
	"
		[thisTrigger, True] spawn ODDadvanced_fnc_areaControl;
	",
	"
		[thisTrigger, False] spawn ODDadvanced_fnc_areaControl;
	"
	];
	_LocTrigger setVariable ["trig_ODD_var_Pad", _variablesPad, True];

	_variablesPad setVariable ["trig_ODD_var_WantState", False, True];
	_scriptID = [_LocTrigger, False] spawn ODDadvanced_fnc_areaControl;

	// log les hélipads et les triggers dans le fichier var
	ODD_var_ZonePad pushBack _variablesPad;
	ODD_var_AreaTrigger pushBack _LocTrigger;
	// systemChat "prout 2";
} forEach _locations;

// crée et assigne a chaque hélipad une variable contenant les valeurs de reserve pour la zone