/*
* Auteur : Wolv & Hhaine
* Fonction pour créer un civil en patrouille
*
* Arguments :
* 0: Hélipad attaché à la localité <Obj>
*
* Valeur renvoyée :
*
* Exemple:
* [_zo] call ODDcommon_fnc_civPatrol;
*
* Variable publique :
*/
params ["_zo"];

private _pos = position _zo;
private _Buildings = nearestobjects [_pos, ODD_var_Houses, size _zo select 0];
private _group = selectRandom ODD_var_Civilians;

// choisi un batiment aléatoirement
private _GBuild = selectRandom _Buildings;
// spawn le groupe
private _g = [getPos _GBuild, civilian, _group] call BIS_fnc_spawngroup;
// ODD_var_MissionCivilians pushBack _g;

{ [_x] call ODDintels_fnc_addInteraction; } forEach (units _g);

[position ((units _g) select 0), nil, units _g, 100, 1, False, True] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
sleep 1;
[units _g] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf";

{
	_x addEventHandler ["FiredNear", {
		params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
		[_unit, _distance] spawn ODDadvanced_fnc_civiesCover;
	}];
	_x addEventHandler ["Hit", {
		params ["_unit", "_source", "_damage", "_instigator"];
		if (((side _instigator) == WEST) and ((side _unit) == CIVILIAN)) then {
			[-1] call ODDCTI_fnc_updateCivRep;
		};
	}];
}forEach units _g;

_g setVariable ["trig_ODD_var_Civ", True, True];

_g;