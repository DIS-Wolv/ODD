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
