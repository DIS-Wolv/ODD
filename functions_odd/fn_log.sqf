/*
* Author: Wolv
* Fonction de log des ODD
*
* Arguments:
* 0: Tableau des argument a logger <Array>
* 
* Return Value:
* nil
*
* Example:
* [["ma variable : %1", _var]] call WOLV_fnc_log // log cote serveur
* missionNamespace setVariable ["DEBUG", true, true] // active le debug
* [["exemple de debug"]] call WOLV_fnc_log // log cote serveur et dans le chat
*
* Public:
*/
params [["_arg",[""],[]]];

private debug = missionNamespace getVariable "DEBUG"; 
private msg = format _arg;

diag_log format ["ODD-LOG : %1", msg];

if (debug) then {
	[msg] remoteExec ["systemChat", 0];
};
