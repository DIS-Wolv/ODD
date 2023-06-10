/*
* Auteur : QuentinN42
* Fonction pour préparer les camps 
*
* Arguments :
* 0: Centre
* 1: NB
*
* Valeur renvoyée :
* liste de :
*  - position du checkpoint
*  - flavors
*/
params ["_zo", ["_nb", 10]];

private _research_max = 1;
private _research_proba = 0.05;
private _medevac_max = 3;
private _medevac_proba = 0.2;

private _proba_jungle_near_oreokastro = 0.25;
private _pos_bomos = [2300,22300,0];

private _research_nb = 0;
private _medevac_nb = 0;

private _candidates = [];
while {(count _candidates) < _nb} do {
	private _base_pos = (position _zo) getPos [random [0, ODD_var_MissionArea/2, ODD_var_MissionArea], random 360];
	private _best_pos = (
		((selectBestPlaces [_base_pos, ODD_var_MissionArea/4, "meadow + 2*hills", 1, 1]) select 0) select 0
	);

	// si sous l'eau, on recommence
	if (surfaceIsWater _best_pos) then {continue};

	// si trop proche d'un autre camp, on recommence
	private _too_close = false;
	{
		if ((_best_pos distance2D _x) < 500) then {
			_too_close = true;
		};
	} forEach _candidates;
	if (_too_close) then {continue};

	_candidates pushBack _best_pos;
};

private _res = [];
{
	private _p = _x;

	private _current_flavors = [];
	// Si en haut a gauche, des camps plus vert
	// Sinon plutot sand
	if ((_pos_bomos distance2D _p) < 10000) then {
		_current_flavors pushBack (
			["Jungle", "Green"] selectRandomWeighted [_proba_jungle_near_oreokastro, 1 - _proba_jungle_near_oreokastro]
		);
	} else {
		_current_flavors pushBack (
			["Brown", "Green", "Rusty"] selectRandomWeighted [
				0.7,
				0.2,
				0.1
			]
		);
	};
	if (_research_nb < _research_max) then {
		if (_research_proba > random 1) then {
			_research_nb = _research_nb + 1;
			_current_flavors pushBack "Research";
		};
	};
	if (!("Research" in _current_flavors) and _medevac_nb < _medevac_max) then {
		if (_medevac_proba > random 1) then {
			_medevac_nb = _medevac_nb + 1;
			_current_flavors pushBack "Medevac";
		};
	};

	private _tries = 0;
	while {_tries < 5} do {
		_tries = _tries + 1;
		private _posOpPossible = selectBestPlaces [_p, 250, "meadow + hills - 2*forest - houses", 1, 5];
		private _posOp = (selectRandom _posOpPossible) select 0;
		private _final_pos = [_posOp, _current_flavors] call ODDadvanced_fnc_createOutpostAtPos;
		if ((count _final_pos) > 0) then {
			_res pushBack [_final_pos, _current_flavors];
			break
		};
	}
} forEach _candidates;

_res;
