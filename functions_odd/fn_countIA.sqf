
//["Test Count IA"] remoteExec ["systemChat", 0];
_nbIa = 0;		// au debut il y a 0

{ 
	{ 
	if (alive _x) then {		// Si l'units est en vie
		_nbIa = _nbIa + 1;		// compte plus 1 
	};  						
	} forEach units _x;  		// Pour chaque Units
} forEach MissionIA;			// De chaque groupe

_nbIa;	//return le nombre d'ia
