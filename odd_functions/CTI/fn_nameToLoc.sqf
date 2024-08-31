/*
* Auteur : Wolv
* Fonction pour récupérer la locations avec un certain noms
*
* Arguments :
*	_name : Nom de la location
* 
* Valeur renvoyée :
*	Liste des locations
*
* Exemple :
* 	["Athira"] call ODDCTI_fnc_nameToLoc;
*
* Variable publique :
* 
*/

params ["_name"];

// need to be executed on the server
if (!isServer) exitWith {true;};

private _i = -1;
{
	if (text _x == _name) then {_i = _forEachIndex};
}forEach ODD_var_AllLocations;

// loc not found
if (_i == -1) exitWith {false;};

// return the location
ODD_var_AllLocations select _i;



