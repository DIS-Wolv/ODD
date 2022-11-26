/*
* Auteur : Wolv
* Fonction pour activé et désactivé les IA dans les zone quand on est pas a coté
*
* Arguments :
* 0: Trigger <Obj>
* 1: Activation ou desactivation de la zone
*
* Valeur renvoyée :
*
* Exemple:
* [_trigger, True] call ODD_fnc_areaControl
*
* Variable publique :
*/

params ["_trigger", "_state", ["_radius", 2000]];

[["ON-OFF : zone %1 : status %2", _trigger, _state]] call ODD_fnc_log;

_isActive = _trigger getVariable ["trig_ODD_var_active", False];

if (_isActive) then {
	_scriptID = _trigger getVariable ["trig_ODD_var_scriptID", -1];
	if (_scriptID != -1) then {
		terminate _scriptID;
		_trigger setVariable ["trig_ODD_var_active", False, True];
		_trigger setVariable ["trig_ODD_var_scriptID", -1, True];
	};
};


if (! _isActive) then {	
	_trigger setVariable ["trig_ODD_var_active", True, True];

	_pos = position _trigger;

	_IA = _pos nearEntities _radius;

	if (!_state) then {
		dostop _IA;
	};
	{
		if (_state) then {
			_x enableAI 'All';
			_x stop False;
		}
		else {
			_x stop True;
			sleep 0.5;
			_x disableAI 'All';
		}
	} forEach _IA;

	_trigger setVariable ["trig_ODD_var_active", False, True];
}
else {
	[["Erreur coupure du script arera control"]] call ODD_fnc_log;
};

_trigger setVariable ["trig_ODD_var_active", False, True];
_trigger setVariable ["trig_ODD_var_scriptID", -1, True];

/*
	format ["
		[('Test ON : ' + '%1')] remoteExec ['systemChat', 0];
		_pos = position thisTrigger;
		_IA = _pos nearEntities %2;
		{
			_x stop false;
		} forEach _IA;
	", text _x, _rad], 
	format ["
		[('Test OFF : ' + '%1')] remoteExec ['systemChat', 0];
		_pos = position thisTrigger;
		_IA = _pos nearEntities %2;
		{
			_x stop true;
		} forEach _IA;
	", text _x, _rad]

*/
