/*
* Auteur : Wolv
* Fonction pour importé depuis le profil les données de la mission
*
* Arguments :
* 
* Valeur renvoyée :
*
* Exemple :
*	[] call ODDCTI_fnc_profileImport
*
* Variable publique :
* 
*/
params [["_varName", "ODDCTI_var_Proggression"]];

["Début de l'import"] remoteExec ["systemChat", 0];

private _data = [];

_data = profileNamespace getVariable [_varName, []];

if (_data isEqualTo []) exitWith {["Pas d'import a faire"] remoteExec ["systemChat", 0]; true;};

[_data] call ODDCTI_fnc_ImportData;

["Import des données de la mission"] remoteExec ["systemChat", 0];

