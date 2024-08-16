/*
* Auteur : Wolv
* Fonction pour sauvegardé les donnés de missions quand on est a la base
*
* Arguments :
* 
* Valeur renvoyée :
*
* Exemple :
*	[] call ODDCTI_fnc_callSave
*
* Variable publique :
* 
*/

if (ODD_var_NeedSave == false) exitWith {true;};

["En attente du retours base pour save"] remoteExec ["systemChat", 0];

// chaque 20 seconde on regarde si on peux save (donc si les joueurs sont a la base)
waitUntil {
	uisleep 20;

	// compte le nombre de joueur Total connecté
	private _nbPlayer = count ([] call BIS_fnc_listPlayers);

	// compte le nombre de joueur sur base + FOB + usine
	private _nbPlayerOnBase = {
		(_x inArea [position fob, 30, 30, 0, False]) 
		or (_x inArea [position base, 100, 100, 0, False])
		or (_x inArea [position usine, 30, 30, 0, False])
	} count ([] call BIS_fnc_listPlayers);

	_nbPlayerOnBase == _nbPlayer;
};

["Début de la sauvegarde, ne quittez pas !"] remoteExec ["systemChat", 0];
// sleep pour despawn les IAs
uisleep 30;

// fait avancé les ia enemies
private _lastProgressDate = ODD_var_ProgressDate;
// si la date est pas défini on la met a la date actuel
if (isnil "_lastProgressDate") then {
	_lastProgressDate = date;
	ODD_var_ProgressDate = _lastProgressDate;
};

// on avance les IA toutes les 24h minimum
if ([date] call ODDCommon_fnc_dateInNumber <= ([_lastProgressDate] call ODDCommon_fnc_dateInNumber + 1)) then {
	ODD_var_ProgressDate = date;
	[] call ODDCTI_fnc_ProgressMap;
	["Progressions des Enemies !"] remoteExec ["systemChat", 0];
};


// sauvergarde des données
[] remoteExec ["ODDCTI_fnc_profileSave", 2];

// on a sauvegardé donc on remet la variable a false
ODD_var_NeedSave = false;
