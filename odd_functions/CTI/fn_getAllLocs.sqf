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

if (isNil "DISCommon_var_InitCustomLocations") exitWith {true;};

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

// en fonction de si on est serveur ou client 
if (isServer) then {
	// serveur, descide de l'index de chaque location
	{
		_x setVariable ["ODD_var_AllLocations_index", _forEachIndex];
		ODD_var_AllLocationsName pushBack (text _x);
	} forEach _locations;
	// crée une table de correspondance entre le nom et l'index
	// ODD_var_AllLocationsName = _locations apply {text _x};
}
else {
	// client, récupère la table de correspondance
	[clientOwner, "ODD_var_AllLocationsName"] remoteExec ["publicVariableClient", 2];
	// on se base sur la table de correspondance pour définir l'index de chaque location

	_locationName = _locations apply {text _x};
	{
		if (text _x == (ODD_var_AllLocationsName select _forEachIndex)) then {
			_x setVariable ["ODD_var_AllLocations_index", _forEachIndex];
		}
		else {
			private _index = _locationName find (text _x);
			_x setVariable ["ODD_var_AllLocations_index", _index];
			// réordonne la var
		};
	} forEach _locations;
};

ODD_var_AllLocations = _locations;

ODD_var_AllLocations
