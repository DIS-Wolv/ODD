/*
* Auteur : Wolv
* Fonction pour spawn les garisons dans une localités
*
* Arguments :
* 0: Localité <Obj>
* 1: Maison <Obj>
*
* Valeur renvoyée :
*
* Exemple:
* [_loc] call ODDcontrol_fnc_spawnGar;
*
*/
params ["_loc", "_bat"];

if (isNil "_loc") exitWith {[["Erreur ODDcontrol_fnc_spawnGar : Aucune localité spécifiée"]] call ODDcommon_fnc_log;};
private _groupClassName = [];


// a réfléchir
// if ((playersNumber West) <= 4) then {
//	 if (random 1 > 0.5) then {
//		 _groupClassName selectRandom ODD_var_Pair;
//	 } else {
//		 _groupClassName selectRandom ODD_var_FireTeam;
//	 };
// }
// else if ((playersNumber West) <= 8) then {
//	 if (random 1 > 0.5) then {
//		 _groupClassName selectRandom ODD_var_Squad;
//	 } else {
//		 _groupClassName selectRandom ODD_var_FireTeam;
//	 };
// };
// choix le group a faire spawn
_groupClassName = selectRandom ODD_var_Squad;

// systemchat format ["Groupe: %1", _groupClassName];
// spawn le group
private _group = [getPosATL _bat, east, _groupClassName] call BIS_fnc_spawngroup;

_group setVariable ["ODD_var_Loc", _loc, True];

// désactive le headless client sur les IAs
{
	_x setVariable ["acex_headless_blacklist", True, True]; // blacklist l'unit des HC
} forEach (units _group);

// fait garrisonner les IAs
[position ((units _group) select 0), nil, units _group, 50, 1, False, True] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";

{
	// ajoute un event handler pour la rédition
	private _id = -1;

	// ajoute un event handler pour la suppression des grenades
	_id = _x addEventHandler ["Fired", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
		[_unit, _weapon, _projectile] spawn {
			params ["_unit", "_weapon", "_projectile"];
			sleep 1;
			if (_weapon == "Throw" and (_projectile distance _unit) < 5) then {
				deleteVehicle _projectile;
			};
		};
	}];
	_x setVariable ["ODD_var_GrenadeHandler", _id, True];

	_id = _x addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		[_unit, _killer] call ODDadvanced_fnc_surrender;
		private _aliveGroup = false;
		{
			if ((alive _x) and (lifeState _x != "INCAPACITATED")) then {
				_aliveGroup = true;
			};
		} forEach units group _unit;
		if (!_aliveGroup) then {
			{
				private _id = _x getVariable ["ODD_var_KilledHandler", -1];
				if (_id != -1) then {
					_x removeEventHandler ["Killed", _id];
				};
				_x setDamage 1;
				[_x] join grpNull;
			} forEach units group _unit;
		};
	}];
	_x setVariable ["ODD_var_KilledHandler", _id, True];
	_x setVariable ["ODD_var_SurrenderHandler", _id, True];

} forEach units _group;

_group addEventHandler ["Empty", {
	params ["_group"];
	private _loc = _group getVariable ["ODD_var_Loc", objNull];
	if (isNull _loc) exitWith {};

	// retire le groupe de la liste des garnisons
	private _groupList = _loc getVariable ["ODD_var_OccGarnisonGroup", []];
	_groupList = _groupList - [_group];
	_loc setVariable ["ODD_var_OccGarnisonGroup", _groupList, True];
}];

_group;
