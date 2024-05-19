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
* 
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
	private _varToGet = [["odd_var_acteni", 0], ["odd_var_tgteni", 0], ["ODD_var_prcRecrut", 0], ["ODD_var_isBlue", false], ["ODD_var_isFrontLine", false]];

	{
		_MaLoc set [_x select 0, (_loc getVariable [(_x select 0), (_x select 1)])];
	} forEach _varToGet;

	_LocData set [(text _x), _MaLoc];
} forEach ODDvar_mesLocations;

_data set ["LocData", _LocData];

_data set ["ODD_var_CivilianReputation", ODD_var_CivilianReputation];

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


