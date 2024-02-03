/*
* Auteur: Wolv
* Function pour crée un garage
* 
* Return Value:
* nil
*
*/

params [["_obj", factory]];

WolvGarage_var_OBJ = _obj;
WolvGarage_var_Range = 100;
WolvGarage_var_IddDisplayGarage = 0310221;
WolvGarage_var_IddDisplayInv = 0310222;
WolvGarage_var_IddDisplayInvAce = 0310223;

//Liste des élements dans l'arsenal
WolvGarage_var_ListArsenal = ["30Rnd_556x45_Stanag_red", "rhsusf_200Rnd_556x45_box", "rhsusf_100Rnd_762x51", "rhs_mag_20Rnd_SCAR_762x51_m80_ball", "rhs_mag_M433_HEDP", "rhsusf_mag_17Rnd_9x19_JHP", "rhsusf_mag_40Rnd_46x30_FMJ", "rhs_weap_M136", "rhs_weap_M136_hp", "rhs_mag_maaws_HEAT", "rhs_mag_maaws_HE", "MRAWS_HE_F", "rhs_weap_fgm148", "rhs_fgm148_magazine_AT", "R3F_ERYX", "R3F_ERYX_mag", "rhs_weap_fim92", "rhs_fim92_mag", "R3F_MMP_STATIC_Bag", "R3F_MMP_STATIC_Bag_support", "rhs_mag_m67", "rhs_mag_mk84", "SmokeShell", "SmokeShellBlue", "SmokeShellGreen", "rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m714_White", "rhs_mag_m713_Red", "rhsusf_falconii_mc", "ACE_elasticBandage", "ACE_packingBandage", "ACE_plasmaIV", "ACE_plasmaIV_500", "ACE_tourniquet", "ACE_morphine", "ACE_epinephrine", "ACE_splint", "ACE_CableTie", "ACE_Clacker", "ACE_M26_Clacker", "rhsusf_m112_mag", "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag", "ClaymoreDirectionalMine_Remote_Mag", "avm224_W_M224_mortar_carry", "avm224_M_6Rnd_60mm_HE_0_csw", "avm224_M_6Rnd_60mm_HE_csw", "ACE_Chemlight_HiGreen", "ACE_DefusalKit", "R3F_ITEM_Brouilleur", "ToolKit", "ACE_EntrenchingTool", "acex_intelitems_notepad", "ACE_EarPlugs", "ACE_SpraypaintGreen", "ACE_SpraypaintRed", "ACE_SpraypaintBlue", "ACE_wirecutter", "ACE_UAVBattery", "ACE_Kestrel4500", "ACE_Tripod", "ACE_Vector", "B_IR_Grenade", "UGL_FlareCIR_F", "Laserbatteries", "ACE_Altimeter"];

WolvGarage_var_CrateLoad = [["rhs_mag_m67", 50],["rhs_mag_mk84", 50],["SmokeShell", 50],["rhs_mag_M433_HEDP", 50],["rhs_mag_m714_White", 20],["rhs_mag_m713_Red", 10],["rhsusf_100Rnd_762x51", 50],["rhsusf_200Rnd_556x45_box", 50],["30Rnd_556x45_Stanag_red", 150],["rhsusf_mag_17Rnd_9x19_JHP", 50],["rhs_weap_M136", 5],["rhs_weap_M136_hp", 5],["rhs_mag_maaws_HEAT", 10],["rhs_mag_maaws_HE", 10],["R3F_ERYX_mag", 10],["MRAWS_HE_F", 20],["rhs_fgm148_magazine_AT", 5],["rhs_fim92_mag", 5],["ACE_elasticBandage", 200],["ACE_packingBandage", 200]];
WolvGarage_var_VlLoad = [["rhs_weap_M136", 5],["30Rnd_556x45_Stanag_red", 30],["rhsusf_200Rnd_556x45_box", 5],["rhs_mag_M433_HEDP", 15],["rhs_mag_m67", 10],["SmokeShell", 10],["Toolkit", 1],["ACE_EntrenchingTool", 1],["ACE_elasticBandage", 30],["ACE_packingBandage", 30],["ACE_plasmaIV", 5]];

if(!isNil "ce") then {
    // VL Camo CE
	WolvGarage_var_ListUsine = ["rhsusf_m1165a1_gmv_m2_m240_socom_d", "R3F_PLFS_A", "rhsusf_m1025_w_m2", "rhsusf_m998_w_2dr_fulltop", "R3F_VBMR_TOP_127", "R3F_VBMR_TOP_127_LOURD", "rhsusf_CGRCAT1A2_M2_usmc_wd", "rhsusf_M1230_M2_usarmy_wd", "rhsusf_stryker_m1127_m2_wd", "rhsusf_stryker_m1126_m2_wd", "RHS_M2A3_BUSKIII_wd", "rhsusf_mrzr4_d", "B_Boat_Transport_01_F", "rhsgref_hidf_rhib", "RHS_MELB_MH6M", "RHS_MELB_AH6M", "RHS_UH60M_d", "RHS_UH60M_ESSS_d", "R3F_TIGRE", "I_G_HMG_02_F", "I_G_HMG_02_high_F", "R3F_MMP_STATIC", "RHS_TOW_TriPod_D", "B_Mortar_01_F", "B_CargoNet_01_ammo_F"];
} else {
    // VL Camo Desert
	WolvGarage_var_ListUsine = ["rhsusf_m1165a1_gmv_m2_m240_socom_d", "R3F_PLFS_A", "rhsusf_m1025_d_m2", "rhsusf_m998_d_2dr_fulltop", "R3F_VBMR_TDF_TOP_127", "R3F_VBMR_TDF_TOP_127_LOURD", "rhsusf_CGRCAT1A2_M2_usmc_d", "rhsusf_M1230_M2_usarmy_d", "rhsusf_stryker_m1127_m2_d", "rhsusf_stryker_m1126_m2_d", "RHS_M2A3_BUSKIII", "rhsusf_mrzr4_d", "B_Boat_Transport_01_F", "rhsgref_hidf_rhib", "RHS_MELB_MH6M", "RHS_MELB_AH6M", "RHS_UH60M", "RHS_UH60M_ESSS", "R3F_TIGRE", "I_G_HMG_02_F", "I_G_HMG_02_high_F", "R3F_MMP_STATIC", "RHS_TOW_TriPod_D", "B_Mortar_01_F", "B_CargoNet_01_ammo_F"];
};
WolvGarage_var_CratesList = ["B_CargoNet_01_ammo_F"];

WolvGarage_var_ItemAce = ["ACE_medicalSupplyCrate_advanced", "ACE_Wheel", "ACE_Track", "Box_NATO_AmmoVeh_F", "ACE_Box_82mm_Mo_HE", "ACE_Box_82mm_Mo_Combo"];
//Liste des élements dans l'arsenal ACE

WolvGarage_var_ListVL = [];

_obj addAction ["<t color='#5c7038'>Garage</t>", {call WolvGarage_fnc_garCreate},[],1.5,True,True,"", "True",5];

private _radGar = WolvGarage_var_Range; // raduis du garrage

private _garTrigger = createTrigger ["EmptyDetector", WolvGarage_var_OBJ];  //crée le trigger
_garTrigger setTriggerArea [_radGar, _radGar, 0, false];        //definie la taille
_garTrigger setTriggerActivation ["VEHICLE", "PRESENT", true];  //activation a la présence d'un vl
_garTrigger setTriggerStatements ["this", 
    "[] remoteexec ['WolvGarage_fnc_garUpdateVlProx', 0];",
    "[] remoteexec ['WolvGarage_fnc_garUpdateVlProx', 0];"];

WolvGarage_var_OBJ setVariable ["_var_updateTrigger", _garTrigger, True];
