/*
* Auteur : Wolv
* Fonction d'initialisation groupes de la faction ChDKZ Insurgents.
*
* Arguments :
* 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODDdata_fnc_varEne
*
* Variable publique :
*/

ODD_var_Pair = [
	["rhsgref_ins_grenadier_rpg","rhsgref_ins_rifleman_aksu"],	//RPG
	["rhsgref_ins_machinegunner","rhsgref_ins_rifleman"],		// MG
	["rhsgref_ins_specialist_aa","rhsgref_ins_rifleman_akm"]	// AA
];
// Liste des paires

ODD_var_FireTeam = [
	["rhsgref_ins_squadleader","rhsgref_ins_machinegunner","rhsgref_ins_medic","rhsgref_ins_rifleman_aks74"],				// Commande
	["rhsgref_ins_squadleader","rhsgref_ins_grenadier","rhsgref_ins_rifleman_aks74","rhsgref_ins_rifleman_aksu"],		// GL
	["rhsgref_ins_squadleader","rhsgref_ins_rifleman_RPG26","rhsgref_ins_grenadier_rpg","rhsgref_ins_rifleman_aks74"],	// LAT - RPG 7
	["rhsgref_ins_squadleader","rhsgref_ins_rifleman_RPG26","rhsgref_ins_rifleman_aksu","rhsgref_ins_rifleman_akm"],	// LAT
	["rhsgref_ins_squadleader","rhsgref_ins_machinegunner","rhsgref_ins_rifleman","rhsgref_ins_rifleman_aks74"],		// MG
	["rhsgref_ins_squadleader","rhsgref_ins_arifleman_rpk","rhsgref_ins_rifleman_RPG26","rhsgref_ins_rifleman_aksu"],	// LAT 
	["rhsgref_ins_squadleader","rhsgref_ins_specialist_aa","rhsgref_ins_rifleman_aks74","rhsgref_ins_rifleman_akm"],	// AA
	["rhsgref_ins_squadleader","rhsgref_ins_arifleman_rpk","rhsgref_ins_rifleman","rhsgref_ins_militiaman_mosin"]		// Rifle
];
// Liste des équipes

ODD_var_Squad = [
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
// Liste des groupes

ODD_var_Vehicles = [
	["rhsgref_ins_btr60"],["rhsgref_ins_btr70"],["rhsgref_ins_btr70"],
	["rhsgref_ins_uaz_dshkm"],["rhsgref_ins_uaz_dshkm"],["rhsgref_BRDM2_ins"],
	["rhsgref_BRDM2_HQ_ins"],["rhsgref_BRDM2_HQ_ins"],["rhsgref_ins_uaz"],
	["rhsgref_ins_ural"]
];
ODD_var_HeavyVehicles = [
	["rhsgref_ins_zsu234"],["rhsgref_ins_btr70"],["rhsgref_ins_btr70"],["rhsgref_ins_bmd2"],
	["rhsgref_ins_bmd1"],["rhsgref_ins_bmp1k"],["rhsgref_ins_t72ba"],["rhsgref_ins_uaz_spg9"]
];
ODD_var_TransportVehicles = [
	["rhsgref_ins_btr60"],["rhsgref_ins_btr70"],["rhsgref_ins_uaz"],["rhsgref_ins_uaz_open"],["rhsgref_ins_bmd1"],["rhsgref_ins_bmd1p"],["rhsgref_ins_bmd2"],["rhsgref_ins_bmp1"],["rhsgref_ins_bmp1d"],["rhsgref_ins_bmp1k"],
	["rhsgref_ins_bmp1p"],["rhsgref_ins_bmp2e"],["rhsgref_ins_bmp2"],["rhsgref_ins_bmp2d"],["rhsgref_ins_bmp2k"],["rhsgref_BRDM2_ins"],["rhsgref_BRDM2_ATGM_ins"],["rhsgref_BRDM2UM_ins"],["rhsgref_BRDM2_HQ_ins"],
	["rhsgref_ins_gaz66"],["rhsgref_ins_gaz66o"],["rhsgref_ins_kraz255b1_cargo_open"],["rhsgref_ins_ural"],["rhsgref_ins_ural_open"],["rhsgref_ins_ural_work"],["rhsgref_ins_ural_work_open"],["rhsgref_ins_zil131"],
	["rhsgref_ins_zil131_open"]
];
ODD_var_FlyingVehicles = [["rhsgref_ins_Mi8amt"]];
//Liste des Vehicules

