/*
* Auteur : Wolv
* Fonction pour exporté les donnée de la mission
*
* Arguments :
* 
* Valeur renvoyée :
*	0 : Donnée sauvergardé (array)
*
* Exemple :
* 	[] call ODDCTI_fnc_ExportData
*
* Variable publique :
* 
*/
params [["_saveDefault", false]];

if (!isServer) exitWith {true;};
if (isNil "ODD_var_INITMAP") exitWith {[["Export sur mission non init"]] call ODDcommon_fnc_log;};

[["Export Debut"]] call ODDcommon_fnc_log;

// liste des object a save
private _objectToSave = [FOB, armesFob, medicalFob, lanceursFob, factory, usine];

// création de l'array de sauvegarde
private _data = createHashMap;
private _LocData = createHashMap;
private _objectData = createHashMap;
private _missionsData = createHashMap;

// pour chaque location 
{
	[["Export début %1", (text _x)]] call ODDcommon_fnc_log;
	// création de l'array de sauvegarde
	private _MaLoc = createHashMap;
	private _loc = _x;

	// liste des variable a get avec leur valeur par défaut
	private _varToGet = [
		["ODD_var_LocName",""],
		["ODD_var_OccActEniVeh", []],
		["ODD_var_OccTgtEniVeh", [_x] call ODDCalc_fnc_calcVehOnLoc],
		["ODD_var_CivActPax", [_x] call ODDCalc_fnc_calcCivOnLoc],
		["ODD_var_CivTgtPax", [_x] call ODDCalc_fnc_calcCivOnLoc],
		["ODD_var_OccActEni", [_x] call ODDCalc_fnc_calcEniOnLoc],
		["ODD_var_OccTgtEni", [_x] call ODDCalc_fnc_calcEniOnLoc],
		["ODD_var_OccPrcRecrut", 0],
		["ODD_var_OccRecrutVeh",0],
		["ODD_var_isBlue", false],
		["ODD_var_isFrontLine", false]
	];
	// pour chaque variable
	{
		// récupération de la valeur
		private _getValue = _loc getVariable [(_x select 0), (_x select 1)];
		private _defValue = (_x select 1);
		// si la valeur est différente de la valeur par défaut ou si on doit sauver les valeurs par défaut
		if ((!(_getValue isEqualTo _defValue)) or _saveDefault) then {
			// on set la variable
			_MaLoc set [_x select 0, (_getValue)];
		};
	} forEach _varToGet;

	// récupération de l'id de la location
	private _locId = _loc getVariable ["ODD_var_LocId", -1];
	// on set la location
	_LocData set [_locId, _MaLoc];
	[["Export OK %1", (text _x)]] call ODDcommon_fnc_log;
} forEach ODD_var_AllLocations;

// on set dans l'array de sauvegarde global l'array de save des loc crafter plus haut
_data set ["LocData", _LocData];

// private _varToGet = ["ODD_var_CivilianReputation", "ODD_var_CTIMarkerInfo"];
// {
// 	_data set [_x select 0, (_this select 0)]; // la il faut le contenue de la variable (_this select 0) et pas sont nom
// } forEach _varToGet;

// récupération des variable a saver
_data set ["ODD_var_CivilianReputation", ODD_var_CivilianReputation];	// réputation civil
_data set ["ODD_var_CTIMarkerInfo", ODD_var_CTIMarkerInfo];				// marker de la map
_data set ["ODD_var_ProgressDate", ODD_var_ProgressDate];				// date de progression

private _date = date;
_data set ["ODD_var_DateTime", _date];									// date actuelle

// Partie missions 
_data set ["ODDMIS_var_MissionID", ODDMIS_var_MissionID];						// ID de la mission
_data set ["ODDMIS_var_CompletedMissions", ODDMIS_var_CompletedMissions];	// nombre de mission terminé
{
	// crée une hashmap
	private _dataMis = createHashMap;
	private _id = -1;
	// récupère les données de la mission
	private _mission = ODDMIS_var_ActiveMissions get _x;

	// pour chaque variable de la mission
	{
		// suivant la variable
		switch _x do {
			case "vehicule": {
				// on récupère les valeurs véhicules
				private _vls = _mission get _x;
				// on crée une liste de véhicule
				private _ListType = [];
				private _ListPos = [];
				private _ListDir = [];
				{
					_ListType pushBack (TypeOf _x);
					_ListPos pushBack (getpos _x);
					_ListDir pushBack (getdir _x);
				} forEach _vls;
				_dataMis set ["VlType", _ListType];
				_dataMis set ["VlPos", _ListPos];
				_dataMis set ["VlDir", _ListDir];
			};
			case "id": {
				// si c'est l'id de la mission on le récupère
				_id = _mission get _x;
				_dataMis set [_x, _id];
			};
			default {
				// sinon on save la variable
				_dataMis set [_x, _mission get _x];
			};
		};
	} forEach _mission;
	// on set la mission dans l'array de sauvegarde
	_missionsData set [_id, _dataMis];
} forEach ODDMIS_var_ActiveMissions;										// liste des missions actives
_data set ["ODDMIS_var_ActiveMissions", _missionsData];						// liste des missions

// pour chaque object a save
{
	// crée une hashmap
	private _object = createHashMap;
	// si l'object n'est pas null
	if (!isnull _x) then {
		// on set les variable de l'object
		_object set ["pos", getPosASL _x];	// position
		_object set ["dir", getDir _x];		// direction

		_objectData set [str _x, _object];	// on set l'object dans l'array de sauvegarde
	};
} forEach _objectToSave;

// on set dans l'array de sauvegarde global l'array de save des object crafter plus haut
_data set ["ObjectData", _objectData];

systemChat "Export des données de la mission";

[["Export OK"]] call ODDcommon_fnc_log;

_data;


