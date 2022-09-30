/*
* Auteur : Wolv
* Fonction pour écrire dans le RPT (et possiblement dans le chat) les informations de débug
*
* Arguments :
* 0: Tableau des argument que l'on veut dans le log <Array>
* 
* Valeur renvoyée :
* nil
*
* Exemple :
* [["ma variable : %1", _var]] call ODD_fnc_log // Pour log uniquement sur le RPT
* missionNamespace setVariable ["ODD_var_DEBUG", true, true] // Pour commencer l'affichage des messages de débug dans le chat
* [["exemple de ODD_var_DEBUG"]] call ODD_fnc_log // Pour log dans le RPT et dans le chat
*
* Variable publique :
*/
params [["_arg",[""],[]]];

private _debug = missionNamespace getVariable "ODD_var_DEBUG"; 
if (isNil "_debug") then {
	_debug = false;
};
private _msg = format _arg;

diag_log format ["ODD-LOG : %1", _msg];

if (_debug) then {
	[_msg] remoteExec ["systemChat", 0];
};
