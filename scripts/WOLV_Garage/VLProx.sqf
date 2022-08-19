/*
* Author: Wolv
* Script permetant d'update la list avec les vl proche 
* 
* Return Value:
* nil
*
*/

//nettoye la liste
lbClear IdcListVL;

// recup les vl a proximité et les rajoute a la liste
ListVL = nearestObjects [PosGarage, ["car", "tank", "plane", "ship", "helicopter"], 100];

{
	lbAdd [IdcListVL, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
	lbSetPicture [IdcListVL, _foreachindex, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "picture")]
} forEach ListVL;

call compile preprocessFile 'scripts\WOLV_garage\Inventaire.sqf';