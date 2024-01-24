


WolvGarage_var_IdcListInv = 1500;
WolvGarage_var_IdcListAresnal = 1501;
WolvGarage_var_IdcChoixVl = 2100;
WolvGarage_var_BarreInv = 1900;

private _isCreate = False;

_isCreate = createDialog "GUIgarage_Inv";

WolvGarage_var_ListSpawn = call WolvGarage_fnc_garVlProx;

if (_isCreate) then {
	{
		lbAdd [WolvGarage_var_IdcChoixVl, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
		lbSetPicture [WolvGarage_var_IdcChoixVl, _foreachindex, getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "picture")]
	} forEach WolvGarage_var_ListVL;

	{
		if (getText (configFile >> "CfgWeapons" >> _x >> "displayName") != "") then {
			lbAdd [WolvGarage_var_IdcListAresnal, getText (configFile >> "CfgWeapons" >> _x >> "displayName")];
		}
		else {
			lbAdd [WolvGarage_var_IdcListAresnal, getText (configFile >> "CfgMagazines" >> _x >> "displayName")];
		};
	} forEach WolvGarage_var_ListArsenal;
};

((findDisplay WolvGarage_var_IddDisplayInv) displayCtrl WolvGarage_var_IdcChoixVl) ctrlAddEventHandler ["LBSelChanged", "call WolvGarage_fnc_invUpdate"];
((findDisplay WolvGarage_var_IddDisplayInv) displayCtrl WolvGarage_var_IdcListAresnal) ctrlAddEventHandler ["LBDblClick", "[1] call WolvGarage_fnc_invAddItem"];
// Double clic pour créer le véhicule
