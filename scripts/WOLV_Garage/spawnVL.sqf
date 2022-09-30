/*
* Auteur: Wolv
* Script pour créer des véhicules à proximité de l'usine
* 
* Return Value:
* nil
*
*/

_pos = position usine;
_index = lbCurSel IdcListSpawn;
if (_index != -1) then { 
	_vlType = (ListSpawn select _index);
	_pos = _pos findEmptyPosition [7, 100, _vlType];

	if ((count _pos) != 0) then {
		// Crée le véhicule
		_vl = _vlType createvehicle _pos;

		[_vl, 1] call BIS_fnc_initVehicle;

		clearWeaponCargoGlobal _vl;	
		clearMagazineCargoGlobal _vl; 
		clearBackpackCargoGlobal _vl; 
		clearItemCargoGlobal _vl; 
		//vide le véhicule

		_vl addWeaponCargoGlobal ["rhs_weap_M136", 5];
		// Ajoute des M136

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

		//[_vl, 20] call ace_cargo_fnc_setSpace; //force la taille du cargo a 20 pour debug

		["ACE_medicalSupplyCrate_advanced", _vl, 1] call ace_cargo_fnc_addCargoItem;
		// Ajoute une caisse medicale ACE dans l'inventaire ACE du véhicule

		private _inv = (_vl getVariable "ace_cargo_loaded") select 0;
		// Récupère le premier élément de l'inventaire ACE

		if (!isNil "_inv") then {
			if (_inv != "ACE_medicalSupplyCrate_advanced" ) then {
				[_inv, _vl, 3] call ace_cargo_fnc_addCargoItem;
			};
		// Ajoute une caisse médicale ACE s'il n'y en a pas
		};
	} 
	else {
		systemChat "Pas de position libre";
	};
};

call compile preprocessFile 'scripts\WOLV_garage\VLProx.sqf';
// Met à jour la liste des inventaires
