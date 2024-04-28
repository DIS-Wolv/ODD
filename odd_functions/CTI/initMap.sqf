/*
* Auteur : Wolv
* Fonction pour crée les liens entre les localité 
*
* Arguments :
* 
* Valeur renvoyée :
*	nil
*
* Exemple :
* 
*
* Variable publique :
* 
*/

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

private _map = (findDisplay 12 displayCtrl 51);

{
	// récupère la position de la location
	private _pos = getPos _x;
	private _range = 1000;

	switch (type _x) do {
		case (ODD_var_LocationType select 0): { // Capital
			_range = 4500;
		};
		case (ODD_var_LocationType select 1): { // City
			_range = 3000;
		};
		case (ODD_var_LocationType select 2): { // Village
			_range = 2000;
		};
		case (ODD_var_LocationType select 3): { // Name
			_range = 2000;
		};
		case (ODD_var_LocationType select 4): { // NameLocal
			_range = 1000;
		};
		case (ODD_var_LocationType select 5): { // Hill
			_range = 1000;
		};
		default {};
	};
	if ([_x] call ODDCommon_fnc_isMillitary) then {
		_range = _range + 1000;
	};

	private _nearLoc = nearestLocations[_pos, ODD_var_LocationType, _range];
	_nearLoc = [_nearLoc] call _fnc_removeBlackListed;

	while {count _nearLoc < 4} do {
		_range = _range + 100;
		_nearLoc = nearestLocations[_pos, ODD_var_LocationType, _range];
		_nearLoc = [_nearLoc] call _fnc_removeBlackListed;
	};

	private _maLoc = createLocation [_x];
	_nearLoc = _nearLoc apply {createLocation [_x]};
	
	{
		private _nearLocR = _x getVariable ["ODD_var_nearLocations", []];
		_nearLocR pushBackUnique _maLoc;
		_x setVariable ["ODD_var_nearLocations", _nearLocR];
	}forEach _nearLoc;

	private _maLoc = createLocation [_x];
	private _nearLocO = _maLoc getVariable ["ODD_var_nearLocations", []];
	{
		_nearLoc pushBackUnique _x;
	}forEach _nearLocO;

	{
		if(text _x == text _maLoc) then {
			_nearLoc = _nearLoc - [_x];
		};
	} forEach _nearLoc;

	_maLoc setVariable ["ODD_var_nearLocations", _nearLoc];


	// attribue les valeurs de pax sur chaque location
	private _tgtEni = 0;		// le nombre de pax sur la loc doit tendre vers cette valeur
	private _actEni = 0;		// le nombre de pax actuel sur la loc
	
	// remplacer par un super calcul du nombre de pax
	_tgtEni = [_x] call compile preprocessFile "odd_functions\CTI\calcEniOnLoc.sqf";
	_actEni = round (_tgtEni * 0.9);

	_maLoc setVariable ["ODD_var_actEni", _actEni];
	_maLoc setVariable ["ODD_var_tgtEni", _tgtEni];
	_maLoc setVariable ["ODD_var_isBlue", false];
	_maLoc setVariable ["ODD_var_isFrontLine", false]; 

	private _isMil = [_x] call ODDCommon_fnc_isMillitary;
	if (_isMil) then {
		_maLoc setVariable ["ODD_var_prcRecrut", 0.2];
	}
	else {
		_maLoc setVariable ["ODD_var_prcRecrut", 0];
	};

	// crée un marker sur la map
	private _marker = createMarkerLocal [text _maLoc, (_pos getPos [25, 270])];
	_marker setMarkerType "mil_dot";
	_marker setMarkerColor "ColorBlack";
	_marker setMarkerSize [1, 1];
	// _marker setMarkerText (text _maLoc);
	_marker setMarkerAlpha 0.5;
	_x setVariable ["ODD_var_marker", _marker];
}forEach _locations;

ODDvar_mesLocations = _locations;

systemChat "Map Initialized";


// private _map = (findDisplay 12 displayCtrl 51);
// {
// 	private _nearloc = _x getVariable ["ODD_var_nearLocations", []];
// 	private _pos = getPos _x;

// 	{
// 		private _posloc = getPos _x;
	

// 		_map ctrlAddEventHandler ["Draw",Format [
// 			"(_this select 0) drawLine [
// 				%1,
// 				%2,
// 				[0,0,1,1]
// 			];", _pos, _posloc]
// 		];

// 	}forEach _nearloc;
// } forEach _locations;
