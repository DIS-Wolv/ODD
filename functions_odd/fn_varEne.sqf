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
* [] call WOLV_fnc_varEne
*
* Public:
*/
params [["_FacForce",-1]];

_nbFaction = 1;

_nFaction = round ((random 1) * _nbFaction);

_nomFaction = "NomFactionDefaut";

if (_FacForce >= 1 AND _FacForce <= _nFaction) then {
	_nFaction = _FacForce;
};

switch (_nFaction) do {
	case 1: {
		[] call WOLV_fnc_varEneArd;
		_nomFaction = "Ardistant";
	};
	case 2: {
		[] call WOLV_fnc_varEneArd;
		_nomFaction = "Ardistant";
	};
	default {
		[] call WOLV_fnc_varEneArd;
		_nomFaction = "Ardistant";
	};
};

[["Faction Choisie : %1", _nomFaction]] call WOLV_fnc_log;
