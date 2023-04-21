/*
* Auteur : Wolv
* Fonction d'initialisation groupes de la faction FIA.
*
* Arguments :
* 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODDadvanced_fnc_varEneFia
*
* Variable publique :
*/

ODD_var_Pair = [
	["O_G_Soldier_F","O_G_Soldier_lite_F"],
	["O_G_Soldier_F","O_G_Soldier_LAT_F"],
	["O_G_Soldier_F","O_G_Sharpshooter_F"],
	["O_G_Soldier_F","O_G_Soldier_AR_F"],
	["O_G_Soldier_F","O_G_Soldier_GL_F"]
];
// liste des paires

ODD_var_FireTeam = [		// BFR Ardistan
	["O_G_Soldier_SL_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_LAT_F"],				// LAT
	["O_G_Soldier_SL_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_LAT2_F"],				// HAT
	["O_G_Soldier_SL_F","O_G_Soldier_GL_F","O_G_Soldier_F","O_G_Soldier_lite_F"],			// GL
	["O_G_Soldier_SL_F","O_G_Soldier_F","O_G_Soldier_AR_F","O_G_Soldier_A_F"],				// MG
	["O_G_Soldier_SL_F","O_G_Soldier_LAT_F","O_G_Soldier_AR_F","O_G_Soldier_A_F"],
	["O_G_Soldier_SL_F","O_G_Soldier_GL_F","O_G_Soldier_F","O_G_Soldier_TL_F"],
	["O_G_Soldier_TL_F","O_G_Sharpshooter_F","O_G_Soldier_AR_F","O_G_Soldier_AR_F"],
	["O_G_Soldier_SL_F","O_G_Soldier_LAT_F","O_G_Soldier_A_F","O_G_Soldier_LAT2_F"]			
];
// Liste des équipes
ODD_var_Squad = [
	["O_G_Soldier_SL_F","O_G_Soldier_F","O_G_Soldier_AR_F","O_G_Soldier_F","O_G_Soldier_GL_F","O_G_Soldier_M_F","O_G_Soldier_LAT_F","O_G_medic_F"],
	["O_G_officer_F","O_G_Soldier_TL_F","O_G_Soldier_AR_F","O_G_Soldier_A_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_LAT_F","O_G_Sharpshooter_F"],
	["O_G_Soldier_SL_F","O_G_Soldier_GL_F","O_G_Soldier_F","O_G_Soldier_AR_F","O_G_Soldier_lite_F","O_G_Soldier_AR_F","O_G_Soldier_F","O_G_Soldier_A_F"],
	["O_G_Soldier_TL_F","O_G_Soldier_F","O_G_Soldier_AR_F","O_G_Soldier_A_F","O_G_Soldier_LAT_F","O_G_Soldier_F","O_G_Soldier_LAT2_F","O_G_Soldier_A_F"],
	["O_G_Soldier_SL_F","O_G_Soldier_F","O_G_Soldier_F","O_G_Soldier_M_F","O_G_Soldier_TL_F","O_G_Soldier_lite_F","O_G_Soldier_lite_F","O_G_Soldier_F"]
];
// Liste des groupes

ODD_var_Vehicles = [
	["O_G_Offroad_01_AT_F"],["O_G_Offroad_01_armed_F"],["O_G_Offroad_01_F"],["O_G_Van_01_transport_F"]
];
ODD_var_HeavyVehicles = [
	["O_G_Offroad_01_armed_F"]
];
ODD_var_TransportVehicles = [
	["O_G_Offroad_01_F"],["O_G_Van_01_transport_F"],["O_G_Van_02_transport_F"]
];
// Liste des véhicules

ODD_var_FlyingVehicles = [
];
