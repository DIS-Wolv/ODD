

_index = lbCurSel WolvGarage_var_IdcListVlUsine;
if (_index != -1) then { 
	_vlType = (WolvGarage_var_ListUsine select _index);
	_pos = WolvGarage_var_pos findEmptyPosition [5, 100, _vlType];

	if ((count _pos) != 0) then {
		// Crée le véhicule
		_vl = _vlType createvehicle _pos;

		clearWeaponCargoGlobal _vl;
		clearMagazineCargoGlobal _vl;
		clearBackpackCargoGlobal _vl;
		clearItemCargoGlobal _vl;
		//vide le véhicule

		_vl addWeaponCargoGlobal ["rhs_weap_M136", 5];
		// Ajoute des M136
		
		if (_vlType in WolvGarage_var_CratesList) then {
			_vl addItemCargoGlobal ["rhs_mag_m67", 50];
			_vl addItemCargoGlobal ["rhs_mag_mk84", 50];
			_vl addItemCargoGlobal ["SmokeShell", 50];
			_vl addItemCargoGlobal ["rhs_mag_M433_HEDP", 50];
			_vl addItemCargoGlobal ["rhs_mag_m714_White", 50];
			_vl addItemCargoGlobal ["rhs_mag_m713_Red", 10];
			_vl addItemCargoGlobal ["rhs_mag_m714_White", 10];
			_vl addMagazineCargoGlobal ["rhsusf_100Rnd_762x51", 50];
			_vl addMagazineCargoGlobal ["rhsusf_200Rnd_556x45_box", 50];
			_vl addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag", 150];
			_vl addMagazineCargoGlobal ["rhsusf_mag_17Rnd_9x19_JHP", 50];
			_vl addWeaponCargoGlobal ["rhs_weap_M136", 5];
			_vl addWeaponCargoGlobal ["rhs_weap_M136_hp", 5];
			_vl addMagazineCargoGlobal ["rhs_mag_maaws_HEAT", 10];
			_vl addMagazineCargoGlobal ["rhs_mag_maaws_HE", 10];
			_vl addMagazineCargoGlobal ["MRAWS_HE_F", 20];
			_vl addMagazineCargoGlobal ["rhs_fgm148_magazine_AT", 5];
			_vl addMagazineCargoGlobal ["rhs_fim92_mag", 5];
			_vl addItemCargoGlobal ["ACE_elasticBandage", 200];
			_vl addItemCargoGlobal ["ACE_packingBandage", 200];
		}
		else {
			_vl addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag", 30];
			_vl addMagazineCargoGlobal ["rhsusf_200Rnd_556x45_box", 5];
			//_vl addMagazineCargoGlobal ["rhsusf_100Rnd_762x51", 5];
			//_vl addMagazineCargoGlobal ["rhsusf_mag_17Rnd_9x19_JHP", 10];
			_vl addMagazineCargoGlobal ["rhs_mag_M433_HEDP", 15];
			// Ajoute des chargeurs

			_vl addItemCargoGlobal ["rhs_mag_m67", 10];
			_vl addItemCargoGlobal ["SmokeShell", 10];
			//_vl addItemCargoGlobal ["SmokeShellGreen", 5];
			// Ajoute des grenades

			//_vl addItemCargoGlobal ["ACE_CableTie", 5];
			_vl addItemCargoGlobal ["Toolkit", 1];
			_vl addItemCargoGlobal ["ACE_EntrenchingTool", 1];
			//_vl addItemCargoGlobal ["ACE_wirecutter", 1];
			//_vl addItemCargoGlobal ["ACE_EarPlugs", 3];
			//_vl addItemCargoGlobal ["ACE_DefusalKit", 1]; 
			// Ajoute des items

			_vl addItemCargoGlobal ["ACE_elasticBandage", 30];
			_vl addItemCargoGlobal ["ACE_packingBandage", 30];
			_vl addItemCargoGlobal ["ACE_plasmaIV", 5];
			//_vl addItemCargoGlobal ["ACE_tourniquet", 10]; 
			// Ajoute des items médicaux ACE
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

