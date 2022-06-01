// Creation des partouille
pair = [
	["brf_o_ard_atr_rpg7","brf_o_ard_rifleman"],
	["brf_o_ard_machinegunner","brf_o_ard_machinegunner_asst"],
	["brf_o_agr_aa_specialist","brf_o_agr_aa_asst"]
];
publicVariable "pair";

// Creation des "FireTeam"
fireTeam = [		// BFR Ardistan
	["brf_o_ard_squadleader","brf_o_ard_radiooperator","brf_o_ard_medic","brf_o_ard_rifleman"],					// Commande
	["brf_o_ard_teamleader","brf_o_ard_grenadier","brf_o_ard_rifleman","brf_o_ard_rifleman"],					// GL
	["brf_o_ard_teamleader","brf_o_ard_atr_rpg7","brf_o_ard_rifleman","brf_o_ard_rifleman"],					// LAT - RPG 7
	["brf_o_ard_teamleader","brf_o_ard_lat","brf_o_ard_rifleman","brf_o_ard_rifleman"],							// LAT
	["brf_o_ard_teamleader","brf_o_ard_machinegunner","brf_o_ard_machinegunner_asst","brf_o_ard_rifleman"],		// MG
	["brf_o_ard_teamleader","brf_o_ard_rifleman","brf_o_ard_rifleman","brf_o_ard_rifleman"],					// Rifle 
	["brf_o_agr_squadleader","brf_o_agr_aa_specialist","brf_o_agr_aa_specialist","brf_o_agr_aa_asst"]			// AA
];
publicVariable "fireTeam";

// Creation des "Squad"
squad = [
	["brf_o_ard_squadleader","brf_o_ard_grenadier","brf_o_ard_rifleman","brf_o_ard_rifleman","brf_o_ard_teamleader","brf_o_ard_lat","brf_o_ard_rifleman","brf_o_ard_rifleman"],
		//GL
	["brf_o_ard_squadleader","brf_o_ard_grenadier","brf_o_ard_rifleman","brf_o_ard_rifleman","brf_o_ard_teamleader","brf_o_ard_lat","brf_o_ard_rifleman","brf_o_ard_rifleman"],
		//LAT - RPG 7
	["brf_o_ard_squadleader","brf_o_ard_machinegunner","brf_o_ard_machinegunner_asst","brf_o_ard_rifleman","brf_o_ard_teamleader","brf_o_ard_lat","brf_o_ard_rifleman","brf_o_ard_rifleman"],
		//MG
	["brf_o_ard_squadleader","brf_o_ard_rifleman","brf_o_ard_rifleman","brf_o_ard_marksman","brf_o_ard_teamleader","brf_o_ard_lat","brf_o_ard_rifleman","brf_o_ard_rifleman"],
		//MXM
	["brf_o_ard_squadleader","brf_o_ard_rifleman","brf_o_ard_rifleman","brf_o_ard_lat","brf_o_ard_teamleader","brf_o_ard_rifleman","brf_o_ard_rifleman","brf_o_ard_rifleman"]
		//Rifle
];
publicVariable "squad";

//Liste des Vehicule
Vehicule = [["brf_o_ard_btr70"],["brf_o_ard_btr70"],
	["brf_o_ard_brdm2_hq"],
	["brf_o_ard_brdm2_um"],
	["brf_o_ard_uaz_dshkm"],["brf_o_ard_uaz_dshkm"],
	["brf_o_ard_uaz"],["brf_o_ard_uaz_open"],
	["brf_o_ard_ural"]];//,["brf_o_ard_btr80"],["brf_o_ard_brdm2_um"],["brf_o_ard_brdm2"]];
publicVariable "Vehicule";

//Liste des HVT
HVT = [
	["O_Officer_Parade_F"],
	["O_Officer_Parade_Veteran_F"],
	["rhssaf_army_o_m10_para_officer"],
	["rhssaf_army_o_m93_oakleaf_summer_officer"],
	["brf_o_afm_commander"]
];
publicVariable "HVT";

