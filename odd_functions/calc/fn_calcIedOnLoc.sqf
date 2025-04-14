/*
* Auteur : Wolv
* Fonction pour calculer le nombre d'IEDs dans une zone
*
* Arguments :
*	_zo : Zone (object)
* 
* Valeur renvoyée :
*   _nbIED : nombre d'IEDs
*   _Ieds : infos sur les IEDs
*
* Exemple :
*	[_loc] call ODDCalc_fnc_calcIEDOnLoc
*
* Variable publique :
* 
*/

params ["_zo"];
private _Ieds = 0;

// récupération des paramettres de la zone
private _pos = getPos _zo;
private _roads = _pos nearRoads (size _zo select 0);


// calcul du nombre d'IEDs  // a réduire
private _minIED = round ((count _roads) *  1 / 100) max 0;
private _maxIED = round ((count _roads) * 4 / 100);

private _nbIED = round (random (_maxIED - _minIED)) + _minIED;

if (count _roads == 0) then {
	_nbIED = 0;
};

// crée les variables pour les IEDs
private _IEDs = [];
for "_i" from 1 to _nbIED do {
	// choix de si c'est un leurre
	private _isDecoy = false;
	if (floor (random 4) == 0) then {
		_isDecoy = true;
	};

	// choix des types d'IED et de covers
	_coverClass = selectRandom ODD_var_IEDCover;
	private _exploClass = "";
	if (_isDecoy) then {
		_exploClass = "Land_HelipadEmpty_F"; //"Land_HelipadEmpty_F" - "Land_JumpTarget_F"
	} else {
		_exploClass = selectRandom ODD_var_IEDExplosive;
	};

	// choix de la route a piegée
	private _SelectedRoad = selectRandom _roads;
	
	// if (isNil "_SelectedRoad") then {
	// 	systemChat format ["%1", text _zo];
	// };
	// systemChat format ["%1", _roads];
	// systemChat format ["%1", typeName _SelectedRoad];

	private _connectedRoads = roadsConnectedTo _SelectedRoad;

	private _dir = 0;
	if (count _connectedRoads != 0) then {
		_connectedRoad = selectRandom _connectedRoads;
		_dir = _SelectedRoad getDir _connectedRoad;
	}
	else {
		_dir = random 360;
	};

	// calcul de la position de l'IED
	private _coverPos = _SelectedRoad getPos [(3 + random 2.5), (_dir + 90)];
	private _exploPos = _coverPos getPos [((random 0.5) + 0.2), random 360];

	// choix de la direction du cover
	private _coverDir = random 360;

	private _thisIED = [_coverPos, _coverDir, _coverClass, _exploPos, _exploClass, _isDecoy];
	_IEDs pushBack _thisIED;
};

// retourne les valeurs
[_nbIED, _IEDs];
