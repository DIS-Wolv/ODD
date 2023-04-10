/*
* Auteur : Wolv & Hhaine
* Fonction pour créer un groupe d'ennemis en patpatrouille
*
* Arguments :
* 0: Hélipad attaché à la localité <Obj>
*
* Valeur renvoyée :
*
* Exemple:
* [_loc] call ODDcommon_fnc_civPatrol;
*
* Variable publique :
*/
params ["_loc"];
private _zo = _loc getVariable ["trig_ODD_var_loc", ""];
private _pos = position _zo;
private _Buildings = nearestobjects [_pos, ODD_var_Houses, size _zo select 0];
private _players = (playersNumber west);
private _group = selectRandom ODD_var_Pair;
if (_players < 5) then {		// si moins de 5 joueurs
	if (round random 1 == 0) then {			// 1/2 de chance 
		_group = selectRandom ODD_var_Pair;		// pair
	}
	else {
		_group = selectRandom ODD_var_FireTeam;	// fireteam
	};
} else {
	if (_players < 14) then {		// si plus de 5 joueurs et moins de 
		if (round random 2 == 0) then {			// 1/4 de chance 
			_group = selectRandom ODD_var_FireTeam;		// fireteam
		}
		else {
			_group = selectRandom ODD_var_Pair;			// pair
		};
	} else {
		if (round random 2 == 0) then {			// 1/4 de chance 
			_group = selectRandom ODD_var_Squad;		// fireteam
		}
		else {
			_group = selectRandom ODD_var_FireTeam;		// squad
		};
		
	};
	
};

// choisi un batiment aléatoirement
private _GBuild = selectRandom _Buildings;
// spawn le groupe
private _g = [getPos _GBuild, east, _group] call BIS_fnc_spawngroup;
// ODD_var_MissionCivilians pushBack _g;

{
	private _id = _x addEventHandler["Killed", 
		{ 
			params ["_unit", "_killer"]; 
			[_unit, _killer] call ODDadvanced_fnc_surrender;
		}
	];
	_x setVariable ["ODD_var_SurrenderHandler", _id, True];
	// EH pour secure Area ?
}forEach units _g;

[_g, position _zo, size _zo select 0] call bis_fnc_taskpatrol;

_g setVariable ["trig_ODD_var_Pat", True, True];

_g;
