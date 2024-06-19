/*
* Auteur : Wolv
* Fonction pour calculer le nombre de civils dans une zone
*
* Arguments :
*	_zo : Zone (object)
* 
* Valeur renvoyée :
*	_enemies : Nombre d'ennemis
*
* Exemple :
*	
*
* Variable publique :
* 
*/

params ["_zo"];
private _nbcivilan = 0;

private _loctype = [_zo] call ODDcommon_fnc_ZoType;
private _Buildings = nearestObjects [position _zo, ODD_var_Houses, size _zo select 0];
// Nombre de maisons dans la localité

if ([_zo] call ODDCommon_fnc_isMillitary) then {
	_locType = 10;
};


switch (_loctype) do {
	case (10): {
		_nbcivilan = 0;
	};
	case (5): {
		_nbcivilan = _nbcivilan + (count _Buildings) / 18;
	};
	case (4): {
		_nbcivilan = (_nbcivilan + (count _Buildings) / 13) min 11;
	};
	case (3): {
		_nbcivilan = (_nbcivilan + (count _Buildings) / 7) min 14;
	};
	case (2): {
		_nbcivilan = _nbcivilan + (count _Buildings) / 6;
	};
	case (1): {
		if (count _Buildings < 10) then {
			_nbcivilan = _nbcivilan + (count _Buildings) / 2;
		}
		else {
			_nbcivilan = _nbcivilan + (count _Buildings) / 5;
		};
		
	};
};


round (_nbcivilan);
