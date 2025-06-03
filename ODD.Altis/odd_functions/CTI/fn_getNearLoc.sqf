/*
* Auteur : Wolv
* Fonction pour récupérer les locations a proximité d'une location de base
*
* Arguments :
*	_BaseLoc : location de base
* 
* Valeur renvoyée :
*	Liste des locations a proximité
*
* Exemple :
* 	[] call ODDCTI_fnc_getNearLoc;
*
* Variable publique :
* 
*/

params ["_BaseLoc"];

// récupère la position de la location
private _pos = getPos _BaseLoc;

// fonction pour supprimer les locations blacklistées
private _fnc_removeBlackListed = {
	params ["_locations"];
    // pour chaque location
	{
        // si le texte de la loc est dans la liste des locations blacklistées
		if (text _x in ODD_var_BlackistedLocation) then {
            // ca dégage    
			_locations = _locations - [_x];
		};
	}forEach _locations;
    // renvoie les location
	_locations;
};

// range de recherche de base
private _range = 1000;

// en fonction du type de location on augmente le range
switch (type _BaseLoc) do {
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

// si c'est une base militaire on augmente encore le range
if ([_BaseLoc] call ODDCommon_fnc_isMillitary) then {
    _range = _range + 1000;
};

// récupère les locations a proximité
private _nearLoc = nearestLocations[_pos, ODD_var_LocationType, _range];
// retire les locations blacklistées
_nearLoc = [_nearLoc] call _fnc_removeBlackListed;

// tant qu'on a pas 4 locations
while {count _nearLoc < 4} do {
    // on augmente le range
    _range = _range + 100;
    // on récupère les locations a proximité
    _nearLoc = nearestLocations[_pos, ODD_var_LocationType, _range];
    // on retire les locations blacklistées
    _nearLoc = [_nearLoc] call _fnc_removeBlackListed;
};

// on transforme les locations en objet location
_nearLoc = _nearLoc apply {createLocation [_x]};

// pour chaque location a coté
{
    // on récupère la liste actuelle des locations connecté a la location distante
    private _nearLocR = _x getVariable ["ODD_var_nearLocations", []];
    // on ajoute la location de base (liens a double sens)
    _nearLocR pushBackUnique _BaseLoc;
    // on met a jour la liste des locations connectées
    _x setVariable ["ODD_var_nearLocations", _nearLocR];
}forEach _nearLoc;

// on récupère la liste actuelle des locations a coté de celle ou on est actuellement
private _nearLocO = _BaseLoc getVariable ["ODD_var_nearLocations", []];

// pour chaque location 
{
    // on ajoute l'ajoute a la liste
    _nearLoc pushBackUnique _BaseLoc;
}forEach _nearLocO;
_BaseLoc setVariable ["ODD_var_nearLocations", _nearLoc];

// on retire la location de base de la liste des locations a coté
{
    if(text _BaseLoc == text _BaseLoc) then {
        _nearLoc = _nearLoc - [_BaseLoc];
    };
} forEach _nearLoc;

_nearLoc;
