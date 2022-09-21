/*
* Author: Wolv
* Fonction permetant de créé un objectif secondaire sur une zone 
*
* Arguments:
* 0: Zone Principal <Obj>
* 1: Force Mission <String>
*
* Return Value:
* Nom de l'odd_var_objectif créé
*
* Example:
* [_zo] call ODD_fnc_createTargetSec
* [_zo, _missiontype] call ODD_fnc_createTargetSec
*
* Public:
*/
params ["_zo", ["_type", -1]];

//recup les loc a proximité
_zoList = nearestLocations[position _zo, ODD_var_LocationType, ODD_var_DistanceZO];

// Choisis une location
private _zoSec = selectRandom _zoList;
_zoList = _zoList - [_zoSec];

// Choisis une missions random
private _Mission = selectRandom ODD_var_TargetSecTypeName;

if (_type >= 0 and _type < count ODD_var_TargetSecTypeName) then {
    _Mission = ODD_var_TargetSecTypeName select _type;
    [["Mission secondaire forcé : %1 (%2)", _Mission, _type]] call ODD_fnc_log;
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

