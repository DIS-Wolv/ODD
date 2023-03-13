/*
* Auteur : Wolv
* Fonction pour créer une zone d'opération
*
* Arguments :
* 0: Choisi une zone <Obj>
*
* Valeur renvoyée :
* Localité
*
* Exemple:
* [] call ODDadvanced_fnc_createZO
* [_forceZO] call ODDadvanced_fnc_createZO
*
* Variable publique :
*/
params [["_forceZO", ""]];

private _obj = 0;

if (typeName _forceZO != "LOCATION") then {
	_obj = [] call ODDcommon_fnc_SelectZO;
	[["Localité choisie : %1", text _obj]] call ODDcommon_fnc_log;
}
else {
	systemChat "carrote";
	_obj = _forceZO;
	[["Localité Forcé : %1", text _obj]] call ODDcommon_fnc_log;
};

// systemChat str _obj;
// [str (text _obj)] remoteExec ["systemChat", 0];
// [["Marquer mis en place"]] call ODDcommon_fnc_log;
_obj;
// Renvoie la localité
