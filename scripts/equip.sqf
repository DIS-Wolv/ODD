private _unit = player;

if (!isNil("ce")) then {
	switch (str(_unit)) do {
		case "god";
		case "god1": {_unit execVM "loads\ce\zeus.sqf"}; //god

		case "coyCds": {_unit execVM "loads\ce\cds.sqf"}; //cds
		case "coyMed": {_unit execVM "loads\ce\medecin.sqf"}; //Med
		case "coyGvIng": {_unit execVM "loads\ce\gv.sqf"}; //Gv
		case "coyCde": {_unit execVM "loads\ce\cde.sqf"}; //Cde
		
		case "grCdg";
		case "sgCdg": {_unit execVM "loads\ce\cdg.sqf"}; //Cdg
		
		case "grMed";
		case "sgMed": {_unit execVM "loads\ce\medecin.sqf"}; //Med
		
		case "sgBlCde";
		case "sgGrCde";
		case "grBlCde";
		case "grGrCde": {_unit execVM "loads\ce\cde.sqf"}; //Cde
		
		case "sgGvIng";
		case "sgBlGv1";
		case "sgBlGv2";
		case "sgGrGv1";
		case "sgGrGv2";
		
		case "grGvIng";
		case "grBlGv1";
		case "grBlGv2";
		case "grGrGv1";
		case "grGrGv2": {_unit execVM "loads\ce\gv.sqf"}; //Gv
		
		case "sgCdb";
		case "grCdb": {_unit execVM "loads\ce\cdbr.sqf"};

		case "crCdb";
		case "alCdb": {_unit execVM "loads\ce\cdb.sqf"}; //CdB
		
		case "sgEq";
		case "grEq";
		case "crEq1";
		case "crEq2";
		case "alEq1";
		case "alEq2": {_unit execVM "loads\ce\equipier.sqf"}; //Eq
		
		case "haP1";
		case "haP2";
		case "haP3";
		case "haP4": {_unit execVM "loads\Helo.sqf"}; //Ha
		
		case "albP1";
		case "albP2": {_unit execVM "loads\Pilot.sqf"}; //Alb

		default {_unit execVM "loads\ce\gv.sqf"};
	};
}
else {
	switch (str(_unit)) do {
		case "god";
		case "god1": {_unit execVM "loads\da\zeus.sqf"}; //god

		case "coyCds": {_unit execVM "loads\da\cds.sqf"}; //cds
		case "coyMed": {_unit execVM "loads\da\medecin.sqf"}; //Med
		case "coyGvIng": {_unit execVM "loads\da\gv.sqf"}; //Gv
		case "coyCde": {_unit execVM "loads\da\cde.sqf"}; //Cde
		
		case "grCdg";
		case "sgCdg": {_unit execVM "loads\da\cdg.sqf"}; //Cdg
		
		case "grMed";
		case "sgMed": {_unit execVM "loads\da\medecin.sqf"}; //Med
		
		case "sgBlCde";
		case "sgGrCde";
		case "grBlCde";
		case "grGrCde": {_unit execVM "loads\da\cde.sqf"}; //Cde
		
		case "sgGvIng";
		case "sgBlGv1";
		case "sgBlGv2";
		case "sgGrGv1";
		case "sgGrGv2";
		
		case "grGvIng";
		case "grBlGv1";
		case "grBlGv2";
		case "grGrGv1";
		case "grGrGv2": {_unit execVM "loads\da\gv.sqf"}; //Gv
		
		case "sgCdb";
		case "grCdb": {_unit execVM "loads\da\cdbr.sqf"};

		case "crCdb";
		case "alCdb": {_unit execVM "loads\da\cdb.sqf"}; //CdB
		
		case "sgEq";
		case "grEq";
		case "crEq1";
		case "crEq2";
		case "alEq1";
		case "alEq2": {_unit execVM "loads\da\equipier.sqf"}; //Eq
		
		case "haP1";
		case "haP2";
		case "haP3";
		case "haP4": {_unit execVM "loads\Helo.sqf"}; //Ha
		
		case "albP1";
		case "albP2": {_unit execVM "loads\Pilot.sqf"}; //Alb

		default {_unit execVM "loads\da\gv.sqf"};
	};
};
sleep 1;