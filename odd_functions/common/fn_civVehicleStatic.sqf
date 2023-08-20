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
* [_zo] call ODDcommon_fnc_civVehicleStatic;
*
* Variable publique :
*/
params ["_zo", ["_radius", 1000]];

// choisit un VL
private _group = selectRandom ODD_var_CivilianVehicles;
// Trouve une maison a cote de laquelle faire spawn le VL
private _house = selectRandom nearestobjects [
	position _zo,
	ODD_var_Houses,
	_radius
];

private _pos = (position _house) getPos [10, (random 360)];

// spawn le VL
private _grp = [_pos, _group select 0, civilian] call ODDadvanced_fnc_createVehiculeAtPos;

if (isNil "_grp") exitWith {};
_grp setVariable ["trig_ODD_var_Civ", True, True];

// VL
private _vl = vehicle leader _grp;
[_vl, True, True, (random[2, 10, 15])] call ODDcommon_fnc_CtrlVlLock;
_vl setVariable ["trig_ODD_var_Civ", True, True];
_vl setdir (((getDir _house) + (round (random 4)) + 90) % 360);

// Civils
{
	_x setVariable ["trig_ODD_var_Civ", True, True];
	unassignVehicle _x;  // disambark
} forEach units _grp;

_grp
