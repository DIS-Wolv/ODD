params[["_dist", 1000], ["_angle", 0]];

private _msg = "";
if (0.5 > random 1) then {  // une chance sur deux donner une distance en texte
    private _msg = switch (floor(_dist/200)) do {
        case 0: { "très proche" };
        case 1: { "proche" };
        case 2: { "loin" };
        default { "très loin" };
    };
} else { // sinon en chiffre
    _msg = format ["a %1m", 50 + floor(_dist/50)*50];
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
