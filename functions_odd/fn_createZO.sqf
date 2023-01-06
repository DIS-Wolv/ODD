/*
* Auteur : Wolv
* Fonction pour créer une zone d'opération
*
* Arguments :
* 0: Choisi une zone <STRING>
*
* Valeur renvoyée :
* Localité
*
* Exemple:
* [] call ODD_fnc_createZO
* [_forceZO] call ODD_fnc_createZO
*
* Variable publique :
*/
params [["_forceZO", ""]];

private _location = [];
private _SelectSector = [];

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
	[["Secteur choisi : %1", str _SelectSector]] call ODD_fnc_log;
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

[["Nombre de locations : %1", str(count(_location))]] call ODD_fnc_log;

private _obj = selectRandom _location;
// Choisi un objectif aléatoirement
private _Buildings = nearestobjects[position _obj, ODD_var_Houses, 200];

while {(text _obj in ODD_var_BlackistedLocation) or (count _Buildings == 0)} do {
	// On s'assure que la localité est viable
	_obj = selectRandom _location;
	_Buildings = nearestobjects[position _obj, ODD_var_Houses, 200];
};

[["Localité choisie : %1", text _obj]] call ODD_fnc_log;

if (_forceZO != "") then {
	{
		if (_forceZO == text _x) then {
			_obj = _x;
		};
	}forEach _location;
	[["Localité imposée : %1", text _obj]] call ODD_fnc_log;
};

// private _pos = position _obj;
// // Récupère la position de l'objectif
// _pos set [0, ((_pos select 0) + ((size _obj) select 0)/2)];
// _pos set [1, ((_pos select 1) + ((size _obj) select 0)/2)];
// _marker = createMarker ["ODDOBJ", _pos];
// _marker setMarkertype "hd_objective";
// _marker setMarkerColor "coloropfor";
// _marker setMarkertext "O";
// // Ajoute un marqueur d'objectif

// [text _obj] remoteExec ["systemChat", 0];
[["Marquer mis en place"]] call ODD_fnc_log;

_obj;
// Renvoie la localité
