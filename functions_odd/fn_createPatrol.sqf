/*
* Author: Wolv
* Fonction permetant de crée des garde en patrouille dans la zone
*
* Arguments:
* 0: Zone souhaité <Obj>
* 1: Es ce la zone principale <BOOL>
* 2: Activation du debug dans le chat <BOOL>
*
* Return Value:
* nil
*
* Example:
* [_zo] call ODD_fnc_createPatrol
* [_zo, true, false] call ODD_fnc_createPatrol
*
* Public:
*/

// recup les argument
params ["_zo", ["_action", false], ["_Debug", false]];

// Compte les Joueurs
private _human_players = count(allPlayers - entities "HeadlessClient_F"); // removing Headless Clients
private _nbPartol = [];

if (_action) then {
	
	//préparation des variables pour le calcule du nombre de groupe
	_locProx = nearestLocations [position _zo, locationType, 3000]; //Recup les location a - de 3000m 
	{
		if (text _x in locationBlkList) then {		//si dans la liste Noir 
			_locProx deleteAt _forEachIndex;				//on delete la location de notre liste 
		};
	}forEach _locProx;		// /!\ pas compté celle ou on est 
	_Buildings = nearestObjects [position _zo, Maison, size _zo select 0];	//Nombre de maison dans la localité
	_taille = size _zo select 0;		// Taille de la Zone
	_heure = date select 3;		// heure de la journé
	private _locType = 0;
	if (type _zo == locationType select 5) then { _locType = 0;};
	if (type _zo == locationType select 4) then { _locType = 1;};
	if (type _zo == locationType select 3) then { _locType = 2;};
	if (type _zo == locationType select 2) then { _locType = 3;};
	if (type _zo == locationType select 1) then { _locType = 4;};
	if (type _zo == locationType select 0) then { _locType = 5;};
	
	{
		if (_x in ["military", "airbase", "airfield"]) then {_locType = 3;};
	}forEach ((text _zo) splitString " ");
	
	_locType = (_locType + random[-1.2,0,1.2]) max 0;
	
	// Calule le nombre de groupe
	_NbPatrouille = round(
		(
			(_taille / 75) 
			+ ((count _Buildings)^(1/2)) 
			+ (_human_players / 4) 
			- ((_locType^2) / 2) 
			- (((count _locProx)/ 5) ^ (3/2)) 
			- ((((_heure - 12)^2)/ 48 ) + 3 ) 
			+ 4
		)/4);
	_nbPartol resize _NbPatrouille;
	
    [["Nombre de Patrouille sur %1 : %2 groupes", text _zo, _NbPatrouille]] call ODD_fnc_log;

	//Pour tout les groupes nessaire 
	{
		// choisi un groupe	
		private _group = selectRandom fireTeam;
		
		// choisi une position rdm dans un cercle autour du centre de l'obj
		_distPattrouille = (((size _x select 0) * 2) max 500);
		_pos = position _zo getPos [(random _distPattrouille), random 360];
		
		while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 10] > 0) or ((_pos select 2) < 0 )} do { 		// si il y a plus de 0 cailloux dans les 10 mettres ou position sous l'eau
			_pos = position _zo getPos [(random _distPattrouille), random 360];			//tire une nouvelles position car on veux pas qu'il spawn dans un cailloux
		};
		// systemChat(str(_pos));
		//spawn le groupe
		_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
		
		//Ajoute le groupe a la liste des IA de la missions
		MissionIA pushBack _g;
		
		sleep 1;
		
		//lui assigne des waypoint de patrouille
		[_g, _pos, round ((size _zo select 0) * 1.5)] call bis_fnc_taskpatrol;
		
	}forEach _nbPartol;
}
else {
	//Calule le nombre de groupe
	_nbPartol resize round (4 + _human_players / 8);
	//Ajoute un random
	_nbPartol resize 0 max (round random [(count _nbPartol) - 2, (count _nbPartol), (count _nbPartol) + 2]);

    [["Nombre de Patrouille sur %1 : %2 groupes", text _zo, count(_nbPartol)]] call ODD_fnc_log;

	{
		// choisi un groupe	
		private _group = selectRandom fireTeam;
		
		// choisi une position rdm dans un cercle autour du centre de l'obj
		_pos = position _zo getPos [800 * random 1, random 360];
		
		while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 10] > 0) or ((_pos select 2) < 0 )} do { 		// si il y a plus de 0 cailloux dans les 10 mettres ou position sous l'eau
			_pos = position _zo getPos [random 800, random 360];		//tire une nouvelles position car on veux pas qu'il spawn dans un cailloux
		};
		
		//spawn le groupe
		_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
		
		//Ajoute le groupe a la liste des IA de la missions
		ZOpIA pushBack _g;
		
		//lui assigne des waypoint de patrouille
		[_g, position _zo, size _zo select 0] call bis_fnc_taskpatrol;
		
	} forEach _nbPartol;
};
