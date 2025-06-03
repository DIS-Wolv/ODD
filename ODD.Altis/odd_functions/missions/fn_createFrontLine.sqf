/*
* Auteur : Wolv
* Fonction pour créer une missions sur la ligne de front
*
* Arguments :
* 
* 
* Valeur renvoyée :
*
* Exemple :
* 	[0] call ODDMIS_fnc_createFrontLine;
*
* Variable publique :
* 
*/

params ["_zoneID","_missionType","_missionID"];

// On récupère la zone
private _zone = ODD_var_AllLocations select _zoneID;

private _name = _zone getVariable ["ODD_var_LocName"];

systemChat format ["ODD_CallCreate : Create FrontLine %1 (%2) : %3", _name, _zoneID, _missionsType];
