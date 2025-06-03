/*
* Auteur : Wolv
* Fonction pour sauvegardé dans le profil les données de la mission
*
* Arguments :
* 
* Valeur renvoyée :
*
* Exemple :
*	[] call ODDCTI_fnc_updateLocationVar;
*
* Variable publique :
* - ODD_var_AllLocations
* - ODD_var_AllLocationsBlue
* - ODD_var_AllLocationsBlueIndex
* - ODD_var_AllLocationsFrontLine
* - ODD_var_AllLocationsFrontLineIndex
* - ODD_var_AllLocationsRed
* - ODD_var_AllLocationsRedIndex
* 
*/

if (!isServer) exitWith {true;};
ODD_var_AllLocationsStateUpdate = False;
publicVariable "ODD_var_AllLocationsStateUpdate";

[] call ODDCTI_fnc_getAllLocs;

private _LocBlue = [];
private _LocRed = [];
private _LocFrontLine = [];

{
    private _loc = _x;
    private _index = _loc getVariable ["ODD_var_LocId", -1];
    if (_index >= 0) then {
        if (_loc getVariable ["ODD_var_isBlue", true]) then {
            _LocBlue pushBack _loc;
        }
        else {
            if (_loc getVariable ["ODD_var_isFrontLine", true]) then {
                _LocFrontLine pushBack _loc;
            }
            else {
                _LocRed pushBack _loc;
            };
        };
    };
} forEach ODD_var_AllLocations;

// pour un usage LOCAL UNIQUEMENT
ODD_var_AllLocationsBlue = _LocBlue;
ODD_var_AllLocationsFrontLine = _LocFrontLine;
ODD_var_AllLocationsRed = _LocRed;

// pour un usage GLOBAL
ODD_var_AllLocationsBlueIndex = _LocBlue apply { _x getVariable ["ODD_var_LocId", -1]; };
ODD_var_AllLocationsFrontLineIndex = _LocFrontLine apply { _x getVariable ["ODD_var_LocId", -1]; };
ODD_var_AllLocationsRedIndex = _LocRed apply { _x getVariable ["ODD_var_LocId", -1]; };

publicVariable "ODD_var_AllLocationsBlue";
publicVariable "ODD_var_AllLocationsFrontLine";
publicVariable "ODD_var_AllLocationsRed";

ODD_var_AllLocationsStateUpdate = True;
publicVariable "ODD_var_AllLocationsStateUpdate";
