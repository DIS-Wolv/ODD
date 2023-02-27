
params [["_obj", factory]];

WolvGarage_var_OBJ = _obj;
WolvGarage_var_IddDisplayGarage = 0310221;
WolvGarage_var_IddDisplayInv = 0310222;
WolvGarage_var_IddDisplayInvAce = 0310223;

WolvGarage_var_ListArsenalWeap = ["rhs_weap_M136", "rhs_weap_fgm148", "rhs_weap_fim92"];
WolvGarage_var_ListArsenalMag = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhsusf_200Rnd_556x45_box", "rhsusf_100Rnd_762x51", "rhsusf_mag_17Rnd_9x19_JHP", "rhs_mag_M433_HEDP", "rhs_mag_m67", "SmokeShell", "SmokeShellGreen", "rhs_fgm148_magazine_AT", "rhs_fim92_mag", "DemoCharge_Remote_Mag", "MRAWS_HE_F", "rhs_mag_maaws_HEAT", "rhs_mag_maaws_HE"];
WolvGarage_var_ListArsenalItem = ["ACE_Clacker", "ACE_elasticBandage", "ACE_packingBandage", "ACE_plasmaIV", "ACE_splint", "ACE_tourniquet", "ACE_CableTie", "Toolkit", "ACE_EntrenchingTool", "ACE_DefusalKit", "ACE_wirecutter", "ACE_EarPlugs"];
//Liste des élements dans l'arsenal

if(!isNil "ce") then {
	WolvGarage_var_ListUsine = ["rhsusf_m1165a1_gmv_m2_m240_socom_d", "rhsusf_m1025_w_m2", "rhsusf_m998_w_2dr_fulltop", "rhsusf_CGRCAT1A2_M2_usmc_wd", "rhsusf_M1230_M2_usarmy_wd", "rhsusf_stryker_m1126_m2_wd", "RHS_M2A3_BUSKIII_wd", "rhsusf_mrzr4_d", "B_Boat_Transport_01_F", "rhsgref_hidf_rhib", "RHS_MELB_MH6M", "RHS_MELB_AH6M", "RHS_UH60M_d", "RHS_UH60M_ESSS_d", "I_G_HMG_02_F", "I_G_HMG_02_high_F", "RHS_TOW_TriPod_D", "B_Mortar_01_F"];
} else {
	WolvGarage_var_ListUsine = ["rhsusf_m1165a1_gmv_m2_m240_socom_d", "rhsusf_m1025_d_m2", "rhsusf_m998_d_2dr_fulltop", "rhsusf_CGRCAT1A2_M2_usmc_d", "rhsusf_M1230_M2_usarmy_d", "rhsusf_stryker_m1126_m2_d", "RHS_M2A3_BUSKIII", "rhsusf_mrzr4_d", "B_Boat_Transport_01_F", "rhsgref_hidf_rhib", "RHS_MELB_MH6M", "RHS_MELB_AH6M", "RHS_UH60M", "RHS_UH60M_ESSS", "I_G_HMG_02_F", "I_G_HMG_02_high_F", "RHS_TOW_TriPod_D", "B_Mortar_01_F"];
};

WolvGarage_var_ItemAce = ["ACE_medicalSupplyCrate_advanced", "ACE_Wheel", "ACE_Track", "Box_NATO_AmmoVeh_F", "ACE_Box_82mm_Mo_HE", "ACE_Box_82mm_Mo_Combo"];
//Liste des élements dans l'arsenal ACE

WolvGarage_var_ListVL = [];

_obj addAction ["<t color='#5c7038'>Garage</t>", {call WolvGarage_fnc_garCreate},[],1.5,True,True,"", "True",5];


