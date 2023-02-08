[] execVM "R3F_LOG\init.sqf";
[] execVM "scripts\rDate.sqf";
[] execVM "scripts\markers.sqf";

enableSaving [false, false];

// Partie pour les ODD (Opération Dynamique de la DIS)
["DIS_mrk_FOB_0"] call DISCommon_fnc_PosFob;
call ODD_fnc_var;
call DISCommon_fnc_customLocation;
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
armes execVM "loads\crate\armes.sqf";
medical execVM "loads\crate\medical.sqf";
lanceurs execVM "loads\crate\lanceurs.sqf";
para execVM "loads\crate\para.sqf";
armesFob execVM "loads\crate\armesFob.sqf";
medicalFob execVM "loads\crate\medicalFob.sqf";
lanceursFob execVM "loads\crate\lanceursFob.sqf";
acces setVariable ["R3F_LOG_disabled", true];
dump setVariable ["R3F_LOG_disabled", true];
dump execVM "loads\crate\dump.sqf";

if(!isNil "pa") 
then {
	pDiv setObjectTextureGlobal [0, "pics\divers.jpg"];
};

if(!isNil "ce")
then {
	pInf setVariable ["R3F_LOG_disabled", true];
	pInf setObjectTextureGlobal [0, "pics\ce.jpg"];
	acces execVM "loads\crate\itemsCe.sqf";
}
else {
	pInf setVariable ["R3F_LOG_disabled", true];
	pInf setObjectTextureGlobal [0, "pics\da.jpg"];
	acces execVM "loads\crate\itemsDa.sqf";
};

//[] remoteExec ["scripts\rWeather.sqf"]; 
