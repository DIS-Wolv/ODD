/*
* Auteur : Wolv
* Fonction pour choisir une zone d'opération
*
* Arguments :
*
* Valeur renvoyée :
* Localité
*
* Exemple:
* [] call ODDcommon_fnc_SelectZO
*
* Variable publique :
*	- ODD_var_SelectedSector
*/

private _location = [];
private _SelectSector = [];
private _obj = 0;

if (!isNil "ODD_var_SelectedSector") then {
	if (count(ODD_var_SelectedSector) != 0) then {
		{
			switch (_x) do {
				case (ODDGUI_var_Secteur select 0): {
					_SelectSector pushback (ODDGUI_var_SecteurMarker select 0);
				};
				case (ODDGUI_var_Secteur select 1): {
					_SelectSector pushback (ODDGUI_var_SecteurMarker select 1);
				};
				case (ODDGUI_var_Secteur select 2): {
					_SelectSector pushback (ODDGUI_var_SecteurMarker select 2);
				};
				case (ODDGUI_var_Secteur select 3): {
					_SelectSector pushback (ODDGUI_var_SecteurMarker select 3);
				};
				case (ODDGUI_var_Secteur select 4): {
					_SelectSector pushback (ODDGUI_var_SecteurMarker select 4);
				};
				case (ODDGUI_var_Secteur select 5): {
					_SelectSector pushback (ODDGUI_var_SecteurMarker select 5);
				};
				case (ODDGUI_var_Secteur select 6): {
					_SelectSector pushback (ODDGUI_var_SecteurMarker select 6);
				};
				case (ODDGUI_var_Secteur select 7): {
					_SelectSector pushback (ODDGUI_var_SecteurMarker select 7);
				};
				case (ODDGUI_var_Secteur select 8): {
					_SelectSector pushback (ODDGUI_var_SecteurMarker select 8);
				};
			};
		} forEach ODD_var_SelectedSector;
	}
	else {
		_SelectSector = ODDGUI_var_SecteurMarker;
	};
	[["Secteur choisi : %1", str _SelectSector]] call ODDcommon_fnc_log;
	{
		_pos = getMarkerPos _x;
		_loc = nearestLocations[_pos, ODD_var_LocationType, 5000];
		_location = (_location - _loc) + _loc;
		// Récupère toutes les localité de chaque secteur (en un exemplaire)
	} forEach _SelectSector;
}
else {
	_location = nearestLocations[[15000, 15000], ODD_var_LocationType, 30000];
	// Récupère toutes les localités de la carte
};

[["Nombre de locations : %1", str(count(_location))]] call ODDcommon_fnc_log;

_obj = selectRandom _location;
// Choisi un objectif aléatoirement
private _Buildings = nearestobjects[position _obj, ODD_var_Houses, 200, True];

private _loctype = 0;
switch (type _obj) do {
	case (ODD_var_LocationType select 5): { _locType = 0;};
	case (ODD_var_LocationType select 4): { _locType = 1;};
	case (ODD_var_LocationType select 3): { _locType = 2;};
	case (ODD_var_LocationType select 2): { _locType = 3;};
	case (ODD_var_LocationType select 1): { _locType = 4;};
	case (ODD_var_LocationType select 0): { _locType = 5;};
};
{
	if (_x in ODD_var_LocationMilitaryName) then {
		_loctype = 3;
	};
}forEach ((text _obj) splitstring " ");

while {((text _obj in ODD_var_BlackistedLocation) or (count _Buildings == 0) or (_locType <= 2)/*limite l'utilisation des petites localité*/) and (count _location > 1)} do {
	// On s'assure que la localité est viable
	_location = _location - [_obj];
	_obj = selectRandom _location;
	_Buildings = nearestobjects[position _obj, ODD_var_Houses, 200, True];
	
	_loctype = 0;
	switch (type _obj) do {
		case (ODD_var_LocationType select 5): { _locType = 0;};
		case (ODD_var_LocationType select 4): { _locType = 1;};
		case (ODD_var_LocationType select 3): { _locType = 2;};
		case (ODD_var_LocationType select 2): { _locType = 3;};
		case (ODD_var_LocationType select 1): { _locType = 4;};
		case (ODD_var_LocationType select 0): { _locType = 5;};
	};
	{
		if (_x in ODD_var_LocationMilitaryName) then {
			_loctype = 3;
		};
	}forEach ((text _obj) splitstring " ");
};

_obj;

