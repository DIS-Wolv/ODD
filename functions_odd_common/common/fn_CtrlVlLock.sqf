/*
	Auteur : Wolv
	Fonction permettant de gérer le verrouillage/déverrouillage des VLS
	Arguments :
	0: Véhicule
	1: Verrouiller (true) ou déverrouiller (false) le véhicule (par défaut : true)
	2: Peut être déverrouillé (true) ou non (false) (par défaut : true)
	3: Temps avant déverrouillage automatique (en secondes) (par défaut : 15)
	4: Distance maximale pour déverrouiller (en mètres) (par défaut : 5)
	Valeur renvoyée :
	nil
	Exemple:
	[vl] call ODDcommon_fnc_CtrlVlLock
*/

// Récupère les arguments
params ["_vl", ["_lock", true], ["_canBeUnlocked", true], ["_unlockTime", 15], ["_unlockDistance", 5]];

if (_lock) then {
	[_vl, 2] remoteExec ["lock", (owner _vl)];

	if (_canBeUnlocked) then {
		[
			_vl, "<t color='#FF0000'>Déverrouiller le véhicule</t>",
			"a3\ui_f\data\igui\cfg\actions\ico_cpt_start_on_ca.paa","a3\ui_f\data\igui\cfg\actions\ico_cpt_start_on_ca.paa",
			format ["_target distance _this < %1", _unlockDistance], true, [], [],
			{
				[_target, 0] remoteExec ["lock", (owner _target)];
			}, {}, [], _unlockTime, nil, true, true
		] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
	}
} 
else {
	[_vl, 0] remoteExec ["lock", (owner _vl)];
};
