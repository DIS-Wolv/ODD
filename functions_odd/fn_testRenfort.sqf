params ["_return", "_nbIa", "_BaseIa", ["_Debug", false]];

//["Test Renfort"] remoteExec ["systemChat", 0];

if (_BaseIa / 2 > _nbIa and _return) then {
	_rdm = round (100/ (100 - ((_nbIa * 2)/_BaseIa) * 100));
	if (_Debug) then {
		[Format["Test renfort %1 / %2 => %3 ", _nbIa, _BaseIa, _rdm]]remoteExec ["systemChat", 0];
	};
	if(round(random (1 max _rdm)) == 0) then {	
		[_zo, _Debug] call WOLV_fnc_createRenfort; // appelle renfort
		_return = false;
	};
};

_return;


