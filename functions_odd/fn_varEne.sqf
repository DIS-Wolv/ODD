/*
* Auteur : Wolv
* Fonction pour choisir faction.
*
* Arguments :
* 0: numéro de la faction (-1 pour random)
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [-1, true, false] call ODD_fnc_varEne
*
* Variable publique :
*/
params [["_FacForce", -1], ["_init", false], ["_initVL", false]];

ODD_var_FactionNames = ["Ardistant", "BlackPond", "ChDKZ-Insurgents", "FIA", "Saf", "Tanoa Liberation army"];
publicVariable "ODD_var_FactionNames";
if (!_init) then {
	private _nbFaction = count ODD_var_FactionNames;
	// Nombre de factions

	private _nFaction = round ((random 1) * (_nbFaction - 1));
	if (typeName _FacForce != "SCALAR") then {
		_FacForce = -1;
	};

	if ((_FacForce >= 0) AND (_FacForce <= _nbFaction)) then {
		_nFaction = _FacForce;
	};

	switch (_nFaction) do {
		case 0: {
			[] call ODD_fnc_varEneArd;
		};
		case 1: {
			[] call ODD_fnc_varEneBlp;
		};
		case 2: {
			[] call ODD_fnc_varEneChDKZ;
		};
		case 3: {
			[] call ODD_fnc_varEneFia;
		};
		case 4: {
			[] call ODD_fnc_varEneSaf;
		};
		case 5: {
			[] call ODD_fnc_varEneTla;
		};
		default {
			[] call ODD_fnc_varEneArd;
		};
	};
	ODD_var_SelectedFaction = ODD_var_FactionNames select _nFaction;
	publicVariable "ODD_var_SelectedFaction";

	[["Faction Choisie : %1", ODD_var_SelectedFaction]] call ODD_fnc_log;
};

if (_initVL) then {
	ODD_var_Support = false; 
	// Défini la présence de support pour les joueurs 

	private _supportSlot = ["crCdb","crEq1","crEq2","alCdb","alEq1","alEq2","haP1","haP2","haP3","haP4","albP1","albP2"];
	private _allp = allPlayers;
	{
		private _slot = (getUserInfo (getPlayerID _x)) select 10;	
		// Récupère le slot du joueur
		if (_slot in _supportSlot) then {
			ODD_var_Support = true;
		};
	} forEach _allp; 

	private _allVl = nearestObjects [[1500,1500], ODD_var_BluforVehicles, 30000];

	private _VlBase = nearestObjects [getPos base, ODD_var_BluforVehicles, 300];

	ODD_var_CountSupportVehicles = _allVl - _VlBase;

	if (count ODD_var_CountSupportVehicles != 0) then {
		ODD_var_Support = true;
	};

	ODD_var_SpawnableVehicles = ODD_var_Vehicles;
	ODD_var_SpawnableHeavyVehicles = ODD_var_HeavyVehicles;
};

