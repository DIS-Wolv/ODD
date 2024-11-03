/*
* Auteur : Wolv
* Fonction pour créer une missions sur la zone ennemie
*
* Arguments :
* 
* 
* Valeur renvoyée :
*
* Exemple :
* 	[0] call ODDMIS_fnc_createRed;
*
* Variable publique :
* 
*/

params ["_zoneID","_missionsType"];

// On récupère la zone
private _zone = ODD_var_AllLocations select _zoneID;

