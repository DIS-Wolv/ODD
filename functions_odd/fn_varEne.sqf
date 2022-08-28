/*
* Author: Wolv
* Fonction de choix des faction.
*
* Arguments:
* 0: numéro de la faction (-1 pour random)
*
* Return Value:
* nil
*
* Example:
* [] call ODD_fnc_varEne
*
* Public:
*/
params [["_FacForce", -1]];

_nbFaction = 2;		//NB faction 

_nFaction = round ((random 1) * (_nbFaction - 1));

nomFaction = ["Ardistant","ChDKZ-Insurgents"];

if (_FacForce >= 0 AND _FacForce <= _nFaction) then {
	_nFaction = _FacForce;
};

switch (_nFaction) do {
	case 0: {
		[] call ODD_fnc_varEneArd;
	};
	case 1: {
		[] call ODD_fnc_varEneChDKZ;
	};
	default {
		[] call ODD_fnc_varEneArd;
	};
};

[["Faction Choisie : %1", nomFaction select _nFaction]] call ODD_fnc_log;
