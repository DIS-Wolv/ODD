/*
* Auteur : Wolv & Hhaine
* Fonction pour activé et désactivé les IA dans les zone quand on est pas a coté
*
* Arguments :
* 0: Trigger <Obj>
* 1: Activation ou desactivation de la zone
*
* Valeur renvoyée :
*
* Exemple:
* [_trigger, True] call ODDadvanced_fnc_areaControl
*
* Variable publique :
*/

params ["_trigger", ["_state", False], ["_radius", 1000]];
private _loc = _trigger getVariable ["trig_ODD_var_Pad", -1];

if ((typeName _loc) != "SCALAR") then {
	private _textLoc = _loc getVariable ["trig_ODD_var_locName", ""];
	[["Spawn Civil : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	
	_loc setVariable ["trig_ODD_var_civWantState", _state, True];

	_isActive = _loc getVariable ["trig_ODD_var_civControlActive", False];
	if (!_isActive) then {
		_loc setVariable ["trig_ODD_var_civControlActive", True, True];
		
		// Spawn des civils
		_pos = position _loc;
		_IA = _pos nearEntities _radius;
		{
			_own = owner _x;
			if (_state) then {
				[_x, 'ALL'] remoteExec ["enableAI", _own];
				
				if ((_x getVariable ["ODD_var_IsInGarnison", False]) == True) then {
					[_x, 'PATH'] remoteExec ["disableAI", _own];
				};

				[_x, False] remoteExec ["stop", _own];
			}
			else {
				[_x] remoteExec ["dostop", _own];
				[_x, True] remoteExec ["stop", _own];
				uisleep 1;
				[_x, 'ALL'] remoteExec ["disableAI", _own];
			}
		} forEach _IA;
		// Fin du spawn 

		_WantState = _loc getVariable ["trig_ODD_var_civWantState", _state];
		_loc setVariable ["trig_ODD_var_civControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_civControl;
		}
	};
};