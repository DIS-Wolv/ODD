/*
* Auteur : Wolv
* Fonction pour préparé les IEDs dans les localités proches du joueur 
*
* Arguments :
* 0: Trigger <Obj>
* 1: Activation ou desactivation de la zone
*
* Valeur renvoyée :
*
* Exemple:
* [_zo, _nbIED] call ODDcommon_fnc_initIED
*
* Variable publique :
*/
params ["_zo", ["_nb", 0]];

private _IEDs = [];
if (_nb > 0) then {
	_IEDS resize [_nb, []];
};

private _roads = (getPos _zo) nearRoads (size _loc select 0);

{
	if (count _roads > 0) then {
		private _road = selectRandom _roads;	// choisie une route random
		private _roadPos = position _road;		// recupère la position de la route
		
		private _coverDir = 0;						// direction default = 0
		_cRoads = roadsConnectedTo _road; 			// recupère les routes connecté
		
		_roads = _roads - [_road] - _cRoads;		// supprime la route ou il y a un IED et les routes directement adjacente
		
		if (count _cRoads > 0) then {
			_coverDir = _road getDir (selectrandom _cRoads); // si au moins 1 route connecté prend la direction de la route
		};
		_roadPos = _roadPos getPos [(3 + random 2.5), (_coverDir + 90)]; // choisie une position sur le coté

		// définie le cover et ca position
		private _cover = selectRandom ODD_var_IEDCover;
		private _coverPos = _roadPos findEmptyPosition [sizeOf _cover, 50, _cover];

		// définie l'explosif et ca position 
		private _explo = selectRandom ODD_var_IEDExplosive;
		private _exploPos = _coverPos getPos [(random 0.5) + 0.2, random 360];

		private _type = floor random 5; // choisie le type de l'IED
		if ((floor random 4) == 0) then { _type = -1; }; // 1/4 chance que ca soit un faux
		
		private _triggerMan = selectRandom ODD_var_Civilians;
		private _triggerManPos = [0,0,0];

		// _type = 0;
		switch (_type) do {
			case 0: {	// IED détonné radio, brouillable, triggerman ennemi loin
				_triggerMan = [selectRandom (selectRandom ODD_var_Pair)];

				// recupère uniquement les batiment entre 50 et 100 m
				private _bclist = nearestobjects [_coverPos, ODD_var_Houses, 20];
				private _blist = nearestobjects [_coverPos, ODD_var_Houses, 100];
				if (count _blist <= count _bclist) then {_blist = nearestobjects [_coverPos, ODD_var_Houses, 250];};
				_bList = _bList - _bclist;

				// choisie un batiment random
				private _b = selectRandom _bList;

				if (!(count _blist > 0)) then {
					_triggerManPos = _coverPos getPos [70 + random (50), random 360]; // en choisie une position random
				}
				else {
					// recupère les positions dans le batiment 
					private _poslist = [_b] call BIS_fnc_buildingPositions;
					_triggerManPos = selectrandom _poslist; // en choisie une position random
				};
			};
			case 1: {	// IED détonné radio, brouillable, triggerman civil loin
				_triggerMan = selectRandom ODD_var_Civilians;

				// recupère uniquement les batiment entre 50 et 100 m
				private _bclist = nearestobjects [_coverPos, ODD_var_Houses, 20];
				private _blist = nearestobjects [_coverPos, ODD_var_Houses, 100];
				if (count _blist <= count _bclist) then {_blist = nearestobjects [_coverPos, ODD_var_Houses, 250];};
				_bList = _bList - _bclist;

				// choisie un batiment random
				private _b = selectRandom _bList;
				if (!(count _blist > 0)) then {_b = nearestBuilding _coverPos};

				// recupère les positions dans le batiment 
				private _poslist = [_b] call BIS_fnc_buildingPositions;
				if (!(count _poslist > 0)) then {_poslist = [position _b]};
				_triggerManPos = selectrandom _poslist; // en choisie une position random
			};
			case 2: {	// ied détonné par fil, non brouillable, triggerman ennemi proche
				_triggerMan = [selectRandom (selectRandom ODD_var_Pair)];

				// recupère uniquement les batiment entre 10 et 50 m
				private _bclist = nearestobjects [_coverPos, ODD_var_Houses, 10];
				private _blist = nearestobjects [_coverPos, ODD_var_Houses, 50];
				if (count _blist <= count _bclist) then {_blist = nearestobjects [_coverPos, ODD_var_Houses, 250];};
				_bList = _bList - _bclist;

				// choisie un batiment random
				private _b = selectRandom _bList;
				if (!(count _blist > 0)) then {_b = nearestBuilding _coverPos};

				// recupère les positions dans le batiment 
				private _poslist = [_b] call BIS_fnc_buildingPositions;
				if (!(count _poslist > 0)) then {_poslist = [position _b]};
				_triggerManPos = selectrandom _poslist; // en choisie une position random
			};
			case 3: {	// ied détonné par fil, non brouillable, triggerman civil proche
				_triggerMan = selectRandom ODD_var_Civilians;

				// recupère uniquement les batiment entre 10 et 50 m
				private _bclist = nearestobjects [_coverPos, ODD_var_Houses, 10];
				private _blist = nearestobjects [_coverPos, ODD_var_Houses, 50];
				if (count _blist <= count _bclist) then {_blist = nearestobjects [_coverPos, ODD_var_Houses, 250];};
				_bList = _bList - _bclist;

				// choisie un batiment random
				private _b = selectRandom _bList;
				if (!(count _blist > 0)) then {_b = nearestBuilding _coverPos};

				// recupère les positions dans le batiment 
				private _poslist = [_b] call BIS_fnc_buildingPositions;
				if (!(count _poslist > 0)) then {_poslist = [position _b]};
				_triggerManPos = selectrandom _poslist; // en choisie une position random
			};
			case 4: {	// ied mine qui explose s'il y a plus de 2 joueurs à portée
				_triggerMan = "";
				_triggerManPos = [0,0,0];
			};
			case -1: {	// ied fake
				_explo = "";
				_exploPos = [0,0,0];
				_triggerMan = "";
				_triggerManPos = [0,0,0];
			};
			default {
				[["ODD_BUG : Action IED non prévue : %1", _action]] call ODDcommon_fnc_log;
			};
		};
		_triggerManPos set [2, (_triggerManPos select 2) + 0.1];

		_IEDS set [_forEachIndex, [_cover, _coverPos, _coverDir, _explo, _exploPos, _type, _triggerMan, _triggerManPos]];
	}
	else {
		_IEDS = _IEDS - [];
	};
} forEach _IEDS;

_IEDS;
