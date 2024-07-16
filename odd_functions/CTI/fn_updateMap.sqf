/*
* Auteur : Wolv
* Fonction pour mettre a jours les markers sur la carte
*
* Arguments :
* 0: _info: niveaux de detaille des infos
* 
* Valeur renvoyée :
*
* Exemple :
* 	[0] call ODDCTI_fnc_updateMapLocation
*
* Variable publique :
* 
*/

params [["_info", 0]];

// systemChat format ["Mise a jours des markers sur la carte"];
{
	[_x, _info] call ODDCTI_fnc_updateMapLocation;
} forEach ODDvar_AllLocations;

