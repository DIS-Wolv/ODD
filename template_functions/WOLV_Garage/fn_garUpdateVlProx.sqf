/*
* Auteur: Wolv
* Function pour mettre a jour les vls a proximité
* 
* Return Value:
* nil
*
*/

if (!isNull(findDisplay WolvGarage_var_IddDisplayGarage)) then {

lbClear WolvGarage_var_IdcListVlProx;

WolvGarage_var_ListVL = call WolvGarage_fnc_garVlProx;

{
	lbAdd [WolvGarage_var_IdcListVlProx, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
	if (getText (configFile >> "CfgVehicles" >> "C_IDAP_supplyCrate_F" >> "picture") != "pictureThing") then 
	{
		lbSetPicture [WolvGarage_var_IdcListVlProx, _foreachindex, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "picture")]
	}
} forEach WolvGarage_var_ListVL;

};
