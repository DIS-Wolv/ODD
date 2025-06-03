/*
* Auteur : Wolv
* Fonction pour sauvegardé dans le profil les données de la mission
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
// params ["_target"]; // permetre de save sur les profils user ?

private _data = [];

// réupération des données
_data = [] call ODDCTI_fnc_ExportData;

[["Save Debut"]] call ODDcommon_fnc_log;
// réucpération des données déjà sauvegardé
private _savedData = profileNamespace getVariable ["ODDCTI_var_Proggression", []];

// si ce n'est pas un hashmap on le transforme
if (typeName _savedData != "HASHMAP") then {
    _savedData = createHashMapFromArray _savedData;
};

// on récupère le nom de la map
private _map = worldName;

// ajoute les données
_savedData set [_map, _data];

// on sauvegarde les données dans le profiles
profileNamespace setVariable ["ODDCTI_var_Proggression", _savedData];
saveProfileNamespace;

["Missions Sauvegardée"] remoteExec ["systemChat", 0];
[["Save OK"]] call ODDcommon_fnc_log;

_data;
