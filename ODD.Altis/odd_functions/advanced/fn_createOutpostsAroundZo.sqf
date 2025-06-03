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


private _offset_angle = random 360;
private _research_nb = 0;
private _medevac_nb = 0;

for "_i" from 0 to _outpost_nb - 1 do {
	private _current_flavors = []; // Do this to create a copy of the array
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


	// On ajoute une couleur en fonction du nombre d'arbres autour
	private _color = "Brown";
	private _weight_Brown = 0;
	private _weight_Green = 0;
	private _weight_Rusty = 0;
	private _weight_Jungle = 0;
	private _nb_trees_around = count nearestTerrainObjects [_p, ["Tree", "small tree"], 150];
	if (_nb_trees_around < 100) then {
		// pas d'arbres = sand
		_weight_Brown = 7;
		_weight_Green = 1;
		_weight_Rusty = 2;
		_weight_Jungle = 0;
	} else {
		// arbres = green
		_weight_Brown = 0;
		_weight_Green = 7;
		_weight_Rusty = 2;
		_weight_Jungle = 1;
	};
	_current_flavors pushBack (["Brown","Green","Rusty","Jungle"] selectRandomWeighted [_weight_Brown, _weight_Green, _weight_Rusty, _weight_Jungle]);


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
