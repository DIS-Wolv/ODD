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

// On stocke une variable globale a la mission pour reduire 
// progressivement les chances d'obtenir des intels.
clientOwner publicVariableClient "ODD_var_intel_interogation_data";
if (isNil "ODD_var_intel_interogation_data") then { ODD_var_intel_interogation_data = createHashMap;};
private _proba_reducer = ODD_var_intel_interogation_data getOrDefault [_src, 100];


// Choix de si on doit donner des intels


private _pourcent_de_chance = 100;
if (_src == "OPFOR") then {  // Torture
	private _torture = _target getVariable ["ace_medical_medications", []];
	_pourcent_de_chance = 30 + 10*(count _torture);
};


// Calcul depuis le % de chances
private _doit_donner_intel = ((random 100) < _pourcent_de_chance) and ((random 100) <  _proba_reducer);


// Donne les intels

private _res_txt = nil;
private _res_pos = nil;

if (_doit_donner_intel) then {
    ODD_var_intel_interogation_data set [_src, _proba_reducer * 3/4];
    publicVariableServer "ODD_var_intel_interogation_data";
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
