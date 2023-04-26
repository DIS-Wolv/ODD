params ["_unit"];

if (!isNil("ce")) then {
	switch (str(_unit)) do {
		case "god";
		case "god1": {[_unit] call DISLoadCe_fnc_zeus}; //god

		case "coyCds": {[_unit] call DISLoadCe_fnc_cds}; //cds
		case "coyMed": {[_unit] call DISLoadCe_fnc_medecin}; //Med
		case "coyGvIng": {[_unit] call DISLoadCe_fnc_gv}; //Gv
		case "coyCde": {[_unit] call DISLoadCe_fnc_cde}; //Cde
		
		case "grCdg";
		case "trCdg";
		case "sgCdg": {[_unit] call DISLoadCe_fnc_cdg}; //Cdg
		
		case "grMed";
		case "trMed";
		case "sgMed": {[_unit] call DISLoadCe_fnc_medecin}; //Med
		
		case "sgBlCde";
		case "sgGrCde";
		case "trBlCde";
		case "trGrCde";
		case "grBlCde";
		case "grGrCde": {[_unit] call DISLoadCe_fnc_cde}; //Cde
		
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
		case "grGrGv2": {[_unit] call DISLoadCe_fnc_gv}; //Gv
		
		case "sgCdb";
		case "trCdb";
		case "grCdb": {[_unit] call DISLoadCe_fnc_cdbr};

		case "crCdb";
		case "trCdb";
		case "alCdb": {[_unit] call DISLoadCe_fnc_cdb}; //CdB
		
		case "sgEq";
		case "grEq";
		case "trEq";
		case "crEq1";
		case "crEq2";
		case "alEq1";
		case "alEq2": {[_unit] call DISLoadCe_fnc_equipier}; //Eq
		
		case "haP1";
		case "haP2";
		case "haP3";
		case "haP4": {[_unit] call DISLoad_fnc_Helo}; //Ha
		
		case "albP1";
		case "albP2": {[_unit] call DISLoad_fnc_Pilot}; //Alb

		default {[_unit] call DISLoadCe_fnc_gv};
	};
}
else {
	switch (str(_unit)) do {
		case "god";
		case "god1": {[_unit] call DISLoadDa_fnc_zeus}; //god

		case "coyCds": {[_unit] call DISLoadDa_fnc_cds}; //cds
		case "coyMed": {[_unit] call DISLoadDa_fnc_medecin}; //Med
		case "coyGvIng": {[_unit] call DISLoadDa_fnc_gv}; //Gv
		case "coyCde": {[_unit] call DISLoadDa_fnc_cde}; //Cde
		
		case "grCdg";
		case "sgCdg": {[_unit] call DISLoadDa_fnc_cdg}; //Cdg
		
		case "grMed";
		case "sgMed": {[_unit] call DISLoadDa_fnc_medecin}; //Med
		
		case "sgBlCde";
		case "sgGrCde";
		case "grBlCde";
		case "grGrCde": {[_unit] call DISLoadDa_fnc_cde}; //Cde
		
		case "sgGvIng";
		case "sgBlGv1";
		case "sgBlGv2";
		case "sgGrGv1";
		case "sgGrGv2";
		
		case "grGvIng";
		case "grBlGv1";
		case "grBlGv2";
		case "grGrGv1";
		case "grGrGv2": {[_unit] call DISLoadDa_fnc_gv}; //Gv
		
		case "sgCdb";
		case "grCdb": {[_unit] call DISLoadDa_fnc_cdbr};

		case "crCdb";
		case "alCdb": {[_unit] call DISLoadDa_fnc_cdb}; //CdB
		
		case "sgEq";
		case "grEq";
		case "crEq1";
		case "crEq2";
		case "alEq1";
		case "alEq2": {[_unit] call DISLoadDa_fnc_equipier}; //Eq
		
		case "haP1";
		case "haP2";
		case "haP3";
		case "haP4": {[_unit] call DISLoad_fnc_Helo}; //Ha
		
		case "albP1";
		case "albP2": {[_unit] call DISLoad_fnc_Pilot}; //Alb

		default {[_unit] call DISLoadDa_fnc_gv};
	};
};
sleep 1;