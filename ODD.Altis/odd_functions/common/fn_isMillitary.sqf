/*
* Auteur : Wolv & Hhaine
* Fonction pour savoir si une localité est une base militaire
*
* Arguments :
* 0: localité (object)
*
* Valeur renvoyée :
* 0: booléen (true si c'est une base militaire, false sinon)
*
* Exemple:
* [_zo] call ODDcommon_fnc_isMillitary;
*
* Variable publique :
*/

params ["_location"];

private _textPart = (text _location) splitString " ";
private _val = false;	

{
	if (_x in ODD_var_LocationMilitaryName) then {
		_val = true;
	};
} forEach _textPart;
_val;

