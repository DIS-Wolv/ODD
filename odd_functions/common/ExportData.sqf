/*
* Auteur : Wolv
* Fonction pour récupérer les données de la mission
*
* Arguments :
*
* Valeur renvoyée :
* 0: booléen (true si c'est une base militaire, false sinon)
*
* Exemple:
* [_zo] call ODDcommon_fnc_isMillitary;
*
* Variable publique :
*/

private _data = createHashMap;
private _LocData = createHashMap;

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

_data;


