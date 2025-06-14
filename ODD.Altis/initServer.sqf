[] execVM "R3F_LOG\init.sqf";

//NE PAS EDITER AU DESSOUS DE CETTE LIGNE
[] call DISCommon_fnc_rDate;

enableSaving [False, False];
["DIS_mrk_FOB_0"] call DISCommon_fnc_PosFob;

[{DISCommon_var_CanTP = True; publicVariable "DISCommon_var_CanTP";}] remoteExec ["call",0,True];
sleep 5;

[] call ODDdata_fnc_var;
remoteExec ["DISCommon_fnc_customLocations", -2, True];
ODD_var_CurrentMission = 0;
publicVariable "ODD_var_CurrentMission";
oddCtrl setObjectTextureGlobal [0, "pics\OddAltis.jpg"];
[] spawn oddCTI_fnc_initMap;

[{DISCommon_var_CanTP = True; publicVariable "DISCommon_var_CanTP";}] remoteExec ["call",0,True];

[] call DISLoad_fnc_varLoads;