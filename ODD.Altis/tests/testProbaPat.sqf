params [["_locNameee", 'Athira']];

// récup la loc
_loc = ["ODD_var_LocName", _locNameee, false] call ODDCTI_fnc_getlocWhere;
_loc = _loc select 0;
// récup la pos
private _posLoc = getPos _loc;
_posLoc deleteAt [2];
_posLoc = _posLoc getPos [0,0];
_posLoc = ASLToAGL _posLoc;
_posLoc set [2, -(_posLoc select 2)];

// systemChat format ["%1", (_posLoc select 2)];

// delete les anciens markers
{
	deleteMarker _x;
} forEach allMapMarkers; 

// définie les variables
private _radius = size _loc select 0;
private _batList = nearestObjects [_posLoc, ODD_var_Houses, _radius];
private _maxValue = _radius * 2;
// pour chaque maison
{
	// récupère la position de la maison
	private _pos = getPosASL _x;
	
	// calcul des variables
	// distance de la maison à la loc
	private _dist = (_pos distance2D _posLoc);
	// differnce de hauteur de la maison à la loc
	private _deltaA = ((_pos  select 2) - (_posLoc select 2)) * 2;
	// nombre de maisons à proximité
	private _nearBuild = (count (nearestObjects [_pos, ODD_var_Houses, 50])) * 14;
	// nombre de rouge a proximité
	private _nearRed = ({(side _x) == east} count (_pos nearEntities ["man", 50])) * 5 - 20;
	
	// calcul de la probabilité
	private _proba = (_dist - _deltaA - _nearBuild - _nearRed) / _maxValue;
	_proba = _proba max 0.005;
 
	// couleur en fonction de la probabilité
	private _color = "ColorBlue";
	switch true do {
		case (_proba < 0.1): {_color = "ColorGreen";};
		case (_proba < 0.2): {_color = "ColorYellow";};
		case (_proba < 0.3): {_color = "ColorOrange";};
		case (_proba < 0.5): {_color = "ColorRed";};
	};

	// create marker
	private _marker = createMarker [format ["%1", _x], _pos];
	_marker setMarkerColor _color;
	_marker setMarkerSize [0.5, 0.5];
	_marker setMarkerText format ["%1", (floor(_proba * 1000))/1000, _dist, _deltaA, _nearBuild, _nearRed]; // | %2 | %3 | %4 | %5 (floor(_proba * 100))/100
	_marker setMarkerDir 0;
	_marker setMarkerType "mil_dot";

} forEach _batList;





