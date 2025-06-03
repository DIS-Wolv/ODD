/*
	Auteur : Wolv, Hhaine
	Fonction permettant de géré l'execution les triggers de RTB
	Arguments :
	0: Statut souhaité (True = je compte, False = j'attends) <BOOL>

	Valeur renvoyée :
	<Null>
	Exemple:
	[] call ODDadvanced_fnc_TrigWaitRtb
*/

params [["_state", True]];

_act = Base getVariable ['ODD_var_CountActive', False];

if (_state != _act) then {
	if (_state) then {
		Base setVariable ["ODD_var_CountActive", _state, True];
		[["Compte des joueurs sur base : %1", _state]] call ODDcommon_fnc_log;
	}
	else {
		// systemChat str(_state);
		private _playercheck = [] call ODDcommon_fnc_CountOnBase;
		if (_playercheck == 0) then {
			Base setVariable ["ODD_var_CountActive", _state, True];
			[["Compte des joueurs sur base : %1", _state]] call ODDcommon_fnc_log;
        };
	};
};
