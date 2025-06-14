[player] call DISLoad_fnc_Equip;
[] execVM "scripts\intro.sqf";
[] execVM "R3F_LOG\init.sqf";

base addAction ["FOB", {[position fob] call DISCommon_fnc_fastTravel},[],1.5,True,True,"","DISCommon_var_CanTP",5];
base addAction ["Usine", {[position usine] call DISCommon_fnc_fastTravel},[],1.5,True,True,"","DISCommon_var_CanTP",5];

// Partie pour les ODD (Opération Dynamique de la DIS)
[] call ODDdata_fnc_var;
// call DIScommon_fnc_customLocations;
oddCtrl addAction ["<t color='#1836E9'>ODD</t>", {[] call OddGuiMissions_fnc_open;},[],1.5,True,True,"","True",5];
// oddCtrl addAction ["<t color='#1836E9'>ODD</t>", {systemChat "Panneaux Désactivé";},[],1.5,True,True,"","True",5];
oddCtrl setVariable ["R3F_LOG_disabled", True];
_haltAction = ["haltCivilian","Halt","\z\ace\addons\captives\ui\Surrender_ca.paa",{[player] call ODDadvanced_fnc_haltCivilian},{True}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _haltAction] call ace_interact_menu_fnc_addActionToObject;
[] call ODDadvanced_fnc_infoOdd;
[True] call ODDadvanced_fnc_particules;

