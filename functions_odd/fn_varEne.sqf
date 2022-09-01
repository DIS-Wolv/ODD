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
* [-1, true, false] call ODD_fnc_varEne
*
* Public:
*/
params [["_FacForce", -1], ["_init", false], ["_initVL", false]];

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

if (_initVL) then {
	ODD_var_support = false; // nous avons du support ou pas 

	ODD_var_supportSlot = ["crCdb","crEq1","crEq2","alCdb","alEq1","alEq2","haP1","haP2","haP3","haP4","albP1","albP2"];
	_allp = allPlayers;
	{
		_slot = (getUserInfo (getPlayerID _x)) select 10;	//recupère le slote du joueurs
		if (_slot in ODD_var_supportSlot) then {
			ODD_var_support = true;
		};
	} forEach _allp; 

	_allVl = nearestObjects [[1500,1500], ODD_var_VehiculeBlue, 30000];

	_VlBase = nearestObjects [getPos base, ODD_var_VehiculeBlue, 300];

	ODD_var_VlSupport = _allVl - _VlBase;

	if (count ODD_var_VlSupport != 0) then {
		ODD_var_support = true;
	};

	ODD_var_VehiculeSel = ODD_var_Vehicule;
	ODD_var_VehiculeLourdSel = ODD_var_VehiculeLourd;
};

