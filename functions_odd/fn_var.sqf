/*
* Author: Wolv
* Fonction d'initialisation des variables globale.
*
* Arguments:
* 
*
* Return Value:
* nil
*
* Example:
* [] call WOLV_fnc_var
*
* Public:
*/

// array des maison whitelist
Maison = [
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
publicVariable "Maison";

// liste des civils
Civils = [["C_man_p_fugitive_F"], ["C_man_1"], ["C_Man_casual_1_F"], ["C_Man_casual_2_F"], ["C_Man_casual_3_F"], ["C_Man_casual_4_v2_F"], ["C_Man_casual_5_v2_F"],
    ["C_Man_casual_6_v2_F"], ["C_Man_casual_7_F"], ["C_Man_casual_8_F"], ["C_Man_casual_9_F"], ["C_Man_casual_4_F"], ["C_Man_casual_5_F"], ["C_Man_casual_6_F"],
    ["C_man_polo_1_F"], ["C_man_polo_2_F"], ["C_man_polo_3_F"], ["C_man_polo_4_F"], ["C_man_polo_5_F"], ["C_man_polo_6_F"], ["C_man_shorts_1_F"], ["C_man_1_1_F"],
    ["C_man_1_2_F"], ["C_man_1_3_F"], ["C_Man_Fisherman_01_F"], ["C_man_hunter_1_F"], ["C_journalist_F"], ["C_Journalist_01_War_F"], ["C_Man_Messenger_01_F"], ["C_Man_paramedic_01_F"],
    ["C_man_shorts_2_F"], ["C_man_shorts_3_F"], ["C_man_shorts_4_F"]
];
publicVariable "Civils";

// Vehicule civil
CivilsVL = ["C_Hatchback_01_F",
    "C_Hatchback_01_sport_F",
    "C_Offroad_02_unarmed_F",
    "C_Offroad_01_F",
    "C_Offroad_01_covered_F",
    "C_Offroad_01_repair_F",
    "C_Tractor_01_F",
    "C_SUV_01_F",
    "C_Van_01_transport_F",
    "C_Van_01_box_F",
    "C_Van_02_transport_F",
    "C_Van_02_vehicle_F",
    "C_Van_02_service_F",
    "C_Van_02_medevac_F",
    "brf_c_afc_zil131_blue",
    "brf_c_afc_zil131_orange"
];
publicVariable "CivilsVL";

// liste des prisonier
Otage = [["B_pilot_F"], ["B_Fighter_pilot_F"], ["B_helicrew_F"], ["B_Helipilot_F"]];
publicVariable "Otage";

// liste des vehicule Objectif
tgVehicule = [
    "rhsgref_ins_gaz66_r142", "rhs_gaz66_r142_vdv", "rhsgref_cdf_b_gaz66_r142", "rhsgref_cdf_gaz66_r142", "rhs_tigr_msv", "rhs_tigr_3camo_msv", "rhs_tigr_m_msv", "rhs_tigr_m_3camo_msv"
];
publicVariable "tgVehicule";

// array des ia de la mission
MissionIA = [];
publicVariable "MissionIA";

// array des ia en ZO+
ZopiA = [];
publicVariable "ZopiA";

// array des ia en garnison
GarnisonIA = [];
publicVariable "GarnisonIA";

// array des civil de la mission
MissionCivil = [];
publicVariable "MissionCivil";

// array des props de la mission
MissionProps = [];
publicVariable "MissionProps";

// array des props de la missions en local
MissionPropslocal = [nil, nil];
publicVariable "MissionPropslocal";

// liste de/des objectif(s)
Objectif = [];
publicVariable "Objectif";

// Definie les diff??rent objectif possible
TargettypeName = ["Caisse", "HVT", "Secure Area", "intel", "Helico", "Prisoniers", "Vehicule"];
	// (convoi hummanitaire, bombe, convoi ?? intercepter)
publicVariable "TargettypeName";

// Definie les type de location que on veux
locationtype = ['nameCityCapital', 'nameCity', 'nameVillage', 'name', 'namelocal', 'Hill'];
publicVariable "locationtype";
locationBlklist = ["", "Kavala pier", "Fournos", "Neochori", "Monisi", "Agios Kosmas", "Cape Makrinos", "Pyrgi", "Sagonisi", "Agios Panagiotis", "Savri", "Cape Drakontas", "Riga", "Spokos", "Amoni", "Amfissa", "Kira", "Bomos", "Synneforos", "Atsalis", "Thronos", "Cape Agrios", "Nychi", "Zeloran", "Cape Zefyris", "Agios Georgios", "Almyra", "Agios andreas", "sideras", "Polemistia", "Skiptro", "Ochrolimni", "Chelonisi", "Didymos", "Mazi"];
publicVariable "locationBlklist";//deBlackListe Neochori ? et autre ?

// array de differente possibilit?? de texte
textCaisse = [
    "Les forces ennemis dans la zone de %1 ont r??cemment re??u du mat??riel. Votre mission est de vous rendre sur place et de d??truire leurs caisses de stockage."
];
publicVariable "textCaisse";
textHVT = [
	"Un haut grad?? nous a ??t?? signal?? ?? proximit?? de %1. C'est pour nous une opportunit?? en or de d??sorganiser la chaine de commandement de l'ennemi.",
    "Nous avons rep??r?? un commandant des forces ennemies ?? proximit?? de %1. Notre mission est d'aller le capturer ou le neutraliser."
];
publicVariable "textHVT";
textSecure = [
    "La r??gion de %1 est de plus en plus instable. Vous devez vous rendre sur place et pacifier la zone en y neutralisant les forces arm??es pr??sentes sur zone."
];
publicVariable "textSecure";
textIntel = [
    "Des intel ont ??t?? rep??r??s dans la r??gion de %1, rendez-vous sur place et s??curisez-les.",
    "Les forces ennemies d??tiennent des informations importantes. Rendez vous dans la r??gion de %1 et r??cup??rez les."
];
publicVariable "textIntel";
textHelico = [
    "Un h??licopt??re alli?? s'est ??cras?? a proximit?? de la zone de %1. Rendez-vous sur place et recup??rez les bo??tes noires."
];
publicVariable "textHelico";
textPrisoniers = [
    "Un pilote alli?? a ??t?? captur?? dans la zone de %1, votre mission est d???aller le chercher et de le ramener a la base."
];
publicVariable "textPrisoniers";
textVL = [
    "Un v??hicule ennemi comportant une technologie importante a ??t?? rep??r?? ?? proximit?? de %1, allez le r??cup??rer et ramener le ?? la FOB."
];
publicVariable "textVL";

ObjetHIDE = [];
publicVariable "ObjetHIDE";

goClear = true;
publicVariable "goClear";

[] call WOLV_fnc_varRoadBlock;
[] call WOLV_fnc_varEneArd;
