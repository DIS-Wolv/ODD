params [["_missionType",-1], ["_ForceZO",-1], ["_ZOP",True], ["_Debug", False]];

call WOLV_fnc_var;

// systemChat("Init ODD");
if(CurrentMission == 0) then {
	private _future = serverTime + 6;//5;
	["Génération d'une mission"] remoteExec ["systemChat", 0];
	CurrentMission = 2;
	publicVariable "CurrentMission";
	// Choix d'un Lieux objectif 
	Private _zo = call WOLV_fnc_createZO;
	// Private _diff = [_zo] call _CalcDifficulty
	// systemChat(str(_diff));

	// Choix d'une missions
	Private _target = [_zo, _missionType] call WOLV_fnc_createTarget;
	
	[_zo, true] call WOLV_fnc_civil;
	
	[_zo, true] call WOLV_fnc_createGarnison;
	
	[_zo, true] call WOLV_fnc_createPatrol;
	
	[_zo, true] call WOLV_fnc_createVehicule;
	
	[_zo] call WOLV_fnc_roadBlock;
	
	if(_ZOP) then {
		// Ajouté des location a proximité ou il y aurai des patrouilles 
		//toute les loc a proximité
		private _location = nearestLocations[position _zo, locationType, 4000]; 
		Private _closeLoc = nearestLocations[position _zo, locationType, 800];
		_location = _location - [_zo];
		_location = _location - _closeLoc; // location = location entre 800 et 5000 m
		
		private _i = 0;
		while {_i < count(_location)} do {
			private _Buildings = nearestObjects[position (_location select _i), Maison, 200];
			if ((text (_location select _i) in locationBlkList) or (count _Buildings == 0)) then {
				_location = _location - [_location select _i];
			}
			else {
				_i = _i + 1;
			};
		};	// degage les locations indésirable
		
		
		//choix des locations a activation	
		_nbloc = round random [0, (count(_location)*3/5), count(_location)]; // on prend entre 0 et toute les loc a poximité centré sur 2/5
		
		while {count(_location) > _nbloc} do {			// tant que trop de loc
			_location = (_location) - [(selectrandom _location)];	// - 1 loc random // distance2D ???
		};
		
		{
			_action = round random 3;		// random en 0 et 2
			if (_action == 0)then{};		//si 0 fait rien 
			if (_action == 1)then{			//si 1 
				[_x, false] call WOLV_fnc_createPatrol;	//patrouilles
			};
			if (_action == 2)then{			// si 2 
				[_x, false] call WOLV_fnc_createPatrol;	//patrouilles
				// [_x] call WOLV_fnc_roadBlock;		//RoadBlock
			//	[_x, false] call WOLV_fnc_createGarnison;	//garnison
			};
			[_x, false] call WOLV_fnc_civil;				//a chaque fois Civil
		}forEach _location;	//*/	// pour toute les ZO+ activé 
	};

	{				//normalement ne devrait pas servir mais on laisse au cas ou (sert a dégagé les gars mort au spawn)
		deleteVehicle _x;		//supprime le corps
	} forEach alldead;			//pour chaque corps 
	
	
	waitUntil { serverTime >= _future };
	TimeStart = serverTime;
	["Mission Générée"] remoteExec ["systemChat", 0];
	CurrentMission = 1;
	publicVariable "CurrentMission";
	publicVariable "Objectif";
	publicVariable "MissionProps";
	publicVariable "GarnisonIA";
	publicVariable "MissionIA";
	publicVariable "ZOpIA";
	publicVariable "TimeStart";
	private _NextTick = serverTime + 60;
	
	_nbIa = call WOLV_fnc_countIA;
	
	["Task","ASSIGNED",true] call BIS_fnc_taskSetState;
	
	_BaseIa = _nbIa;
	private _Renfort = true;
	private _nbItt = 0;
	
	if (!_Debug) then {
		waitUntil{sleep 1; count (position _zo nearEntities[["SoldierWB"], 1000]) >= 1};
		["Mission Lancée"] remoteExec ["systemChat", 0];
	};

	TimeZO = serverTime;
	publicVariable "TimeZO";

	// update + souvent la liste des objectifs 

	if (_target == TargetTypeName select 0) then {	//obj est une caisse a detruire
		while {(count (magazineCargo (Objectif select 0)) != 0) and (CurrentMission == 1)} do {	//tant que la caisse comporte des explosif (donc pas explosé)
			// sleep 60;
			private _NextTick = serverTime + 60;
			
			call WOLV_fnc_sortieGarnison;
	
			_nbIa = call WOLV_fnc_countIA;
			//systemChat(str(_nbIa));
			
			_Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testRenfort;
			
			_nbItt = _nbItt + 1;
			_nbItt call WOLV_fnc_garbageCollector;

			waitUntil {sleep 1; (!((count (magazineCargo (Objectif select 0)) != 0) and (CurrentMission == 1))) or serverTime > _NextTick};			
		};
		
		sleep(1);
		["Task","SUCCEEDED"] call BIS_fnc_taskSetState;		// tache accomplie
	};

	if (_target == TargetTypeName select 1) then {	//obj est un HVT
		// systemChat(Format["HVT en vie : %1, captif : %2",str(alive (Objectif select 0)), str(!(captive (Objectif select 0)))]);
		while {(alive (Objectif select 0) and !(captive (Objectif select 0))) and (CurrentMission == 1)} do {	//tant que la cible est et en vie et libre
			_NextTick = serverTime + 60;
			
			call WOLV_fnc_sortieGarnison;
	
			_nbIa = call WOLV_fnc_countIA;
			//systemChat(str(_nbIa));
			
			_Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testRenfort;
			
			_nbItt = _nbItt + 1;
			_nbItt call WOLV_fnc_garbageCollector;
			
			waitUntil {((alive (Objectif select 0) and !(captive (Objectif select 0))) and (CurrentMission == 1)) == false or serverTime > _NextTick};
		};
		sleep(1);
		["Task","SUCCEEDED"] call BIS_fnc_taskSetState;		// tache accomplie
	};

	if (_target == TargetTypeName select 2) then {	//obj est une zone a securizé 
		_seuil = round (_BaseIa / 20);
		// systemChat(Format["%1 / %2", _BaseIa, _seuil]);
		//[format["%1 / %2", _nbIa, _seuil] remoteExec ["systemChat", 0];;
		while {(_nbIa > _seuil) and (CurrentMission == 1)} do {	//tant qu'il y as plus de 10 IA	
			// sleep 60;
			_NextTick = serverTime + 60;
			
			call WOLV_fnc_sortieGarnison;
	
			_nbIa = call WOLV_fnc_countIA;
			//systemChat(str(_nbIa));
			
			_Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testRenfort;
			
			_nbItt = _nbItt + 1;
			_nbItt call WOLV_fnc_garbageCollector;

			waitUntil {((_nbIa > _seuil) and (CurrentMission == 1)) == false or serverTime > _NextTick};
			
		};
		sleep(1);
		["Task","SUCCEEDED"] call BIS_fnc_taskSetState;		// tache accomplie
	};
	
	if ((_target == TargetTypeName select 3) or (_target == TargetTypeName select 4)) then {	//obj est un Intel ou un Helico
		while {(Objectif select 1) and (CurrentMission == 1)} do {
			private _NextTick = serverTime + 60;
			
			call WOLV_fnc_sortieGarnison;
	
			_nbIa = call WOLV_fnc_countIA;
			//systemChat(str(_nbIa));
			
			_Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testRenfort;
			
			_nbItt = _nbItt + 1;
			_nbItt call WOLV_fnc_garbageCollector;

			waitUntil {((Objectif select 1) and (CurrentMission == 1)) == false or serverTime > _NextTick};
		};
		sleep(1);
		["Task","SUCCEEDED"] call BIS_fnc_taskSetState;		// tache accomplie
	};
	
	if (_target == TargetTypeName select 5) then {	//obj est un Prisonier
		while {((!(fob in nearestObjects[(Objectif select 0),[],50])) and (alive (Objectif select 0))) and (CurrentMission == 1)} do {	//tant que la cible est captive
			_NextTick = serverTime + 60;
			
			call WOLV_fnc_sortieGarnison;
	
			_nbIa = call WOLV_fnc_countIA;
			//systemChat(str(_nbIa));
			
			_Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testRenfort;
			
			_nbItt = _nbItt + 1;
			_nbItt call WOLV_fnc_garbageCollector;
			
			waitUntil {(((!(fob in nearestObjects[(Objectif select 0),[],50])) and (alive (Objectif select 0))) and (CurrentMission == 1)) == false or serverTime > _NextTick};
			//systemChat(Format["HVT en vie : %1, captif : %2",str(alive (Objectif select 0)), str(!(captive (Objectif select 0)))]);	//fait rien
		};
		
		sleep(1);
		if (alive (Objectif select 0)) then {
			["Task","SUCCEEDED"] call BIS_fnc_taskSetState;		// tache accomplie
		}
		else {
			["Task","FAILED"] call BIS_fnc_taskSetState;		// tache échoué
		};
	};

	if (_target == TargetTypeName select 6) then {	//obj vl 
		while {((!(fob in nearestObjects[(Objectif select 0),[],50])) and (alive (Objectif select 0))) and (CurrentMission == 1)} do {	//tant que la cible est pas detruite
			_NextTick = serverTime + 60;
			
			call WOLV_fnc_sortieGarnison;
	
			_nbIa = call WOLV_fnc_countIA;
			//systemChat(str(_nbIa));
			
			_Renfort = [_Renfort, _nbIa, _BaseIa] call WOLV_fnc_testRenfort;
			
			_nbItt = _nbItt + 1;
			_nbItt call WOLV_fnc_garbageCollector;
			
			waitUntil {(((!(fob in nearestObjects[(Objectif select 0),[],50])) and (alive (Objectif select 0))) and (CurrentMission == 1)) == false or serverTime > _NextTick};
			//systemChat(Format["HVT en vie : %1, captif : %2",str(alive (Objectif select 0)), str(!(captive (Objectif select 0)))]);	//fait rien
		};
		
		sleep(1);
		if (alive (Objectif select 0)) then {
			["Task","SUCCEEDED"] call BIS_fnc_taskSetState;		// tache accomplie
		}
		else {
			["Task","FAILED"] call BIS_fnc_taskSetState;		// tache échoué
		};
	};

	TimeObj = serverTime;
	publicVariable "TimeObj";

	sleep(5);
	
	if (CurrentMission == 1) then {
		// cree la tache retour base
		_task = [true, "Extract", ["Rentrez a la base", "RTB", "RTB"], objNull, "ASSIGNED", 2] call BIS_fnc_taskCreate;
		["Extract","move"] call BIS_fnc_taskSetType;
		sleep(1);
		
		waitUntil { sleep 1;
			(count (getpos base nearEntities[["SoldierWB"], 150])) +	//nb joueur Base + 
			(count (getpos fob nearEntities[["SoldierWB"], 150])) 		// nb joueur FOB 
			>= count(allPlayers - entities "HeadlessClient_F") 			// < nb joueur total (donc quand tout le monde sur base / FOB stop la boucle)
		};		

		["Extract","SUCCEEDED"] call BIS_fnc_taskSetState;		// Valide la tache

		TimeEnd = serverTime;
		publicVariable "TimeEnd";

		//sleep(2);				// Attend 2 s
		private _DebutNettoyage = serverTime + 30;
		
		waitUntil {serverTime > _DebutNettoyage};	
		
		[] call WOLV_fnc_clearZO;		// nettoye la ZO
	};
	
}
else {
	["Une mission est déjà en cours"] remoteExec ["systemChat", 0];
};

//player setPosASL position _zo;
//Affiche la Missions
//systemChat(_target);


