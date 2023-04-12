/*
* Auteur : Wolv
* Fonction pour renvoyer le type de localité
*
* Arguments :
* 0: Zone souhaité <Objet>
*
* Valeur renvoyée :
* entier 
*
* Exemple :
* [_zo] call ODDcommon_fnc_ZoType
*
* Variable publique :
*/
params ["_zo"];

private _loctype = 0;	// ODD_var_LocationType = ['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill'];
switch (type _zo) do {
	case (ODD_var_LocationType select 5): {_loctype = 0;};
	case (ODD_var_LocationType select 4): {_loctype = 1;};
	case (ODD_var_LocationType select 3): {_loctype = 2;};
	case (ODD_var_LocationType select 2): {_loctype = 3;};
	case (ODD_var_LocationType select 1): {_loctype = 4;};
	case (ODD_var_LocationType select 0): {_loctype = 5;};
};

_loctype;
