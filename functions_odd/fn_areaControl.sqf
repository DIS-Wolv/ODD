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

params ["_trigger", ["_state", False], ["_radius", 1000]];

_loc = _trigger getVariable ["trig_ODD_var_loc", -1];

if ((typeName _loc) != "SCALAR") then {
	_textLoc = _loc getVariable ["trig_ODD_var_locName", ""];
	[["ON-OFF : Zone %1 : status %2", _textLoc, _state]] call ODD_fnc_log;
	
	_loc setVariable ["trig_ODD_var_WantState", _state, True];

	_isActive = _loc getVariable ["trig_ODD_var_active", False];
	if (!_isActive) then {
		_loc setVariable ["trig_ODD_var_active", True, True];

		_pos = position _loc;

		_IA = _pos nearEntities _radius;
		if (!_state) then {
			[_IA] remoteExec["dostop", 2];
		};
		{
			if (_state) then {
				[_x, 'ALL'] remoteExec ["enableAI", owner _x];
				
				if ((_x getVariable ["acex_headless_blacklist", False]) == True) then {
					[_x, 'PATH'] remoteExec ["disableAI", owner _x];
				};

				[_x, False] remoteExec ["stop", owner _x];
			}
			else {
				[_x, True] remoteExec ["stop", owner _x];
				sleep 0.5;
				[_x, 'ALL'] remoteExec ["disableAI", owner _x];
			}
		} forEach _IA;

		_loc setVariable ["trig_ODD_var_ActiveState", _state, True];

		_WantState = _loc getVariable ["trig_ODD_var_WantState", _state];
		_loc setVariable ["trig_ODD_var_active", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODD_fnc_areaControl;
		}
	};
};


/////////////////////////////////////////////////////////////////////////////////////

// _isActive = _trigger getVariable ["trig_ODD_var_active", False];

// if (_isActive) then {
// 	_scriptID = _trigger getVariable ["trig_ODD_var_scriptID", -1];
// 	[["ScriptID : %1 | IsDone : %2", _scriptID, scriptDone _scriptID]] call ODD_fnc_log;
// 	if (_scriptID != -1) then {
// 		terminate _scriptID;
// 		_trigger setVariable ["trig_ODD_var_active", False, True];
// 		_trigger setVariable ["trig_ODD_var_scriptID", -1, True];
// 	};
// };


// if (! _isActive) then {	
// 	_trigger setVariable ["trig_ODD_var_active", True, True];

// 	_pos = position _loc;

// 	_IA = _pos nearEntities _radius;

// 	if (!_state) then {
// 		[_IA] remoteExec["dostop", 2];
// 	};
// 	{
// 		if (_state) then {
// 			[_x, 'ALL'] remoteExec ["enableAI", owner _x];
// 			[_x, False] remoteExec ["stop", owner _x];
// 		}
// 		else {
// 			[_x, True] remoteExec ["stop", owner _x];
// 			sleep 0.5;
// 			[_x, 'ALL'] remoteExec ["disableAI", owner _x];
// 		}
// 	} forEach _IA;

// 	_trigger setVariable ["trig_ODD_var_active", False, True];
// }
// else {
// 	[["Erreur coupure du script arera control"]] call ODD_fnc_log;
// };

// _trigger setVariable ["trig_ODD_var_active", False, True];
// _trigger setVariable ["trig_ODD_var_scriptID", -1, True];

/*
	format ["
		[('Test ON : ' + '%1')] remoteExec ['systemChat', 0];
		_pos = position thisTrigger;
		_IA = _pos nearEntities %2;
		{
			_x stop False;
		} forEach _IA;
	", text _x, _rad], 
	format ["
		[('Test OFF : ' + '%1')] remoteExec ['systemChat', 0];
		_pos = position thisTrigger;
		_IA = _pos nearEntities %2;
		{
			_x stop True;
		} forEach _IA;
	", text _x, _rad]

*/
