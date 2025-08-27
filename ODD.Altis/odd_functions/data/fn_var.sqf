/*
* Auteur : Wolv
* Fonction d'initialisation des variables globale.
*
* Arguments :
* 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODDdata_fnc_var
*
* Variable publique :
*/

if (isNil "ODD_var_FirstDefinition") then {
	ODD_var_FirstDefinition = True;
};

if (isNil "ODD_var_CivilianReputation") then {
	ODD_var_CivilianReputation = 50;
};

if (ODD_var_FirstDefinition) then {

	ODD_var_BuildingGood = [
		"land_Chapel_V1_F", "land_Chapel_V2_F", "land_Chapel_Small_V1_F", "land_Chapel_Small_V2_F", "land_Offices_01_V1_F",
		"land_WIP_F", "land_Airport_tower_F", "land_BagBunker_Large_F", "land_BagBunker_Small_F", "land_BagBunker_tower_F",
		"land_i_Barracks_V1_F", "land_i_Barracks_V1_dam_F", "land_i_Barracks_V2_F", "land_i_Barracks_V2_dam_F", "land_u_Barracks_V2_F",
		"land_Cargo_HQ_V1_F", "land_Cargo_HQ_V2_F", "land_Cargo_HQ_V3_F", "land_Cargo_Patrol_V1_F", "land_Cargo_Patrol_V2_F",
		"land_Cargo_Patrol_V3_F", "land_Cargo_tower_V1_F", "land_Cargo_tower_V1_No1_F", "land_Cargo_tower_V1_No2_F", "land_Cargo_tower_V1_No3_F",
		"land_Cargo_tower_V1_No4_F", "land_Cargo_tower_V1_No5_F", "land_Cargo_tower_V1_No6_F", "land_Cargo_tower_V1_No7_F", "land_Cargo_tower_V2_F",
		"land_Cargo_tower_V3_F", "land_Medevac_HQ_V1_F", "land_HBarriertower_F", "land_MilOffices_V1_F", "land_Research_house_V1_F",
		"land_Research_HQ_F", "land_GH_MainBuilding_entry_F", "land_GH_MainBuilding_left_F", "land_GH_MainBuilding_middle_F", "land_GH_MainBuilding_right_F",
		"land_Stadium_p4_F", "land_Stadium_p5_F", "land_Stadium_p9_F", "land_GuardHouse_01_F", "land_Cargo_HQ_V4_F",
		"land_Cargo_Patrol_V4_F", "land_Cargo_tower_V4_F", "land_BagBunker_01_large_green_F", "land_HBarrier_01_big_tower_green_F",
		"land_HBarrier_01_tower_green_F", "land_pillboxBunker_01_big_F", "land_pillboxBunker_01_hex_F", "land_pillboxBunker_01_rectangle_F", "land_Hospital_main_F",
		"land_Hospital_side1_F", "land_Hospital_side2_F", "land_BagBunker_01_small_green_F","land_Airport_02_terminal_F"
	];
	ODD_var_BuildingNormal = [
		"land_LightHouse_F", "land_i_House_Big_01_V1_F", "land_i_House_Big_01_V1_dam_F", "land_i_House_Big_01_V2_F", "land_i_House_Big_01_V2_dam_F",
		"land_i_House_Big_01_V3_F", "land_i_House_Big_01_V3_dam_F", "land_u_House_Big_01_V1_F", "land_u_House_Big_01_V1_dam_F", "land_i_House_Big_02_V1_F",
		"land_i_House_Big_02_V1_dam_F", "land_i_House_Big_02_V2_F", "land_i_House_Big_02_V2_dam_F", "land_i_House_Big_02_V3_F", "land_i_House_Big_02_V3_dam_F",
		"land_u_House_Big_02_V1_F", "land_u_House_Big_02_V1_dam_F", "land_i_Shop_01_V1_F", "land_i_Shop_01_V1_dam_F", "land_i_Shop_01_V2_F",
		"land_i_Shop_01_V2_dam_F", "land_i_Shop_01_V3_F", "land_i_Shop_01_V3_dam_F", "land_u_Shop_01_V1_F", "land_u_Shop_01_V1_dam_F",
		"land_i_Shop_02_V1_F", "land_i_Shop_02_V2_dam_F", "land_i_Shop_02_V3_F", "land_i_Shop_02_V3_dam_F", "land_i_Shop_02_V1_dam_F",
		"land_i_Shop_02_V2_F", "land_u_Shop_02_V1_F", "land_u_Shop_02_V1_dam_F", "land_i_House_Small_01_V1_F", "land_i_House_Small_01_V1_dam_F",
		"land_i_House_Small_01_V2_F", "land_i_House_Small_01_V2_dam_F", "land_i_House_Small_01_V3_F", "land_i_House_Small_01_V3_dam_F", "land_u_House_Small_01_V1_F",
		"land_u_House_Small_01_V1_dam_F", "land_u_House_Small_02_V1_F", "land_i_House_Small_02_V1_F", "land_i_House_Small_02_V1_F", "land_i_House_Small_02_V1_F",
		"land_i_House_Small_02_V2_F", "land_i_House_Small_02_V3_F", "land_i_House_Small_03_V1_F", "land_i_House_Small_03_V1_dam_F", "land_i_Stone_HouseBig_V1_F",
		"land_i_Stone_HouseBig_V1_dam_F", "land_i_Stone_HouseBig_V2_F", "land_i_Stone_HouseBig_V2_dam_F", "land_i_Stone_HouseBig_V3_F",
		"land_i_Stone_HouseBig_V3_dam_F", "land_i_Stone_Shed_V1_F", "land_i_Stone_Shed_V2_F", "land_i_Stone_HouseSmall_V1_F", "land_i_Stone_HouseSmall_V1_dam_F",
		"land_i_Stone_HouseSmall_V2_F", "land_i_Stone_HouseSmall_V2_dam_F", "land_i_Stone_HouseSmall_V3_F", "land_i_Stone_HouseSmall_V3_dam_F", "land_Unfinished_Building_01_F",
		"land_Unfinished_Building_02_F", "land_CarService_F", "land_dp_mainFactory_F", "land_Factory_Main_F", "land_i_Shed_ind_F",
		"land_i_Shed_ind_F", "land_Cargo_House_V1_F", "land_Cargo_House_V2_F", "land_Cargo_House_V3_F", "land_Medevac_house_V1_F",
		"land_dome_Big_F", "land_dome_Small_F", "land_BeachBooth_01_F", "land_GH_Gazebo_F", "land_GH_House_1_F",
		"land_GH_House_2_F", "land_Stadium_p2_F", "land_Stadium_p3_F", "land_Stadium_p6_F", "land_Stadium_p7_F",
		"land_Stadium_p1_F", "land_Stadium_p8_F", "land_House_Small_01_F", "land_House_Small_02_F", "land_House_Small_03_F",
		"land_House_Small_04_F", "land_House_Small_06_F", "land_School_01_F", "land_Addon_04_F", "land_fuelStation_01_shop_F",
		"land_Hotel_01_F", "land_Hotel_02_F", "land_Shop_town_01_F", "land_Shop_town_03_F", "land_Supermarket_01_F",
		"land_Warehouse_03_F", "land_SM_01_shed_F", "land_Airport_01_controltower_F", "land_Airport_02_controltower_F", "land_Airport_02_hangar_left_F",
		"land_Airport_02_hangar_right_F", "land_Barracks_01_camo_F", "land_Barracks_01_grey_F", "land_Barracks_01_dilapidated_F", "land_Cargo_House_V4_F"
	];
	ODD_var_BuildingBad = [
		"land_Castle_01_tower_F", "land_u_Addon_02_V1_F", "land_i_Addon_02_V1_F", "land_i_Addon_03_V1_F", "land_i_Addon_03mid_V1_F",
		"land_i_Addon_04_V1_F", "land_i_Garage_V1_F", "land_i_Garage_V1_dam_F", "land_i_Garage_V2_F", "land_i_Garage_V2_dam_F",
		"land_Metal_Shed_F", "land_d_House_Big_01_V1_F", "land_d_House_Big_02_V1_F", "land_d_Shop_01_V1_F", "land_d_Shop_02_V1_F",
		"land_d_House_Small_01_V1_F", "land_u_House_Small_02_V1_dam_F", "land_d_House_Small_02_V1_F", "land_i_House_Small_02_V1_dam_F", "land_i_House_Small_02_V2_dam_F",
		"land_i_House_Small_02_V3_dam_F", "land_cargo_house_slum_F", "land_Slum_House01_F", "land_Slum_House02_F", "land_Slum_House03_F",
		"land_d_Stone_HouseBig_V1_F", "land_i_Stone_Shed_V1_dam_F", "land_i_Stone_Shed_V3_F", "land_i_Stone_Shed_V3_dam_F", "land_d_Stone_Shed_V1_F",
		"land_d_Stone_HouseSmall_V1_F", "land_Airport_tower_dam_F", "land_Hangar_F", "land_fuelStation_Build_F", "land_Shed_Small_F",
		"land_u_Shed_ind_F", "land_spp_tower_F", "land_TtowerBig_1_F", "land_TtowerBig_2_F", "land_d_windmill01_F",
		"land_i_windmill01_F", "land_radar_Small_F", "CamoNet_blufor_F", "CamoNet_opfor_F", "CamoNet_inDP_F",
		"CamoNet_blufor_open_F", "CamoNet_opfor_open_F", "CamoNet_inDP_open_F", "CamoNet_blufor_big_F", "CamoNet_opfor_big_F",
		"CamoNet_inDP_big_F", "land_nav_pier_m_F", "land_pier_addon", "land_pier_Box_F", "land_pier_F",
		"land_pier_small_F", "land_pier_wall_F", "land_Lifeguardtower_01_F", "land_Kiosk_blueking_F", "land_Kiosk_gyros_F",
		"land_Kiosk_papers_F", "land_Kiosk_redburger_F", "land_GH_Platform_F", "land_GH_Stairs_F", "land_IRMaskingCover_01_F",
		"land_IRMaskingCover_02_F", "land_GarageShelter_01_F", "land_House_Big_01_F", "land_House_Big_02_F", "land_House_Big_03_F",
		"land_House_Big_04_F", "land_House_Big_05_F", "land_House_Native_01_F", "land_House_Native_02_F", "land_Shed_01_F",
		"land_Shed_02_F", "land_Shed_03_F", "land_Shed_04_F", "land_Shed_05_F", "land_Shed_07_F",
		"land_Slum_01_F", "land_Slum_02_F", "land_Slum_03_F", "land_fuelStation_01_workshop_F", "land_MetalShelter_01_F",
		"land_MetalShelter_02_F", "land_Shop_City_01_F", "land_Mausoleum_01_F", "land_Church_02_F", "land_fortress_01_5m_F",
		"land_fortress_01_10m_F", "land_fortress_01_innerCorner_70_F", "land_fortress_01_innerCorner_90_F", "land_fortress_01_innerCorner_110_F",
		"land_fortress_01_outterCorner_50_F", "land_fortress_01_outterCorner_80_F", "land_fortress_01_outterCorner_90_F", "land_Temple_Native_01_F", "land_DPP_01_mainFactory_F",
		"land_Warehouse_02_F", "land_SCF_01_clarifier_F", "land_SCF_01_generalBuilding_F", "land_SCF_01_chimney_F", "land_SCF_01_storageBin_big_F",
		"land_SCF_01_storageBin_medium_F", "land_SM_01_reservoirtower_F", "land_SM_01_shed_unfinished_F", "land_SM_01_shelter_narrow_F", "land_SM_01_shelter_wide_F",
		"land_Airport_01_hangar_F", "land_Airport_01_terminal_F", "CamoNet_ghex_F", "CamoNet_ghex_open_F", "CamoNet_ghex_big_F",
		"land_pierConcrete_01_4m_ladders_F", "land_pierConcrete_01_16m_F", "land_pierConcrete_01_30deg_F", "land_pierConcrete_01_end_F", "land_pierConcrete_01_steps_F",
		"land_pierWooden_01_10m_norails_F", "land_pierWooden_01_16m_F", "land_pierWooden_01_dock_F", "land_pierWooden_01_hut_F", "land_pierWooden_01_ladder_F",
		"land_pierWooden_01_platform_F", "land_pierWooden_02_16m_F", "land_pierWooden_02_30deg_F", "land_pierWooden_02_barrel_F", "land_pierWooden_02_hut_F",
		"land_pierWooden_02_ladder_F", "land_pierWooden_03_F", "land_BasaltWall_01_gate_F", "land_Castle_01_wall_01_F", "land_Castle_01_wall_02_F",
		"land_Castle_01_wall_03_F", "land_Castle_01_wall_04_F", "land_Castle_01_wall_05_F", "land_Castle_01_wall_06_F", "land_Castle_01_wall_07_F",
		"land_Castle_01_wall_08_F", "land_Castle_01_wall_09_F", "land_Castle_01_wall_10_F", "land_Castle_01_wall_11_F", "land_Castle_01_wall_12_F",
		"land_Castle_01_wall_13_F", "land_Castle_01_wall_14_F", "land_Castle_01_wall_15_F", "land_Castle_01_wall_16_F", "land_Castle_01_house_ruin_F",
		"land_Castle_01_church_a_ruin_F", "land_Castle_01_church_b_ruin_F", "land_Castle_01_church_ruin_F", "land_Castle_01_step_F",
		"land_i_Stone_Shed_V2_dam_F"
	];
	ODD_var_BuildingWeightGood = 0.8;
	ODD_var_BuildingWeightNormal = 0.5;
	ODD_var_BuildingWeightBad = 0.2;

	// Liste des maisons comptées
	ODD_var_Houses = ODD_var_BuildingGood + ODD_var_BuildingNormal + ODD_var_BuildingBad;

	// Liste des maisons à prioritariser pour les objectifs
	ODD_var_ObjectiveHouses = [
		"land_Chapel_V1_F", "land_Chapel_V2_F", "land_Chapel_Small_V1_F", "land_Chapel_Small_V2_F", "land_Offices_01_V1_F", "land_Castle_01_tower_F",
		"land_u_Addon_02_V1_F", "land_i_Addon_02_V1_F", "land_i_House_Big_01_V1_F", "land_i_House_Big_01_V1_dam_F", "land_i_House_Big_01_V2_F", "land_i_House_Big_01_V2_dam_F",
		"land_i_House_Big_01_V3_F", "land_i_House_Big_01_V3_dam_F", "land_u_House_Big_01_V1_F", "land_u_House_Big_01_V1_dam_F", "land_i_House_Big_02_V1_F",
		"land_i_House_Big_02_V1_dam_F", "land_i_House_Big_02_V2_F", "land_i_House_Big_02_V2_dam_F", "land_i_House_Big_02_V3_F", "land_i_House_Big_02_V3_dam_F",
		"land_u_House_Big_02_V1_F", "land_u_House_Big_02_V1_dam_F", "land_i_Shop_01_V1_F", "land_i_Shop_01_V1_dam_F", "land_i_Shop_01_V2_F", "land_i_Shop_01_V2_dam_F",
		"land_i_Shop_01_V3_F", "land_i_Shop_01_V3_dam_F", "land_u_Shop_01_V1_F", "land_u_Shop_01_V1_dam_F", "land_i_Shop_02_V1_F", "land_i_Shop_02_V1_dam_F",
		"land_i_Shop_02_V2_F", "land_i_Shop_02_V2_dam_F", "land_i_Shop_02_V3_F", "land_i_Shop_02_V3_dam_F", "land_u_Shop_02_V1_F", "land_u_Shop_02_V1_dam_F",
		"land_i_House_Small_01_V1_F", "land_i_House_Small_01_V1_dam_F", "land_i_House_Small_01_V2_F", "land_i_House_Small_01_V2_dam_F", 
		"land_i_House_Small_01_V3_F", "land_u_House_Small_01_V1_F", "land_i_House_Small_02_V1_F", "land_i_House_Small_02_V2_F", "land_i_House_Small_02_V3_F",
		"land_u_House_Small_02_V1_F", "land_i_House_Small_03_V1_F", "land_i_House_Small_03_V1_dam_F", "land_i_Stone_HouseBig_V1_F",
		"land_i_Stone_HouseBig_V1_dam_F", "land_i_Stone_HouseBig_V2_F", "land_i_Stone_HouseBig_V2_dam_F", "land_i_Stone_HouseBig_V3_F", "land_i_Stone_HouseBig_V3_dam_F",
		"land_i_Stone_Shed_V1_F", "land_i_Stone_Shed_V2_F", "land_i_Stone_Shed_V3_F", "land_i_Stone_HouseSmall_V1_F", "land_i_Stone_HouseSmall_V1_dam_F",
		"land_i_Stone_HouseSmall_V2_F", "land_i_Stone_HouseSmall_V2_dam_F", "land_i_Stone_HouseSmall_V3_F", "land_i_Stone_HouseSmall_V3_dam_F", "land_Airport_tower_F",
		"land_CarService_F", "land_Factory_Main_F", "land_fuelStation_Build_F", "land_i_Shed_ind_F", "land_spp_tower_F", "land_i_Barracks_V1_F", "land_i_Barracks_V1_dam_F",
		"land_i_Barracks_V2_F", "land_i_Barracks_V2_dam_F", "land_u_Barracks_V2_F", "land_Cargo_House_V1_F", "land_Cargo_House_V2_F", "land_Cargo_House_V3_F", "land_Cargo_HQ_V1_F",
		"land_Cargo_HQ_V2_F", "land_Cargo_HQ_V3_F", "land_Cargo_tower_V1_F", "land_Cargo_tower_V1_No1_F", "land_Cargo_tower_V1_No2_F", "land_Cargo_tower_V1_No3_F",
		"land_Cargo_tower_V1_No4_F", "land_Cargo_tower_V1_No5_F", "land_Cargo_tower_V1_No6_F", "land_Cargo_tower_V1_No7_F", "land_Cargo_tower_V2_F", "land_Cargo_tower_V3_F",
		"land_Medevac_house_V1_F", "land_Medevac_HQ_V1_F", "land_MilOffices_V1_F", "land_dome_Big_F", "land_dome_Small_F", "land_Research_house_V1_F", "land_Research_HQ_F",
		"land_Kiosk_blueking_F", "land_Kiosk_gyros_F", "land_Kiosk_papers_F", "land_Kiosk_redburger_F", "land_GH_Gazebo_F", "land_GH_House_1_F", "land_GH_House_2_F",
		"land_GH_MainBuilding_entry_F", "land_GH_MainBuilding_left_F", "land_GH_MainBuilding_middle_F", "land_GH_MainBuilding_right_F", "land_Stadium_p9_F",
		"land_GarageShelter_01_F", "land_House_Big_01_F", "land_House_Big_02_F", "land_House_Big_03_F", "land_House_Big_04_F", "land_House_Native_01_F", "land_House_Native_02_F",
		"land_House_Small_01_F", "land_House_Small_02_F", "land_House_Small_03_F", "land_House_Small_04_F", "land_House_Small_06_F", "land_School_01_F", "land_Slum_03_F",
		"land_Addon_04_F", "land_fuelStation_01_shop_F", "land_fuelStation_01_workshop_F", "land_Hotel_01_F", "land_Hotel_02_F", "land_Shop_City_01_F", "land_Shop_town_01_F",
		"land_Shop_town_03_F", "land_Supermarket_01_F", "land_Warehouse_03_F", "land_Temple_Native_01_F", "land_GuardHouse_01_F", "land_SM_01_shed_F", "land_Airport_01_controltower_F",
		"land_Airport_02_controltower_F", "land_Airport_02_terminal_F", "land_Barracks_01_camo_F", "land_Barracks_01_grey_F", "land_Barracks_01_dilapidated_F", "land_Cargo_House_V4_F",
		"land_Cargo_HQ_V4_F", "land_Cargo_tower_V4_F", "land_pillboxBunker_01_big_F", "land_pillboxBunker_01_hex_F", "land_pillboxBunker_01_rectangle_F", "land_Hospital_main_F",
		"land_Hospital_side1_F", "land_Hospital_side2_F" //*/
	];

	// Liste des civils
	ODD_var_Civilians = [["C_man_p_fugitive_F"], ["C_man_1"], ["C_Man_casual_1_F"], ["C_Man_casual_2_F"], ["C_Man_casual_3_F"], ["C_Man_casual_4_v2_F"], ["C_Man_casual_5_v2_F"],
		["C_Man_casual_6_v2_F"], ["C_Man_casual_7_F"], ["C_Man_casual_8_F"], ["C_Man_casual_9_F"], ["C_Man_casual_4_F"], ["C_Man_casual_5_F"], ["C_Man_casual_6_F"],
		["C_man_polo_1_F"], ["C_man_polo_2_F"], ["C_man_polo_3_F"], ["C_man_polo_4_F"], ["C_man_polo_5_F"], ["C_man_polo_6_F"], ["C_man_shorts_1_F"], ["C_man_1_1_F"],
		["C_man_1_2_F"], ["C_man_1_3_F"], ["C_Man_Fisherman_01_F"], ["C_man_hunter_1_F"], ["C_journalist_F"], ["C_Journalist_01_War_F"], ["C_Man_Messenger_01_F"], ["C_Man_paramedic_01_F"],
		["C_man_shorts_2_F"], ["C_man_shorts_3_F"], ["C_man_shorts_4_F"]
	];

	// Liste des véhicule civils
	ODD_var_CivilianVehicles = [["C_Hatchback_01_F"],
		["C_Hatchback_01_sport_F"],
		["C_Offroad_02_unarmed_F"],
		["C_Offroad_01_F"],
		["C_Offroad_01_covered_F"],
		["C_Offroad_01_repair_F"],
		["C_Tractor_01_F"],
		["C_SUV_01_F"],
		["C_Van_01_transport_F"],
		["C_Van_01_box_F"],
		["C_Van_02_transport_F"],
		["C_Van_02_vehicle_F"],
		["C_Van_02_service_F"],
		["C_Van_02_medevac_F"],
		["brf_c_afc_zil131_blue"],
		["brf_c_afc_zil131_orange"]
	];

	// Distance autour de la zone objectif qui est considérée comme zone de mission
	ODD_var_MissionAreaAvgSize = 4000;
	ODD_var_MissionAreaVarSize = 500;

	// Type de ponts
	ODD_var_BridgeType = ["Land_Bridge_Concrete_PathLod_F", "Land_Bridge_HighWay_PathLod_F", "Land_Bridge_Asphalt_PathLod_F", "Land_Bridge_01_PathLod_F"];

	// Liste des IEDs ruraux plaque de pression
	ODD_var_IEDExplosive = ["rhsusf_explosive_m112", "rhsusf_explosive_m112x4", "DemoCharge_F", "IEDLandBig_F", "IEDUrbanBig_F", "IEDLandSmall_F", "IEDUrbanSmall_F", "rhs_mine_ozm72_c", "rhssaf_tm200", "rhs_ec200_sand", "BombCluster_01_UXO3_F", "BombCluster_03_UXO3_F", "rhs_uxo_ao1_3", "rhs_uxo_ptab25m_3", "APERSMineDispenser_Mine_F", "ATMine", "ACE_SLAMBottomMine", "BombCluster_01_UXO4_F", "BombCluster_02_UXO4_F", "rhs_uxo_ptab1m_2", "rhs_uxo_ptab25ko_2", "rhs_uxo_ptab25m_2"];

	// Liste des IEDs urbains plaque de pression
	ODD_var_IEDCover = ["Land_PlasticNetFence_01_roll_F",
		"Land_WoodenCounter_01_F",
		// "Land_Rack_F",
		// "Land_ShelvesWooden_F",
		// "Land_ShelvesWooden_blue_F",
		// "Land_ShelvesWooden_khaki_F",
		// "Land_KartStand_01_F",
		// "Land_ToolTrolley_02_F",
		// "Land_ToolTrolley_01_F",
		// "Land_WeldingTrolley_01_F",
		// "Land_DieselGroundPowerUnit_01_F",
		// "Land_PressureWasher_01_F",
		"RoadCone_F",
		"Land_RoadCone_01_F",
		"RoadCone_L_F",
		"Land_CinderBlock_01_F",
		"Land_WheelCart_F",
		"Land_CzechHedgehog_01_new_F",
		"Land_CzechHedgehog_01_old_F",
		"Land_Fortress_01_bricks_v2_F",
		"Land_GarbageBin_02_F",
		"Land_Pillow_old_F",
		"PowerCable_01_Roll_F",
		"Land_PaperBox_01_small_destroyed_brown_IDAP_F",
		"Land_PaperBox_01_small_ransacked_brown_F",
		"Land_FoodSack_01_dmg_brown_F",
		"Land_FoodSack_01_empty_brown_idap_F",
		"Land_FoodSack_01_full_white_idap_F",
		"Land_GarbageHeap_02_F",
		"Land_Tyre_F",
		"Land_GarbageBin_01_F",
		"Land_GarbageBags_F",
		"Land_GarbageWashingMachine_F",
		"Tire_Van_02_F",
		"Land_Portable_generator_F",
		"Land_GarbagePallet_F",
		"Land_GarbageBin_03_F",
		"Land_GarbageContainer_closed_F",
		"Land_GarbageContainer_open_F",
		"Land_WheelieBin_01_F",
		"WaterPump_01_forest_F",
		"Land_WoodenCart_F",
		"Land_LiquidDispenser_01_F",
		"Land_Wreck_Skodovka_F",
		"Land_Wreck_CarDismantled_F",
		"Land_Wreck_Car2_F",
		"Land_Wreck_Car3_F",
		"Land_Wreck_Car_F",
		"Land_Wreck_Offroad_F",
		"Land_Wreck_UAZ_F",
		"Land_JunkPile_F",
		"Land_Tyres_F",
		"Tire_Van_02_Transport_F",
		"Tire_Van_02_Cargo_F",
		"Land_GarbageBarrel_01_F",
		"Land_GarbageBarrel_02_F",
		"Land_GarbageBarrel_02_buried_F",
		"Land_GarbageBarrel_01_english_F",
		"Land_GarbageHeap_03_F",
		"Land_GarbageHeap_04_F",
		"Land_GarbageHeap_01_F",
		"Land_WoodenShelter_01_ruins_F",
		"Land_WoodenBox_F",
		"Land_WoodenLog_F",
		"Land_CratesPlastic_F",
		"Land_CratesShabby_F",
		"Land_Bench_01_F",
		"Land_Bench_02_F",
		"Land_BarrelEmpty_F",
		"Land_BarrelEmpty_grey_F",
		"Land_BarrelTrash_F",
		"Land_BarrelWater_F",
		"Land_BarrelWater_grey_F",
		"Land_BarrelTrash_grey_F",
		"Land_Bucket_F",
		"Land_ChairPlastic_F",
		"Land_Pallet_F",
		"Land_Pallets_F"
	];
	
	{
		ODD_var_IEDCover pushBack (_x select 0);
	} forEach ODD_var_CivilianVehicles;

	// Liste des faux IEDs ruraux
	ODD_var_RemoteControlledStandartIED = ["IEDLandSmall_F", "IEDLandSmall_F", "IEDLandBig_F"];

	// Liste des faux IEDs urbains
	ODD_var_RemoteControlledUrbanIED = ["IEDUrbanSmall_F", "IEDUrbanSmall_F", "IEDUrbanBig_F"];

	// Defini les types de localité que l'on veut
	ODD_var_LocationType = ['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill'];
	ODD_var_LocationMilitaryName = ["Military", "military", "airbase", "airfield", "Ghost", "Blanches"];

	// Liste des localités en liste noire
	ODD_var_BlackistedLocation = [
		"", "Agela", "Skopos", "Kavala Pier", "Fournos", "Agios Minas", "Monisi", "Agios Kosmas", "Cape Makrinos", "Pyrgi", "Sagonisi", "Agios Panagiotis", "Savri", "Cape Drakontas", "Riga", "Spokos", "Amoni", "Amfissa", "Kira", "Bomos", "Synneforos", "Atsalis", "Thronos", "Cape Agrios", "Nychi", "Zeloran", "Cape Zefyris", "Agios Georgios", "Almyra", "Agios Andreas", "sideras", "Polemistia", "Skiptro", "Ochrolimni", "Chelonisi", "Didymos", "Mazi",
		"Dents du Midi", "Mont Chauve", "Pic de Feas", "Eperon", "Isaro", "Monte", "Le Roi"
	];

	// Liste des possibilités de renseignement
	ODD_var_IntelType = ["ObjectifPos", "VLCivilPos", "IEDPos", "CheckpointPos", "VLEnemiePos", "MedicalCratePos"];


	// Autorisation de nettoyage (debug)
	ODD_var_GoClear = True;

	// Liste des véhicules pouvant etre utilisé par les alliés
	ODD_var_BluforVehicles = ["B_APC_Tracked_01_AA_F", "B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_AFV_Wheeled_01_cannon_F", "B_AFV_Wheeled_01_up_cannon_F", "B_APC_Tracked_01_CRV_F", "B_MBT_01_mlrs_F",
	"B_MBT_01_arty_F", "B_Boat_Armed_01_minigun_F", "B_Heli_Light_01_dynamicLoadout_F", "B_Heli_Attack_01_dynamicLoadout_F", "B_Plane_CAS_01_dynamicLoadout_F", "B_Plane_Fighter_01_F", "B_Plane_Fighter_01_Stealth_F",
	"B_MBT_01_TUSK_F", "B_MBT_01_cannon_F", "B_T_APC_Tracked_01_AA_F", "B_T_APC_Wheeled_01_cannon_F", "B_T_APC_Tracked_01_rcws_F", "B_T_APC_Tracked_01_CRV_F", "B_T_AFV_Wheeled_01_cannon_F", "B_T_AFV_Wheeled_01_up_cannon_F",
	"B_T_MBT_01_mlrs_F", "B_T_MBT_01_arty_F", "B_T_Boat_Armed_01_minigun_F", "B_T_UAV_03_dynamicLoadout_F", "B_UAV_05_F", "B_UAV_02_dynamicLoadout_F", "B_T_VTOL_01_armed_F", "B_T_VTOL_01_infantry_F", "B_T_VTOL_01_vehicle_F",
	"B_T_MBT_01_TUSK_F", "B_T_MBT_01_cannon_F", "rhsusf_stryker_m1126_m2_d", "rhsusf_stryker_m1126_mk19_d", "rhsusf_stryker_m1127_m2_d", "rhsusf_stryker_m1132_m2_np_d", "rhsusf_stryker_m1132_m2_d", "rhsusf_stryker_m1134_d",
	"rhsusf_m109d_usarmy", "RHS_AH64D", "RHS_AH64DGrey", "RHS_M2A2", "RHS_M2A2_BUSKI", "RHS_M2A3", "RHS_M2A3_BUSKI", "RHS_M2A3_BUSKIII", "RHS_M6", "rhsusf_M1117_D", "rhsusf_M1117_O", "rhsusf_m1a1aimd_usarmy",
	"rhsusf_m1a1aim_tuski_d", "rhsusf_m1a2sep1d_usarmy", "rhsusf_m1a2sep1tuskid_usarmy", "rhsusf_m1a2sep1tuskiid_usarmy", "rhsusf_m1a2sep2d_usarmy", "rhsusf_stryker_m1126_m2_wd", "rhsusf_stryker_m1126_mk19_wd",
	"rhsusf_stryker_m1127_m2_wd", "rhsusf_stryker_m1132_m2_np_wd", "rhsusf_stryker_m1132_m2_wd", "rhsusf_stryker_m1134_wd", "rhsusf_m109_usarmy", "RHS_AH64D_wd", "RHS_M2A2_wd", "RHS_M2A2_BUSKI_WD", "RHS_M2A3_wd",
	"RHS_M2A3_BUSKI_wd", "RHS_M2A3_BUSKIII_wd", "RHS_M6_wd", "rhsusf_M1117_W", "rhsusf_m1a1aimwd_usarmy", "rhsusf_m1a1aim_tuski_wd", "rhsusf_m1a2sep1wd_usarmy", "rhsusf_m1a2sep1tuskiwd_usarmy", "rhsusf_m1a2sep1tuskiiwd_usarmy",
	"rhsusf_m1a2sep2wd_usarmy", "rhsusf_mkvsoc", "RHS_MELB_AH6M", "RHS_MELB_MH6M", "RHS_A10", "rhsusf_f22", "RHS_AH1Z", "RHS_UH1Y_FFAR_d", "RHS_UH1Y_d", "rhsusf_m1a1fep_d", "rhsusf_M142_usmc_WD", "RHS_AH1Z_wd",
	"RHS_UH1Y_FFAR", "RHS_UH1Y", "rhsusf_m1a1fep_wd", "rhsusf_m1a1fep_od", "rhsusf_m1a1hc_wd"];

	ODD_var_CratesTypes = [
		"ACE_medicalSupplyCrate_advanced",
		"ACE_medicalSupplyCrate_advanced",
		"ACE_medicalSupplyCrate_advanced",
		"ACE_medicalSupplyCrate",
		"ACE_medicalSupplyCrate",
		"ACE_medicalSupplyCrate",
		"Box_NATO_AmmoOrd_F",
		"Box_NATO_Grenades_F",
		"Box_NATO_Support_F"];

	// Liste des objets à supprimer à la fin de la mission 
	ODD_var_DeleteObjects = ["ACE_Track", "ACE_Wheel", "ACE_envelope_big", "GRAD_envelope_giant", "GRAD_envelope_long", "GRAD_envelope_short", "ACE_envelope_small", "GRAD_envelope_vehicle"];

	ODD_var_FactionNames = ["Ardistant", "BlackPond", "ChDKZ-Insurgents", "FIA", "Saf", "Tanoa Liberation army"];

	[] call ODDdata_fnc_varMissions;
	[] call ODDdata_fnc_varRoadBlock;
	[] call ODDdata_fnc_varOutpost;
	[] call ODDdata_fnc_varIntel;

	// server is debuger by default
	ODD_var_Debbuger = [2];

	ODD_var_FirstDefinition = False;

	ODD_var_ZonePad = [];
	ODD_var_Outposts = [];
	ODD_var_intel_interogation_data = createHashMap;

	// Liste des triggers
	ODD_var_Trigger = [];
};

// Liste des trigger pour enable/disable les IA dans les zones
ODD_var_AreaTrigger = [];

// Liste des AIs de la zone objectif
ODD_var_MainAreaIA = [];

// Liste des AIs dans les zones secondaires
ODD_var_SecondaryAreasIA = [];

// Liste des IEDs 
ODD_var_MissionIED = [];
ODD_var_MissionIEDTriggerMan = [];
ODD_var_MissionIEDTrigger = [];

// Liste des AIs en garnison
ODD_var_GarnisonnedIA = [];

// Liste des véhicule IA
ODD_var_IAVehicles = [];

// Liste des caisses med de la mission
ODD_var_Crates = [];

// Liste des civils de la mission
ODD_var_MissionCivilians = [];

// Liste des vehicules civil de la mission
ODD_var_MissionCivilianVehicles = [];

// Liste des props de la mission
ODD_var_MissionProps = [];

// Liste des positions des checkpoints
ODD_var_MissionCheckPoint = [];

// Liste des props de la missions en local
ODD_var_MissionSmokePillar = [];

// Liste des objectifs
ODD_var_Objective = [];

// Liste des objets cachés dans la missions
ODD_var_HiddenObjects = [];

// Liste des marquer d'intel
ODD_var_IntelMarker = [];

// Nom de la faction selectionner
ODD_var_SelectedFaction = "";

// semaphore pour le spawn de VL
// cf. fn_createVehiculeAtPos.sqf
ODD_var_vls_lock =  "Land_HelipadEmpty_F" createVehicle [0,0,0];
