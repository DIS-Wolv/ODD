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
["CIVIL", player] call ODDintels_fnc_giveIntel;

*/
params[["_src", "CIVIL"], ["_target", objNull]];


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
        { // Caisse
            params[["_loc", [0,0,0]]];

            private _obj = [_loc, 500, "ODD_var_Crates"] call ODDintels_fnc_getClosestOjbInArr;
            if (isNil "_obj") exitWith {[selectRandom (ODD_var_intel_msgs_NO_Crates get "CIVIL"), nil]};

            [
                (selectRandom ODD_var_intel_part_civ_a_vu_caisse)
                + " "
                + ([_obj] call ODDintels_fnc_formatCaisse)
                + " "
                + ([_loc, position _obj, ODD_var_intel_proba_civ_grid] call ODDintels_fnc_formatPos),
                nil
            ]
        },
        { // ODD_var_MissionIED
            params[["_loc", [0,0,0]]];

            private _obj = [_loc, 1000, "ODD_var_MissionIED"] call ODDintels_fnc_getClosestOjbInArr;
            if (isNil "_obj") exitWith {[selectRandom (ODD_var_intel_msgs_NO_IED get "CIVIL"), nil]};

            [
                (selectRandom ODD_var_intel_part_civ_a_vu)
                + " "
                + (selectRandom ODD_var_intel_part_civ_name_IED)
                + " "
                + ([_loc, position _obj, ODD_var_intel_proba_civ_grid] call ODDintels_fnc_formatPos),
                nil
            ]
        },
        { // ODD_var_IAVehicles
            params[["_loc", [0,0,0]]];

            private _obj = [_loc, 2000, "ODD_var_IAVehicles"] call ODDintels_fnc_getClosestOjbInArr;
            if (isNil "_obj") exitWith {[selectRandom (ODD_var_intel_msgs_NO_IAVehicles get "CIVIL"), nil]};

            [
                (selectRandom ODD_var_intel_part_civ_a_vu)
                + " "
                + ([_obj] call ODDintels_fnc_nameVl)
                + " "
                + ([_loc, position _obj, ODD_var_intel_proba_civ_grid] call ODDintels_fnc_formatPos),
                nil
            ]
        },
        { // ODD_var_MissionCheckPoint
            params[["_loc", [0,0,0]]];

            private _obj = [_loc, 2000, "ODD_var_MissionCheckPoint"] call ODDintels_fnc_getClosestOjbInArr;
            if (isNil "_obj") exitWith {[selectRandom (ODD_var_intel_msgs_NO_MissionCheckPoint get "CIVIL"), nil]};

            [
                (selectRandom ODD_var_intel_part_civ_a_vu)
                + " "
                + (selectRandom ODD_var_intel_part_civ_name_checkpoint)
                + " "
                + ([_loc, position _obj, ODD_var_intel_proba_civ_grid] call ODDintels_fnc_formatPos),
                nil
            ]
        },
        { // ODD_var_Outposts
            params[["_loc", [0,0,0]]];

            private _obj = [_loc, 2000, "ODD_var_Outposts"] call ODDintels_fnc_getClosestOjbInArr;
            if (isNil "_obj") exitWith {[selectRandom (ODD_var_intel_msgs_NO_Outposts get "CIVIL"), nil]};

            [
                (selectRandom ODD_var_intel_part_civ_a_vu)
                + " "
                + (selectRandom ODD_var_intel_part_civ_name_outpost)
                + " "
                + ([_loc, position _obj, ODD_var_intel_proba_civ_grid] call ODDintels_fnc_formatPos),
                nil
            ]
        }
    ]],
    ["OPFOR", [
        { // Caisse
            params[["_loc", [0,0,0]]];

            private _obj = [_loc, 1000, "ODD_var_Crates"] call ODDintels_fnc_getClosestOjbInArr;
            if (isNil "_obj") exitWith {[selectRandom (ODD_var_intel_msgs_NO_Crates get "OPFOR"), nil]};

            [
                (selectRandom ODD_var_intel_part_mil_a_vu_caisse)
                + " "
                + ([_obj] call ODDintels_fnc_formatCaisse)
                + " "
                + ([_loc, position _obj, ODD_var_intel_proba_mil_grid] call ODDintels_fnc_formatPos),
                nil
            ]
        },
        { // ODD_var_MissionIED
            params[["_loc", [0,0,0]]];

            private _obj = [_loc, 1500, "ODD_var_MissionIED"] call ODDintels_fnc_getClosestOjbInArr;
            if (isNil "_obj") exitWith {[selectRandom (ODD_var_intel_msgs_NO_IED get "OPFOR"), nil]};

            [
                (selectRandom ODD_var_intel_part_mil_a_vu)
                + " "
                + (selectRandom ODD_var_intel_part_mil_name_IED)
                + " "
                + ([_loc, position _obj, ODD_var_intel_proba_mil_grid] call ODDintels_fnc_formatPos),
                nil
            ]
        },
        { // ODD_var_IAVehicles
            params[["_loc", [0,0,0]]];

            private _obj = [_loc, 4000, "ODD_var_IAVehicles"] call ODDintels_fnc_getClosestOjbInArr;
            if (isNil "_obj") exitWith {[selectRandom (ODD_var_intel_msgs_NO_IAVehicles get "OPFOR"), nil]};

            [
                (selectRandom ODD_var_intel_part_mil_a_vu)
                + " "
                + ([_obj] call ODDintels_fnc_nameVl)
                + " "
                + ([_loc, position _obj, ODD_var_intel_proba_mil_grid] call ODDintels_fnc_formatPos),
                nil
            ]
        },
        { // ODD_var_MissionCheckPoint
            params[["_loc", [0,0,0]]];

            private _obj = [_loc, 3000, "ODD_var_MissionCheckPoint"] call ODDintels_fnc_getClosestOjbInArr;
            if (isNil "_obj") exitWith {[selectRandom (ODD_var_intel_msgs_NO_MissionCheckPoint get "OPFOR"), nil]};

            [
                (selectRandom ODD_var_intel_part_mil_a_vu)
                + " "
                + (selectRandom ODD_var_intel_part_mil_name_checkpoint)
                + " "
                + ([_loc, position _obj, ODD_var_intel_proba_mil_grid] call ODDintels_fnc_formatPos),
                nil
            ]
        },
        { // ODD_var_Outposts
            params[["_loc", [0,0,0]]];

            private _obj = [_loc, 5000, "ODD_var_Outposts"] call ODDintels_fnc_getClosestOjbInArr;
            if (isNil "_obj") exitWith {[selectRandom (ODD_var_intel_msgs_NO_Outposts get "OPFOR"), nil]};

            [
                (selectRandom ODD_var_intel_part_mil_a_vu)
                + " "
                + (selectRandom ODD_var_intel_part_mil_name_outpost)
                + " "
                + ([_loc, position _obj, ODD_var_intel_proba_mil_grid] call ODDintels_fnc_formatPos),
                nil
            ]
        }
    ]],
    ["PRENS", [
        { // todo
            params[["_loc", [0,0,0]]];

            [nil, nil]
        }
    ]]
];


private _func = selectRandom (_intels_funcs_map get _src);
private _res = [position _target] call _func;

_res
