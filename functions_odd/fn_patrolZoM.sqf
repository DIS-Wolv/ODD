/*
* Author: Wolv
* Fonction permetant de généré les waypoint des partouille en ZO -
*
* Arguments:
* 0: Groupe en patrouille
* 1: Est un vl (cherche des WP sur des routes)
*
* Return Value:
* nil
*
* Example:
* [_g] call ODD_fnc_patrolZoM
*
* Public:
*/
params ["_g", ["_isVL", False]];

//position du chef de groupe
private _leader = (units _g select 0);
private _pos = position _leader;

//liste des ZO possible trié du plus proche du chef de groupe
_zoList = nearestLocations[getpos ODD_var_ZO, ODD_var_LocationType, 4000, _pos];

//selectionne la ou il commence la patrouille
_pZo = _zoList select 0;

//retire la zone actuelle
_zoList = _zoList - [_pZo];

//choisi la zone suivante
_nextZo = selectrandom _zoList;

//systemChat str text _pZo;
for "_i" from 0 to ((round(random 4))+4) do {

	_posWP = position _pZo getPos [(random 300) + 300, random 360];

	if (_isVL) then {		
		_posWP = selectrandom (position _pZo nearRoads 600);
	};

	_g addWaypoint [_posWP, 5];

};

//patrouille sur la ZO suivante
_posWP = position _nextZo getPos [(random 100) + 100, random 360];
if (_isVL) then {
	_posWP = selectrandom (position _nextZo nearRoads 200);
};
_g addWaypoint [_posWP, 5];

waitUntil {
	sleep 5;
	(_leader distance2D (getPos _nextZo)) < 300
};

[_g] spawn ODD_fnc_patrolZoM;