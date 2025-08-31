/*
* Auteur : Wolv
* Fonction pour récupérer les locations avec un certain status
*
* Arguments :
*	_var : Nom de la variable
*   _value : Valeur de la variable (optionnel, default : true)
* 
* Valeur renvoyée :
*	Liste des locations
*
* Exemple :
* 	[] call ODDCTI_fnc_getLocWhere;
*
* Variable publique :
* 
*/

params ["_var", ["_value", true], ["_ReturnIndex", true]];

// need to be executed on the server (the var are only on the server's location)
if (!isServer) exitWith {true;};
// if (isNil "ODD_var_AllLocations") then {
//     [] call ODDCTI_fnc_getAllLocs;
// };

// récupère la liste des locations
Private _AllLocToReturn = ODD_var_AllLocations;

// trie les locations pour ne garder que celles qui ont la variable _var avec la valeur _value
_AllLocToReturn = _AllLocToReturn apply {
	if (typeName (_x getVariable [_var, false]) != "ARRAY") then {
		if (_x getVariable [_var, false] == _value) then {_x} else {objNull};
	}
	else {
		if (count (_x getVariable [_var, []]) == _value) then {_x} else {objNull};
	};
};

// retire les objNull (locations sans la variable _var a la bonne valeur)
_AllLocToReturn = _AllLocToReturn - [objNull];

// si dois renvoier les index
if (_ReturnIndex) then {
	// renvoie les index
	_AllLocToReturn = _AllLocToReturn apply {_x getVariable ["ODD_var_LocId", -1];};
};

// renvoie la liste des locations
_AllLocToReturn;

