/*
* Author: Wolv
* Script permetant de faire spawn des vehicules a proximité de l'usine
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
		//spawn le vl
		_vl = _vlType createvehicle _pos;

		[_vl, 1] call BIS_fnc_initVehicle;

		//*
		//attend
		// sleep 1;

		//vide le vehicule
		clearWeaponCargoGlobal _vl;		//les armes
		clearMagazineCargoGlobal _vl;	//les chargeurs
		clearBackpackCargoGlobal _vl;	//les sac a dos
		clearItemCargoGlobal _vl;		//les items (FAK)

		//*
		//AT
		//for "_i" from 1 to 500 do {_vl addItem "rhs_weap_M136";};
		_vl addWeaponCargoGlobal ["rhs_weap_M136", 5];
		//*
		//chargeur
		_vl addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag", 30];
		_vl addMagazineCargoGlobal ["rhsusf_200Rnd_556x45_box", 5];
		//_vl addMagazineCargoGlobal ["rhsusf_100Rnd_762x51", 5];
		//_vl addMagazineCargoGlobal ["rhsusf_mag_17Rnd_9x19_JHP", 10];
		_vl addMagazineCargoGlobal ["rhs_mag_M433_HEDP", 15];

		//grenade
		_vl addItemCargoGlobal ["rhs_mag_m67", 10];
		_vl addItemCargoGlobal ["SmokeShell", 10];
		//_vl addItemCargoGlobal ["SmokeShellGreen", 5];

		//other
		//_vl addItemCargoGlobal ["ACE_CableTie", 5];
		_vl addItemCargoGlobal ["Toolkit", 1];
		_vl addItemCargoGlobal ["ACE_EntrenchingTool", 1];
		//_vl addItemCargoGlobal ["ACE_wirecutter", 1];
		//_vl addItemCargoGlobal ["ACE_EarPlugs", 3];
		//_vl addItemCargoGlobal ["ACE_DefusalKit", 1]; 
		//

		//aceMed 
		_vl addItemCargoGlobal ["ACE_elasticBandage", 30];
		_vl addItemCargoGlobal ["ACE_packingBandage", 30];
		_vl addItemCargoGlobal ["ACE_plasmaIV", 5];
		//_vl addItemCargoGlobal ["ACE_tourniquet", 10]; 

		//[_vl, 20] call ace_cargo_fnc_setSpace; //force la taille du cargo a 20 pour debug

		//caisse med dans l'inventaire Ace du vl
		["ACE_medicalSupplyCrate_advanced", _vl, 1] call ace_cargo_fnc_addCargoItem;

		//recupère le 1er element de l'inventaire
		private _inv = (_vl getVariable "ace_cargo_loaded") select 0;
		//systemChat str _inv;
		if (!isNil "_inv") then {
			if (_inv != "ACE_medicalSupplyCrate_advanced" ) then { // si pas caisse med
				//en rajoute dans l'inventaire Ace du vl (donc + de chaine ou de roue de secours)
				[_inv, _vl, 3] call ace_cargo_fnc_addCargoItem;
			};
		};
		//*/

		_index = lbAdd [IdcListVL, getText (configFile >> "CfgVehicles" >> (typeOf _vl) >> "displayName")];
		lbSetPicture [IdcListVL, _index, getText (configFile >> "CfgVehicles" >> _vlType >> "picture")];
		ListVL pushBack _vl;
	} 
	else {
		systemChat "Pas de position libre";
		//"Information" hintC "Pas de position libre";
	};
};