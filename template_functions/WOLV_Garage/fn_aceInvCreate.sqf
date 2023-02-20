


WolvGarage_var_IdcListInvAce = 1500;
WolvGarage_var_IdcListAresnalAce = 1501;
WolvGarage_var_IdcChoixVl = 2100;
WolvGarage_var_BarreInvAce = 1900;
WolvGarage_var_AceInvSize = 1101;

private _isCreate = False;

_isCreate = createDialog "GUIgarage_InvAce";

WolvGarage_var_ListSpawn = call WolvGarage_fnc_garVlProx;

if (_isCreate) then {
	{
		lbAdd [WolvGarage_var_IdcChoixVl, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
		lbSetPicture [WolvGarage_var_IdcChoixVl, _foreachindex, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "picture")]
	} forEach WolvGarage_var_ListVL;

	{
		lbAdd [WolvGarage_var_IdcListAresnalAce, getText (configFile >> "CfgVehicles" >> _x >> "displayName")];
	} forEach WolvGarage_var_ItemAce;
};

((findDisplay WolvGarage_var_IddDisplayInvAce) displayCtrl WolvGarage_var_IdcChoixVl) ctrlAddEventHandler ["LBSelChanged", "call WolvGarage_fnc_aceInvUpdate"];
// Double clic pour créer le véhicule

((findDisplay WolvGarage_var_IddDisplayInvAce) displayCtrl WolvGarage_var_IdcListInvAce) ctrlAddEventHandler ["LBDblClick", "[1] call WolvGarage_fnc_aceInvRemoveItem"];
((findDisplay WolvGarage_var_IddDisplayInvAce) displayCtrl WolvGarage_var_IdcListAresnalAce) ctrlAddEventHandler ["LBDblClick", "[1] call WolvGarage_fnc_aceInvAddItem"];

