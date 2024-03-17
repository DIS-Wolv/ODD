/*
* Auteur : QuentinN42
* Fonction pour donner des intels aux joueurs.
*
* Arguments :
* _src:
*  - "CIVIL"
*  - "OPFOR"
*  - "PRENS"
*
* _target:
*  - si _src="CIVIL" : le civil a qui on parle
*  - si _src="OPFOR" : l'IA qu'on interoge
*  - si _src="PRENS" : la zone de mission
*
* Valeur renvoyée :
* nil
*
* Exemple :

// Init :
[] call ODDdata_fnc_varIntel;
ODD_var_Crates = [
	"ACE_medicalSupplyCrate_advanced" createvehicle (position player)
];

// Exec
["CIVIL", player] call ODDintels_fnc_maybeGiveIntel;

*/
params[["_src", "CIVIL"], ["_target", objNull]];


private _doit_donner_intel = true;

// TODO : probas en fonction de _src et _target
private _res_txt = nil;
private _res_pos = nil;

if (_doit_donner_intel) then {
    private _res = [_src,_target] call ODDintels_fnc_giveIntel;
    _res_txt = _res select 0;
    _res_pos = _res select 1;
} else {
    _res_txt = selectRandom (ODD_var_intel_msgs_NO get _src);
};

// Si texte non nil et non vide, on affiche l'intel.
if (!isNil "_res_txt" && _res_txt != "") then {
    // Affichage de l'intel
    [_res_txt] remoteExec ["systemChat", 0];
} else {
    // BUG : fallback sur un message generique
    ["Je n'ai rien a vous dire."] remoteExec ["systemChat", 0];
};

// TODO : impl _res_pos
