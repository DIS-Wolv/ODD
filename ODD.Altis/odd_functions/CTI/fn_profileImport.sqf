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
[["Début de l'import"]] call ODDcommon_fnc_log;

private _data = [];

// réupération des données dans le profile
_data = profileNamespace getVariable [_varName, []];

// on récupère le nom de la map
private _mapName = worldName;

// si ce n'est pas un hashmap on le transforme
if (typeName _data != "HASHMAP") then {
	_data = createHashMapFromArray _data;
};

// on récupère les données de la map
private _mapData = _data get _mapName;

if (_mapData isEqualTo []) exitWith {["Pas d'import a faire"] remoteExec ["systemChat", 0]; true;};

[_mapData] call ODDCTI_fnc_ImportData;
["marker_1", FOB, False] call DISCommon_fnc_markers;

["Données importé"] remoteExec ["systemChat", 0];
[["Données importé"]] call ODDcommon_fnc_log;
ODD_var_DataLoaded = true;
