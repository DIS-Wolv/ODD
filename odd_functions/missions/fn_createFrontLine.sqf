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

params ["_zoneID","_missionsType"];

// On récupère la zone
private _zone = ODD_var_AllLocations select _zoneID;

