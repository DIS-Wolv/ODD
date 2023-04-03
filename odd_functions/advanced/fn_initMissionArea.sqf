/*
* Auteur : Wolv
* Fonction pour assigner le nombre de patrouilles, garnisons et véhicules en réserve dans une zone. 
*
* Arguments :
* 0: Centre de la zone (localité de l'obj) <Objet>
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
private _radA = 1200;
private _alt = 1000;

{
	_loc = _x;
	_pos = position _loc;
	// crée des hélipads invisibles sur chaque localité autout de l'objectif avec ODD_var_MissionArea 
	_markerZ = "Land_HelipadEmpty_F" createVehicle _pos;
	_markerZ setVariable ["trig_ODD_var_locName", text _loc, True];

	// utilise les fonctions pour calculer les reserves sur chaque localité	
	private _patrolPool = [_loc,(_loc == _zo)] call ODDadvanced_fnc_initPatrol;
	private _patrolLimit = [XXXX] call ODDadvanced_fnc_LimitPatrol;
	_markerZ setVariable ["trig_ODD_var_patrols", [_patrolPool,_patrolLimit], True];

	// crée les triggers pour activer/désactiver les AIs
	private _LocTrigger = createTrigger ["EmptyDetector", _pos, True]; 
	_LocTrigger setTriggerArea [_radA, _radA, 0, False, _alt]; 
	_LocTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", True]; 
	_LocTrigger setTriggerStatements ["this",
	"
		[thisTrigger, True] spawn ODDadvanced_fnc_areaControl;
	",
	"
		[thisTrigger, False] spawn ODDadvanced_fnc_areaControl;
	"
	];
	_LocTrigger setVariable ["trig_ODD_var_loc", _markerZ, True];

	_markerZ setVariable ["trig_ODD_var_WantState", False, True];
	_scriptID = [_LocTrigger, False] spawn ODDadvanced_fnc_areaControl;

	// log les hélipads et les triggers dans le fichier var
	ODD_var_ZonePad pushBack _markerZ;
	ODD_var_AreaTrigger pushBack _LocTrigger;
} forEach _location;

// crée et assigne a chaque hélipad une variable contenant les valeurs de reserve pour la zone