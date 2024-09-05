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

[["Save en attente de joueurs"]] call ODDcommon_fnc_log;
["En attente du retours base pour save"] remoteExec ["systemChat", 0];

// chaque 5 seconde on regarde si on peux save (donc si les joueurs sont a la base)
waitUntil {
	uisleep 5;

	// compte le nombre de joueur Total connecté
	private _nbPlayer = count (allPlayers - entities "HeadlessClient_F");

	// compte le nombre de joueur sur base + FOB + usine
	private _nbPlayerOnBase = {
		(_x inArea [position base, 500, 500, 0, False])
		// or (_x inArea [position fob, 30, 30, 0, False]) 
		// or (_x inArea [position usine, 30, 30, 0, False])
	} count (allPlayers - entities "HeadlessClient_F");
	if (ODD_var_DEBUG) then {
		systemChat format ["Nombre de joueur sur base : %1/%2", _nbPlayerOnBase, _nbPlayer];
	};

	_nbPlayerOnBase >= _nbPlayer;
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

[["Test progression enemie"]] call ODDcommon_fnc_log;
// on avance les IA toutes les 24h minimum
if ([date] call ODDCommon_fnc_dateInNumber <= ([_lastProgressDate] call ODDCommon_fnc_dateInNumber + 1)) then {
	ODD_var_ProgressDate = date;
	["Progressions des Enemies !"] remoteExec ["systemChat", 0];
	[] call ODDCTI_fnc_ProgressMap;
};

[["Save joueurs sur base"]] call ODDcommon_fnc_log;
// sauvergarde des données
[] remoteExec ["ODDCTI_fnc_profileSave", 2];

// on a sauvegardé donc on remet la variable a false
ODD_var_NeedSave = false;
