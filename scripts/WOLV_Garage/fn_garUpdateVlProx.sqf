

lbClear WolvGarage_var_IdcListVlProx;

WolvGarage_var_ListVL = call WolvGarage_fnc_garVlProx;

{
	lbAdd [WolvGarage_var_IdcListVlProx, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
	lbSetPicture [WolvGarage_var_IdcListVlProx, _foreachindex, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "picture")]
} forEach WolvGarage_var_ListVL;