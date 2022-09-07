/*
* Author: Wolv
* Fonction permetant de compter les IA en vie dans la zone principale
*
* Arguments:
* 0: Activation du ODD_var_DEBUG dans le chat <BOOL>
*
* Return Value:
* le nombre d'IA en vie <INT>
*
* Example:
* [] call ODD_fnc_countIA
* [true] call ODD_fnc_countIA
*
* Public:
*/
params [["_Debug", false]];
//["Test Count IA"] remoteExec ["systemChat", 0];
private _nbIa = 0;		// au debut il y a 0

{ 
	{ 
	if (alive _x and !(captive _x)) then {		// Si l'units est en vie
		_nbIa = _nbIa + 1;		// compte plus 1 
	};
	} forEach units _x;  		// Pour chaque Units
} forEach ODD_var_MissionIA;			// De chaque groupe

[["Nombre d'IA : %1", str(_nbIa)]] call ODD_fnc_log;
_nbIa;	//return le nombre d'ia
