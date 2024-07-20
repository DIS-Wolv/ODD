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

// chaque 5 seconde on regarde si on peux save (donc si les joueurs sont a la base)
waitUntil {
	sleep 5;

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

// sauvergarde des données
[] remoteExec ["ODDCTI_fnc_profileSave", 2];

// on a sauvegardé donc on remet la variable a false
ODD_var_NeedSave = false;
