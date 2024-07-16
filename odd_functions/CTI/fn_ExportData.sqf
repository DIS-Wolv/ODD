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

private _objectToSave = [FOB, armesFob, medicalFob, lanceursFob, factory, usine];

private _data = createHashMap;
private _LocData = createHashMap;
private _objectData = createHashMap;

{
	private _MaLoc = createHashMap;
	private _loc = _x;
	private _varToGet = [["ODD_var_OccActEniVeh", []], ["ODD_var_OccTgtEniVeh", 0], ["ODD_var_CivActPax", 0], ["ODD_var_CivTgtPax", 0], ["ODD_var_OccActEni", 0], ["ODD_var_OccTgtEni", 0], ["ODD_var_OccPrcRecrut", 0], ["ODD_var_isBlue", false], ["ODD_var_isFrontLine", false]];

	{
		_MaLoc set [_x select 0, (_loc getVariable [(_x select 0), (_x select 1)])];
	} forEach _varToGet;

	_LocData set [(text _x), _MaLoc];
} forEach ODDvar_AllLocations;

_data set ["LocData", _LocData];

// private _varToGet = ["ODD_var_CivilianReputation", "ODD_var_CTIMarkerInfo"];
// {
// 	_data set [_x select 0, (_this select 0)]; // la il faut le contenue de la variable (_this select 0) et pas sont nom
// } forEach _varToGet;

_data set ["ODD_var_CivilianReputation", ODD_var_CivilianReputation];
_data set ["ODD_var_CTIMarkerInfo", ODD_var_CTIMarkerInfo];

{
	private _object = createHashMap;
	if (!isnull _x) then {
		_object set ["pos", getPosATL _x];
		_object set ["dir", getDir _x];

		_objectData set [str _x, _object];
	};
} forEach _objectToSave;

_data set ["ObjectData", _objectData];

systemChat "Export des données de la mission";
_data;


