/*
* Auteur : Wolv
* Fonction pour créer une missions dans la zone bleue
*
* Arguments :
*   _zoneID : ID de la zone
*   _missionsType : Type de missions
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call ODDMIS_fnc_createBlue;
*
* Variable publique :
* 
*/

params ["_zoneID","_missionsType"];

// On récupère la zone
private _zone = ODD_var_AllLocations select _zoneID;


private _name = _zone getVariable ["ODD_var_LocName"];

systemChat format ["ODD_CallCreate : Create Blue %1 (%2) : %3", _name, _zoneID, _missionsType];
