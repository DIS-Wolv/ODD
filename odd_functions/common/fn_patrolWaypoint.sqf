/*
* Auteur : Wolv
* Fonction pour donner les Waypoints de patrouille à un groupe
*
* Arguments :
* 0: Groupe <Obj>
* 1: localité <Obj>
* 2: Nombre de Waypoints <Int>
*
* Valeur renvoyée :
* Groupe <Obj>
*
* Exemple:
* [_group, _loc] call ODDcommon_fnc_patrolWaypoint;
*
*/
params ["_group", "_loc", ["_nb", 20]];

// si il manque des arguments
if (isNil "_loc") exitWith {};
if (isNil "_group") exitWith {};

// récupération des infos de la localité
private _sizeMax = (size _loc) select 0;
private _pos = getPos _loc;

// si il y a moins de 3 groupes sur la localité on réduit la zone de patrouille
private _GroupOnLoc = _loc getVariable ["ODD_var_OccGarnisonGroup", []];
_GroupOnLoc = _GroupOnLoc + (_loc getVariable ["ODD_var_OccPatrolGroup", []]);
_GroupOnLoc = _GroupOnLoc - [grpNull];

// if(count (_GroupOnLoc) <= 4) then {
private _size = 150;
// };
if (side _group == east) then {
	_size = ((count (_GroupOnLoc) * 25) + 75) min _sizeMax;
};

// calcul des distances min et max
private _distMin = _size / 2;
private _distMax = _size;

private _basDeg = 0;
_baseDeg = random 360;
private _deg = 360 / _nb;

private _posList = [];

// pour chaque point 
for "_i" from 0 to (_nb - 1) do {
	// calcul de la position
	private _maPos = _pos getPos [(_distMin + random(_distMax)), ((_deg * _i) + _baseDeg)];
	// ajout à la liste
	_posList pushBack _maPos;
};

// mélange de la liste
_posList = _posList call BIS_fnc_arrayShuffle;

// ajout des waypoints
_group setBehaviour "SAFE";
{
	if ((ATLToASL(_x) select 2) >= 0) then {
		_group addWaypoint [_x, 0];
	};
} forEach _posList;

// ajout du waypoint pour recacluler les wp
private _last = _group addWaypoint [(_posList select 0), 0];
// _last setWaypointType "CYCLE";

_last setWaypointStatements ["true",Format["
	private _group = group this;
	private _loc = _group getVariable 'ODD_var_Loc';

	[_group, _loc] call ODDcommon_fnc_patrolWaypoint;
"]];

_group;
