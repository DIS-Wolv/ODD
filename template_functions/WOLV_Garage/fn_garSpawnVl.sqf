

_index = lbCurSel WolvGarage_var_IdcListVlUsine;
if (_index != -1) then { 
	_vlType = (WolvGarage_var_ListUsine select _index);
	_pos = WolvGarage_var_pos findEmptyPosition [5, 100, _vlType];

	if ((count _pos) != 0) then {
		// Crée le véhicule
		_vl = _vlType createvehicle _pos;

		//vide le véhicule
		clearWeaponCargoGlobal _vl;
		clearMagazineCargoGlobal _vl;
		clearBackpackCargoGlobal _vl;
		clearItemCargoGlobal _vl;

		
		if (_vlType in WolvGarage_var_CratesList) then {
			{
				_vl addItemCargoGlobal [(_x select 0), (_x select 1)];
			}forEach WolvGarage_var_CrateLoad;
		}
		else {
			{
				_vl addItemCargoGlobal [(_x select 0), (_x select 1)];
			}forEach WolvGarage_var_VlLoad;

			_plate = ["DIS-"];
			_plate pushBack groupid (group player);
			_plate pushBack "-";
			for "_i" from 0 to 2 do {
				_plate pushBack (floor random 10);
			};
			_vl setPlateNumber ( _plate joinString "");
		};

		[_vl, 30] call ace_cargo_fnc_setSpace; //force la taille du cargo a 30

		["ACE_medicalSupplyCrate_advanced", _vl, 1] call ace_cargo_fnc_addCargoItem;
		// Ajoute une caisse medicale ACE dans l'inventaire ACE du véhicule

		private _inv = (_vl getVariable "ace_cargo_loaded") select 0;
		// Récupère le premier élément de l'inventaire ACE

		if (!isNil "_inv") then {
			if (_inv != "ACE_medicalSupplyCrate_advanced" ) then {
				[_inv, _vl, 3] call ace_cargo_fnc_addCargoItem;
			};
			// Ajoute 3 roues ou chenilles de rechange
		};
	} 
	else {
		systemChat "Pas de position libre";
	};
};

[] remoteexec ["WolvGarage_fnc_garUpdateVlProx", 0];

