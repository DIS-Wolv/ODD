/*
* Author: Wolv
* Fonction d'initialisation des variables globale des Enemie, ici faction ChDKZ Insurgents.
*
* Arguments:
* 
*
* Return Value:
* nil
*
* Example:
* [] call WOLV_fnc_varEne
*
* Public:
*/

// Creation des partouille
pair = [
	["rhsgref_ins_grenadier_rpg","rhsgref_ins_rifleman_aksu"],	//RPG
	["rhsgref_ins_machinegunner","rhsgref_ins_rifleman"],		// MG
	["rhsgref_ins_specialist_aa","rhsgref_ins_rifleman_akm"]	// AA
];
publicVariable "pair";

// Creation des "FireTeam"
fireTeam = [		// ChDKZ insurgents
	["rhsgref_ins_commander","rhsgref_ins_squadleader","rhsgref_ins_medic","rhsgref_ins_rifleman_aks74"],				// Commande
	["rhsgref_ins_squadleader","rhsgref_ins_grenadier","rhsgref_ins_rifleman_aks74","rhsgref_ins_rifleman_aksu"],		// GL
	["rhsgref_ins_squadleader","rhsgref_ins_rifleman_RPG26","rhsgref_ins_grenadier_rpg","rhsgref_ins_rifleman_aks74"],	// LAT - RPG 7
	["rhsgref_ins_squadleader","rhsgref_ins_rifleman_RPG26","rhsgref_ins_rifleman_aksu","rhsgref_ins_rifleman_akm"],	// LAT
	["rhsgref_ins_squadleader","rhsgref_ins_machinegunner","rhsgref_ins_rifleman","rhsgref_ins_rifleman_aks74"],		// MG
	["rhsgref_ins_squadleader","rhsgref_ins_arifleman_rpk","rhsgref_ins_rifleman_RPG26","rhsgref_ins_rifleman_aksu"],	// LAT 
	["rhsgref_ins_squadleader","rhsgref_ins_specialist_aa","rhsgref_ins_rifleman_aks74","rhsgref_ins_rifleman_akm"],	// AA
	["rhsgref_ins_squadleader","rhsgref_ins_arifleman_rpk","rhsgref_ins_rifleman","rhsgref_ins_militiaman_mosin"]		// Rifle
];
publicVariable "fireTeam";

// Creation des "Squad"
squad = [
	["rhsgref_ins_squadleader","rhsgref_ins_grenadier","rhsgref_ins_rifleman","rhsgref_ins_rifleman_RPG26","rhsgref_ins_rifleman_akm","rhsgref_ins_rifleman_aks74","rhsgref_ins_rifleman_aksu","rhsgref_ins_rifleman"],
		//GL
	["rhsgref_ins_squadleader","rhsgref_ins_rifleman_RPG26","rhsgref_ins_rifleman","rhsgref_ins_grenadier_rpg","rhsgref_ins_arifleman_rpk","rhsgref_ins_rifleman_aks74","rhsgref_ins_rifleman_aksu","rhsgref_ins_militiaman_mosin"],
		//LAT - RPG 7
	["rhsgref_ins_squadleader","rhsgref_ins_machinegunner","rhsgref_ins_rifleman_aksu","rhsgref_ins_rifleman_aks74","rhsgref_ins_rifleman_RPG26","rhsgref_ins_rifleman_akm","rhsgref_ins_rifleman_aksu","rhsgref_ins_rifleman_akm"],
		//MG
	["rhsgref_ins_squadleader","rhsgref_ins_rifleman_RPG26","rhsgref_ins_rifleman","rhsgref_ins_rifleman_akm","rhsgref_ins_rifleman_aks74","rhsgref_ins_sniper","rhsgref_ins_spotter","rhsgref_ins_rifleman_aks74"],
		//MXM
	["rhsgref_ins_squadleader","rhsgref_ins_arifleman_rpk","rhsgref_ins_rifleman_aksu","rhsgref_ins_rifleman_aks74","rhsgref_ins_rifleman_RPG26","rhsgref_ins_rifleman_akm","rhsgref_ins_rifleman_aksu","rhsgref_ins_rifleman_akm"]
		//Rifle
];
publicVariable "squad";

//Liste des Vehicule
Vehicule = [
	["rhsgref_ins_uaz"],["rhsgref_ins_uaz_dshkm"],["rhsgref_ins_uaz_open"],
	["rhsgref_ins_gaz66"],["rhsgref_ins_gaz66o"],["rhsgref_ins_kraz255b1_cargo_open"],["rhsgref_ins_zil131"],["rhsgref_ins_zil131_open"],
	["rhsgref_ins_btr60"],["rhsgref_BRDM2_ins"],["rhsgref_BRDM2UM_ins"],["rhsgref_BRDM2_HQ_ins"],["rhsgref_BRDM2_HQ_ins"]
];
publicVariable "Vehicule";

//Liste des HVT
HVT = [
	["O_Officer_Parade_F"],
	["O_Officer_Parade_Veteran_F"],
	["rhssaf_army_o_m10_para_officer"],
	["rhssaf_army_o_m93_oakleaf_summer_officer"],
	["brf_o_afm_commander"],
	["rhsgref_ins_commander"]
];
publicVariable "HVT";
