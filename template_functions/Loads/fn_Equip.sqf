params ["_unit"];

if (isNil "_unit") exitWith {};
if (isNil "DISLoadMc_var_Zeus") then {[] call DISLoad_fnc_varLoads;};

switch (str(_unit)) do {
	case "god";
	case "god1": {[DISLoadMc_var_Zeus, _unit] call DISLoad_fnc_SetLoad;}; //god

	case "coyCds": {[DISLoadMc_var_CdS, _unit] call DISLoad_fnc_SetLoad;}; //cds
	
	case "grCdg";
	case "trCdg";
	case "sgCdg": {[DISLoadMc_var_CdG, _unit] call DISLoad_fnc_SetLoad;}; //Cdg
	
	case "coyMed";
	case "grMed";
	case "trMed";
	case "sgMed": {[DISLoadMc_var_Medecin, _unit] call DISLoad_fnc_SetLoad;}; //Med
	
	case "coyCde";
	case "sgBlCde";
	case "sgGrCde";
	case "trBlCde";
	case "trGrCde";
	case "grBlCde";
	case "grGrCde": {[DISLoadMc_var_CdE, _unit] call DISLoad_fnc_SetLoad;}; //Cde
	
	case "coyGvIng";

	case "sgGvIng";
	case "sgBlGv1";
	case "sgBlGv2";
	case "sgGrGv1";
	case "sgGrGv2";

	case "trGvIng";
	case "trBlGv1";
	case "trBlGv2";
	case "trGrGv1";
	case "trGrGv2";
	
	case "grGvIng";
	case "grBlGv1";
	case "grBlGv2";
	case "grGrGv1";
	case "grGrGv2": {[DISLoadMc_var_GvBck, _unit] call DISLoad_fnc_SetLoad;}; //Gv
	
	case "sgCdb";
	case "trCdb";
	case "grCdb": {[DISLoadMc_var_CDBR, _unit] call DISLoad_fnc_SetLoad;};

	case "crCdb";
	case "trCdb";
	case "alCdb": {[DISLoadMc_var_CDB, _unit] call DISLoad_fnc_SetLoad;}; //CdB
	
	case "sgEq";
	case "grEq";
	case "trEq";
	case "crEq1";
	case "crEq2";
	case "alEq1";
	case "alEq2": {[DISLoadMc_var_Equipier, _unit] call DISLoad_fnc_SetLoad;}; //Eq
	
	case "haP1";
	case "haP2";
	case "haP3";
	case "haP4": {[DISLoad_var_piloteHelo, _unit] call DISLoad_fnc_SetLoad;}; //Ha
	
	case "albP1";
	case "albP2": {[DISLoad_var_piloteAvions, _unit] call DISLoad_fnc_SetLoad;}; //Alb

	default {[DISLoadMc_var_GV, _unit] call DISLoad_fnc_SetLoad;};
};


sleep 1;