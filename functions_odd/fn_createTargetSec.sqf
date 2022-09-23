/*
* Auteur : Wolv
* Fonction pour créer un objectif secondaire
*
* Arguments :
* 0: Zone Principal <Objet>
* 1: Force Mission <String>
*
* Valeur renvoyée :
* Nom de l'odd_var_objectif créé
*
* Exemple :
* [_zo] call ODD_fnc_createTargetSec
* [_zo, _missiontype] call ODD_fnc_createTargetSec
*
* Variable publique :
*/
params ["_zo", ["_type", -1]];

_zoList = nearestLocations[position _zo, ODD_var_LocationType, ODD_var_DistanceZO];
// Récupère les localités à proximité

private _zoSec = selectRandom _zoList;
// Choisi une localité
_zoList = _zoList - [_zoSec];

private _Mission = selectRandom ODD_var_TargetSecTypeName;
// Choisi une mission secondaire aléatoirement

if (_type >= 0 and _type < count ODD_var_TargetSecTypeName) then {
    _Mission = ODD_var_TargetSecTypeName select _type;
    [["Mission secondaire forcée : %1 (%2)", _Mission, _type]] call ODD_fnc_log;
};

[["Mission secondaire : %1, sur : %2", _Mission, text _zoSec]] call ODD_fnc_log;

switch (_Mission) do {
	case(ODD_var_TargetSecTypeName select 0): {		//IED
		//create 2-5 "champ" IED campagne + 2-5 "champ" urbain
		//définir une limite d'ied a déminé 50% ?
	};
	case(ODD_var_TargetSecTypeName select 1): {		//Vehicule
		//definir type 
		//definir une condition de victoire distance ?
		private _zoDest = selectRandom _zoList;
		[["Mission secondaire destination : %1", text _zoDest]] call ODD_fnc_log;
	};
};

