/*
* Auteur : QuentinN42
* Fonction pour créer des camps autours d'une ville
*
* Arguments :
* 0: Zone objectif <position>
* 1: Nombre de camps souhaités <INT>
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [_zo] call ODDadvanced_fnc_createOutpostsAroundZo
* [_zo, 2] call ODDadvanced_fnc_createOutpostsAroundZo
*/
params ["_zo", ["_outpost_nb", 4]];

private _research_max = 1;
private _research_proba = 0.05;
private _medevac_max = 1;
private _medevac_proba = 0.2;

private _proba_jungle_near_oreokastro = 0.25;

private _base_flavors = [];

// Si en haut a gauche, des camps plus vert
// Sinon plutot sand
private _pos_bomos = [2300,22300,0];
if ((_pos_bomos distance2D _zo) < 10000) then {
	_base_flavors pushBack (
		["Jungle", "Green"] selectRandomWeighted [_proba_jungle_near_oreokastro, 1 - _proba_jungle_near_oreokastro]
	);
} else {
	_base_flavors pushBack (
		["Brown", "Green", "Rusty"] selectRandomWeighted [
			0.7,
			0.2,
			0.1
		]
	);
};

private _offset_angle = random 360;
private _research_nb = 0;
private _medevac_nb = 0;

for "_i" from 0 to _outpost_nb - 1 do {
	private _current_flavors = _base_flavors + []; // Do this to create a copy of the array
	if (_research_nb < _research_max) then {
		if (_research_proba > random 1) then {
			_research_nb = _research_nb + 1;
			_current_flavors pushBack "Research";
		};
	};
	if (_medevac_nb < _medevac_max) then {
		if (_medevac_proba > random 1) then {
			_medevac_nb = _medevac_nb + 1;
			_current_flavors pushBack "Medevac";
		};
	};


	private _angle = ((_i * 360 / _outpost_nb) + _offset_angle) % 360;
	private _distance = 500;

	// rotation d'un angle et decalage de _distance
	private _p = _zo getPos [_distance, _angle];

	// marker pour debug
	_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_p select 0), (_p select 1), (_p select 2)]), _p]; 
	_marker setMarkerType "hd_dot";
	_marker setMarkerColor "ColorBlue";

	private _tries = 0;
	while {_tries < 5} do {
		_tries = _tries + 1;
		private _posOpPossible = selectBestPlaces [_p, 150, "meadow + hills - 2*forest - houses", 1, 5];
		private _posOp = (selectRandom _posOpPossible) select 0;
		private _created = [_posOp, _current_flavors] call ODDadvanced_fnc_createOutpostAtPos;
		if (_created) then {
			break
		} else {
			systemChat format ["Unable to generate camps : %1 tries.", _tries];
		};
	}
};
