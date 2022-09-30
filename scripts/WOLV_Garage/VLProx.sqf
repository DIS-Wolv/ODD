/*
* Auteur: Wolv
* Script pour mettre à jour la liste des véhicules à proximité
* 
* Return Value:
* nil
*
*/

lbClear IdcListVL;
// Nettoie la liste

ListVL = nearestObjects [PosGarage, ["car", "tank", "plane", "ship", "helicopter"], 100];
// Récupère les véhicules à proximité et les ajoute à la liste

{
	lbAdd [IdcListVL, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
	lbSetPicture [IdcListVL, _foreachindex, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "picture")]
} forEach ListVL;

call compile preprocessFile 'scripts\WOLV_garage\Inventaire.sqf';
