/*
* Auteur : QuentinN42
* Fonction pour spawn/despawn les VLs
*
* Arguments :
* 0: Trigger <Obj>
* 1: Activation ou desactivation de la zone
*/

params ["_trigger", ["_state", False], ["_radius", 1000]];

private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];

if ((typeName _pad) != "SCALAR") then {
	private _textLoc = _pad getVariable ["trig_ODD_var_locName", ""];
	
	_pad setVariable ["trig_ODD_var_VlsWantState", _state, True];

	private _isActive = _pad getVariable ["trig_ODD_var_VlsControlActive", False];
	if (!_isActive) then {
		_pad setVariable ["trig_ODD_var_VlsControlActive", True, True];

		// Debut du spawn
		private _nb = _pad getVariable ["trig_ODD_var_Vls", 0];
		if (_state) then {
			systemChat format ["%1: Activation de %2 VLs", _textLoc, _nb];
		}
		else {
			systemChat format ["%1: Desactivation de %2 VLs", _textLoc, _nb];
		};
		// Fin du spawn

		private _WantState = _pad getVariable ["trig_ODD_var_VlsWantState", _state];
		_pad setVariable ["trig_ODD_var_VlsControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_OutpostControl;
		}
	};
};
