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
