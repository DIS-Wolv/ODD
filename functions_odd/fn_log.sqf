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
* [["ma variable : %1", _var]] call ODD_fnc_log // log cote serveur
* missionNamespace setVariable ["DEBUG", true, true] // active le debug
* [["exemple de debug"]] call ODD_fnc_log // log cote serveur et dans le chat
*
* Public:
*/
params [["_arg",[""],[]]];

private _debug = missionNamespace getVariable "DEBUG"; 
if(isNil "_debug") then {
	_debug = false;
};
private _msg = format _arg;

diag_log format ["ODD-LOG : %1", _msg];

if (_debug) then {
	[_msg] remoteExec ["systemChat", 0];
};
