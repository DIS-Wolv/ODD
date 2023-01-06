/*
* Auteur : Wolv
* Fonction d'initialisation groupes de la faction SAF.
*
* Arguments :
* 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODD_fnc_varEneSaf
*
* Variable publique :
*/

ODD_var_Pair = [
	["rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_gl"],
	["rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_mgun_m84"],
	["rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_rifleman_m21"],
	["rhssaf_army_o_m93_oakleaf_summer_rifleman_m21","rhssaf_army_o_m93_oakleaf_summer_rifleman_m70"],
	["rhssaf_army_o_m93_oakleaf_summer_rifleman_m21","rhssaf_army_o_m93_oakleaf_summer_rifleman_m70"],
	["rhssaf_army_o_m93_oakleaf_summer_rifleman_m21","rhssaf_army_o_m93_oakleaf_summer_spec_aa"],
	["rhssaf_army_o_m93_oakleaf_summer_rifleman_m21","rhssaf_army_o_m93_oakleaf_summer_rifleman_at"],
	["rhssaf_army_o_m93_oakleaf_summer_spotter","rhssaf_army_o_m93_oakleaf_summer_sniper_m76"]
];
// liste des paires

ODD_var_FireTeam = [		// BFR Ardistan
	["rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_rifleman_m21","rhssaf_army_o_m93_oakleaf_summer_mgun_m84","rhssaf_army_o_m93_oakleaf_summer_asst_mgun"],
	["rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_gl","rhssaf_army_o_m93_oakleaf_summer_rifleman_m70","rhssaf_army_o_m93_oakleaf_summer_rifleman_m21"],	
	["rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_spec_aa","rhssaf_army_o_m93_oakleaf_summer_rifleman_m70","rhssaf_army_o_m93_oakleaf_summer_rifleman_m21"],
	["rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_engineer","rhssaf_army_o_m93_oakleaf_summer_rifleman_m21","rhssaf_army_o_m93_oakleaf_summer_medic"],
	["rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_asst_spec_aa","rhssaf_army_o_m93_oakleaf_summer_spec_aa","rhssaf_army_o_m93_oakleaf_summer_rifleman_at"],
	["rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_rifleman_m70","rhssaf_army_o_m93_oakleaf_summer_mgun_m84","rhssaf_army_o_m93_oakleaf_summer_rifleman_at"],
	["rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_mgun_m84","rhssaf_army_o_m93_oakleaf_summer_mgun_m84","rhssaf_army_o_m93_oakleaf_summer_asst_mgun"],
	["rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_rifleman_m70","rhssaf_army_o_m93_oakleaf_summer_sniper_m76","rhssaf_army_o_m93_oakleaf_summer_gl"]			
];
// Liste des équipes
ODD_var_Squad = [
	["rhssaf_army_o_m93_oakleaf_summer_sq_lead","rhssaf_army_o_m93_oakleaf_summer_medic","rhssaf_army_o_m93_oakleaf_summer_mgun_m84","rhssaf_army_o_m93_oakleaf_summer_asst_mgun","rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_gl","rhssaf_army_o_m93_oakleaf_summer_rifleman_m70","rhssaf_army_o_m93_oakleaf_summer_rifleman_m21"],
	["rhssaf_army_o_m93_oakleaf_summer_sq_lead","rhssaf_army_o_m93_oakleaf_summer_rifleman_m21","rhssaf_army_o_m93_oakleaf_summer_asst_spec_at","rhssaf_army_o_m93_oakleaf_summer_spec_at","rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_rifleman_m70","rhssaf_army_o_m93_oakleaf_summer_asst_spec_aa","rhssaf_army_o_m93_oakleaf_summer_spec_aa"],
	["rhssaf_army_o_m93_oakleaf_summer_sq_lead","rhssaf_army_o_m93_oakleaf_summer_engineer","rhssaf_army_o_m93_oakleaf_summer_rifleman_m70","rhssaf_army_o_m93_oakleaf_summer_sniper_m76","rhssaf_army_o_m93_oakleaf_summer_gl","rhssaf_army_o_m93_oakleaf_summer_rifleman_at","rhssaf_army_o_m93_oakleaf_summer_mgun_m84","rhssaf_army_o_m93_oakleaf_summer_asst_mgun"],
	["rhssaf_army_o_m93_oakleaf_summer_sq_lead","rhssaf_army_o_m93_oakleaf_summer_mgun_m84","rhssaf_army_o_m93_oakleaf_summer_asst_mgun","rhssaf_army_o_m93_oakleaf_summer_rifleman_m21","rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_rifleman_m70","rhssaf_army_o_m93_oakleaf_summer_asst_mgun","rhssaf_army_o_m93_oakleaf_summer_mgun_m84"],
	["rhssaf_army_o_m93_oakleaf_summer_sq_lead","rhssaf_army_o_m93_oakleaf_summer_rifleman_m21","rhssaf_army_o_m93_oakleaf_summer_spec_at","rhssaf_army_o_m93_oakleaf_summer_asst_spec_at","rhssaf_army_o_m93_oakleaf_summer_ft_lead","rhssaf_army_o_m93_oakleaf_summer_rifleman_m70","rhssaf_army_o_m93_oakleaf_summer_rifleman_at","rhssaf_army_o_m93_oakleaf_summer_rifleman_m21"]
];
// Liste des groupes

ODD_var_Vehicles = [
	["rhssaf_army_o_m1151_olive_pkm"],["rhssaf_army_o_m1025_olive_m2"],["rhssaf_army_o_m1025_olive"]
];
ODD_var_HeavyVehicles = [
	["rhssaf_army_o_t72s"]
];
ODD_var_TransportVehicles = [
	"rhssaf_army_o_m1025_olive","rhssaf_army_o_m998_olive_2dr_fulltop","rhssaf_army_o_ural"
];
// Liste des véhicules

ODD_var_FlyingVehicles = [
	"rhssaf_airforce_o_ht40","rhssaf_airforce_o_l_18"
];
