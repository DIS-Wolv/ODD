/*
* Auteur : Wolv
* Fonction de spawn des IEDs
*
* Arguments :
* 0: Est ce la zone principale <OBJ>
* 1: Nombre d'IED <INT>
* 2: Distance à la sone <INT>
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [_zo] call ODD_fnc_pressureIED
* [_zo, 2, 4000] call ODD_fnc_pressureIED
*
* Variable publique :
*/
params ["_zo", ["_nb", 2], ["_isDecoy", False], ["_dist", ODD_var_MissionArea]];

_pos = position _zo; 
private _props = [];
private _IED = [];
_IED resize _nb;
private _trapTypeLand = [];
private _trapTypeUrban = [];

_LocType = ODD_var_LocationType - ['namelocal', 'Hill'];
_nearZO = nearestLocations[position _zo, _LocType, _dist];

_roads = _pos nearRoads _dist;

{
	_posZo = position _x;
	_roadZo = _posZo nearRoads ((size _x select 1));
	_roads = _roads + _roadZo + _roadZo;
	// Ajoute plusieurs fois les routes dans les localités
} forEach _nearZO;

_roadsFOB = position usine nearRoads 200;
_roads = _roads - _roadsFOB;
// Retire les routes près de l'objet "usine" à la liste
{
	_trapRoad = selectRandom _roads;
	_cRoads = roadsConnectedTo _trapRoad;
	while {count _cRoads == 0} do {
		_roads = _roads - [_trapRoad];
		_trapRoad = selectRandom _roads;
		_cRoads = roadsConnectedTo _trapRoad;
	};

	_cRoad = selectRandom _cRoads;
	_dir = _trapRoad getDir _cRoad;
	_roads = _roads - [_trapRoad];
	_trapPos = _trapRoad getPos [(3 + random 2.5), (_dir + 90)]; 
	// Défini la position de l'IED plus ou moins sur le coté de la route
	
	if (_isDecoy) then {
		// Les leurs n'explosent que par action volontaire
		_trapTypeLand = ODD_var_RemoteControlledStandartIED;
		_trapTypeUrban = ODD_var_RemoteControlledUrbanIED;
	}
	else {
		// Les "vrais" IEDs qui peuvent exploser lorsque l'on marche dessus
		_trapTypeLand = ODD_var_PressurePlateStandardIED;
		_trapTypeUrban = ODD_var_PressurePlateUrbanIED;
	};

	_trapType = _trapTypeLand + _trapTypeUrban;

	_houses1 = _trapPos nearObjects ["House", 30];
	if (count _houses1 >= 2) then {
		_trapType = _trapType + _trapTypeUrban;
	}
	else {
		_trapType = _trapType + _trapTypeLand;
	};

	_houses2 = _trapPos nearObjects ["House", 70];
	_houses2 = _houses2 - _houses1;
	if (count _houses2 >= 15) then {
		_trapType = _trapType + _trapTypeUrban;
	}
	else {
		_trapType = _trapType + _trapTypeLand;
	};

	_houses3 = _trapPos nearObjects ["House", 150];
	_houses3 = _houses3 - (_houses1 + _houses2);
	if (count _houses3 >= 15) then {
		_trapType = _trapType + _trapTypeUrban;
	}
	else {
		_trapType = _trapType + _trapTypeLand;
	};
	// Change la probabilité qu'un IED soit de type urbain ou rural en fonction du nombre de maison a proximité 

	_trapClass = selectRandom _trapType; 
	
	_trap = createMine[_trapClass, _trapPos, [], 0];
	
	_IED set [_forEachIndex, _trap];

}forEach _IED; 

if (_isDecoy) then {
	[["ODD_Quantité : Nombre d'IED non activé placé : %1", { !(isNull _x) } count _IED]] call ODD_fnc_log;
	ODD_var_MissionProps = ODD_var_MissionProps + _IED;
}
else {
	[["ODD_Quantité : Nombre d'IED activé placé : %1", { !(isNull _x) } count _IED]] call ODD_fnc_log;
	ODD_var_MissionIED = ODD_var_MissionIED + _IED;
	ODD_var_MissionProps = ODD_var_MissionProps + _IED;
};
// Ajoute les IEDs au log
