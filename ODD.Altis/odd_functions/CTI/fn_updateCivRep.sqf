/*
* Auteur : Wolv
* Fonction pour mettre a jours la variable de réputation civils 
*
* Arguments :
* - int Value : valeur du modificateur
* 
* Valeur renvoyée :
*
* Exemple :
*   [0] call ODDCTI_fnc_updateCivRep;
*
* Variable publique :
* 
*/

params [["_value", 0]];


ODD_var_CivilianReputation = (
	(
		(
			ODD_var_CivilianReputation + _value
		) max 0
	) min 100);

[["Civilan Rept Modification %1 => %2", _value, ODD_var_CivilianReputation]] call ODDcommon_fnc_log;

