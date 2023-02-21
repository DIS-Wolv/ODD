/*
	Auteur : Wolv
	Fonction permettant de gérer le verrouillage/déverrouillage des VLS
	Arguments :
	0: Véhicule
	1: Verrouiller (True) ou déverrouiller (False) le véhicule (par défaut : True)
	2: Peut être déverrouillé (True) ou non (False) (par défaut : True)
	3: Temps avant déverrouillage automatique (en secondes) (par défaut : 15)
	4: Distance maximale pour déverrouiller (en mètres) (par défaut : 5)
	Valeur renvoyée :
	nil
	Exemple:
	[vl] call ODDcommon_fnc_CtrlVlLock
*/

// Récupère les arguments
params ["_vl", ["_lock", True], ["_canBeUnlocked", True], ["_unlockTime", 15], ["_unlockDistance", 5]];

if (_lock) then {
	[_vl, 2] remoteExec ["lock", (owner _vl)];

	if (_canBeUnlocked) then {
		[
			_vl, "<t color='#FF0000'>Déverrouiller le véhicule</t>",
			"a3\ui_f\data\igui\cfg\actions\ico_cpt_start_on_ca.paa","a3\ui_f\data\igui\cfg\actions\ico_cpt_start_on_ca.paa",
			format ["_target distance _this < %1", _unlockDistance], True, [], [],
			{
				[_target, 0] remoteExec ["lock", (owner _target)];
			}, {}, [], _unlockTime, nil, True, True
		] remoteExec ["BIS_fnc_holdActionAdd", 0, True];
	}
} 
else {
	[_vl, 0] remoteExec ["lock", (owner _vl)];
};
