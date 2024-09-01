[] execVM "R3F_LOG\init.sqf";
[] execVM "scripts\rDate.sqf";
[] spawn DISCommon_fnc_markers;
[] call DISCommon_fnc_customLocations;

enableSaving [False, False];

// Partie pour les ODD (Opération Dynamique de la DIS)
["DIS_mrk_FOB_0"] call DISCommon_fnc_PosFob;
[] call ODDdata_fnc_var;
remoteExec ["DISCommon_fnc_customLocations", -2, True];
ODD_var_CurrentMission = 0;
publicVariable "ODD_var_CurrentMission";
oddCtrl setObjectTextureGlobal [0, "pics\OddAltis.jpg"];
[] spawn oddCTI_fnc_initMap;

//NE PAS EDITER AU DESSOUS DE CETTE LIGNE
sleep 5;
//tawvd_disablenone = True;
base setObjectTextureGlobal [0, "pics\disMoto.jpg"];
rules setObjectTextureGlobal [0, "pics\tip.jpg"];
pCav setObjectTextureGlobal [0, "pics\cav.jpg"];
pPil setObjectTextureGlobal [0, "pics\pilot.jpg"];
pRens setObjectTextureGlobal [0, "pics\rens.jpg"];
armes spawn DISLoadCrate_fnc_armes;
medical spawn DISLoadCrate_fnc_medical;
lanceurs spawn DISLoadCrate_fnc_lanceurs;
para spawn DISLoadCrate_fnc_para;
armesFob spawn DISLoadCrate_fnc_armes;
medicalFob spawn DISLoadCrate_fnc_medical;
lanceursFob spawn DISLoadCrate_fnc_lanceurs;
acces setVariable ["R3F_LOG_disabled", True];
dump setVariable ["R3F_LOG_disabled", True];
dump spawn DISLoadCrate_fnc_dump;

if(!isNil "pa") 
then {
	pDiv setObjectTextureGlobal [0, "pics\divers.jpg"];
	pDiv setVariable ["R3F_LOG_disabled", True];
};

pInf setVariable ["R3F_LOG_disabled", True];
pInf setObjectTextureGlobal [0, "pics\ce.jpg"];
acces spawn DISLoadCrate_fnc_items;

[] call DISLoad_fnc_varLoads;
[pCav] call DISLoad_fnc_ArsenalAce;
//[] remoteExec ["scripts\rWeather.sqf"];

["marker_1", FOB, True] call DISCommon_fnc_markers;
