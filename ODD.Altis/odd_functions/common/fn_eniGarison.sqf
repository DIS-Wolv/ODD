/*
* Auteur : Wolv & Hhaine
* Fonction pour créer un civil en garnison
*
* Arguments :
* 0: Hélipad attaché à la localité <Obj>
*
* Valeur renvoyée :
*
* Exemple:
* [_zo] call ODDcommon_fnc_civGarnison;
*
* Variable publique :
*/
params ["_zo"];

private _pos = position _zo;
private _Buildings = nearestobjects [_pos, ODD_var_Houses, size _zo select 0];
private _players = (playersNumber west);
private _group = selectRandom ODD_var_Pair;
if (_players < 5) then {		// si moins de 5 joueurs
		_group = selectRandom ODD_var_FireTeam;	// fireteam
} else {
	if (_players < 14) then {		// si plus de 5 joueurs et moins de 
		if (round random 2 == 0) then {			// 1/4 de chance 
			_group = selectRandom ODD_var_Squad;	
		}
		else {
			_group = selectRandom ODD_var_FireTeam;	
		};
	} else {
		if (round random 2 > 1) then {			// 1/2 de chance 
			_group = selectRandom ODD_var_Squad;
		}
		else {
			_group = selectRandom ODD_var_FireTeam;	
		};
		
	};
	
};

// choisi un batiment aléatoirement
private _GBuild = selectRandom _Buildings;

// spawn le groupe
private _g = [getPos _GBuild, east, _group] call BIS_fnc_spawngroup;
// ODD_var_MissionCivilians pushBack _g;

{
	_x setVariable ["acex_headless_blacklist", True, True]; // blacklist l'unit des HC
} forEach (units _g);
sleep 1;
[position ((units _g) select 0), nil, units _g, 100, 1, False, True] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";

{
	private _id = _x addEventHandler["Killed", 
		{ 
			params ["_unit", "_killer"]; 
			[_unit, _killer] call ODDadvanced_fnc_surrender;
		}
	];
	_x setVariable ["ODD_var_SurrenderHandler", _id, True];
	// EH pour secure Area ?

	_x addEventHandler ["Fired", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
		[_unit, _weapon, _projectile] spawn {
			params ["_unit", "_weapon", "_projectile"];
			sleep 1;
			if (_weapon == "Throw" and (_projectile distance _unit) < 5) then {
				deleteVehicle _projectile;
			};
		};
	}];
}forEach units _g;


_g setVariable ["trig_ODD_var_Gar", True, True];

_g;
