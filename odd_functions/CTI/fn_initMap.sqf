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
// on execute la fonction et on la marque comme appelé
ODD_var_INITMAP = true;
[{ODD_var_INITMAP = true;}] remoteExec ["call", 0, true];

// partie de la gestion des sauvegardes
// au début pas besoin de save
ODD_var_NeedSave = false;

// crée le trigger de sauvegarde
private _triggerBase = createTrigger ["EmptyDetector", base, True];
_triggerBase setTriggerArea [50, 50, 0, False, -1];
_triggerBase setTriggerActivation ["ANYPLAYER", "PRESENT", True];
_triggerBase setTriggerStatements ["this and ODD_var_NeedSave", "[] spawn ODDCTI_fnc_callSave", ""];


// variable de distance de spawn
// private _radRoadBlock = 1500;
// private _radOutpost = 1500;
// private _radIED = 1400;
// private _radDisable = 1000;
private _radSpawnEni = 1000;
private _radSpawnVl = 1500;
private _radSpawnCivils = 900;
private _alt = 1000;

[] call ODDdata_fnc_varEneArd;

ODD_var_CTIMarkerInfo = 1;
ODDCTI_var_capturePrc = 0.2;

// fonction pour supprimer les locations blacklistées
private _fnc_removeBlackListed = {
	params ["_locations"];
	{
		if (text _x in ODD_var_BlackistedLocation) then {
			_locations = _locations - [_x];
		};
	}forEach _locations;
	_locations;
};


private _locations = nearestLocations[[worldSize / 2, worldSize / 2], ODD_var_LocationType, worldSize * 2];

// retire les locations blacklistées
_locations = [_locations] call _fnc_removeBlackListed;

// pour chaque location
{
	// récupère la position de la location
	private _pos = getPos _x;
	private _range = 1000;

	switch (type _x) do {
		case (ODD_var_LocationType select 0): { // Capital
			_range = 4500;
		};
		case (ODD_var_LocationType select 1): { // City
			_range = 3000;
		};
		case (ODD_var_LocationType select 2): { // Village
			_range = 2000;
		};
		case (ODD_var_LocationType select 3): { // Name
			_range = 2000;
		};
		case (ODD_var_LocationType select 4): { // NameLocal
			_range = 1000;
		};
		case (ODD_var_LocationType select 5): { // Hill
			_range = 1000;
		};
		default {};
	};
	if ([_x] call ODDCommon_fnc_isMillitary) then {
		_range = _range + 1000;
	};

	private _nearLoc = nearestLocations[_pos, ODD_var_LocationType, _range];
	_nearLoc = [_nearLoc] call _fnc_removeBlackListed;

	while {count _nearLoc < 4} do {
		_range = _range + 100;
		_nearLoc = nearestLocations[_pos, ODD_var_LocationType, _range];
		_nearLoc = [_nearLoc] call _fnc_removeBlackListed;
	};

	private _maLoc = createLocation [_x];
	_nearLoc = _nearLoc apply {createLocation [_x]};
	
	{
		private _nearLocR = _x getVariable ["ODD_var_nearLocations", []];
		_nearLocR pushBackUnique _maLoc;
		_x setVariable ["ODD_var_nearLocations", _nearLocR];
	}forEach _nearLoc;

	// private _maLoc = createLocation [_x];
	private _nearLocO = _maLoc getVariable ["ODD_var_nearLocations", []];
	{
		_nearLoc pushBackUnique _x;
	}forEach _nearLocO;

	{
		if(text _x == text _maLoc) then {
			_nearLoc = _nearLoc - [_x];
		};
	} forEach _nearLoc;

	_maLoc setVariable ["ODD_var_nearLocations", _nearLoc];


	// attribue les valeurs de pax sur chaque location
	private _tgtEni = 0;		// le nombre de pax sur la loc doit tendre vers cette valeur
	private _actEni = 0;		// le nombre de pax actuel sur la loc
	// Set des variable d'enemie
	_tgtEni = [_x] call ODDCTI_fnc_calcEniOnLoc;
	_actEni = round (_tgtEni);
	_maLoc setVariable ["ODD_var_OccActEni", _actEni];
	_maLoc setVariable ["ODD_var_OccTgtEni", _tgtEni];

	// valeur de vehicule
	private _vehtgt = 0;
	private _vehact = [];
	// Set des variable de vehicule
	_vehtgt = [_x] call compile preprocessFile "odd_functions\CTI\fn_calcVehOnLoc.sqf";
	for "_i" from 1 to _vehtgt do {
		_vehact pushBack (selectRandom ODD_var_Vehicles);
	};
	_maLoc setVariable ["ODD_var_OccActEniVeh", _vehact];
	_maLoc setVariable ["ODD_var_OccTgtEniVeh", _vehtgt];

	// valeur de civil
	private _civtgt = 0;
	private _civact = 0;
	// Set des variable de civil
	_civtgt = [_x] call compile preprocessFile "odd_functions\CTI\fn_calcCivOnLoc.sqf";
	_civact = round (_civtgt);
	_maLoc setVariable ["ODD_var_CivActPax", _civact];
	_maLoc setVariable ["ODD_var_CivTgtPax", _civtgt];

	// Set des variable de capture
	_maLoc setVariable ["ODD_var_isBlue", false];
	_maLoc setVariable ["ODD_var_isFrontLine", false]; 

	// Set des variable de recrutement
	private _isMil = [_x] call ODDCommon_fnc_isMillitary;
	if (_isMil) then {
		_maLoc setVariable ["ODD_var_OccPrcRecrut", 0.2];
	}
	else {
		_maLoc setVariable ["ODD_var_OccPrcRecrut", 0];
	};

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
	_triggerEni setTriggerActivation ["WEST", "PRESENT", true];
	_triggerEni setTriggerStatements ["this",
		Format ["[thisTrigger, true, %1] spawn ODDControl_fnc_controlEniPax;", _radSpawnEni],
		Format ["[thisTrigger, false, %1] spawn ODDControl_fnc_controlEniPax; ODD_var_NeedSave = true;", _radSpawnEni]
	];
	_triggerEni setVariable ["ODD_var_location", _maLoc];
	_maLoc setVariable ["ODD_var_triggerEni", _triggerEni];

	// crée le trigger de spawn de vehicule
	private _triggerVH = createTrigger ["EmptyDetector", _pos, true];
	_triggerVH setTriggerArea [_radSpawnVl, _radSpawnVl, 0, false, _alt];
	_triggerVH setTriggerActivation ["WEST", "PRESENT", true];
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
		_triggerCiv setTriggerActivation ["WEST", "PRESENT", true];
		_triggerCiv setTriggerStatements ["this",
			Format ["[thisTrigger, true, %1] spawn ODDControl_fnc_controlCiv;", _radSpawnEni],
			Format ["[thisTrigger, false, %1] spawn ODDControl_fnc_controlCiv; ODD_var_NeedSave = true;", _radSpawnEni]
		];
		_triggerCiv setVariable ["ODD_var_location", _maLoc];
		_maLoc setVariable ["ODD_var_triggerCiv", _triggerCiv];
	};
	
} forEach _locations;

ODD_var_AllLocations = _locations;

["DIS_mrk_FOB_4"] call DISCommon_fnc_PosFob;

[ODD_var_CTIMarkerInfo] call ODDCTI_fnc_updateMap;

// import les donnés sauvergardé
[] call ODDCTI_fnc_profileImport;

// event Handler, quand un mec est attaché il sort de son groupe
["ace_captiveStatusChanged", {
	params ["_unit", "_state", "_reason", "_caller"];
	if (!isPlayer _unit) then {
		if (_state == true) then {
			[_unit] join grpNull;
			_x addEventHandler ["Hit", {
				params ["_unit", "_source", "_damage", "_instigator"];
				if ((side _instigator) == WEST) then {
					[-0.25] call ODDCTI_fnc_updateCivRep;
				};
				if ((side _instigator) == EAST) then {
					[0.10] call ODDCTI_fnc_updateCivRep;
				};
			}];
			_x addEventHandler ["Killed", {
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

systemChat "Map Initialized";


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
