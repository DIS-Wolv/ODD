[] execVM "scripts\intro.sqf";
[] execVM "R3F_LOG\init.sqf";
[] execVM "scripts\respawn.sqf";
[] execVM "scripts\infoHalo.sqf";
[] spawn DISCommon_fnc_RecoDroneInfo;
[] spawn WolvLights_fnc_init;
[] spawn WolvGarage_fnc_init;
sleep 1;

// Partie pour les ODD (Opération Dynamique de la DIS)
call ODDdata_fnc_var;
// call DIScommon_fnc_customLocations;
oddCtrl addAction ["<t color='#1836E9'>ODD</t>", {call OddGuiMissions_fnc_open;},[],1.5,True,True,"","True",5];
oddCtrl setVariable ["R3F_LOG_disabled", True];
_haltAction = ["haltCivilian","Halt","\z\ace\addons\captives\ui\Surrender_ca.paa",{[player] call ODDadvanced_fnc_haltCivilian},{True}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _haltAction] call ace_interact_menu_fnc_addActionToObject;
[] call ODDadvanced_fnc_infoOdd;
[True] call ODDadvanced_fnc_particules;

// Ajout de la fonction pour couper les petits buissons
_nobushAction = ["noBush","Cut bushes","\z\ace\addons\logistics_wirecutter\ui\wirecutter_ca.paa",{[player] spawn DISCommon_fnc_CutBushes;},{True}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _nobushAction] call ace_interact_menu_fnc_addActionToObject;

// Ajout de la fonction pour reset la radio
_RadioAction = ["Radio","Reset Radio","\z\tfar\addons\core\ui\ACE_Interaction_Radio_Icon.paa",{[player] spawn DISCommon_fnc_resetRadio;},{True}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _RadioAction] call ace_interact_menu_fnc_addActionToObject;

//NE PAS EDITER AU DESSOUS DE CETTE LIGNE
base addAction["<t color='#0D4C00'>Full heal</t>",{[player] call ace_medical_treatment_fnc_fullHealLocal;}];
base addAction ["FOB", {[fob] call DISCommon_fnc_fastTravel},[],1.5,True,True,"","True",5];
ob setVariable ["R3F_LOG_disabled", True];
rules addAction ["Bug Zeus","scripts\backupZeus.sqf",[],1.5,True,True,"","True",2];
halo addAction ["Saut",{[player] call DISCommon_fnc_haloJump},[],1.5,True,True,"","True",5];
halo setVariable ["R3F_LOG_disabled", True];
factory setVariable ["R3F_LOG_disabled", True];
repair setVariable ["R3F_LOG_disabled", True];
refuel setVariable ["R3F_LOG_disabled", True];
rearm setVariable ["R3F_LOG_disabled", True];
rules setVariable ["R3F_LOG_disabled", True];
pCav setVariable ["R3F_LOG_disabled", True];
[pPil] call DISCommon_fnc_arsenal;
pPil setVariable ["R3F_LOG_disabled", True];
pPil addAction ["Hélicoptère",{[DISLoad_var_piloteHelo, _this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pPil addAction ["Chasseur",{[DISLoad_var_piloteAvions, _this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
armes addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_armes;},[],1.5,True,True,"","",5];
armes setVariable ["R3F_LOG_disabled", True];
medical addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_medical;},[],1.5,True,True,"","",5];
medical setVariable ["R3F_LOG_disabled", True];
lanceurs addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_lanceurs;},[],1.5,True,True,"","",5];
lanceurs setVariable ["R3F_LOG_disabled", True];
para addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_para;},[],1.5,True,True,"","",5];
para setVariable ["R3F_LOG_disabled", True];
armesFob addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_armes;},[],1.5,True,True,"","player distance2D armesFob < 10 && armesFob distance2D fob < 20",5];
medicalFob addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_medical;},[],1.5,True,True,"","player distance2D medicalFob < 10 && medicalFob distance2D fob < 20",5];
lanceursFob addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_lanceurs;},[],1.5,True,True,"","player distance2D lanceursFob < 10 && lanceursFob distance2D fob < 20",5];
acces setVariable ["R3F_LOG_disabled", True];
dump addAction ["Vider la caisse",{[_this select 0] call DISLoadCrate_fnc_dump;},[],1.5,True,True,"","",5];
dump setVariable ["R3F_LOG_disabled", True];
//nul = [factory] execVM "R3F_LOG\USER_FUNCT\init_creation_factory.sqf";

pRens setVariable ["R3F_LOG_disabled", True];
pRens addAction ["Reco Drone",{["B_UAV_02_F", 2000, 2000, (position Base)] call DISCommon_fnc_RecoDrone;},[],1.5,True,True,"","",5];
pRens addAction ["Afficher les générateurs",{[1] call WolvLights_fnc_mapgen;},[],1.5,True,True,"","True",5];
pRens addAction ["Cacher les générateurs",{[0] call WolvLights_fnc_mapgen;},[],1.5,True,True,"","True",5];

if(!isNil "pa") 
then {
	[] execVM "scripts\infoBoat.sqf";
	[] execVM "scripts\retourPa.sqf";
	lifeboat setVariable ["R3F_LOG_disabled", True];
	lifeboat1 setVariable ["R3F_LOG_disabled", True];
	lifeboat2 setVariable ["R3F_LOG_disabled", True];
	lifeboat3 setVariable ["R3F_LOG_disabled", True];
	lifeboat4 setVariable ["R3F_LOG_disabled", True];
	boatRack setVariable ["R3F_LOG_disabled", True];
	pierLadder setVariable ["R3F_LOG_disabled", True];
	boatRack addAction ["Sortir un semi-rigide", {[] call DISCommon_fnc_createBoat},[],1.5,True,True,"","True",5];
	boatRack addAction ["Récupérer les bateaux", {[] call DISCommon_fnc_deleteBoats},[],1.5,True,True,"","True",5];
	base addAction ["Usine", {[usine] call DISCommon_fnc_fastTravel},[],1.5,True,True,"","True",5];
	usine addAction ["Porte-avions", {[ob] call DISCommon_fnc_fastTravel},[],1.5,True,True,"","True",5];
	usine setVariable ["R3F_LOG_disabled", True];
	fob addAction ["Porte-avions", {[ob] call DISCommon_fnc_fastTravel},[],1.5,True,True,"","True",5];
	pDiv addAction ["CdG (Plongeur)",{[DISLoadPL_var_CDG, _this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
	pDiv addAction ["CdE (Plongeur)",{[DISLoadPL_var_CDE, _this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
	pDiv addAction ["GV (Plongeur)",{[DISLoadPL_var_GV, _this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
	pDiv addAction ["Minimi (Plongeur)",{[DISLoadPL_var_Minimi5, _this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
	pDiv addAction ["Médecin (Plongeur)",{[DISLoadPL_var_Medecin, _this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
	pDiv setVariable ["R3F_LOG_disabled", True];
}
else {
	fob addAction ["Porte-avions", {[ob] call DISCommon_fnc_fastTravel},[],1.5,True,True,"","True",5];
};

pCav setVariable ["R3F_LOG_disabled", True];
pInf setVariable ["R3F_LOG_disabled", True];

pCav addAction ["Chef de Bord (médecin)",{[DISLoadMc_var_CDB, _this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pCav addAction ["Chef de Bord (groupe d'infanterie)",{[DISLoadMc_var_CDBR, _this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pCav addAction ["Equipier",{[DISLoadMc_var_Equipier, _this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];

pInf addAction ["GV",{[DISLoadMc_var_GV,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["Gv Sac",{[DISLoadMc_var_GvBck,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["Grenadier",{[DISLoadMc_var_Grenadier,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["Minimi 5.56",{[DISLoadMc_var_Minimi5,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["Minimi 7.62",{[DISLoadMc_var_Minimi7,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["Chef d'Equipe",{[DISLoadMc_var_CdE,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["Chef de Groupe",{[DISLoadMc_var_CdG,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["Chef de Section",{[DISLoadMc_var_CdS,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["Medecin",{[DISLoadMc_var_Medecin,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["EOD",{[DISLoadMc_var_EOD,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["EOD Light",{[DISLoadMc_var_EOD_Light,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["TP",{[DISLoadMc_var_TP,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];
pInf addAction ["Zeus",{[DISLoadMc_var_Zeus,_this select 1] call DISLoad_fnc_SetLoad;},[],1.5,True,True,"","",5];

acces addAction ["Recharger la caisse",{[_this select 0] call DISLoadCrate_fnc_items},[],1.5,True,True,"","",5];

[] call DISLoad_fnc_varLoads;

sleep 3;
