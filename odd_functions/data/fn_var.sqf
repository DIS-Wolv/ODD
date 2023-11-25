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
	// Liste des maisons comptées
	ODD_var_Houses = [
		"land_Chapel_V1_F", "land_Chapel_V2_F", "land_Chapel_Small_V1_F", "land_Chapel_Small_V2_F", "land_Offices_01_V1_F", "land_Castle_01_tower_F", "land_LightHouse_F",
		"land_WIP_F", "land_u_Addon_02_V1_F", "land_i_Addon_02_V1_F", "land_i_Addon_03_V1_F", "land_i_Addon_03mid_V1_F", "land_i_Addon_04_V1_F", "land_i_Garage_V1_F",
		"land_i_Garage_V1_dam_F", "land_i_Garage_V2_F", "land_i_Garage_V2_dam_F", "land_Metal_Shed_F", "land_i_House_Big_01_V1_F", "land_i_House_Big_01_V1_dam_F",
		"land_i_House_Big_01_V2_F", "land_i_House_Big_01_V2_dam_F", "land_i_House_Big_01_V3_F", "land_i_House_Big_01_V3_dam_F", "land_u_House_Big_01_V1_F",
		"land_u_House_Big_01_V1_dam_F", "land_d_House_Big_01_V1_F", "land_i_House_Big_02_V1_F", "land_i_House_Big_02_V1_dam_F", "land_i_House_Big_02_V2_F",
		"land_i_House_Big_02_V2_dam_F", "land_i_House_Big_02_V3_F", "land_i_House_Big_02_V3_dam_F", "land_u_House_Big_02_V1_F", "land_u_House_Big_02_V1_dam_F",
		"land_d_House_Big_02_V1_F", "land_i_Shop_01_V1_F", "land_i_Shop_01_V1_dam_F", "land_i_Shop_01_V2_F", "land_i_Shop_01_V2_dam_F", "land_i_Shop_01_V3_F",
		"land_i_Shop_01_V3_dam_F", "land_u_Shop_01_V1_F", "land_u_Shop_01_V1_dam_F", "land_d_Shop_01_V1_F", "land_i_Shop_02_V1_F", "land_i_Shop_02_V1_dam_F",
		"land_i_Shop_02_V2_F", "land_i_Shop_02_V2_dam_F", "land_i_Shop_02_V3_F", "land_i_Shop_02_V3_dam_F", "land_u_Shop_02_V1_F", "land_u_Shop_02_V1_dam_F",
		"land_d_Shop_02_V1_F", "land_i_House_Small_01_V1_F", "land_i_House_Small_01_V1_dam_F", "land_i_House_Small_01_V2_F", "land_i_House_Small_01_V2_dam_F",
		"land_i_House_Small_01_V3_F", "land_i_House_Small_01_V3_dam_F", "land_u_House_Small_01_V1_F", "land_u_House_Small_01_V1_dam_F", "land_d_House_Small_01_V1_F",
		"land_i_House_Small_02_V1_F", "land_i_House_Small_02_V1_dam_F", "land_i_House_Small_02_V2_F", "land_i_House_Small_02_V2_dam_F", "land_i_House_Small_02_V3_F",
		"land_i_House_Small_02_V3_dam_F", "land_u_House_Small_02_V1_F", "land_u_House_Small_02_V1_dam_F", "land_d_House_Small_02_V1_F", "land_i_House_Small_03_V1_F",
		"land_i_House_Small_03_V1_dam_F", "land_cargo_house_slum_F", "land_Slum_House01_F", "land_Slum_House02_F", "land_Slum_House03_F", "land_i_Stone_HouseBig_V1_F",
		"land_i_Stone_HouseBig_V1_dam_F", "land_i_Stone_HouseBig_V2_F", "land_i_Stone_HouseBig_V2_dam_F", "land_i_Stone_HouseBig_V3_F", "land_i_Stone_HouseBig_V3_dam_F",
		"land_d_Stone_HouseBig_V1_F", "land_i_Stone_Shed_V1_F", "land_i_Stone_Shed_V1_dam_F", "land_i_Stone_Shed_V2_F", "land_i_Stone_Shed_V2_dam_F", "land_i_Stone_Shed_V3_F",
		"land_i_Stone_Shed_V3_dam_F", "land_d_Stone_Shed_V1_F", "land_i_Stone_HouseSmall_V1_F", "land_i_Stone_HouseSmall_V1_dam_F", "land_i_Stone_HouseSmall_V2_F",
		"land_i_Stone_HouseSmall_V2_dam_F", "land_i_Stone_HouseSmall_V3_F", "land_i_Stone_HouseSmall_V3_dam_F", "land_d_Stone_HouseSmall_V1_F",
		"land_Unfinished_Building_01_F", "land_Unfinished_Building_02_F", "land_Airport_tower_F", "land_Airport_tower_dam_F", "land_Hangar_F", "land_CarService_F",
		"land_dp_mainFactory_F", "land_Factory_Main_F", "land_fuelStation_Build_F", "land_Shed_Small_F", "land_i_Shed_ind_F", "land_u_Shed_ind_F", "land_spp_tower_F",
		"land_TtowerBig_1_F", "land_TtowerBig_2_F", "land_d_windmill01_F", "land_i_windmill01_F", "land_BagBunker_Large_F", "land_BagBunker_Small_F", "land_BagBunker_tower_F",
		"land_i_Barracks_V1_F", "land_i_Barracks_V1_dam_F", "land_i_Barracks_V2_F", "land_i_Barracks_V2_dam_F", "land_u_Barracks_V2_F", "land_Cargo_House_V1_F",
		"land_Cargo_House_V2_F", "land_Cargo_House_V3_F", "land_Cargo_HQ_V1_F", "land_Cargo_HQ_V2_F", "land_Cargo_HQ_V3_F", "land_Cargo_Patrol_V1_F", "land_Cargo_Patrol_V2_F",
		"land_Cargo_Patrol_V3_F", "land_Cargo_tower_V1_F", "land_Cargo_tower_V1_No1_F", "land_Cargo_tower_V1_No2_F", "land_Cargo_tower_V1_No3_F", "land_Cargo_tower_V1_No4_F",
		"land_Cargo_tower_V1_No5_F", "land_Cargo_tower_V1_No6_F", "land_Cargo_tower_V1_No7_F", "land_Cargo_tower_V2_F", "land_Cargo_tower_V3_F", "land_Medevac_house_V1_F",
		"land_Medevac_HQ_V1_F", "land_HBarriertower_F", "land_MilOffices_V1_F", "land_radar_Small_F", "CamoNet_blufor_F", "CamoNet_opfor_F", "CamoNet_inDP_F",
		"CamoNet_blufor_open_F", "CamoNet_opfor_open_F", "CamoNet_inDP_open_F", "CamoNet_blufor_big_F", "CamoNet_opfor_big_F", "CamoNet_inDP_big_F", "land_nav_pier_m_F",
		"land_pier_addon", "land_pier_Box_F", "land_pier_F", "land_pier_small_F", "land_pier_wall_F", "land_dome_Big_F", "land_dome_Small_F", "land_Research_house_V1_F",
		"land_Research_HQ_F", "land_BeachBooth_01_F", "land_Lifeguardtower_01_F", "land_Kiosk_blueking_F", "land_Kiosk_gyros_F", "land_Kiosk_papers_F",
		"land_Kiosk_redburger_F", "land_GH_Gazebo_F", "land_GH_House_1_F", "land_GH_House_2_F", "land_GH_MainBuilding_entry_F", "land_GH_MainBuilding_left_F",
		"land_GH_MainBuilding_middle_F", "land_GH_MainBuilding_right_F", "land_GH_Platform_F", "land_GH_Stairs_F", "land_Stadium_p1_F", "land_Stadium_p2_F",
		"land_Stadium_p3_F", "land_Stadium_p4_F", "land_Stadium_p5_F", "land_Stadium_p6_F", "land_Stadium_p7_F", "land_Stadium_p8_F", "land_Stadium_p9_F",
		"land_IRMaskingCover_01_F", "land_IRMaskingCover_02_F", "land_GarageShelter_01_F", "land_House_Big_01_F", "land_House_Big_02_F", "land_House_Big_03_F",
		"land_House_Big_04_F", "land_House_Big_05_F", "land_House_Native_01_F", "land_House_Native_02_F", "land_House_Small_01_F", "land_House_Small_02_F",
		"land_House_Small_03_F", "land_House_Small_04_F", "land_House_Small_06_F", "land_School_01_F", "land_Shed_01_F", "land_Shed_02_F", "land_Shed_03_F",
		"land_Shed_04_F", "land_Shed_05_F", "land_Shed_07_F", "land_Slum_01_F", "land_Slum_02_F", "land_Slum_03_F", "land_Addon_04_F", "land_fuelStation_01_shop_F",
		"land_fuelStation_01_workshop_F", "land_Hotel_01_F", "land_Hotel_02_F", "land_MetalShelter_01_F", "land_MetalShelter_02_F", "land_Shop_City_01_F",
		"land_Shop_town_01_F", "land_Shop_town_03_F", "land_Supermarket_01_F", "land_Warehouse_03_F", "land_Mausoleum_01_F", "land_Church_02_F", "land_fortress_01_5m_F",
		"land_fortress_01_10m_F", "land_fortress_01_innerCorner_70_F", "land_fortress_01_innerCorner_90_F", "land_fortress_01_innerCorner_110_F",
		"land_fortress_01_outterCorner_50_F", "land_fortress_01_outterCorner_80_F", "land_fortress_01_outterCorner_90_F", "land_Temple_Native_01_F",
		"land_DPP_01_mainFactory_F", "land_GuardHouse_01_F", "land_Warehouse_02_F", "land_SCF_01_clarifier_F", "land_SCF_01_generalBuilding_F", "land_SCF_01_chimney_F",
		"land_SCF_01_storageBin_big_F", "land_SCF_01_storageBin_medium_F", "land_SM_01_reservoirtower_F", "land_SM_01_shed_F", "land_SM_01_shed_unfinished_F",
		"land_SM_01_shelter_narrow_F", "land_SM_01_shelter_wide_F", "land_Airport_01_controltower_F", "land_Airport_01_hangar_F", "land_Airport_01_terminal_F",
		"land_Airport_02_controltower_F", "land_Airport_02_hangar_left_F", "land_Airport_02_hangar_right_F", "land_Airport_02_terminal_F", "land_Barracks_01_camo_F",
		"land_Barracks_01_grey_F", "land_Barracks_01_dilapidated_F", "CamoNet_ghex_F", "CamoNet_ghex_open_F", "CamoNet_ghex_big_F", "land_Cargo_House_V4_F",
		"land_Cargo_HQ_V4_F", "land_Cargo_Patrol_V4_F", "land_Cargo_tower_V4_F", "land_BagBunker_01_large_green_F", "land_BagBunker_01_small_green_F",
		"land_HBarrier_01_big_tower_green_F", "land_HBarrier_01_tower_green_F", "land_pillboxBunker_01_big_F", "land_pillboxBunker_01_hex_F",
		"land_pillboxBunker_01_rectangle_F", "land_pierConcrete_01_4m_ladders_F", "land_pierConcrete_01_16m_F", "land_pierConcrete_01_30deg_F",
		"land_pierConcrete_01_end_F", "land_pierConcrete_01_steps_F", "land_pierWooden_01_10m_norails_F", "land_pierWooden_01_16m_F", "land_pierWooden_01_dock_F",
		"land_pierWooden_01_hut_F", "land_pierWooden_01_ladder_F", "land_pierWooden_01_platform_F", "land_pierWooden_02_16m_F", "land_pierWooden_02_30deg_F",
		"land_pierWooden_02_barrel_F", "land_pierWooden_02_hut_F", "land_pierWooden_02_ladder_F", "land_pierWooden_03_F", "land_BasaltWall_01_gate_F",
		"land_Castle_01_wall_01_F", "land_Castle_01_wall_02_F", "land_Castle_01_wall_03_F", "land_Castle_01_wall_04_F", "land_Castle_01_wall_05_F",
		"land_Castle_01_wall_06_F", "land_Castle_01_wall_07_F", "land_Castle_01_wall_08_F", "land_Castle_01_wall_09_F", "land_Castle_01_wall_10_F",
		"land_Castle_01_wall_11_F", "land_Castle_01_wall_12_F", "land_Castle_01_wall_13_F", "land_Castle_01_wall_14_F", "land_Castle_01_wall_15_F", "land_Castle_01_wall_16_F",
		"land_Castle_01_house_ruin_F", "land_Castle_01_church_a_ruin_F", "land_Castle_01_church_b_ruin_F", "land_Castle_01_church_ruin_F", "land_Castle_01_step_F",
		"land_Hospital_main_F", "land_Hospital_side1_F", "land_Hospital_side2_F"
	];

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
	ODD_var_MissionArea = 4000;

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

	// Liste des prisoniers
	ODD_var_Hostages = [["B_pilot_F"], ["B_Fighter_pilot_F"], ["B_helicrew_F"], ["B_Helipilot_F"]];

	// liste des vehicules objectif à sécuriser
	ODD_var_SercureVehicles = ["O_APC_Wheeled_02_rcws_v2_F", "O_MRAP_02_F", "O_Truck_03_device_F", "rhsgref_BRDM2UM_msv", "rhs_gaz66_r142_msv", "rhs_tigr_m_vdv", "I_MRAP_03_F"];

	// liste des vehicules objectif à détruire
	ODD_var_DestroyVehicles = ["rhsgref_ins_zsu234", "rhsgref_ins_BM21", "O_SAM_System_04_F", "RHS_BM21_MSV_01", "rhs_prp3_msv", "rhs_9k79", "rhs_D30_vdv", "I_Truck_02_MRL_F", "rhs_gaz66_r142_msv", "O_APC_Wheeled_02_rcws_v2_F", "O_MRAP_02_F", "I_MRAP_03_F", "rhs_bmp3mera_msv", "rhs_btr80_msv"];

	ODD_var_HumaVehicles = [ "C_IDAP_Truck_02_water_F", "B_Truck_01_box_F", "C_Truck_02_box_F"];

	ODD_var_HVTKill = [
		["brf_o_afm_commander"],
		["brf_o_afr_commander"],
		["brf_o_agr_commander"],
		["brf_o_ard_commander"],
		["brf_o_sra_commander"],
		["rhsgref_ins_squadleader"],
		["rhsgref_ins_commander"],
		["O_officer_F"],
		["O_A_soldier_F"],
		["O_G_officer_F"],
		["O_GEN_Commander_F"],
		["rhs_vdv_flora_officer"],
		["rhs_vdv_flora_officer_armored"],
		["rhs_vdv_recon_officer"],
		["rhssaf_army_o_m93_oakleaf_summer_officer"],
		["rhsgref_tla_squadleader"]
	];  // Liste des HVT à tuer

	ODD_var_HVTSecure = [
		["O_Officer_Parade_F"],
		["O_Officer_Parade_Veteran_F"],
		["brf_o_afm_commander"],
		["brf_o_afr_commander"],
		["brf_o_agr_commander"],
		["brf_o_ard_commander"],
		["brf_o_sra_commander"],
		["rhsgref_ins_squadleader"],
		["rhsgref_ins_commander"],
		["O_officer_F"],
		["O_A_soldier_F"],
		["O_G_officer_F"],
		["O_GEN_Commander_F"],
		["rhs_vdv_flora_officer"],
		["rhs_vdv_flora_officer_armored"],
		["rhs_vdv_recon_officer"],
		["rhssaf_army_o_m93_oakleaf_summer_officer"],
		["rhsgref_tla_squadleader"]
	];	// Liste des HVT securiser

	// Defini les différents objectifs possibles
	ODD_var_MissionType = ["Caisse", "Tuer un HVT", "Capturer un HVT", "Sécurisation de zone", "intel", "Helico", "Prisonniers", "Sécurisation de véhicule", "Destruction de véhicule", "Convoie Humanitaire"];
		// convoi hummanitaire, bombe, convoi à intercepter

	// Defini les différents objectifs secondaires possibles
	ODD_var_SecondaryMissionType = ["IED a déminer", "Vehicule volé"]; 
		// convoie hummanitaire ?(remplacé dans l'objectif principale par convoie mattériel ?)

	// Defini les types de localité que l'on veut
	ODD_var_LocationType = ['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill'];
	ODD_var_LocationMilitaryName = ["Military", "military", "airbase", "airfield", "Ghost", "Blanches"];

	// Liste des localités en liste noire
	ODD_var_BlackistedLocation = [
		"", "Kavala Pier", "Fournos", "Agios Minas", "Monisi", "Agios Kosmas", "Cape Makrinos", "Pyrgi", "Sagonisi", "Agios Panagiotis", "Savri", "Cape Drakontas", "Riga", "Spokos", "Amoni", "Amfissa", "Kira", "Bomos", "Synneforos", "Atsalis", "Thronos", "Cape Agrios", "Nychi", "Zeloran", "Cape Zefyris", "Agios Georgios", "Almyra", "Agios andreas", "sideras", "Polemistia", "Skiptro", "Ochrolimni", "Chelonisi", "Didymos", "Mazi",
		"Dents du Midi", "Mont Chauve", "Pic de Feas", "Eperon", "Isaro", "Monte", "Le Roi"
	];

	// Liste des possibilités de renseignement
	ODD_var_IntelType = ["ObjectifPos", "VLCivilPos", "IEDPos", "CheckpointPos", "VLEnemiePos", "MedicalCratePos"];

	// Liste des differentes possibilités de briefing
	ODD_var_MissionBriefDestroyCrate = [
		"Les forces ennemis dans la zone de %1 ont récemment reçu du matériel. Votre mission est de vous rendre sur place et de détruire leurs caisses de stockage.",
		"Du matériel compromettant a été localisé dans le secteur de %1. Vos ordres sont de détruire ces caisses par tous les moyens.",
		"Des caisses de munitions ennemi ont été vues dans la zone de %1. Leur destruction affaiblirait grandement les forces ennemies. Votre mission est simple : trouver les caisses et les détruire."
	];

	ODD_var_MissionBriefKillHVT = [
		"Un haut gradé nous a été signalé à proximité de %1. C'est pour nous une opportunité en or de désorganiser la chaine de commandement de l'ennemi.",
		"Le général %2 a été localisé près de %1. C'est pour nous une opportunité en or de désorganiser la chaine de commandement de l'ennemi. Votre missions : le neutraliser.",
		"Nous avons repéré un commandant des forces ennemies à proximité de %1. Notre mission est d'aller le neutraliser.",
		"Nous avons repéré un gradé ennemi à %1, vous devez l'intercepter et le neutraliser."
	];

	ODD_var_MissionBriefSecureHVT = [
		"Un officier a été localisé près de %1. Les informations en sa possession nous sont indispensables. Votre mission est de le capturer et de le ramener a la base.",
		"Le général %2 a été localisé près de %1. Les informations en sa possession nous sont indispensables. Votre mission est de le capturer et de le ramener a la base.",
		"Un haut gradé nous a été signalé à proximité de %1. C'est pour nous une opportunité en or de désorganiser la chaine de commandement de l'ennemi.",
		"Nous avons repéré un commandant des forces ennemies à proximité de %1. Notre mission est d'aller le capturer et de le ramener a la base.",
		"Nous avons repéré un gradé ennemi à %1, vous devez l'intercepter et l'extraire vers la fob pour que nous puissions l'interroger."
	];

	ODD_var_MissionBriefSecureArea = [
		"La région de %1 est de plus en plus instable. Vous devez vous rendre sur place et pacifier la zone en y neutralisant les forces armées présentes sur zone.",
		"La région de %1 est de plus en plus instable. Vous devez vous rendre sur place et pacifier la zone en neutralisant les forces armées présentes.",
		"Le gouverneur de %1 nous demande notre aide pour sécuriser son village qui est en proie à des raids d'une force armée. Rendez-vous sur place et nettoyez la zone."
	];

	ODD_var_MissionBriefSecureIntel = [
		"Des intel ont été repérés dans la région de %1, rendez-vous sur place et sécurisez-les.",
		"Les forces ennemies détiennent des informations importantes. Rendez vous dans la région de %1 et récupérez les.",
		"On a repéré un flux de données confidentiel émanant du secteur de %1. Votre mission est de sécuriser la zone et de récupérer les données."
	];

	ODD_var_MissionBriefBlackBoxes = [
		"Un hélicoptère allié s'est écrasé a proximité de la zone de %1. Rendez-vous sur place et recupérez les boîtes noires.",
		"Un hélicoptère allié s'est écrasé à proximité de la zone de %1. Rendez-vous sur place et recupérez les boîtes noires",
		"Notre pôle scientifique nous demande de récupérer les boîtes noires d’un hélicoptère qui a été abattu aux alentours de la zone %1."
	];

	ODD_var_MissionBriefSecureHostages = [
		"Un pilote allié a été capturé dans la zone de %1, votre mission est d’aller le chercher et de le ramener a la base.",
		"Un pilote allié a été capturé dans la zone de %1. Votre mission est d’aller le chercher et de le ramener à la base.",
		"Suite au crash d'un avion notre pilote a été capturé dans la zone %1. Veuillez le récupérer sain et sauf avant l’arrivée du 'Boucher' pour son interrogatoire."
	];

	ODD_var_MissionBriefSecureVehicle = [
		"Un véhicule ennemi comportant une technologie importante a été repéré à proximité de %1, allez le récupérer et ramener le à la FOB.",
		"Un véhicule ennemi comportant une technologie importante a été repéré à proximité de %1. Allez le récupérer et ramener le à la FOB",
		"Nos services secrets ont repéré qu’une technologie ultra confidentielle est en transit dans le véhicule se trouve en se moment dans la zone %1. Il est impératif de récupérer le véhicule et de le ramener en un seul morceau à la FOB"
	];

	ODD_var_MissionBriefDestroyVehicle = [
		"Un véhicule ennemi important a été repéré à proximité de %1, votre missions, allez le détruire.",
		"Un véhicule ennemi important a été repéré à proximité de %1. Votre mission : aller le détruire",
		"Les services secrets ont la certitude qu’un véhicule ennemi se trouvant dans la zone %1 contient une mallette de déclenchement nucléaire qu’il faut impérativement détruire avec le véhicule"
	];
	
	ODD_var_MissionBriefConvHuma = [
		"Du matériels humanitaire dois être livré dans la zone de %1, votre missions est de conduire le véhicule de la FOB, jusqu'à ça destination.",
		"Une organisation internationale nous demande d'apporter une cargaison humanitaire dans la zone de %1 pour subvenir aux besoins de la population et du centre de soins."
	];

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

	[] call ODDdata_fnc_varRoadBlock;
	[] call ODDdata_fnc_varOutpost;

	ODD_var_Debbuger = [];

	ODD_var_FirstDefinition = False;

	ODD_var_ZonePad = [];

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
