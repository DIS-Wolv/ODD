/*
* Auteur : Wolv
* Fonction pour déterminer le nombre de patrouille a ajouter sur une zone
*
* Arguments :
* 0: Groupe <Obj>
*
* Valeur renvoyée :
*
* Exemple:
* [_group] call ODDcontrol_fnc_garToPatrol;
*
*/
params ["_loc"];

private _seuil = 500;
private _posLoc = position _loc;

// détermine le nombre de patrouille a créer
private _garnison = _loc getVariable ["ODD_var_OccGarnisonGroup", []];

private _countNewPatrol = 2 + round random 2;
_countNewPatrol = _countNewPatrol min (count _garnison);

// pour chaque patrouille a créer
for "_i" from 1 to _countNewPatrol do {
	// récupère le nombre de groupe qu'il reste a spawn
	private _PoolGarnison = _loc getVariable ["ODD_var_OccActEni", 0];
	// si il reste des groupes a spawn
	if (_PoolGarnison > 0) then {

		private _spawnPos = [0,0,0];

		// trouve une position
		private _playerList = allPlayers;
		_playerList = _playerList apply {(getPos _x) distance2D _posLoc};

		private _minDist = selectMin _playerList;
		private _spawnBuild = nearestobjects [_posLoc, ODD_var_Houses, (_seuil/2)];
		if ((_minDist > _seuil) and (count _spawnBuild > 0)) then {
			// player assez loin
			_spawnBat = selectRandom _spawnBuild;
			_spawnPos = selectRandom ([_spawnBat] call BIS_fnc_buildingPositions);

		}
		else {
			private _locSpawn = True;

			// player trop proche ou pas assez de batiments
			private _nearlocation = _loc getVariable ["ODD_var_nearLocations", []];
			// trouve une position de spawn
			private _spawnloc = selectRandom _nearlocation;
			private _isBlue = _spawnloc getVariable ["ODD_var_isBlue", False];
			while {((count _nearlocation) > 0) and (_isBlue)} do {
				_nearlocation = _nearlocation - [_spawnloc];
				_spawnloc = selectRandom _nearlocation;
				_isBlue = _spawnloc getVariable ["ODD_var_isBlue", False];
			};

			_isBlue = _spawnloc getVariable ["ODD_var_isBlue", False];
			if (_isBlue) then {
				_locSpawn = False;
			};

			if (_locSpawn) then {
				_spawnPos = getPos _spawnloc;
			}
			else {
				_spawnPos = _posLoc getPos [(random 1000 + 500), random 360];
			};

		};

		// crée un groupe de patrouille
		private _group = [_loc, _spawnPos] call ODDControl_fnc_spawnPat;
		_loc setVariable ["ODD_var_OccPatrolGroup", ((_loc getVariable ["ODD_var_OccPatrolGroup", []]) + [_group])];

		// suprime un groupe du pool
		_loc setVariable ["ODD_var_OccActEni", (((_loc getVariable ["ODD_var_OccActEni", []]) - 1) max 0)];
	}
	else {
		// transforme une garnison en patrouille
		_garnison = _loc getVariable ["ODD_var_OccGarnisonGroup", []];

		// choisi un groupe de garnison aléatoirement
		private _monGroup = selectRandom _garnison;
		_garnison = _garnison - [_monGroup];

		_loc setVariable ["ODD_var_OccGarnisonGroup", _garnison];

		// Ajout du groupe a la liste des patrouilles
		_loc setVariable ["ODD_var_OccPatrolGroup", ((_loc getVariable ["ODD_var_OccPatrolGroup", []]) + [_monGroup])];
		// le passe en patrouille

		// cette ligne marche pas lol
		[_monGroup] call ODDControl_fnc_GarToPatrol;
	};
};

/*
_posp = position player;

_poszo = position loc;

_distZo = _posp distance2D _poszo;

_seuil = 200;

if (_distZo >= _seuil) then {
 _dirZO = _posp getdir _poszo;
 
 _newpos = _poszo getPos [(_seuil/2), _dirZO];
 
 _spawnBuild = nearestobjects [_newpos, ODD_var_Houses, (_seuil/4)];
 
 _spawnBat = selectRandom _spawnBuild;
 
 _spawnPosS = [_spawnBat] call BIS_fnc_buildingPositions;
 
 private _spawnPos = 0;
 
 if (count _spawnPosS > 0) then {
  _spawnPos = selectRandom _spawnPosS;
 }
 else {
  _spawnPos = position _spawnBat;
 };
 
 _spawnPos = ASLToATL _spawnPos;
 
 "RoadCone_F" createVehicle _spawnPos;

 _vis = [objNull, "VIEW"] checkVisibility [_posp, _spawnPos];
 _vis


}
else {
 _dir = random 360;
	
 _spawnPos = _poszo getPos [(_seuil*2), _dir];
 
 "RoadCone_F" createVehicle _spawnPos;

 _vis = [objNull, "VIEW"] checkVisibility [_posp, _spawnPos];
 _vis
  
};


