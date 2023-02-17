[] execVM "R3F_LOG\init.sqf";
[] execVM "scripts\rDate.sqf";
[] spawn DISCommon_fnc_markers;

enableSaving [false, false];

// Partie pour les ODD (Opération Dynamique de la DIS)
["DIS_mrk_FOB_0"] call DISCommon_fnc_PosFob;
call ODDadvanced_fnc_var;
call DISCommon_fnc_customLocations;
ODD_var_CurrentMission = 0;
publicVariable "ODD_var_CurrentMission";
oddCtrl setObjectTextureGlobal [0, "pics\OddAltis.jpg"];

//NE PAS EDITER AU DESSOUS DE CETTE LIGNE
sleep 5;
//tawvd_disablenone = true;
base setObjectTextureGlobal [0, "pics\disMoto.jpg"];
rules setObjectTextureGlobal [0, "pics\tip.jpg"];
pCav setObjectTextureGlobal [0, "pics\cav.jpg"];
pPil setObjectTextureGlobal [0, "pics\pilot.jpg"];
armes spawn DISLoadCrate_fnc_armes;
medical spawn DISLoadCrate_fnc_medical;
lanceurs spawn DISLoadCrate_fnc_lanceurs;
para spawn DISLoadCrate_fnc_para;
armesFob spawn DISLoadCrate_fnc_armes;
medicalFob spawn DISLoadCrate_fnc_medical;
lanceursFob spawn DISLoadCrate_fnc_lanceurs;
acces setVariable ["R3F_LOG_disabled", true];
dump setVariable ["R3F_LOG_disabled", true];
dump spawn DISLoadCrate_fnc_dump;

if(!isNil "pa") 
then {
	pDiv setObjectTextureGlobal [0, "pics\divers.jpg"];
};

if(!isNil "ce")
then {
	pInf setVariable ["R3F_LOG_disabled", true];
	pInf setObjectTextureGlobal [0, "pics\ce.jpg"];
	acces spawn DISLoadCrate_fnc_itemsCe;
}
else {
	pInf setVariable ["R3F_LOG_disabled", true];
	pInf setObjectTextureGlobal [0, "pics\da.jpg"];
	acces spawn DISLoadCrate_fnc_itemsDa;
};

//[] remoteExec ["scripts\rWeather.sqf"]; 
