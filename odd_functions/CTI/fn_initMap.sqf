/*
* Auteur : Wolv
* Fonction pour crée les liens entre les localité 
*
* Arguments :
* 
* Valeur renvoyée :
*	nil
*
* Exemple :
* 	[] call ODDCTI_fnc_initMap
*
* Variable publique :
* 
*/

// si on est sur le serv et que la fonction n'a pas été appelé
if (!isServer) exitWith {true;};
if (!isNil "ODD_var_INITMAP") exitWith {true;};

waitUntil {
	uiSleep 0.1;
	DISCommon_var_InitCustomLocations
};

[{DISCommon_var_CanTP = False; publicVariable "DISCommon_var_CanTP";}] remoteExec ["call",0,True];

// on execute la fonction et on la marque comme appelé
ODD_var_INITMAP = false;
ODD_var_DataLoaded = false;

// si les variable existe pas on les definie
if (isNil "ODD_var_DEBUG") then {
	ODD_var_DEBUG = False;
};
if (isNil "ODD_var_AllLocations") then {
	ODD_var_AllLocations = [];
};
if (isNil "ODD_var_AllLocationsName") then {
	ODD_var_AllLocationsName = [];
};
if (isNil "ODDMIS_var_CompletedMissions") then {
	ODDMIS_var_CompletedMissions = 0;
};

// partie de la gestion des sauvegardes
// au début pas besoin de save
ODD_var_NeedSave = false;

// crée le trigger de sauvegarde
private _triggerBase = createTrigger ["EmptyDetector", base, True];
_triggerBase setTriggerArea [50, 50, 0, False, -1];
_triggerBase setTriggerActivation ["ANYPLAYER", "PRESENT", True];
_triggerBase setTriggerInterval 5;
_triggerBase setTriggerStatements ["this and ODD_var_NeedSave", "systemChat 'Penser a sauvegardé avant de quitté'", ""];

// remoteExec
[{oddCtrl addAction ["Save Game", {[ODDCTI_fnc_callSave] remoteExec ["call", 2];},[],1.5,True,True,"","True",5];}] remoteExec ["call", 0, True];


// variable de distance de spawn
// private _radRoadBlock = 1500;
// private _radOutpost = 1500;
// private _radDisable = 1000;
private _radSpawnEni = 1000;
private _radSpawnVl = 1500;
private _radSpawnCivils = 900;
private _alt = 1000;
private _radIED = 1000;

[] call ODDdata_fnc_varEneArd;

ODD_var_CTIMarkerInfo = 1;
ODDCTI_var_capturePrc = 0.2;

// récupère les locations
private _locations = [] call ODDCTI_fnc_getAllLocs;

// pour chaque location
{
	// récupère la position de la location
	private _pos = getPos _x;

	// on lie les location a proximité
	private _maLoc = createLocation [_x];
	[_maLoc] call ODDCTI_fnc_getNearLoc;


	// attribue les valeurs de pax sur chaque location
	private _tgtEni = 0;		// le nombre de pax sur la loc doit tendre vers cette valeur
	private _actEni = 0;		// le nombre de pax actuel sur la loc
	// Set des variable d'enemie
	_tgtEni = [_x] call ODDCalc_fnc_calcEniOnLoc;
	_actEni = round (_tgtEni);

	// valeur de vehicule
	private _vehtgt = 0;
	private _vehact = [];
	// Set des variable de vehicule
	_veh = [_x] call ODDCalc_fnc_calcVehOnLoc;
	_vehtgt = (_veh select 0);
	_vehact = (_veh select 1);
	
	// valeur de civil
	private _civtgt = 0;
	private _civact = 0;
	// Set des variable de civil
	_civtgt = [_x] call ODDCalc_fnc_calcCivOnLoc;
	_civact = round (_civtgt);

	// Set des variable de la location
	_maLoc setVariable ["ODD_var_LocName", text _maLoc];
	_maLoc setVariable ["ODD_var_LocId", _forEachIndex];
	ODD_var_AllLocationsName pushBack (text _x);

	// Set des variable de enemie pax
	_maLoc setVariable ["ODD_var_OccActEni", _actEni];
	_maLoc setVariable ["ODD_var_OccTgtEni", _tgtEni];

	// Set des variable de vehicule
	_maLoc setVariable ["ODD_var_OccActEniVeh", _vehact];
	_maLoc setVariable ["ODD_var_OccTgtEniVeh", _vehtgt];

	// Set des variable de civilian
	_maLoc setVariable ["ODD_var_CivActPax", _civact];
	_maLoc setVariable ["ODD_var_CivTgtPax", _civtgt];

	// Set des variable de capture
	_maLoc setVariable ["ODD_var_isBlue", false];
	_maLoc setVariable ["ODD_var_isFrontLine", false];

	// Set des variable de recrutement
	private _isMil = [_x] call ODDCommon_fnc_isMillitary;
	if (_isMil) then {
		_maLoc setVariable ["ODD_var_OccPrcRecrut", 0.2];
		_maLoc setVariable ["ODD_var_OccRecrutVeh", 1];
		_maLoc setVariable ["ODD_var_IsMil", true];
	}
	else {
		_maLoc setVariable ["ODD_var_OccPrcRecrut", 0];
		_maLoc setVariable ["ODD_var_OccRecrutVeh", 0];
		_maLoc setVariable ["ODD_var_IsMil", false];
	};

	// Valeur des caisses
	_crate = [_x] call ODDCalc_fnc_calcCrateOnLoc;
	_maLoc setVariable ["ODD_var_tgtCrate", _crate select 0];
	_maLoc setVariable ["ODD_var_actCrate", _crate select 1];

	// Valeurs des IED
	private _IEDs = [_x] call ODDCalc_fnc_calcIedOnLoc;
	_maLoc setVariable ["ODD_var_tgtIED", _IEDs select 0];
	_maLoc setVariable ["ODD_var_actIED", _IEDs select 1];

	// crée un marker sur la map
	private _marker = createMarkerLocal [Format ["ODD_var_LocMarker_%1", _pos], (_pos getPos [50, 270])];
	_marker setMarkerType "mil_dot";
	_marker setMarkerColor "ColorBlack";
	_marker setMarkerSize [1, 1];
	// _marker setMarkerText (str _vehact);
	_marker setMarkerAlpha 1;
	_x setVariable ["ODD_var_marker", _marker];
	
	// crée le trigger de spawn de pax
	private _triggerEni = createTrigger ["EmptyDetector", _pos, true];
	_triggerEni setTriggerArea [_radSpawnEni, _radSpawnEni, 0, false, _alt];
	_triggerEni setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_triggerEni setTriggerInterval 5;
	_triggerEni setTriggerStatements ["this",
		Format ["[thisTrigger, true, %1] spawn ODDControl_fnc_controlEniPax;", _radSpawnEni],
		Format ["[thisTrigger, false, %1] spawn ODDControl_fnc_controlEniPax; ODD_var_NeedSave = true;", _radSpawnEni]
	];
	_triggerEni setVariable ["ODD_var_location", _maLoc];
	_maLoc setVariable ["ODD_var_triggerEni", _triggerEni];

	// crée le trigger de spawn de vehicule
	private _triggerVH = createTrigger ["EmptyDetector", _pos, true];
	_triggerVH setTriggerArea [_radSpawnVl, _radSpawnVl, 0, false, _alt];
	_triggerVH setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_triggerVH setTriggerInterval 5;
	_triggerVH setTriggerStatements ["this",
		Format ["[thisTrigger, true, %1] spawn ODDControl_fnc_controlEniVeh;", _radSpawnVl],
		Format ["[thisTrigger, false, %1] spawn ODDControl_fnc_controlEniVeh; ODD_var_NeedSave = true;", _radSpawnVl]
	];
	_triggerVH setVariable ["ODD_var_location", _maLoc];
	_maLoc setVariable ["ODD_var_triggerOccVehicule", _triggerVH];

	// si il peux y avoir des civils
	if (_civtgt > 0) then {
		// crée le trigger de spawn de civils
		private _triggerCiv = createTrigger ["EmptyDetector", _pos, true];
		_triggerCiv setTriggerArea [_radSpawnCivils, _radSpawnCivils, 0, false, _alt];
		_triggerCiv setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_triggerCiv setTriggerInterval 5;
		_triggerCiv setTriggerStatements ["this",
			Format ["[thisTrigger, true, %1] spawn ODDControl_fnc_controlCiv;", _radSpawnEni],
			Format ["[thisTrigger, false, %1] spawn ODDControl_fnc_controlCiv; ODD_var_NeedSave = true;", _radSpawnEni]
		];
		_triggerCiv setVariable ["ODD_var_location", _maLoc];
		_maLoc setVariable ["ODD_var_triggerCiv", _triggerCiv];
	};
	//*/
	
	// crée le trigger de spawn d'ieds & Caisses
	private _triggerIED = createTrigger ["EmptyDetector", _pos, true];
	_triggerIED setTriggerArea [_radIED, _radIED, 0, false, _alt];
	_triggerIED setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_triggerIED setTriggerInterval 5;
	_triggerIED setTriggerStatements ["this",
		Format ["[thisTrigger, true, %1] spawn ODDControl_fnc_controlIED; [thisTrigger, true, %1] spawn ODDControl_fnc_controlCrates;", _radIED],
		Format ["[thisTrigger, false, %1] spawn ODDControl_fnc_controlIED; [thisTrigger, false, %1] spawn ODDControl_fnc_controlCrates; ODD_var_NeedSave = true;", _radIED]
	];
	_triggerIED setVariable ["ODD_var_location", _maLoc];
	_maLoc setVariable ["ODD_var_triggerIEDs", _triggerIED];

} forEach _locations;

ODD_var_AllLocations = _locations;

["DIS_mrk_FOB_4"] call DISCommon_fnc_PosFob;

[ODD_var_CTIMarkerInfo] call ODDCTI_fnc_updateMap;

// event Handler, quand un mec est attaché il sort de son groupe
["ace_captiveStatusChanged", {
	params ["_unit", "_state", "_reason", "_caller"];
	if (!isPlayer _unit) then {
		if (_state == true) then {
			[_unit] join grpNull;
			_unit addEventHandler ["Hit", {
				params ["_unit", "_source", "_damage", "_instigator"];
				if ((side _instigator) == WEST) then {
					[-0.25] call ODDCTI_fnc_updateCivRep;
				};
				if ((side _instigator) == EAST) then {
					[0.10] call ODDCTI_fnc_updateCivRep;
				};
			}];
			_unit addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator"];
				if ((side _instigator) == WEST) then {
					[-0.5] call ODDCTI_fnc_updateCivRep;
				};
				if ((side _instigator) == EAST) then {
					[0.25] call ODDCTI_fnc_updateCivRep;
				};
			}];

		};
	};
}] call CBA_fnc_addEventHandler;

["ace_unconscious", {
	params ["_unit", "_state"];

	// code a executé en asynchrone
	private _monCode = {
		params ["_unit", "_state"];
		if (!isPlayer _unit) then {
			if (_state == true) then {
				// si l'unité est dans un véhicule, on le sort
				if (vehicle _unit != _unit) then {
					moveOut _unit;
				};
				// on regarde si tout le groupe est en coma
				private _group = group _unit;
				private _coma = true;
				{
					if (_x getVariable ["ACE_isUnconscious", true]) then {
						_coma = false;
					};
				} forEach units _group;
				// si tout le groupe est en coma
				if (_coma) then {
					{	// on tue tout le groupe
						_x setDamage 1;
					} forEach units _group;
				};

				// on ajoute un event handler pour tuer l'unité si elle est en coma et se prend des damages
				_unit addEventHandler ["Hit", { 
					params ["_unit", "_source", "_damage", "_instigator"]; 
					if (_unit getVariable ["ACE_isconvoinscious", true] and (!isPlayer _unit)) then {
						_unit setDamage 1;		
					};
				}];
			};
		};
	};
	// spawn le code pour avoir un contexte scheduler
	[_unit, _state] spawn _monCode;
}] call CBA_fnc_addEventHandler;

// on marque la map comme initialisé
ODD_var_INITMAP = true;
[{ODD_var_INITMAP = true;}] remoteExec ["call", 0, true];
["Map Initialized"] remoteExec ["systemChat", 0];
[["Map Initialized"]] call ODDcommon_fnc_log;

// crée l'array des missions
[True, "ODD_task_CTI", [Format["Nettoyer %1 de la présence enemie.", worldName], Format["Nettoyer %1", worldName], ""], objNull, "ASSIGNED", -1, False, "map"] call BIS_fnc_taskCreate;
ODDMIS_var_ActiveMissions = createHashMap;
ODDMIS_var_MissionID = 0;

// import les donnés sauvergardé
uiSleep 10;
[] call ODDCTI_fnc_profileImport;
[{DISCommon_var_CanTP = True; publicVariable "DISCommon_var_CanTP";}] remoteExec ["call",0,True];
["Game Ready !"] remoteExec ["systemChat", 0];
[["Game Ready !"]] call ODDcommon_fnc_log;

// private _map = (findDisplay 12 displayCtrl 51);
// {
// 	private _nearloc = _x getVariable ["ODD_var_nearLocations", []];
// 	private _pos = getPos _x;

// 	{
// 		private _posloc = getPos _x;
	

// 		_map ctrlAddEventHandler ["Draw",Format [
// 			"(_this select 0) drawLine [
// 				%1,
// 				%2,
// 				[0,0,1,1]
// 			];", _pos, _posloc]
// 		];

// 	}forEach _nearloc;
// } forEach _locations;
