
// variable pour les missions

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

// Defini les différents objectifs possibles
// missions dans le térritoire allié
ODD_var_MissionTypeBlue = ["Helico", "Convoi Humanitaire"]; // patrouille enemie a tué, ravitallement de base, déploiment d'allié, récupération de matériel, IED a déminer, Vehicule(civil ou Otan), zone a protégé a réparé ?
// missions dans la ligne de front
ODD_var_MissionTypeFrontLine = ["Sécurisation de zone", "intel", "Helico", "Prisonniers", "Sécurisation de véhicule", "Destruction de véhicule"]; // avions écrasé, IED a déminer, convoi à intercepter(prisoner, ravitaillement),, bombe, bureau de recrutement à détruire ? 
// missions dans le térritoire ennemi
ODD_var_MissionTypeEnemy = ["Tuer un HVT", "Capturer un HVT", "intel", "Helico", "Prisonniers", "Destruction de véhicule"]; // avions écrasé, convoi à intercepter (prisoner, ravitaillement), bombe a posé, bureau de recrutement à détruire ?

private _allMission = ODD_var_MissionTypeBlue + ODD_var_MissionTypeFrontLine + ODD_var_MissionTypeEnemy;
ODD_var_MissionType = [];
{
    ODD_var_MissionType pushBackUnique _x;
} forEach _allMission;
//["Caisse", "Tuer un HVT", "Capturer un HVT", "Sécurisation de zone", "intel", "Helico", "Prisonniers", "Sécurisation de véhicule", "Destruction de véhicule", "Convoi Humanitaire"];
    // convoi hummanitaire, bombe, convoi à intercepter


// Liste des prisoniers
ODD_var_Hostages = [["B_pilot_F"], ["B_Fighter_pilot_F"], ["B_helicrew_F"], ["B_Helipilot_F"]];

// liste des vehicules objectif à sécuriser
ODD_var_SercureVehicles = ["O_APC_Wheeled_02_rcws_v2_F", "O_MRAP_02_F", "O_Truck_03_device_F", "rhsgref_BRDM2UM_msv", "rhs_gaz66_r142_msv", "rhs_tigr_m_vdv", "I_MRAP_03_F"];

// liste des vehicules objectif à détruire
ODD_var_DestroyVehicles = ["rhsgref_ins_zsu234", "rhsgref_ins_BM21", "O_SAM_System_04_F", "RHS_BM21_MSV_01", "rhs_prp3_msv", "rhs_9k79", "rhs_D30_vdv", "I_Truck_02_MRL_F", "rhs_gaz66_r142_msv", "O_APC_Wheeled_02_rcws_v2_F", "O_MRAP_02_F", "I_MRAP_03_F", "rhs_bmp3mera_msv", "rhs_btr80_msv"];

ODD_var_HumaVehicles = [ "C_IDAP_Truck_02_water_F", "B_Truck_01_box_F", "C_Truck_02_box_F", "C_IDAP_Pickup_water_rf", "C_IDAP_Van_02_medevac_F", "C_Van_01_box_F", "C_Truck_03_water_rf"];

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

