/*
* Author: Wolv
* Fonction d'initialisation des variables globale des Enemie, ici faction Ardistan.
*
* Arguments:
* 
*
* Return Value:
* nil
*
* Example:
* [] call ODD_fnc_varEne
*
* Public:
*/
// Creation des partouille
ODD_var_pair = [
	["brf_o_ard_atr_rpg7","brf_o_ard_rifleman"],
	["brf_o_ard_machinegunner","brf_o_ard_machinegunner_asst"],
	["brf_o_ard_aa_specialist","brf_o_ard_aa_asst"]
];
publicVariable "ODD_var_pair";

// Creation des "ODD_var_fireTeam"
ODD_var_fireTeam = [		// BFR Ardistan
	["brf_o_ard_squadleader","brf_o_ard_radiooperator","brf_o_ard_medic","brf_o_ard_rifleman"],					// Commande
	["brf_o_ard_teamleader","brf_o_ard_grenadier","brf_o_ard_rifleman","brf_o_ard_rifleman"],					// GL
	["brf_o_ard_teamleader","brf_o_ard_atr_rpg7","brf_o_ard_rifleman","brf_o_ard_rifleman"],					// LAT - RPG 7
	["brf_o_ard_teamleader","brf_o_ard_lat","brf_o_ard_rifleman","brf_o_ard_rifleman"],							// LAT
	["brf_o_ard_teamleader","brf_o_ard_machinegunner","brf_o_ard_machinegunner_asst","brf_o_ard_rifleman"],		// MG
	["brf_o_ard_teamleader","brf_o_ard_rifleman","brf_o_ard_lat","brf_o_ard_rifleman"],							// LAT 
	["brf_o_ard_squadleader","brf_o_ard_aa_specialist","brf_o_ard_aa_specialist","brf_o_ard_aa_asst"]			// AA
];
publicVariable "ODD_var_fireTeam";

// Creation des "ODD_var_squad"
ODD_var_squad = [
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
publicVariable "ODD_var_squad";

//Liste des Vehicule
ODD_var_Vehicule = [
	["brf_o_ard_btr70"],["brf_o_ard_btr70"],["brf_o_ard_brdm2_hq"],["brf_o_ard_brdm2_hq"],["brf_o_ard_brdm2_hq"],
	["brf_o_ard_uaz_dshkm"],["brf_o_ard_brdm2"],["brf_o_ard_brdm2_um"],["brf_o_ard_ural"]
];
publicVariable "ODD_var_Vehicule";

ODD_var_VehiculeLourd = [
	["brf_o_ard_bmp1"],["brf_o_ard_zsu234"],["brf_o_ard_su25"],["brf_o_ard_t72ba"],
	["brf_o_ard_mi24v"],["brf_o_ard_mi8mt"],["brf_o_ard_bmp1d"],["brf_o_ard_bmp2d"],["brf_o_ard_bmp1d"]
];
publicVariable "ODD_var_VehiculeLourd";

ODD_var_VehiculeTransport = [
	"brf_o_ard_bmp1","brf_o_ard_bmp1d","brf_o_ard_bmp2","brf_o_ard_bmp2d","brf_o_ard_brdm2","brf_o_ard_brdm2_atgm","brf_o_ard_brdm2_um","brf_o_ard_brdm2_hq","brf_o_ard_btr70","brf_o_ard_btr80",
	"brf_o_ard_uaz","brf_o_ard_uaz_open","brf_o_ard_ural","brf_o_ard_zil131","brf_o_ard_zil131_open"
];
publicVariable "ODD_var_VehiculeTransport";

ODD_var_VehiculeVollant = ["brf_o_ard_mi24p","brf_o_ard_mi24v","brf_o_ard_mi24vt","brf_o_ard_mi8amt","brf_o_ard_mi8mt","brf_o_ard_mi8mtv3","brf_o_ard_su25"];
publicVariable "ODD_var_VehiculeVollant";

//Liste des ODD_var_HVT
ODD_var_HVT = [
	["O_Officer_Parade_F"],
	["O_Officer_Parade_Veteran_F"],
	["rhssaf_army_o_m10_para_officer"],
	["rhssaf_army_o_m93_oakleaf_summer_officer"],
	["brf_o_afm_commander"]
];
publicVariable "ODD_var_HVT";

