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

params ["_var", ["_value", true]];

// need to be executed on the server
if (!isServer) exitWith {true;};

// récupère la liste des locations
Private _AllLocToReturn = ODD_var_AllLocations;

// trie les locations pour ne garder que celles qui ont la variable _var avec la valeur _value
_AllLocToReturn = _AllLocToReturn apply {
	if (_x getVariable [_var, false] == _value) then {_x} else {objNull};
};

// retire les objNull (locations sans la variable _var a la bonne valeur)
_AllLocToReturn = _AllLocToReturn - [objNull];

// renvoie la liste des locations
_AllLocToReturn;

