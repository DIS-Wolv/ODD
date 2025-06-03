/*
* Auteur : Wolv
* Fonction pour spawn/despawn les IEDs dans les localités proches du joueur 
*
* Arguments :
* 0: Trigger <Obj>
* 1: Activation ou desactivation de la zone
*
* Valeur renvoyée :
*
* Exemple:
* [_trigger, True] call ODDcommon_fnc_IEDControl
*
* Variable publique :
*/

params ["_trigger", ["_state", False], ["_radius", 1000]];

private _map = (findDisplay 12 displayCtrl 51);  // récupères le control de ta map.

private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];

if ((typeName _pad) != "SCALAR") then {
	private _textLoc = _pad getVariable ["trig_ODD_var_locName", ""];
	[["Spawned IED : Zone %1 : status %2", _textLoc, _state]] call ODDcommon_fnc_log;
	
	_pad setVariable ["trig_ODD_var_iedWantState", _state, True];

	_isActive = _pad getVariable ["trig_ODD_var_iedControlActive", False];
	if (!_isActive) then {
		_pad setVariable ["trig_ODD_var_iedControlActive", True, True];
		
		// Debut du spawn
		_IEDS = _pad getVariable ["trig_ODD_var_IEDs", ""];
		if (_state) then {
			
			private _IEDsCover = [];
			{
				private _coverType = _x select 0;
				private _coverPos = _x select 1;
				private _coverDir = _x select 2;
				private _exploType = _x select 3;
				private _exploPos = _x select 4;
				private _type = _x select 5;
				private _triggerManType = _x select 6;
				private _triggerManPos = _x select 7;

				private _cover = [_coverType, _coverPos, _coverDir, _exploType, _exploPos, _type, _triggerManType, _triggerManPos] call ODDcommon_fnc_ied;

				_IEDsCover pushBack _cover;
			} forEach _IEDS;

			_pad setVariable ["trig_ODD_var_IEDs", _IEDsCover, True];
		}
		else {
			private _IEDsCover = [];
			{
				private _cover = _x;
				private _exploType = "";
				private _exploPos = [0,0,0];

				private _coverType = _cover getVariable ["ODD_var_IED_coverType", ""];
				private _coverPos = _cover getVariable ["ODD_var_IED_coverPos", [0,0,0]];
				private _coverDir = _cover getVariable ["ODD_var_IED_coverDir", 0];
				private _type = _cover getVariable ["ODD_var_IED_Type", -1];
				private _explo = _cover getVariable ["ODD_var_IED_Explo", objNull];
				private _triggerMan = _cover getVariable ["ODD_var_IED_TriggerMan", objNull];
				private _triggerManType = _cover getVariable ["ODD_var_IED_TriggerManType", ""];
				private _triggerManPos = _cover getVariable ["ODD_var_IED_TriggerManPos", [0,0,0]];

				if ((position _cover) distance2D _coverPos < 20) then {
					deleteVehicle _cover;
				};
				if (!isNull _explo) then {
					_exploType = _explo getVariable ["ODD_var_IED_ExploType", ""];
					_exploPos = _explo getVariable ["ODD_var_IED_ExploPos", ""];
					_triggerExplo = _explo getVariable ["ODD_var_IED_Trigger", ""];
					
					deleteVehicle _explo;
					deleteVehicle _triggerExplo;
				}
				else {
					_type = -1;
				};
				if (!isNull _triggerMan) then {
					deleteVehicle _triggerMan;
				};
				_IEDsCover pushBack [_coverType, _coverPos, _coverDir, _exploType, _exploPos, _type, _triggerManType, _triggerManPos];
			} forEach _IEDS;
			_pad setVariable ["trig_ODD_var_IEDs", _IEDsCover, True];
		};
		// Fin du spawn 

		_WantState = _pad getVariable ["trig_ODD_var_IEDWantState", _state];
		_pad setVariable ["trig_ODD_var_iedControlActive", False, True];
		if (!(_WantState == _state)) then {
			[_trigger, _WantState] spawn ODDcommon_fnc_IEDControl;
		}
	};
};
