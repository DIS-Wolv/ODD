[] execVM "scripts\intro.sqf";
[] execVM "R3F_LOG\init.sqf";
[] execVM "scripts\respawn.sqf";
[] execVM "scripts\halo\infoHalo.sqf";
[] execVM "scripts\retourPa.sqf";
[] spawn WolvLights_fnc_init;
[] spawn WolvGarage_fnc_init;
sleep 1;

// Partie pour les ODD (Opération Dynamique de la DIS)
call ODD_fnc_var;
call ODD_fnc_customLocation;
oddCtrl addAction ["<t color='#1836E9'>ODD</t>", {call compile preprocessFile "ODD_GUI\GUIODD_Mission\open.sqf";},[],1.5,true,true,"","true",5];
oddCtrl setVariable ["R3F_LOG_disabled", true];
_haltAction = ["haltCivilian","Halt","\z\ace\addons\captives\ui\Surrender_ca.paa",{[player] call ODD_fnc_haltCivilian},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _haltAction] call ace_interact_menu_fnc_addActionToObject;
[] call ODD_fnc_infoOdd;
[True] call ODD_fnc_particules;

// Ajout de la fonction pour couper les petit buissons
_nobushAction = ["noBush","Cut bushes","\z\ace\addons\logistics_wirecutter\ui\wirecutter_ca.paa",{[player] spawn DISCommon_fnc_CutBushes;},{true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _nobushAction] call ace_interact_menu_fnc_addActionToObject;

//NE PAS EDITER AU DESSOUS DE CETTE LIGNE
base addAction["<t color='#0D4C00'>Full heal</t>",{[player] call ace_medical_treatment_fnc_fullHealLocal;}];
base addAction ["FOB","scripts\tp\fob.sqf",["fob"],1.5,true,true,"","true",5];
base addAction ["Afficher les générateurs",{[1] execVM "scripts\lights\mapGen.sqf";},[],1.5,true,true,"","true",5];
base addAction ["Cacher les générateurs",{[0] execVM "scripts\lights\mapGen.sqf";},[],1.5,true,true,"","true",5];
ob setVariable ["R3F_LOG_disabled", true];
rules addAction ["Bug Zeus","scripts\backupZeus.sqf",[],1.5,true,true,"","true",2];
halo addAction ["Saut", "scripts\halo\halo.sqf",[],1.5,true,true,"","true",5];
halo setVariable ["R3F_LOG_disabled", true];
factory setVariable ["R3F_LOG_disabled", true];
repair setVariable ["R3F_LOG_disabled", true];
refuel setVariable ["R3F_LOG_disabled", true];
rearm setVariable ["R3F_LOG_disabled", true];
rules setVariable ["R3F_LOG_disabled", true];
pCav setVariable ["R3F_LOG_disabled", true];
pPil setVariable ["R3F_LOG_disabled", true];
lifeboat setVariable ["R3F_LOG_disabled", true];
lifeboat1 setVariable ["R3F_LOG_disabled", true];
lifeboat2 setVariable ["R3F_LOG_disabled", true];
lifeboat3 setVariable ["R3F_LOG_disabled", true];
lifeboat4 setVariable ["R3F_LOG_disabled", true];
boatRack setVariable ["R3F_LOG_disabled", true];
pierLadder setVariable ["R3F_LOG_disabled", true];
boatRack addAction ["Sortir un semi-rigide", "scripts\boats\spawnBateau.sqf",[],1.5,true,true,"","true",5];
boatRack addAction ["Récupérer les bateaux", "scripts\boats\delBateaux.sqf",[],1.5,true,true,"","true",5];
pPil addAction ["Hélicoptère","loads\helo.sqf",[],1.5,true,true,"","",5];
pPil addAction ["Chasseur","loads\pilot.sqf",[],1.5,true,true,"","",5];
armes addAction ["Recharger la caisse","loads\crate\armes.sqf",[],1.5,true,true,"","",5];
armes setVariable ["R3F_LOG_disabled", true];
medical addAction ["Recharger la caisse","loads\crate\medical.sqf",[],1.5,true,true,"","",5];
medical setVariable ["R3F_LOG_disabled", true];
lanceurs addAction ["Recharger la caisse","loads\crate\lanceurs.sqf",[],1.5,true,true,"","",5];
lanceurs setVariable ["R3F_LOG_disabled", true];
para addAction ["Recharger la caisse","loads\crate\para.sqf",[],1.5,true,true,"","",5];
para setVariable ["R3F_LOG_disabled", true];
armesFob addAction ["Recharger la caisse","loads\crate\armesFob.sqf",[],1.5,true,true,"","player distance2D armesFob < 10 && armesFob distance2D fob < 20",5];
medicalFob addAction ["Recharger la caisse","loads\crate\medicalFob.sqf",[],1.5,true,true,"","player distance2D medicalFob < 10 && medicalFob distance2D fob < 20",5];
lanceursFob addAction ["Recharger la caisse","loads\crate\lanceursFob.sqf",[],1.5,true,true,"","player distance2D lanceursFob < 10 && lanceursFob distance2D fob < 20",5];
acces setVariable ["R3F_LOG_disabled", true];
dump addAction ["Vider la caisse","loads\crate\dump.sqf",[],1.5,true,true,"","",5];
dump setVariable ["R3F_LOG_disabled", true];
//nul = [factory] execVM "R3F_LOG\USER_FUNCT\init_creation_factory.sqf";

if(!isNil "pa") 
then {
	base addAction ["Usine","scripts\tp\usine.sqf",["usine"],1.5,true,true,"","true",5]; 
	usine addAction ["Base Navale","scripts\tp\ob.sqf",["ob"],1.5,true,true,"","true",5]; 
	usine setVariable ["R3F_LOG_disabled", true];
	fob addAction ["Base Navale","scripts\tp\ob.sqf",["ob"],1.5,true,true,"","true",5];
	pDiv setVariable ["R3F_LOG_disabled", true];
	pDiv addAction ["CdG (Plongeur)","loads\divers\cdg.sqf",[],1.5,true,true,"","",5];
	pDiv addAction ["CdE (Plongeur)","loads\divers\cde.sqf",[],1.5,true,true,"","",5];
	pDiv addAction ["GV (Plongeur)","loads\divers\gv.sqf",[],1.5,true,true,"","",5];
	pDiv addAction ["Minimi (Plongeur)","loads\divers\minimi.sqf",[],1.5,true,true,"","",5];
	pDiv addAction ["Médecin (Plongeur)","loads\divers\medecin.sqf",[],1.5,true,true,"","",5];
}
else {
	fob addAction ["Base Opérationnelle","scripts\tp\ob.sqf",["ob"],1.5,true,true,"","true",5];
};

if(!isNil "ce")
then {
	pCav setVariable ["R3F_LOG_disabled", true];
	pInf setVariable ["R3F_LOG_disabled", true];
	pCav addAction ["Chef de Bord (médecin)","loads\ce\cdb.sqf",[],1.5,true,true,"","",5];
	pCav addAction ["Chef de Bord (groupe d'infanterie)","loads\ce\cdbr.sqf",[],1.5,true,true,"","",5];
	pCav addAction ["Equipier","loads\ce\equipier.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Chef de Groupe","loads\ce\cdg.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Chef d'Equipe","loads\ce\cde.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["GV","loads\ce\gv.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Minimi 5.56","loads\ce\minimi5.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Minimi 7.62","loads\ce\minimi7.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Médecin","loads\ce\medecin.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["EOD","loads\ce\eod.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Spotter","loads\ce\spotter.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["TP","loads\ce\tp.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["TP (groupe d'infanterie)","loads\ce\TPinf.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["TE","loads\ce\te.sqf",[],1.5,true,true,"","",5];
	acces addAction ["Recharger la caisse","loads\crate\itemsCe.sqf",[],1.5,true,true,"","",5];
}
else {
	pCav setVariable ["R3F_LOG_disabled", true];
	pInf setVariable ["R3F_LOG_disabled", true];
	pCav addAction ["Chef de Bord (médecin)","loads\da\cdb.sqf",[],1.5,true,true,"","",5];
	pCav addAction ["Chef de Bord (groupe d'infanterie)","loads\da\cdbr.sqf",[],1.5,true,true,"","",5];
	pCav addAction ["Equipier","loads\da\equipier.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Chef de Groupe","loads\da\cdg.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Chef d'Equipe","loads\da\cde.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["GV","loads\da\gv.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Minimi 5.56","loads\da\minimi5.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Minimi 7.62","loads\da\minimi7.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Médecin","loads\da\medecin.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["EOD","loads\da\eod.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["Spotter","loads\da\spotter.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["TP","loads\da\tp.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["TP (groupe d'infanterie)","loads\da\TPinf.sqf",[],1.5,true,true,"","",5];
	pInf addAction ["TE","loads\da\te.sqf",[],1.5,true,true,"","",5];
	acces addAction ["Recharger la caisse","loads\crate\itemsDa.sqf",[],1.5,true,true,"","",5];
};

sleep 3;
