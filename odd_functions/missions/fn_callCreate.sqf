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

// On récupère la zone
private _zone = ODD_var_AllLocations select _zoneID;

// On récupère le camps de la Zone
private _zoneCamp = "blue";
private _isBlue = _zone getVariable ["ODD_var_isBlue"];
// si la zone n'est pas bleu
if (!_isBlue) then {
	// On récupère si la zone est une ligne de front
	_isFront = _zone getVariable ["ODD_var_isFrontLine"];
	// on défine _zone
	if (_isFront) then {
		_zoneCamp = "frontline";
	}
	else{
		_zoneCamp = "enemy";
	};

};
if ((_missionsType in ODD_var_MissionTypeFrontLine) and (_zoneCamp == "frontline")) then {
    [["ODD_CallCreate : Create FrontLine"]] call ODD_fnc_log;
	[_zoneID, _missionsType] call ODDMIS_fnc_createFrontLine;
}
else {
	if ((_missionsType in ODD_var_MissionTypeEnemy) and (_zoneCamp == "enemy")) then {
        [["ODD_CallCreate : Create Enemy"]] call ODD_fnc_log;
		[_zoneID, _missionsType] call ODDMIS_fnc_createEnemy;
	}
	else { 
		if ((_missionsType in ODD_var_MissionTypeBlue) and (_zoneCamp == "blue")) then {
            [["ODD_CallCreate : Create Blue"]] call ODD_fnc_log;
			[_zoneID, _missionsType] call ODDMIS_fnc_createEnemy;
		}
		else { // si le couple mission / zone n'est pas valide
			// Log
            [["ODD_CallCreate : Invalide %1 x %2", _zoneID, _missionsType]] call ODD_fnc_log;
		};
	};
};

