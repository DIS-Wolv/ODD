/*
* Author: Wolv
* Script permetant d'ouvrir le GUI
* 
* Argument :
* Position de l'usine 
* 
* Return Value:
* nil
*
*/

params [["_pos", [0,0,0]]];

// definition des IDD et IDC en variable 
IddDisplay = 110822;
IdcListSpawn = 1500;
IdcListVL = 1501;
IdcListInv = 1503;
IdcListArs = 1502;
IdcBarreInv = 1900;

//definie la position
PosGarage = _pos;

// Liste des Vehicule que on peux faire spawn
if(!isNil "ce") then {
	ListSpawn = ["rhsusf_m1165a1_gmv_m2_m240_socom_d", "rhsusf_m1025_w_m2", "rhsusf_m998_w_2dr_fulltop", "rhsusf_CGRCAT1A2_M2_usmc_wd", "rhsusf_M1230_M2_usarmy_wd", "rhsusf_stryker_m1126_m2_wd", "RHS_M6_wd", "rhsusf_mrzr4_d", "B_Boat_Transport_01_F"];
} else {
	ListSpawn = ["rhsusf_m1165a1_gmv_m2_m240_socom_d", "rhsusf_m1025_d_m2", "rhsusf_m998_d_2dr_fulltop", "rhsusf_CGRCAT1A2_M2_usmc_d", "rhsusf_M1230_M2_usarmy_d", "rhsusf_stryker_m1126_m2_d", "RHS_M6", "rhsusf_mrzr4_d", "B_Boat_Transport_01_F"];
};
//Liste des élement dans l'arsenal
ListArsenalWeap = ["rhs_weap_M136","rhs_weap_fgm148","rhs_weap_fim92"];
ListArsenalMag = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhsusf_200Rnd_556x45_box", "rhsusf_100Rnd_762x51", "rhsusf_mag_17Rnd_9x19_JHP", "rhs_mag_M433_HEDP", "rhs_mag_m67", "SmokeShell", "SmokeShellGreen", "rhs_fgm148_magazine_AT", "rhs_fim92_mag", "DemoCharge_Remote_Mag"];
ListArsenalItem = ["ACE_Clacker", "ACE_elasticBandage", "ACE_packingBandage", "ACE_plasmaIV", "ACE_splint", "ACE_tourniquet", "ACE_CableTie", "Toolkit", "ACE_EntrenchingTool", "ACE_DefusalKit", "ACE_wirecutter", "ACE_EarPlugs"];

private _isCreate = False;

// Creation de la fenetre
_isCreate = createDialog "GUIgarage";

//si la fenetre est créé
if (_isCreate) then {
	// Ajoute les Vehicule a la list de spawn
	{
		lbAdd [IdcListSpawn, getText (configFile >> "CfgVehicles" >> _x >> "displayName")];
		lbSetPicture [IdcListSpawn, _foreachindex, getText (configFile >> "CfgVehicles" >> _x >> "picture")]
	} forEach ListSpawn;
	
	// met a jour la liste des vl proche
	call compile preprocessFile 'scripts\WOLV_garage\VLProx.sqf';
	
	// ajoute les élement a la liste de l'arsenal
	{
		lbAdd [IdcListArs, getText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	} forEach ListArsenalWeap;
	{
		lbAdd [IdcListArs, getText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	} forEach ListArsenalMag;
	{
		lbAdd [IdcListArs, getText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	} forEach ListArsenalItem; 

};

// Ajoute les eventHandler
((findDisplay IddDisplay) displayCtrl IdcListSpawn) ctrlSetEventHandler ["LBDblClick", "execVM 'scripts\WOLV_garage\spawnVL.sqf'"];		// double click pour spawn le vl
((findDisplay IddDisplay) displayCtrl IdcListArs) ctrlSetEventHandler ["LBDblClick", "[1] execVM 'scripts\WOLV_garage\AddItem.sqf'"];		// double click pour Ajouté un item
((findDisplay IddDisplay) displayCtrl IdcListInv) ctrlSetEventHandler ["LBDblClick", "[1] execVM 'scripts\WOLV_garage\RemoveItem.sqf'"];	// double click pour retiré un item
((findDisplay IddDisplay) displayCtrl IdcListVL) ctrlSetEventHandler ["LBSelChanged","execVM 'scripts\WOLV_garage\Inventaire.sqf';"];		// lorsque la liste des vl a proximité update la liste inventaire 

