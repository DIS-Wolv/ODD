/*
* Auteur : Wolv
* Fonction pour créer une missions
*
* Arguments :
*   _zoneID : ID de la zone
*   _missionsType : Type de missions
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call ODDMIS_fnc_callCreate;
*
* Variable publique :
* 
*/

params ["_zoneID","_missionsType"];

// On vérifie que l'on est sur le serveur
if (!isServer) exitWith {true;};
// On vérifie que la map est bien initialisé
if (isNil "ODD_var_INITMAP") exitWith {[["Create Missions sur map non init"]] call ODDcommon_fnc_log;};

// On récupère la zone
private _zone = ODD_var_AllLocations select _zoneID;

// On récupère le camps de la Zone
private _zoneCamp = "blue";
private _isBlue = _zone getVariable ["ODD_var_isBlue", false];

// si la zone n'est pas bleu
if (!_isBlue) then {
	// On récupère si la zone est une ligne de front
	private _isFront = _zone getVariable ["ODD_var_isFrontLine", false];

	// on défine _zone
	if (_isFront) then {
		_zoneCamp = "frontline";
	}
	else{
		_zoneCamp = "enemy";
	};
};

// On récupère l'ID de la mission
private _id = ODD_var_MissionID;
_id = _id + 1;
// On vérifie que l'ID n'est pas déjà utilisé
while {_id in ODD_var_ActiveMissions} do {
	// Log
	[["ODD_CallCreate : Mission %1 déjà active", _id]] call ODD_fnc_log;
	_id = _id + 1;
};
// On met à jour l'ID
ODD_var_MissionID = _id;

// On crée la mission en fonction de la zone
if ((_missionsType in ODD_var_MissionTypeFrontLine) and (_zoneCamp == "frontline")) then {
	// Log
    [["ODD_CallCreate : Create FrontLine"]] call ODD_fnc_log;
	// On crée la mission 
	//spawn ??
	[_zoneID, _missionsType, _id] call compile preprocessFile 'odd_functions\missions\fn_createFrontLine.sqf';//ODDMIS_fnc_createFrontLine;
}
else {
	if ((_missionsType in ODD_var_MissionTypeEnemy) and (_zoneCamp == "enemy")) then {
		// Log
        [["ODD_CallCreate : Create Enemy"]] call ODD_fnc_log;
		// On crée la mission
		[_zoneID, _missionsType, _id] call compile preprocessFile 'odd_functions\missions\fn_createRed.sqf';//ODDMIS_fnc_createRed;
	}
	else { 
		if ((_missionsType in ODD_var_MissionTypeBlue) and (_zoneCamp == "blue")) then {
			// Log
            [["ODD_CallCreate : Create Blue"]] call ODD_fnc_log;
			// On crée la mission
			[_zoneID, _missionsType, _id] call compile preprocessFile 'odd_functions\missions\fn_createBlue.sqf';//ODDMIS_fnc_createBlue;
		}
		else { // si le couple mission / zone n'est pas valide
			// Log
            [["ODD_CallCreate : Invalide %1 x %2", _zoneID, _missionsType]] call ODD_fnc_log;
		};
	};
};

