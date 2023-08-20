/*
* Auteur : Wolv & Hhaine
* Fonction pour créer un civil en patrouille véhiculée
*
* Arguments :
* 0: Hélipad attaché à la localité <Obj>
*
* Valeur renvoyée :
*
* Exemple:
* [_zo] call ODDcommon_fnc_civVehicle;
*
* Variable publique :
*/
params ["_zo", ["_radius", 1000]];

private _pos = position _zo;
private _group = selectRandom ODD_var_CivilianVehicles;
private _roads = _pos nearRoads _radius;

private _grp = [position selectRandom _roads, _group select 0, civilian] call ODDadvanced_fnc_createVehiculeAtPos;

if (isNil "_grp") exitWith {};

// Tourne en boucle
for "_i" from 1 to 4 do {
	private _wai_pos = position selectRandom _roads;
	_grp addWaypoint [_wai_pos, -1];

	if (_i == 4) then {
		_grp addWaypoint [_wai_pos, -1];
		(waypoints _grp) select 5 setWaypointType "CYCLE";
	};
};

_grp setSpeedMode "LIMITED";
{
	_x setVariable ["ODD_var_ZOM", True, True];
	_x call ODDcommon_fnc_addIntel;
	_x addEventHandler ["FiredNear", {
		params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
		[_unit, _distance] spawn ODDadvanced_fnc_civiesCover;
	}];
	_x addEventHandler ["Hit", {
		params ["_unit", "_source", "_damage", "_instigator"];
		if (((side _instigator) == WEST) and ((side _unit) == CIVILIAN)) then {
			ODD_var_CivilianReputation = ODD_var_CivilianReputation - 1;
		};
	}];
	_x setVariable ["trig_ODD_var_Civ", True, True];
} forEach units _grp;

(vehicle ((units _grp) select 0)) setVariable ["trig_ODD_var_Civ", True, True];
_grp setVariable ["trig_ODD_var_Civ", True, True];


_grp;
