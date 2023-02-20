/*
* Auteur : Wolv
* Fonction pour compter les IA en vie dans la zone principale
*
* Arguments :
* 0: Activation du débug dans le chat <BOOL>
*
* Valeur renvoyée :
* Nombre d'IA en vie <INT>
*
* Exemple :
* [] call ODDadvanced_fnc_countIA
*
* Variable publique :
*/
params [];

private _nbIa = 0;		// Initialisation à 0

{ 
	{ 
	if ((alive _x) and !(captive _x) and (lifeState _x != "INCAPACITATED") and !(_x getVariable ['ace_captives_issurrendering', False])) then {		// Si l'unité est en vie
		_nbIa = _nbIa + 1;						// Ajoute 1 au compte
	};
	} forEach units _x;  						// Pour chaque unité
} forEach ODD_var_MainAreaIA;					// De chaque groupe

[["Nombre d'IA : %1", str(_nbIa)]] call ODDadvanced_fnc_log;
_nbIa;											// Renvoie le nombre d'IA