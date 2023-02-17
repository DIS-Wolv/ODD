


WolvGarage_var_IdcListVlProx = 1500;
WolvGarage_var_IdcListVlUsine = 1501;
WolvGarage_var_IdcButtonSpawn = 1603;
WolvGarage_var_IdcButtonParadrop = 1604;
WolvGarage_var_IdcButtonDelete = 1605;

private _isCreate = False;

_isCreate = createDialog "GUIgarage_Garage";

if (_isCreate) then {
	{
		lbAdd [WolvGarage_var_IdcListVlUsine, getText (configFile >> "CfgVehicles" >> _x >> "displayName")];
		lbSetPicture [WolvGarage_var_IdcListVlUsine, _foreachindex, getText (configFile >> "CfgVehicles" >> _x >> "picture")]
	} forEach WolvGarage_var_ListUsine;

	call WolvGarage_fnc_garUpdateVlProx;

};


((findDisplay WolvGarage_var_IddDisplayGarage) displayCtrl WolvGarage_var_IdcListVlUsine) ctrlAddEventHandler ["LBDblClick", "call WolvGarage_fnc_garSpawnVl"];
// Double clic pour créer le véhicule


