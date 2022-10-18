/*
* Auteur : Wolv
* Fonction pour créer des patrouilles dans la zone
*
* Arguments :
* 0: Zone souhaité <Objet>
* 1: Est-ce la zone principale <BOOL>
* 2: Activation du débug dans le chat <BOOL>
*
* Valeur renvoyée :
* nil
*
* Exemple:
* [_zo] call ODD_fnc_createPatrol
* [_zo, true, false] call ODD_fnc_createPatrol
*
* Variable publique :
*/

// Récupère les arguments
params ["_zo", ["_action", False], ["_ZOM", False]];

// Compte les joueurs
private _human_players = ODD_var_PlayerCount; // removing Headless Clients
private _nbPartol = [];

private _loctype = 0;	// ODD_var_LocationType = ['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill'];
switch (type _zo) do {
	case (ODD_var_LocationType select 5): {_loctype = 0;};
	case (ODD_var_LocationType select 4): {_loctype = 1;};
	case (ODD_var_LocationType select 3): {_loctype = 2;};
	case (ODD_var_LocationType select 2): {_loctype = 3;};
	case (ODD_var_LocationType select 1): {_loctype = 4;};
	case (ODD_var_LocationType select 0): {_loctype = 5;};
};
{
	if (_x in ODD_var_LocationMilitaryName) then {
		_locType = 2;
	};
}forEach ((text _zo) splitstring " ");

private _patModifier = 0;
switch (_loctype) do {
	case 0: { _patModifier = -1; };
	case 1: { _patModifier = 0; };
	case 2: { _patModifier = 1; };
	case 3: { _patModifier = 1; };
	case 4: { _patModifier = 2; };
	case 5: { _patModifier = 3; };
	default { _patModifier = 0; };
};

if (_action) then {
	
	// Prépare les variables pour le calcul du nombre de groupes
	_locProx = nearestLocations [position _zo, ODD_var_LocationType, 3000]; //Recup les location a - de 3000m 
	{
		if (text _x in ODD_var_BlackistedLocation) then {		
			// Si la localité est dans la liste noire
			_locProx deleteAt _forEachIndex;
			// La localité est supprimée de notre liste
		};
	}forEach _locProx;
	// Compte les localités à proximité
	_Buildings = nearestObjects [position _zo, ODD_var_Houses, size _zo select 0];	
	// Nombre de maisons dans la localité
	_taille = size _zo select 0;
	// Taille de la Zone
	_heure = date select 3;
    // Heure de la journée
	private _locType = 0;
	switch (type _zo) do {
		case (ODD_var_LocationType select 5): { _locType = 0;};
		case (ODD_var_LocationType select 4): { _locType = 1;};
		case (ODD_var_LocationType select 3): { _locType = 2;};
		case (ODD_var_LocationType select 2): { _locType = 3;};
		case (ODD_var_LocationType select 1): { _locType = 4;};
		case (ODD_var_LocationType select 0): { _locType = 5;};
	};
	
	{
		if (_x in ODD_var_LocationMilitaryName) then {_locType = 3;};
	}forEach ((text _zo) splitString " ");
	
	_locType = (_locType + random[-1.2,0,1.2]) max 0;
	
	// Calule le nombre de groupes
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

	//Pour tous les groupes
	{
		// Choisi un groupe	
		private _group = selectRandom ODD_var_FireTeam;
		
		// Choisi une position aléatoire dans un cercle autour du centre de l'objectif
		_distPattrouille = (((size _zo select 0) * 2) max 500);
		_pos = position _zo getPos [(random _distPattrouille), random 360];
		
		while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 10] > 0) or ((_pos select 2) < 0 )} do { 		
            // S'il y a des rochers ou des maisons à moins de 10m ou si la position est sous l'eau
			_pos = position _zo getPos [(random _distPattrouille), random 360];			
            // Tire une nouvelle position
		};
		// systemChat(str(_pos));
		// Crée le groupe
		_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
		
		// Ajoute le groupe à la liste des IA de la missions
		ODD_var_MainAreaIA pushBack _g;
		
		sleep 1;
		
		// Assigne des points de passage à la patrouille
		[_g, _pos, round ((size _zo select 0) * 1.5)] call bis_fnc_taskpatrol;
		
	}forEach _nbPartol;
}
else {
	//Calule le nombre de groupes
	_nbPartol resize (round (1 + _human_players / (floor (3 + random 3)) + _patModifier));
	// Ajoute de l'aléatoire
	_nbPartol resize 0 max (round random [(count _nbPartol) - 3, (count _nbPartol), (count _nbPartol) + 1]);

	if (!_ZOM) then {
		[["Nombre de Patrouille sur %1 : %2 groupes", text _zo, count(_nbPartol)]] call ODD_fnc_log;

		{
			// Choisi un groupe	
			private _group = selectRandom ODD_var_FireTeam;
			
			// Choisi une position aléatoire dans un cercle autour du centre de l'objectif
			_pos = position _zo getPos [800 * random 1, random 360];
			
			while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 10] > 0) or ((_pos select 2) < 0 )} do { 		// si il y a plus de 0 cailloux dans les 10 mettres ou position sous l'eau
				_pos = position _zo getPos [random 800, random 360];		//tire une nouvelles position car on veux pas qu'il spawn dans un cailloux
			};
			
			// Crée le groupe
			_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
			
			// Ajoute le groupe à la liste des IA de la missions
			ODD_var_SecondaryAreasIA pushBack _g;
			
			// Assigne des points de passage à la patrouille
			[_g, position _zo, size _zo select 0] call bis_fnc_taskpatrol;
			
		} forEach _nbPartol;
	}
	else {
		[["Nombre de Patrouille en ZO- sur %1 : %2 groupes", text _zo, count(_nbPartol)]] call ODD_fnc_log;

		{
			// Choisi un groupe
			private _group = selectRandom ODD_var_FireTeam;

			// Choisi une position aléatoire dans un cercle autour du centre de l'objectif
			_pos = position _zo getPos [800 * random 1, random 360];
			
			while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 10] > 0) or ((_pos select 2) < 0 )} do { 		// si il y a plus de 0 cailloux dans les 10 mettres ou position sous l'eau
				_pos = position _zo getPos [random 400, random 360];		//tire une nouvelles position car on veux pas qu'il spawn dans un cailloux
			};
			// Crée le groupe
			_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;

			// Ajoute le groupe à la liste des IA de la missions
			ODD_var_SecondaryAreasIA pushBack _g;

			[_g] spawn ODD_fnc_patrolZoM;

		} forEach _nbPartol;
	};
};
