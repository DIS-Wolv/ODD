/*
* Auteur : Wolv
*	Fonction permettant de géré le lock/unlock des vls
*
* Arguments :
* 0: Vehicule
*
* Valeur renvoyée :
* nil
*
* Exemple:
* [vl] call ODDcommon_fnc_CtrlVlLock
*
*/

// Récupère les arguments
params ["_vl", ["_lock", True], ["_CanBeUnlock", True], ["_UnlockTime", 15], ["_UnlockDistance", 5]];

if (_lock) then {
	[_vl, 2] remoteExec ["lock", (owner _vl)];

	if (_CanBeUnLock) then {
		[
			_vl, "<t color='#FF0000'>Déverrouiller le véhicule</t>",
			"a3\ui_f\data\igui\cfg\actions\ico_cpt_start_on_ca.paa","a3\ui_f\data\igui\cfg\actions\ico_cpt_start_on_ca.paa",
			Format["_target distance _this < %1", _UnlockDistance], "True", {}, {},
			{
				[_target, 0] remoteExec ["lock", (owner _target)];
			},{}, [], (_UnLockTime), nil, True, True
		] remoteExec ["BIS_fnc_holdActionAdd", 0, True];
	}
}
else {
	[_vl, 0] remoteExec ["lock", (owner _vl)];
};
