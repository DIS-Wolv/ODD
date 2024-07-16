/*
* Auteur : Wolv
* Fonction pour importé depuis le profil les données de la mission
*
* Arguments :
* 
* Valeur renvoyée :
*
* Exemple :
*	[] call ODDCTI_fnc_profileSave
*
* Variable publique :
* 
*/
params [["_varName", "ODDCTI_var_Proggression"]];

["Début de l'import"] remoteExec ["systemChat", 0];

private _data = [];

_data = profileNamespace getVariable [_varName, []];

if (_data isEqualTo []) exitWith {true;};

[_data] call compile preprocessFile "odd_functions\CTI\fn_ImportData.sqf";

["Import des données de la mission"] remoteExec ["systemChat", 0];

