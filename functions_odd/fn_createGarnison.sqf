/* argument :
 *		_zo : Zonne d'operation
 *		
 */
// recup les argument
private _zo = _this select 0;		//Zone ou il faut faire spawn des garnison
private _action = _this select 1;	// es ce l'obj Principale

// Compte les Joueurs
private _human_players = count(allPlayers - entities "HeadlessClient_F"); // removing Headless Clients
private _nbGroup = [];
private _GBuild = [];

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
	
	_NbGarnison = round((((_human_players + 2 )/ 2) + (_taille / 50) + (4*(_locType^(1.2))) - (((count _locProx)/ 7) ^ 2) - ((((_heure - 12)^2)/ 48 ) + 3 ) + 4)/3);
	_nbGroup resize _NbGarnison;
	
	private _Med = true;	//definie qu'il faut faire spawn une caisse 

	// Recupère tout les batiments a proximité
	_Buildings = nearestObjects [position _zo, Maison, size _zo select 0];
	
	if (count _Buildings < count _nbGroup) then {	// Si il y a peux de batiment
		if (count _Buildings < 10)then {
			_nbGroup resize (count _Buildings - 1); 		// diminue le nombre de groupe 
		}
		else {
			_nbGroup resize (count _Buildings - ((count _Buildings) * 0.1)); 		// diminue le nombre de groupe 
		};
	};					//*/ Le but est qu'il y n'est pas 15 groupes en garnison dans 5 maison sur des petits obj avec beaucoup de joueurs
	// systemChat(Format["Garnison : %1",count _nbGroup]);
	
	//Pour tout les groupes nessaire 
	{
		private _group = [];
		// choisi un groupe
		if (floor(random 2) == 0) then {
			_group = selectRandom fireTeam;
		}
		else {
			_group = selectRandom squad; 
		};
		// choisi un batiment aléatoirement
		_GBuild = selectRandom _Buildings;
		
		// caisse med 
		if (_Med and (count _Buildings > 20)) then {		// si plus de 20 maison, et pas de caisse 
			_posBox = [position _GBuild select 0, position _GBuild select 1, (position _GBuild select 2) + 2];
			_box = "ACE_medicalSupplyCrate_advanced" createVehicle _posBox;		//pose une caisse 
			_Med = false;					// definie que la caisse a spawn	
		};
		
		//spawn le groupe
		_g = [getPos _GBuild, EAST, _group] call BIS_fnc_spawnGroup;
		
		//Ajoute le groupe a la liste des IA de la missions
		MissionIA pushBack _g;
		
		//Ajoute le groupe a la liste des IA en garnison
		GarnisonIA pushBack _g;
		
		_Buildings = _Buildings - [_GBuild];
		
		if (!(IsNil "HC1")) then {
			// systemChat "HC1 présent";
			_HCID = owner HC1;

			_g setGroupOwner _HCID;
			{ _x setOwner _HCID; } forEach (units _g);
		};
		
		sleep 2;
		
		//met en garnison
		[position _GBuild, nil, units _g, 20, 2, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
		// { _x disableAI "PATH"; } forEach (units _g);
		// [getPos _GBuild, nil, units _g, 100, 1, false, false] remoteExec ["\z\ace\addons\ai\functions\fnc_garrison.sqf",0]; // Garnison Ace
		// ["YoutV2"] remoteExec ["systemChat"];
		// systemChat("Garnison");
		
		
	}forEach _nbGroup;
	
	/*
	sleep 30;	//_clientID = owner _someobject;
	{
		if(_x == (GarnisonIA select 0)) then {
			[position ((units _x) select 0), nil, units _x, 20, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; // Garnison Ace
		}
		else{
			{
				[position ((units _x) select 0), nil, units _x, 100, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; // Garnison Ace
			}forEach units _x;
		};
	}forEach GarnisonIA;//*/
}
else {
	_nbGroup resize (5 + _human_players / 2); // remplacé la fonction 

	// Recupère tout les batiments a proximité
	_Buildings = nearestObjects [position _zo, Maison, size _zo select 0];
	
	if (count _Buildings < count _nbGroup) then {	// Si il y a peux de batiment
		_nbGroup resize (count _Buildings - 2); 	// diminue le nombre de groupe 
	};					// Le but est qu'il y n'est pas 15 groupes en garnison dans 5 maison sur des petits obj avec beaucoup de joueurs

	//Pour tout les groupes nessaire 
	{
		// choisi un groupe
		private _group = selectRandom fireTeam;
		
		// choisi un batiment aléatoirement
		_GBuild = selectRandom _Buildings;
		
		//spawn le groupe
		_g = [position _GBuild, EAST, _group] call BIS_fnc_spawnGroup;
		
		//Ajoute le groupe a la liste des IA de la missions
		ZOpIA pushBack _g;
		
		sleep(2);
		
		//met en garnison
		[position _GBuild, nil, units _g, 100, 0, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; // Garnison Ace
	}forEach _nbGroup;
};
// systemChat("2.fin");

