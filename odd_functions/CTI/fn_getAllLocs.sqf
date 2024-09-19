/*
* Auteur : Wolv
* Fonction pour récupéré toute les localités
*
* Arguments :
* 
* Valeur renvoyée :
*	nil
*
* Exemple :
* 	[] call ODDCTI_fnc_getAllLocs;
*
* Variable publique :
* 
*/

if (!isNil "DISCommon_var_InitCustomLocations") exitWith {true;};

// fonction pour supprimer les locations blacklistées
private _fnc_removeBlackListed = {
	params ["_locations"];
	{
		if (text _x in ODD_var_BlackistedLocation) then {
			_locations = _locations - [_x];
		};
	}forEach _locations;
	_locations;
};


private _locations = nearestLocations[[worldSize / 2, worldSize / 2], ODD_var_LocationType, worldSize * 2];

// retire les locations blacklistées
_locations = [_locations] call _fnc_removeBlackListed;

{
	_x setVariable ["ODD_var_AllLocations_index", _forEachIndex];
} forEach _locations;

ODD_var_AllLocations = _locations;

ODD_var_AllLocations
