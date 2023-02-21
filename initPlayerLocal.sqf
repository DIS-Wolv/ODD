[] execVM "scripts\intro.sqf";
[] execVM "R3F_LOG\init.sqf";
[] execVM "scripts\respawn.sqf";
[] execVM "scripts\infoHalo.sqf";
[] spawn WolvLights_fnc_init;
[] spawn WolvGarage_fnc_init;
sleep 1;

// Partie pour les ODD (Opération Dynamique de la DIS)
call ODDadvanced_fnc_var;
call DIScommon_fnc_customLocations;
oddCtrl addAction ["<t color='#1836E9'>ODD</t>", {call compile preprocessFile "odd_gui\GUIODD_Mission\open.sqf";},[],1.5,true,true,"","true",5];
oddCtrl setVariable ["R3F_LOG_disabled", true];
_haltAction = ["haltCivilian","Halt","\z\ace\addons\captives\ui\Surrender_ca.paa",{[player] call ODDadvanced_fnc_haltCivilian},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _haltAction] call ace_interact_menu_fnc_addActionToObject;
[] call ODDadvanced_fnc_infoOdd;
[True] call ODDadvanced_fnc_particules;

// Ajout de la fonction pour couper les petits buissons
_nobushAction = ["noBush","Cut bushes","\z\ace\addons\logistics_wirecutter\ui\wirecutter_ca.paa",{[player] spawn DISCommon_fnc_CutBushes;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _nobushAction] call ace_interact_menu_fnc_addActionToObject;

//NE PAS EDITER AU DESSOUS DE CETTE LIGNE
posBase = getPosASL ob;
posFob = getPosASL fob;
base addAction["<t color='#0D4C00'>Full heal</t>",{[player] call ace_medical_treatment_fnc_fullHealLocal;}];
base addAction ["FOB", {[posFob] call DISCommon_fnc_fastTravel},[],1.5,true,true,"","true",5];
base addAction ["Afficher les générateurs",{[1] execVM "scripts\lights\mapGen.sqf";},[],1.5,true,true,"","true",5];
base addAction ["Cacher les générateurs",{[0] execVM "scripts\lights\mapGen.sqf";},[],1.5,true,true,"","true",5];
ob setVariable ["R3F_LOG_disabled", true];
rules addAction ["Bug Zeus","scripts\backupZeus.sqf",[],1.5,true,true,"","true",2];
halo addAction ["Saut",{[player] call DISCommon_fnc_haloJump},[],1.5,true,true,"","true",5];
halo setVariable ["R3F_LOG_disabled", true];
factory setVariable ["R3F_LOG_disabled", true];
repair setVariable ["R3F_LOG_disabled", true];
refuel setVariable ["R3F_LOG_disabled", true];
rearm setVariable ["R3F_LOG_disabled", true];
rules setVariable ["R3F_LOG_disabled", true];
pCav setVariable ["R3F_LOG_disabled", true];
pPil setVariable ["R3F_LOG_disabled", true];
pPil addAction ["Hélicoptère",{[_this select 1] call DISLoad_fnc_Helo;},[],1.5,true,true,"","",5];
pPil addAction ["Chasseur",{[_this select 1] call DISLoad_fnc_Pilot;},[],1.5,true,true,"","",5];
armes addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_armes;},[],1.5,true,true,"","",5];
armes setVariable ["R3F_LOG_disabled", true];
medical addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_medical;},[],1.5,true,true,"","",5];
medical setVariable ["R3F_LOG_disabled", true];
lanceurs addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_lanceurs;},[],1.5,true,true,"","",5];
lanceurs setVariable ["R3F_LOG_disabled", true];
para addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_para;},[],1.5,true,true,"","",5];
para setVariable ["R3F_LOG_disabled", true];
armesFob addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_armes;},[],1.5,true,true,"","player distance2D armesFob < 10 && armesFob distance2D fob < 20",5];
medicalFob addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_medical;},[],1.5,true,true,"","player distance2D medicalFob < 10 && medicalFob distance2D fob < 20",5];
lanceursFob addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_lanceurs;},[],1.5,true,true,"","player distance2D lanceursFob < 10 && lanceursFob distance2D fob < 20",5];
acces setVariable ["R3F_LOG_disabled", true];
dump addAction ["Vider la caisse",{[_this select 0] call DISLoadCrate_fnc_dump;},[],1.5,true,true,"","",5];
dump setVariable ["R3F_LOG_disabled", true];
//nul = [factory] execVM "R3F_LOG\USER_FUNCT\init_creation_factory.sqf";

if(!isNil "pa") 
then {
	[] execVM "scripts\infoBoat.sqf";
	[] execVM "scripts\retourPa.sqf";
	posUsine = getPosASL usine;
	lifeboat setVariable ["R3F_LOG_disabled", true];
	lifeboat1 setVariable ["R3F_LOG_disabled", true];
	lifeboat2 setVariable ["R3F_LOG_disabled", true];
	lifeboat3 setVariable ["R3F_LOG_disabled", true];
	lifeboat4 setVariable ["R3F_LOG_disabled", true];
	boatRack setVariable ["R3F_LOG_disabled", true];
	pierLadder setVariable ["R3F_LOG_disabled", true];
	boatRack addAction ["Sortir un semi-rigide", {[] call DISCommon_fnc_createBoat},[],1.5,true,true,"","true",5];
	boatRack addAction ["Récupérer les bateaux", {[] call DISCommon_fnc_deleteBoats},[],1.5,true,true,"","true",5];
	base addAction ["Usine", {[posUsine] call DISCommon_fnc_fastTravel},[],1.5,true,true,"","true",5];
	usine addAction ["Porte-avions", {[posBase] call DISCommon_fnc_fastTravel},[],1.5,true,true,"","true",5];
	usine setVariable ["R3F_LOG_disabled", true];
	fob addAction ["Porte-avions", {[posBase] call DISCommon_fnc_fastTravel},[],1.5,true,true,"","true",5];
	pDiv setVariable ["R3F_LOG_disabled", true];
	pDiv addAction ["CdG (Plongeur)",{[_this select 1] call DISLoadDivers_fnc_cdg;},[],1.5,true,true,"","",5];
	pDiv addAction ["CdE (Plongeur)",{[_this select 1] call DISLoadDivers_fnc_cde;},[],1.5,true,true,"","",5];
	pDiv addAction ["GV (Plongeur)",{[_this select 1] call DISLoadDivers_fnc_gv;},[],1.5,true,true,"","",5];
	pDiv addAction ["Minimi (Plongeur)",{[_this select 1] call DISLoadDivers_fnc_minimi;},[],1.5,true,true,"","",5];
	pDiv addAction ["Médecin (Plongeur)",{[_this select 1] call DISLoadDivers_fnc_medecin;},[],1.5,true,true,"","",5];
}
else {
	fob addAction ["Porte-avions", {[posBase] call DISCommon_fnc_fastTravel},[],1.5,true,true,"","true",5];
};

if(!isNil "ce")
then {
	pCav setVariable ["R3F_LOG_disabled", true];
	pInf setVariable ["R3F_LOG_disabled", true];
	pCav addAction ["Chef de Bord (médecin)",{[_this select 1] call DISLoadCe_fnc_cdb;},[],1.5,true,true,"","",5];
	pCav addAction ["Chef de Bord (groupe d'infanterie)",{[_this select 1] call DISLoadCe_fnc_cdbr;},[],1.5,true,true,"","",5];
	pCav addAction ["Equipier",{[_this select 1] call DISLoadCe_fnc_equipier;},[],1.5,true,true,"","",5];
	pInf addAction ["Chef de Groupe",{[_this select 1] call DISLoadCe_fnc_cdg;},[],1.5,true,true,"","",5];
	pInf addAction ["Chef d'Equipe",{[_this select 1] call DISLoadCe_fnc_cde;},[],1.5,true,true,"","",5];
	pInf addAction ["GV",{[_this select 1] call DISLoadCe_fnc_gv;},[],1.5,true,true,"","",5];
	pInf addAction ["Minimi 5.56",{[_this select 1] call DISLoadCe_fnc_minimi5;},[],1.5,true,true,"","",5];
	pInf addAction ["Minimi 7.62",{[_this select 1] call DISLoadCe_fnc_minimi7;},[],1.5,true,true,"","",5];
	pInf addAction ["Médecin",{[_this select 1] call DISLoadCe_fnc_medecin;},[],1.5,true,true,"","",5];
	pInf addAction ["EOD",{[_this select 1] call DISLoadCe_fnc_eod;},[],1.5,true,true,"","",5];
	pInf addAction ["Spotter",{[_this select 1] call DISLoadCe_fnc_spotter;},[],1.5,true,true,"","",5];
	pInf addAction ["TP",{[_this select 1] call DISLoadCe_fnc_tp;},[],1.5,true,true,"","",5];
	pInf addAction ["TP (groupe d'infanterie)",{[_this select 1] call DISLoadCe_fnc_tpInf;},[],1.5,true,true,"","",5];
	pInf addAction ["TE",{[_this select 1] call DISLoadCe_fnc_te;},[],1.5,true,true,"","",5];
	acces addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_itemsCe},[],1.5,true,true,"","",5];
}
else {
	pCav setVariable ["R3F_LOG_disabled", true];
	pInf setVariable ["R3F_LOG_disabled", true];
	pCav addAction ["Chef de Bord (médecin)",{[_this select 1] call DISLoadDa_fnc_cdb;},[],1.5,true,true,"","",5];
	pCav addAction ["Chef de Bord (groupe d'infanterie)",{[_this select 1] call DISLoadDa_fnc_cdbr;},[],1.5,true,true,"","",5];
	pCav addAction ["Equipier",{[_this select 1] call DISLoadDa_fnc_equipier;},[],1.5,true,true,"","",5];
	pInf addAction ["Chef de Groupe",{[_this select 1] call DISLoadDa_fnc_cdg;},[],1.5,true,true,"","",5];
	pInf addAction ["Chef d'Equipe",{[_this select 1] call DISLoadDa_fnc_cde;},[],1.5,true,true,"","",5];
	pInf addAction ["GV",{[_this select 1] call DISLoadDa_fnc_gv;},[],1.5,true,true,"","",5];
	pInf addAction ["Minimi 5.56",{[_this select 1] call DISLoadDa_fnc_minimi5;},[],1.5,true,true,"","",5];
	pInf addAction ["Minimi 7.62",{[_this select 1] call DISLoadDa_fnc_minimi7;},[],1.5,true,true,"","",5];
	pInf addAction ["Médecin",{[_this select 1] call DISLoadDa_fnc_medecin;},[],1.5,true,true,"","",5];
	pInf addAction ["EOD",{[_this select 1] call DISLoadDa_fnc_eod;},[],1.5,true,true,"","",5];
	pInf addAction ["Spotter",{[_this select 1] call DISLoadDa_fnc_spotter;},[],1.5,true,true,"","",5];
	pInf addAction ["TP",{[_this select 1] call DISLoadDa_fnc_tp;},[],1.5,true,true,"","",5];
	pInf addAction ["TP (groupe d'infanterie)",{[_this select 1] call DISLoadDa_fnc_tpInf;},[],1.5,true,true,"","",5];
	pInf addAction ["TE",{[_this select 1] call DISLoadDa_fnc_te;},[],1.5,true,true,"","",5];
	acces addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_itemsDa},[],1.5,true,true,"","",5];
};

sleep 3;
