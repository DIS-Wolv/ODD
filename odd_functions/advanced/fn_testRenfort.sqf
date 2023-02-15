/*
* Auteur : Wolv
* Fonction pour déterminer si des renforts doivnent être appeller
*
* Arguments :
* 0: Détermine si des renforts doivent encore être appeller <BOOL>
* 1: Le nombre d'AIs en vie sur zone <INT>
* 2: Le nombre d'AIs sur la zone objectif au début de la mission <INT>
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [_return, _nbIa, _BaseIa] call ODD_fnc_testRenfort
* [_return, _nbIa, _BaseIa, True] call ODD_fnc_testRenfort
*
* Variable publique :
*/
params ["_return", "_nbIa", "_BaseIa"];

if (_BaseIa / 2 > _nbIa and _return) then {
	_rdm = round (100/ (100 - ((_nbIa * 2)/_BaseIa) * 100));
	[["Test renfort %1 / %2 => %3 ", _nbIa, _BaseIa, _rdm]] call ODD_fnc_log;
	if (round(random (1 max _rdm)) == 0) then {	
		[_zo] spawn ODD_fnc_createRenfort; 
		// Fonction qui appelle les renforts
		_return = False;
	};
};

_return;
