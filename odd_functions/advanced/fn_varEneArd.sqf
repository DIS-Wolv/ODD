/*
* Auteur : Wolv
* Fonction d'initialisation groupes de la faction Ardistan.
*
* Arguments :
* 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODDadvanced_fnc_varEneArd
*
* Variable publique :
*/
ODD_var_Pair = [
	["brf_o_ard_atr_rpg7","brf_o_ard_rifleman"],
	["brf_o_ard_machinegunner","brf_o_ard_machinegunner_asst"],
	["brf_o_ard_aa_specialist","brf_o_ard_aa_asst"]
];
// liste des paires

ODD_var_FireTeam = [		// BFR Ardistan
	["brf_o_ard_squadleader","brf_o_ard_radiooperator","brf_o_ard_medic","brf_o_ard_rifleman"],					// Commandement
	["brf_o_ard_teamleader","brf_o_ard_grenadier","brf_o_ard_rifleman","brf_o_ard_rifleman"],					// GL
	["brf_o_ard_teamleader","brf_o_ard_atr_rpg7","brf_o_ard_rifleman","brf_o_ard_rifleman"],					// LAT - RPG 7
	["brf_o_ard_teamleader","brf_o_ard_lat","brf_o_ard_rifleman","brf_o_ard_rifleman"],							// LAT
	["brf_o_ard_teamleader","brf_o_ard_machinegunner","brf_o_ard_machinegunner_asst","brf_o_ard_rifleman"],		// MG
	["brf_o_ard_teamleader","brf_o_ard_rifleman","brf_o_ard_lat","brf_o_ard_rifleman"],							// LAT 
	["brf_o_ard_squadleader","brf_o_ard_aa_specialist","brf_o_ard_aa_specialist","brf_o_ard_aa_asst"]			// AA
];
// Liste des équipes
ODD_var_Squad = [
	["brf_o_ard_squadleader","brf_o_ard_grenadier","brf_o_ard_rifleman","brf_o_ard_rifleman","brf_o_ard_teamleader","brf_o_ard_lat","brf_o_ard_rifleman","brf_o_ard_rifleman"],
		//GL
	["brf_o_ard_squadleader","brf_o_ard_grenadier","brf_o_ard_rifleman","brf_o_ard_rifleman","brf_o_ard_teamleader","brf_o_ard_lat","brf_o_ard_rifleman","brf_o_ard_rifleman"],
		//LAT - RPG 7
	["brf_o_ard_squadleader","brf_o_ard_machinegunner","brf_o_ard_machinegunner_asst","brf_o_ard_rifleman","brf_o_ard_teamleader","brf_o_ard_lat","brf_o_ard_rifleman","brf_o_ard_rifleman"],
		//MG
	["brf_o_ard_squadleader","brf_o_ard_rifleman","brf_o_ard_rifleman","brf_o_ard_marksman","brf_o_ard_teamleader","brf_o_ard_lat","brf_o_ard_rifleman","brf_o_ard_rifleman"],
		//Marksman
	["brf_o_ard_squadleader","brf_o_ard_rifleman","brf_o_ard_rifleman","brf_o_ard_lat","brf_o_ard_teamleader","brf_o_ard_rifleman","brf_o_ard_rifleman","brf_o_ard_rifleman"]
		//Rifle
];
// Liste des groupes

ODD_var_Vehicles = [
	["brf_o_ard_btr70"],["brf_o_ard_btr70"],["brf_o_ard_brdm2_hq"],["brf_o_ard_brdm2_hq"],["brf_o_ard_brdm2_hq"],
	["brf_o_ard_uaz_dshkm"],["brf_o_ard_brdm2"],["brf_o_ard_brdm2_um"],["brf_o_ard_ural"]
];
ODD_var_HeavyVehicles = [
	["brf_o_ard_bmp1"],["brf_o_ard_zsu234"],["brf_o_ard_su25"],["brf_o_ard_t72ba"],
	["brf_o_ard_mi24v"],["brf_o_ard_mi8mt"],["brf_o_ard_bmp1d"],["brf_o_ard_bmp2d"],["brf_o_ard_bmp1d"]
];
ODD_var_TransportVehicles = [
	"brf_o_ard_bmp1","brf_o_ard_bmp1d","brf_o_ard_bmp2","brf_o_ard_bmp2d","brf_o_ard_brdm2","brf_o_ard_brdm2_atgm","brf_o_ard_brdm2_um","brf_o_ard_brdm2_hq","brf_o_ard_btr70","brf_o_ard_btr80",
	"brf_o_ard_uaz","brf_o_ard_uaz_open","brf_o_ard_ural","brf_o_ard_zil131","brf_o_ard_zil131_open"
];
// Liste des véhicules

ODD_var_FlyingVehicles = ["brf_o_ard_mi24p","brf_o_ard_mi24v","brf_o_ard_mi24vt","brf_o_ard_mi8amt","brf_o_ard_mi8mt","brf_o_ard_mi8mtv3","brf_o_ard_su25"];

