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
params [["_zo", ODD_var_SelectedArea], ["_radius", (size ODD_var_SelectedArea) select 0]];

private _nbIa = 0;		// Initialisation à 0
private _pos = position _zo;
private _nearMen = _pos nearEntities [["man", "Car", "Air"], _radius];

{ 
	if ((alive _x) and !(captive _x) and (lifeState _x != "INCAPACITATED") and !(_x getVariable ['ace_captives_issurrendering', False]) and (side _x != west) and (side _x != civilian)) then {		// Si l'unité est en vie
		_nbIa = _nbIa + 1;						// Ajoute 1 au compte
	};
} forEach _nearMen;					// chaque men

[["Nombre d'IA : %1", str(_nbIa)]] call ODDcommon_fnc_log;
_nbIa;											// Renvoie le nombre d'IA
