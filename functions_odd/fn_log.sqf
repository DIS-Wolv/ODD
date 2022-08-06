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
* [["ma variable : %1", _var]] call WOLV_fnc_log
* [["exemple de debug"], true] call WOLV_fnc_log
*
* Public:
*/
params [["_arg",[""],[]], ["_Debug",false,false]];

private msg = format _arg;

diag_log format ["ODD-LOG : %1", msg];

if (_Debug) then {
	[msg] remoteExec ["systemChat", 0];
};