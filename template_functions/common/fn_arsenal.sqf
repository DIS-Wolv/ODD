/*
* Add Virtual Arsenal to an object
*
* Arguments :
* 0: object
*
* Valeur renvoyée :
* nil
*
* Exemple:
* [random_obj] call DISCommon_fnc_arsenal

*/

params ["_obj"];

["AmmoboxInit", _obj] spawn BIS_fnc_arsenal;

_weapons = ["Binocular", "Laserdesignator", "rhs_weap_m240B", "rhs_weap_hk416d10", "rhs_weap_M107", "ACE_Vector", "rhsusf_weap_glock17g4", "rhs_weap_hk416d145", "rhs_weap_XM2010", "rhs_weap_M136", "R3F_FRF2", "rhs_weap_mk17_LB", "rhs_weap_m249_pip_S_para"];
_backpacks = ["KIT_BAG_Alpin_OD", "KIT_BAG_pince_OD", "TFAR_rt1523g_green", "KIT_BAG_od", "tfw_ilbe_whip_gr"];
_items = ["ACE_CableTie", "ACE_surgicalKit", "ACE_Tripod", "rhs_mag_20Rnd_SCAR_762x51_m80_ball", "ACE_packingBandage", "rhsusf_m112_mag", "rhs_mag_m67", "ACE_plasmaIV_500", "ACE_splint", "rhsusf_acc_M8541_mrds", "rhsusf_acc_harris_bipod", "ACE_EntrenchingTool", "Laserbatteries", "ACE_EarPlugs", "rhsusf_100Rnd_762x51", "rhsusf_5Rnd_300winmag_xm2010", "ACE_tourniquet", "ACE_10Rnd_127x99_AMAX_Mag", "ACE_bloodIV", "ACE_NVG_Wide", "ACE_Flashlight_XL50", "rhsusf_acc_ELCAN", "ACE_elasticBandage", "R3F_ITEM_DAGR", "ACE_bloodIV_500", "SmokeShellBlue", "SmokeShellGreen", "SmokeShell", "ACE_VMM3", "ToolKit", "ACE_SpraypaintGreen", "rhsusf_200Rnd_556x45_box", "ACE_DefusalKit", "ItemWatch", "ACE_epinephrine", "rhsusf_acc_ACOG_MDO", "ACE_MapTools", "ACE_Clacker", "rhsusf_mag_10Rnd_STD_50BMG_M33", "TFAR_anprc152", "rhsusf_acc_saw_bipod", "rhsusf_mag_17Rnd_9x19_JHP", "ACE_RangeCard", "rhsusf_acc_ACOG_RMR", "TFAR_anprc152_10", "R3F_ITEM_Brouilleur", "ACE_morphine", "ACE_Kestrel4500", "rhs_mag_30Rnd_556x45_M855A1_Stanag", "ItemMap", "ItemCompass"];
_vests = ["6094_HEAVY_od", "6094_RECON_od", "JPC_4_OD", "V_Rangemaster_belt", "6094_SCOUT_od", "6094_MEDIC_od"];
_uniforms = ["unif_PULL_CE", "unif_SWEAT_ce_impact", "fr_tshirt", "unif_SWEAT_ce_impact_L"];
_googles = ["rhsusf_oakley_goggles_blk"];
_head7 = ["calot_RHC", "Mohawk_Core_S_OD", "rhsusf_cvc_green_alt_helmet", "Mohawk_Core_MANTA_OD", "Mich2001_ess_od"];
_other_mags = ["Laserbatteries"];

_weapons_from_crates_lanceurs = ["rhs_weap_M136","rhs_weap_M136_hp","launch_MRAWS_green_F","rhs_weap_fgm148","rhs_weap_fim92","avm224_W_M224_mortar_carry"];
_ammo_from_crates_lanceurs = ["rhs_weap_M136","rhs_weap_M136_hp","launch_MRAWS_green_F","rhs_weap_fgm148","rhs_weap_fim92","avm224_W_M224_mortar_carry"];

_weapons_from_crates_weapons = ["rhs_weap_hk416d145","rhs_weap_hk416d10","rhs_weap_hk416d145_m320","rhs_weap_m249_pip_S_para","rhs_weap_m240B"];
_ammo_from_crates_weapons = ["rhsusf_acc_eotech_xps3","rhsusf_acc_g33_xps3","rhs_mag_m67","rhs_mag_mk84","SmokeShell","rhs_mag_M433_HEDP","rhs_mag_m714_White","ACE_EarPlugs","rhs_mag_m713_Red","rhs_mag_m714_White","rhsusf_100Rnd_762x51","rhsusf_200Rnd_556x45_box","rhs_mag_30Rnd_556x45_M855A1_Stanag","rhsusf_mag_17Rnd_9x19_JHP"];

_items_from_item_box = ["rhsusf_acc_nt4_black","rhsusf_acc_omega9k","rhsusf_acc_anpeq15side_bk","rhsusf_acc_wmx_bk","ACE_SpraypaintGreen","acc_flashlight_pistol","ACE_DefusalKit","ACE_M26_Clacker","ACE_Clacker","ACE_VMM3","R3F_ITEM_Brouilleur","DemoCharge_Remote_Mag","ClaymoreDirectionalMine_Remote_Mag","SatchelCharge_Remote_Mag","rhsusf_m112_mag","SmokeShellGreen","B_IR_Grenade","ACE_Chemlight_HiGreen","UGL_FlareCIR_F","ACE_NVG_Wide","ACE_EntrenchingTool","ACE_wirecutter","ACE_CableTie","ACE_MapTools","R3F_ITEM_ODP","B_UavTerminal","ACE_UAVBattery","Laserbatteries","ACE_Kestrel4500","ACE_Tripod","ACE_Vector","tfw_rf3080Item","tfw_ilbe_whip_gr","tfw_ilbe_whip_ocp"];

_paradrop_items = ["ACE_Altimeter"];
_paradrop_backpacks = ["B_Parachute"];

[ _obj, _weapons, false, true ] call BIS_fnc_addVirtualWeaponCargo;
[ _obj, _backpacks, false, true ] call BIS_fnc_addVirtualBackpackCargo;
[ _obj, _items, false, true ] call BIS_fnc_addVirtualItemCargo;
[ _obj, _vests, false, true ] call BIS_fnc_addVirtualItemCargo;
[ _obj, _uniforms, false, true ] call BIS_fnc_addVirtualItemCargo;
[ _obj, _googles, false, true ] call BIS_fnc_addVirtualItemCargo;
[ _obj, _head7, false, true ] call BIS_fnc_addVirtualItemCargo;
[ _obj, _other_mags, false, true ] call BIS_fnc_addVirtualItemCargo;
[ _obj, _weapons_from_crates_lanceurs, false, true ] call BIS_fnc_addVirtualWeaponCargo;
[ _obj, _ammo_from_crates_lanceurs, false, true ] call BIS_fnc_addVirtualItemCargo;
[ _obj, _weapons_from_crates_weapons, false, true ] call BIS_fnc_addVirtualWeaponCargo;
[ _obj, _ammo_from_crates_weapons, false, true ] call BIS_fnc_addVirtualItemCargo;
[ _obj, _items_from_item_box, false, true ] call BIS_fnc_addVirtualItemCargo;
[ _obj, _paradrop_backpacks, false, true ] call BIS_fnc_addVirtualBackpackCargo;
[ _obj, _paradrop_items, false, true ] call BIS_fnc_addVirtualItemCargo;