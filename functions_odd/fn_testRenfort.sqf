/*
* Author: Wolv
* Fonction permetant de tester si des renfort deuvnent etre appeler
*
* Arguments:
* 0: Determine si des renfort deuvent etre appeler <BOOL>
* 1: Le nombre d'ia en vie sur zone <INT>
* 2: Le nombre d'ia a l'origine sur la ZO <INT>
* 3: Activation du debug dans le chat <BOOL>
*
* Return Value:
* nil
*
* Example:
* [_return, _nbIa, _BaseIa] call ODD_fnc_testRenfort
* [_return, _nbIa, _BaseIa, true] call ODD_fnc_testRenfort
*
* Public:
*/
params ["_return", "_nbIa", "_BaseIa", ["_Debug", false]];

//["Test Renfort"] remoteExec ["systemChat", 0];

if (_BaseIa / 2 > _nbIa and _return) then {
	_rdm = round (100/ (100 - ((_nbIa * 2)/_BaseIa) * 100));
	[["Test renfort %1 / %2 => %3 ", _nbIa, _BaseIa, _rdm]] call ODD_fnc_log;
	if(round(random (1 max _rdm)) == 0) then {	
		[_zo, _Debug] spawn ODD_fnc_createRenfort; // appelle renfort
		_return = false;
	};
};

_return;
