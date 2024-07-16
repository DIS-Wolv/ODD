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

_data = [] call ODDCTI_fnc_ExportData;

profileNamespace setVariable ["ODDCTI_var_Proggression", _data];
saveProfileNamespace;

["Missions Sauvegardé"] remoteExec ["systemChat", 0];

_data;
