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

private _pos = position _zo;
private _Buildings = nearestobjects [position _zo, ODD_var_Houses, size _zo select 0];
private _GBuild = selectRandom _Buildings;

private _group = selectRandom ODD_var_CivilianVehicles;

_pos = (position _GBuild) findEmptyPosition [3, 100, (_group select 0)];
// spawn le groupe
private _g = (_group select 0) createVehicle _pos;


_g setdir (((getDir _GBuild)+ (round (random 4)) + 90) % 360);

[_g, True, True, (random[2, 10, 15])] call ODDcommon_fnc_CtrlVlLock;

_g setVariable ["trig_ODD_var_Civ", True, True];

_g;