/*
* Auteur : Wolv
* Fonction d'initialisation groupes de la faction BlackPond PMC.
*
* Arguments :
* 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODDdata_fnc_varEneBlp
*
* Variable publique :
*/

ODD_var_Pair = [
	["brf_o_blp_rifleman_m16","brf_o_blp_lat_m72"],
	["brf_o_blp_rifleman","brf_o_blp_lat_m136"],
	["brf_o_blp_rifleman","brf_o_blp_machinegunner"],
	["brf_o_blp_rifleman","brf_o_blp_rifleman_akms"]
];
// liste des paires

ODD_var_FireTeam = [		// BFR Ardistan
	["brf_o_blp_rifleman_m16","brf_o_blp_machinegunner","brf_o_blp_rifleman_akms","brf_o_blp_machinegunner"],	// MGs
	["brf_o_blp_rifleman_akms","brf_o_blp_rifleman","brf_o_blp_lat_m72","brf_o_blp_marksman"],					// MKman
	["brf_o_blp_leader","brf_o_blp_machinegunner","brf_o_blp_rifleman","brf_o_blp_rifleman_m16"],				// MG
	["brf_o_blp_leader","brf_o_blp_rifleman","brf_o_blp_rifleman_akms","brf_o_blp_rifleman_m16"],				// Rifles
	["brf_o_blp_leader","brf_o_blp_grenadier","brf_o_blp_rifleman_m16","brf_o_blp_rifleman_akms"]				// GL
];
// Liste des équipes
ODD_var_Squad = [
	["brf_o_blp_rifleman_m16","brf_o_blp_rifleman","brf_o_blp_machinegunner","brf_o_blp_lat_m136","brf_o_blp_rifleman_akms","brf_o_blp_grenadier","brf_o_blp_rifleman","brf_o_blp_marksman"],
	["brf_o_blp_leader","brf_o_blp_lat_m136","brf_o_blp_rifleman_akms","brf_o_blp_rifleman","brf_o_blp_rifleman_m16","brf_o_blp_lat_m72","brf_o_blp_rifleman_akms","brf_o_blp_rifleman"],
	["brf_o_blp_leader","brf_o_blp_machinegunner","brf_o_blp_lat_m136","brf_o_blp_rifleman_akms","brf_o_blp_rifleman_akms","brf_o_blp_machinegunner","brf_o_blp_rifleman_m16","brf_o_blp_rifleman"],
	["brf_o_blp_leader","brf_o_blp_lat_m136","brf_o_blp_grenadier","brf_o_blp_rifleman_m16","brf_o_blp_rifleman","brf_o_blp_rifleman","brf_o_blp_lat_m72","brf_o_blp_machinegunner"],
	["brf_o_blp_leader","brf_o_blp_machinegunner","brf_o_blp_lat_m72","brf_o_blp_marksman","brf_o_blp_rifleman","brf_o_blp_rifleman_akms","brf_o_blp_machinegunner","brf_o_blp_rifleman_akms"]
];
// Liste des groupes

ODD_var_Vehicles = [
	["brf_o_blp_m1025_m2"],["brf_o_blp_m1025"]
];
ODD_var_HeavyVehicles = [
	["brf_o_blp_m1025_m2"]
];
ODD_var_TransportVehicles = [
	["brf_o_blp_m1025"]
];
// Liste des véhicules

ODD_var_FlyingVehicles = [
	["brf_o_blp_uh1h"],["brf_o_blp_uh1h_gunship"]
];
