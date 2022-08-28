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
params [["_FacForce", -1], ["_init", false]];

ODD_var_NomFactions = ["Ardistant","ChDKZ-Insurgents"];
publicVariable "ODD_var_NomFactions";
if (!_init) then {
	_nbFaction = count ODD_var_NomFactions;		//NB faction 

	_nFaction = round ((random 1) * (_nbFaction - 1));


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

	[["Faction Choisie : %1", ODD_var_NomFactions select _nFaction]] call ODD_fnc_log;
};