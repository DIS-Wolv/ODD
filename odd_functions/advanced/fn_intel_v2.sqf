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
["CIVIL", player] call ODDadvanced_fnc_intel_v2;

*/
params[["_src", "CIVIL"], ["_target", objNull]];


private _doit_donner_intel = {
    params[["_src", "CIVIL"], ["_target", objNull]];
    // TODO
    true
};

private _format_dist_angle = {
    params[["_dist", 0], ["_angle", 0]];
    private _msg = "";
    if (0.5 > random 1) then {  // une chance sur deux donner une distance en texte
        private _txt = switch (floor(_dist/100)) do {
            case 0: { "très proche" };
            case 1: { "proche" };
            case 2: { "loin" };
            default { "très loin" };
        };
        _msg = _msg + " " + _txt;
    } else { // sinon en chiffre
        _msg = _msg + format [" a %1m", 50 + floor(_dist/50)*50];
    };
    private _azim = switch (floor((_angle+22.5)/45)) do {
        case 0: { "Nord" };
        case 1: { "Nord-Est" };
        case 2: { "Est" };
        case 3: { "Sud-Est" };
        case 4: { "Sud" };
        case 5: { "Sud-Ouest" };
        case 6: { "Ouest" };
        case 7: { "Nord-Ouest" };
        default { "Nord" };
    };
    _msg = _msg + " au " + _azim;
    _msg
};
private _format_grid = {
    params[["_loc", [0,0,0]]];
    format [" en %1%2.", floor((_loc select 0) / 100), floor((_loc select 1) / 100)]
};
private _format_caisse = {
    params[["_crate", objNull]];
    private _msg = selectRandom [
        "une caisse",
        "un ravitaillement"
    ];
    if (0.5 > random 1) then {  // une chance sur deux de preciser le type
        if ("medical" in typeOf _crate) then {
            _msg = _msg + " " + selectRandom [
                "medical",
                "de soins"
            ];
        } else {
            _msg = _msg + " " + selectRandom [
                "d'armes",
                "d'armement",
                "d'equipement",
                "de munitions",
                "de materiel"
            ];
        };
    };
    _msg
};
private _format_vl = {
    params[["_vl", objNull]];
    private _msg = selectRandom [
        "un vehicule",
        "un engin",
        "un pick-up"
    ];
    if ((typeOf _vl) in ODD_var_HeavyVehicles) then {
        _msg = selectRandom [
            "un tank",
            "un vehicule lourd",
            "un engin lourd"
        ];
    };
    if ((typeOf _vl) in ODD_var_TransportVehicles) then {
        _msg = selectRandom [
            "un vehicule de transport",
            "un vehicule de logistique",
            "un vehicule de ravitaillement"
        ];
    };
    if ((typeOf _vl) in ODD_var_FlyingVehicles) then {
        _msg = selectRandom [
            "un vehicule aérien",
            "un engin aérien"
        ];
    };
    _msg
};

// ODD_var_MissionCheckPoint
// ODD_var_MissionCivilianVehicles
// ODD_var_Outposts

/* Definition des recuperations d'intels.
* Chaque fonction est definie dans ce tableau.
*
* Input :
* - _loc : position autour de laquelle chercher
*
* Output :
* - txt : texte a afficher ou nil
* - pos : position de l'intel si on veut l'afficher sur carte (not implemented)
*/
private _intels_funcs_map = createHashMapFromArray [
    ["CIVIL", [
        { // ODD_var_Crates
            params[["_loc", [0,0,0]]];

            private _objs = [];
            clientOwner publicVariableClient "ODD_var_Crates";
            if (!isNil "ODD_var_Crates") then {_objs = ODD_var_Crates};
            if (count _objs <= 0) exitWith {[selectRandom (ODD_var_intel_msgs_NO_Crates get "CIVIL"), nil]};
            _objs = _objs apply { [_x distance2D _loc, _x] };
            _objs sort true;

            private _crate = _objs select 0 select 1;
            private _dist = _objs select 0 select 0;
            private _angle = _loc getDir _crate;

            if (_dist > 500) exitWith {[selectRandom (ODD_var_intel_msgs_NO_Crates get "CIVIL"), nil]};

            private _msg = selectRandom [
                "J'ai vu",
                "Il y a",
                "Je les ai vu stocker",
                "Je les ai vu ranger",
                "Je les ai vu entreposer",
                "Je crois avoir vu",
                "Je crois qu'il y a"
            ];
            _msg = _msg + " " + [_crate] call _format_caisse;
            if (0.9 > random 1) then {  // le civil est un peu con donc il donne rarrement une grid
                _msg = _msg + " " + [_dist, _angle] call _format_dist_angle;
            } else { // sinon la gird
                _msg = _msg + [position _crate] call _format_grid;
            };

            [_msg, nil]
        },
        { // ODD_var_IED
            params[["_loc", [0,0,0]]];

            private _objs = [];
            clientOwner publicVariableClient "ODD_var_MissionIED";
            if (!isNil "ODD_var_MissionIED") then {_objs = ODD_var_MissionIED};
            if (count _objs <= 0) exitWith {[selectRandom (ODD_var_intel_msgs_NO_IED get "CIVIL"), nil]};
            _objs = _objs apply { [_x distance2D _loc, _x] };
            _objs sort true;

            private _ied = _objs select 0 select 1;
            private _dist = _objs select 0 select 0;
            private _angle = _loc getDir _ied;

            if (_dist > 500) exitWith {[selectRandom (ODD_var_intel_msgs_NO_IED get "CIVIL"), nil]};

            private _msg = selectRandom [
                "J'ai vu",
                "Il y a",
                "Je crois avoir vu",
                "Je crois qu'il y a"
            ];
            _msg = _msg + " " + selectRandom [
                "une mine",
                "un piege",
                "un explosif",
                "un engin explosif",
                "un engin de mort"
            ];
            if (0.9 > random 1) then {  // le civil est un peu con donc il donne rarrement une grid
                _msg = _msg + " " + [_dist, _angle] call _format_dist_angle;
            } else { // sinon la gird
                _msg = _msg + [position _ied] call _format_grid;
            };

            [_msg, nil]
        },
        { // ODD_var_IAVehicles
            params[["_loc", [0,0,0]]];

            private _objs = [];
            clientOwner publicVariableClient "ODD_var_IAVehicles";
            if (!isNil "ODD_var_IAVehicles") then {_objs = ODD_var_IAVehicles};
            if (count _objs <= 0) exitWith {[selectRandom (ODD_var_intel_msgs_NO_IAVehicles get "CIVIL"), nil]};
            _objs = _objs apply { [_x distance2D _loc, _x] };
            _objs sort true;

            private _vl = _objs select 0 select 1;
            private _dist = _objs select 0 select 0;
            private _angle = _loc getDir _vl;

            if (_dist > 1000) exitWith {[selectRandom (ODD_var_intel_msgs_NO_IAVehicles get "CIVIL"), nil]};

            private _msg = selectRandom [
                "J'ai vu",
                "Il y a",
                "Je crois avoir vu",
                "Je crois qu'il y a"
            ];
            _msg = _msg + " " + [_vl] call _format_vl;
            if (0.9 > random 1) then {  // le civil est un peu con donc il donne rarrement une grid
                _msg = _msg + " " + [_dist, _angle] call _format_dist_angle;
            } else { // sinon la gird
                _msg = _msg + [position _vl] call _format_grid;
            };

            [_msg, nil]
        }
    ]],
    ["OPFOR", [
        { // ODD_var_Crates
            params[["_loc", [0,0,0]]];

            private _objs = [];
            clientOwner publicVariableClient "ODD_var_Crates";
            if (!isNil "ODD_var_Crates") then {_objs = ODD_var_Crates};
            if (count _objs <= 0) exitWith {[selectRandom (ODD_var_intel_msgs_NO_Crates get "OPFOR"), nil]};
            _objs = _objs apply { [_x distance2D _loc, _x] };
            _objs sort true;

            private _crate = _objs select 0 select 1;
            private _dist = _objs select 0 select 0;
            private _angle = _loc getDir _crate;

            if (_dist > 750) exitWith {[selectRandom (ODD_var_intel_msgs_NO_Crates get "OPFOR"), nil]};

            private _msg = selectRandom [
                "Nous avons",
                "Nous avons laissé",
                "Nous avons stocké",
                "Il y a",
                "On stocke",
                "On garde",
                "Je crois que nous avons",
                "Je crois qu'il y a"
            ];
            _msg = _msg + " " + [_crate] call _format_caisse;
            if (0.3 > random 1) then {  // le milouf donne plutot une grid
                _msg = _msg + " " + [_dist, _angle] call _format_dist_angle;
            } else { // sinon la gird
                _msg = _msg + [position _crate] call _format_grid;
            };

            [_msg, nil]
        },
        { // ODD_var_IED
            params[["_loc", [0,0,0]]];

            private _objs = [];
            clientOwner publicVariableClient "ODD_var_MissionIED";
            if (!isNil "ODD_var_MissionIED") then {_objs = ODD_var_MissionIED};
            if (count _objs <= 0) exitWith {[selectRandom (ODD_var_intel_msgs_NO_IED get "OPFOR"), nil]};
            _objs = _objs apply { [_x distance2D _loc, _x] };
            _objs sort true;

            private _ied = _objs select 0 select 1;
            private _dist = _objs select 0 select 0;
            private _angle = _loc getDir _ied;

            if (_dist > 1000) exitWith {[selectRandom (ODD_var_intel_msgs_NO_IED get "OPFOR"), nil]};

            private _msg = selectRandom [
                "Nous avons",
                "Nous avons placé",
                "Il y a",
                "On a placé",
                "On a",
                "Je crois que nous avons placé",
                "Je crois qu'il y a"
            ];
            _msg = _msg + " " + selectRandom [
                "une mine",
                "un piege",
                "un explosif",
                "un engin explosif",
                "un engin de mort"
            ];
            if (0.3 > random 1) then {  // le milouf donne plutot une grid
                _msg = _msg + " " + [_dist, _angle] call _format_dist_angle;
            } else { // sinon la gird
                _msg = _msg + [position _ied] call _format_grid;
            };

            [_msg, nil]
        },
        { // ODD_var_IAVehicles
            params[["_loc", [0,0,0]]];

            private _objs = [];
            clientOwner publicVariableClient "ODD_var_IAVehicles";
            if (!isNil "ODD_var_IAVehicles") then {_objs = ODD_var_IAVehicles};
            if (count _objs <= 0) exitWith {[selectRandom (ODD_var_intel_msgs_NO_IAVehicles get "OPFOR"), nil]};
            _objs = _objs apply { [_x distance2D _loc, _x] };
            _objs sort true;

            private _vl = _objs select 0 select 1;
            private _dist = _objs select 0 select 0;
            private _angle = _loc getDir _vl;

            if (_dist > 1000) exitWith {[selectRandom (ODD_var_intel_msgs_NO_IAVehicles get "OPFOR"), nil]};

            private _msg = selectRandom [
                "Nous avons",
                "Il y a",
                "On a"
            ];
            if (0.3 > random 1) then {  // le milouf donne plutot une grid
                _msg = _msg + " " + [_dist, _angle] call _format_dist_angle;
            } else { // sinon la gird
                _msg = _msg + [position _vl] call _format_grid;
            };

            [_msg, nil]
        }
    ]],
    ["PRENS", [
        { // todo
            params[["_loc", [0,0,0]]];

            [nil, nil]
        }
    ]]
];


// ***** MAIN *****


if ([_src, _target] call _doit_donner_intel) then {
    // Donne intel
    private _func = selectRandom (_intels_funcs_map get _src);
    private _res = [position _target] call _func;
    private _res_txt = _res select 0;
    private _res_pos = _res select 1;

    // Si texte non nil et non vide, on affiche l'intel.
    if (!isNil "_res_txt" && _res_txt != "") then {
        // Affichage de l'intel
        [_res_txt] remoteExec ["systemChat", 0];
    } else {
        // BUG : fallback sur un message generique
        ["Je n'ai rien a vous dire."] remoteExec ["systemChat", 0];
    };
} else {
    private _res_txt = selectRandom (ODD_var_intel_msgs_NO get _src);

    [_res_txt] remoteExec ["systemChat", 0];
};
