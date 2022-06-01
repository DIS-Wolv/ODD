params ["_zo", ["_type",-1]];

//private _zo = _this select 0;
//["TEST create missions"] remoteExec ["systemChat", 0];
//Choisis une missions random
private _Mission = selectRandom TargetTypeName;

//DEBUG => Force le type de missions
if (_type >= 0 and _type < count TargetTypeName) then {
	_Mission = TargetTypeName select _type;
};

_Buildings = [];

while {count _Buildings == 0} do {
	_Buildings = nearestObjects[position _zo, Maison, 200];//test
	// systemChat(str(count _Buildings));
};

_TgBuild = selectRandom _Buildings;

if (_Mission == TargetTypeName select 0) then {	// Caisses
	_posBox = [position _TgBuild select 0, position _TgBuild select 1, (position _TgBuild select 2) + 2];

	//Cree la caisses 
	_box = "Box_IED_Exp_F" createVehicle _posBox;
	_box setPos _posBox;	// la position 2 mettre plus haut 
	_box addItemCargoGlobal ["DemoCharge_Remote_Mag", 2];	// Ajoute des charges explo
	
	Objectif pushback _box;
	// array de differente possibilité de texte 
	_textCaisse = [
		"Les forces ennemis dans la zone de %1 ont récemment reçu du matériel. Votre mission est de vous rendre sur place et de détruire leurs caisses de stockage."
	];
	
	// cree la tache
	_task = [true, "Task", [Format[selectRandom _textCaisse, text _zo], "Détruire les caisses", "ODDOBJ"], objNull, "ASSIGNED", 2] call BIS_fnc_taskCreate;
	["Task","destroy"] call BIS_fnc_taskSetType;
	
	// attent 1s 
	sleep(1);	// pour pas tuer un gars avec la caisses
	
	private _group = [];
	
	if ((round random 2) == 0) then {
		_group = selectRandom pair; // choisi un groupe de 2 
	}
	else{
		_group = selectRandom fireTeam; // choisi un groupe de 4
	};
	// Spawn 2 gars pour defendre 
	_g = [position _TgBuild, EAST, _group] call BIS_fnc_spawnGroup;
	
	// Ajoute le groupe a la liste des IA de la missions
	MissionIA pushBack _g;
	
	//met en garnison
	
	
	if (!(IsNil "HC1")) then {
			// systemChat "HC1 présent";
			_HCID = owner HC1;

			_g setGroupOwner _HCID;
			{ _x setOwner _HCID; } forEach (units _g);
		};
	[position _TgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
};

if (_Mission == TargetTypeName select 1) then {	// HVT
	// choisi une HVT random
	private _group = selectRandom HVT;
	
	// ajoute au groupe de la HVT 4 gars en protection
	_group append selectRandom fireTeam;
	// systemChat(str(_group));
	
	//Spawn le groupe
	_g = [position _TgBuild, EAST, _group] call BIS_fnc_spawnGroup;
	
	//Ajoute le groupe a la liste des IA de la missions
	MissionIA pushBack _g;
	Objectif pushback (units _g select 0);
	//systemChat(str(units _g select 0));
	
	((units _g) select 0) addHandgunItem "hgun_Pistol_heavy_02_F";
	if (round random 4 == 1) then {
		//met en patrioulle
		[_g, getPos _TgBuild, 100] call bis_fnc_taskpatrol;
	}
	else {
		//met en garnison
		if (!(IsNil "HC1")) then {
			// systemChat "HC1 présent";
			_HCID = owner HC1;

			_g setGroupOwner _HCID;
			{ _x setOwner _HCID; } forEach (units _g);
		};
		[position _TgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; // Garnison Ace
	};
	
	
	// array de differente possibilité de texte 
	_textHVT = ["Une haut gradé nous a été signalé à proximité %1. C'est pour nous une opportunité en or de désorganiser la chaine de commandement de l'ennemi.",
		"Nous avons repéré un commandement des forces ennemies à proximité de %1. Notre mission est d'aller le neutraliser, ou de le capturer."
	];
	
	// cree la tache
	_task = [true, "Task", [Format[selectRandom _textHVT, text _zo], "Neutraliser une HVT", "ODDOBJ"], objNull, "ASSIGNED", 2] call BIS_fnc_taskCreate;
	["Task","kill"] call BIS_fnc_taskSetType;
};

if (_Mission == TargetTypeName select 2) then {	// Secure Area
	// cree la tache
	
	// array de differente possibilité de texte 
	_textSecure = [
		"La région de %1 est de plus en plus instable. Vous devez vous rendre sur place et pacifier la zone en y neutralisant les forces armées présentes sur zone"
	];

	_task = [true, "Task", [Format[selectRandom _textSecure, text _zo], "Sécuriser la zone", "ODDOBJ"], objNull, "ASSIGNED", 2] call BIS_fnc_taskCreate;
	["Task","attack"] call BIS_fnc_taskSetType;
};

if (_Mission == TargetTypeName select 3) then {	// Intel
	
	_IntelList = ["Item_SmartPhone","Item_ItemALiVEPhoneOld","Item_MobilePhone","Item_SatPhone","Land_IPPhone_01_black_F","Land_IPPhone_01_olive_F","Land_IPPhone_01_sand_F","Land_Laptop_F","Land_Laptop_device_F","Land_Laptop_unfolded_F","Land_Laptop_Intel_01_F","Land_Laptop_Intel_02_F","Land_Laptop_Intel_Oldman_F","Land_laptop_03_closed_black_F","Land_Laptop_03_black_F","Land_laptop_03_closed_olive_F","Land_Laptop_03_olive_F","Land_laptop_03_closed_sand_F","Land_Laptop_03_sand_F","Land_Laptop_02_F","Land_Laptop_02_unfolded_F"];
	
	_posIntel = [position _TgBuild select 0, position _TgBuild select 1, (position _TgBuild select 2) + 2];
	
	_posIntel set[2,1];
	_table = "Land_WoodenTable_small_F" createVehicle _posIntel;
	_table setDir (getDir _TgBuild);
	MissionProps pushBack _table;
	_posIntel = position _table;
	_posIntel set[2,1.5];
	
	_Intel = "Land_Laptop_F" createVehicle _posIntel; 
	_Intel setPos _posIntel; // la position 2 mettre plus haut 
	// _Intel addAction ["<t color='#FF0000'>Recupérer les Intels</t>", {Objectif set[1, false]; deleteVehicle (_this select 0);}];
	[
		_Intel,"<t color='#FF0000'>Recupérer les Intels</t>",	"\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_search_ca.paa", 
		"\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_search_ca.paa","true", "true",{},{},{Objectif set[1, false]; ["Task","SUCCEEDED"] call BIS_fnc_taskSetState; publicVariable "Objectif"; [(_this select 0)] remoteExec ["removeAllActions"];},
		{},[], (random[2,10,15]), nil, true, true
	] remoteExec ["BIS_fnc_holdActionAdd"];
	MissionProps pushBack _Intel;
	Objectif pushBack _Intel;
	Objectif pushBack true;
	// systemChat(str(Objectif));
	
	// array de differente possibilité de texte 
	_textIntel = [
		"Des Intel ont été repérés dans la région de %1, rendez-vous sur place et sécurisez-les.",
		"Les forces ennemies détiennent des informations importantes. Rendez vous dans la région de %1 et récupérez les."
	];
	// attent 1s 
	sleep(1);	// pour pas tuer un gars avec la caisses
	
	// cree la tache
	[true, "Task", [Format[selectRandom _textIntel, text _zo], "Récupérer des informations", "ODDOBJ"], objNull, "ASSIGNED", 2] call BIS_fnc_taskCreate; 
	["Task","intel"] call BIS_fnc_taskSetType;
	
	private _group = [];
	if (round (random 2) == 0) then {
		_group = selectRandom pair; // choisi un groupe de 2 
	}
	else{
		_group = selectRandom fireTeam; // choisi un groupe de 4
	};
	// Spawn 2 gars pour defendre 
	_g = [position _TgBuild, EAST, _group] call BIS_fnc_spawnGroup;
	
	// Ajoute le groupe a la liste des IA de la missions
	MissionIA pushBack _g;
	
	//met en garnison
	//[_g, getPos _TgBuild] execVM "\x\cba\addons\ai\fnc_waypointGarrison.sqf";
	[position _TgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf";
};

if (_Mission == TargetTypeName select 4) then {	// Helico
	
	// array de differente possibilité de texte 
	_textHelico = [
		"Un hélicopetère allié c'est écrasé a proximité de la zone de %1. Rendez-vous sur place et recupérez les boîtes noires."
	];
	
	_pos = position _zo getPos [((size _zo)select 0) * random 1, random 360];
		
	while {(count nearestTerrainObjects [_pos, ["Rocks","House"], 8] > 0) or ((_pos select 2) < 0 )} do { 		// si il y a plus de 0 cailloux dans les 10 mettres ou position sous l'eau
		_pos = position _zo getPos [random 800, random 360];		//tire une nouvelles position car on veux pas qu'il spawn dans un cailloux
	};
	
	_helico = "Land_Wreck_Heli_Attack_01_F" createVehicle _pos;

	[_pos] remoteExec ["WOLV_fnc_particules", 0];

	// _helico addAction ["<t color='#FF0000'>Recupérer les boîtes noires</t>", {Objectif set[1, false];}];
	[
		_helico,"<t color='#FF0000'>Recupérer les boîtes noires</t>",	"\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_search_ca.paa", 
		"\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_search_ca.paa","true", "true",{},{},{Objectif set[1, false]; ["Task","SUCCEEDED"] call BIS_fnc_taskSetState; publicVariable "Objectif";[(_this select 0)] remoteExec ["removeAllActions"];},
		{},[], (random[10,20,30]), nil, true, false
	] remoteExec ["BIS_fnc_holdActionAdd"];
	MissionProps pushBack _helico;
	Objectif pushBack _helico;
	Objectif pushBack true;
	
	private _group = [];
	if ((round random 2) == 0) then {
		_group = selectRandom pair; // choisi un groupe de 2 
	}
	else{
		_group = selectRandom fireTeam; // choisi un groupe de 4
	};
	// Spawn 2 gars pour defendre 
	_g = [position _TgBuild, EAST, _group] call BIS_fnc_spawnGroup;
	
	// Ajoute le groupe a la liste des IA de la missions
	MissionIA pushBack _g;
	
	_posSmoke = _pos;
	_posSmoke set [1, (_posSmoke select 1) - 3];
	_smoke = "FirePlace_burning_F" createVehicle _pos;
	_smoke setPos _pos;
	MissionProps pushBack _smoke;
	// MissionProps pushBack _smoke;
	
	private _group = selectRandom fireTeam;
	
	// systemChat(str(_pos));
	//spawn le groupe
	_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
	
	//Ajoute le groupe a la liste des IA de la missions
	MissionIA pushBack _g;
	
	sleep 1;
	
	// cree la tache
	_task = [true, "Task", [Format[selectRandom _textHelico, text _zo], "Récupérer les boîtes noires", "ODDOBJ"], objNull, "ASSIGNED", 2] call BIS_fnc_taskCreate;
	["Task","intel"] call BIS_fnc_taskSetType;
	
	[_g, _pos, 150] call bis_fnc_taskpatrol;
};

if (_Mission == TargetTypeName select 5) then {	// Save Prisoniers
	// array de differente possibilité de texte 
	_textPrisoniers = [
		"un pilote allié a été capturé dans la zone de %1, votre mission est d’aller le chercher et de le ramener a la Base."
	];

	// cree la tache
	_task = [true, "Task", [Format[selectRandom _textPrisoniers, text _zo], "Sauver le pilote allié", "ODDOBJ"], objNull, "ASSIGNED", 2] call BIS_fnc_taskCreate;
	["Task","scout"] call BIS_fnc_taskSetType;
	
	// choisi une Prisonier random
	private _group = selectRandom Otage;
	
	//spawn un gars 
	_g = [position _TgBuild, WEST, _group] call BIS_fnc_spawnGroup;
	// ((units _g) select 0) setCaptive 1; //passe en prisonier 
	[position _TgBuild, nil, units _g, 10, 1, false, true] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; 	// Garnison Ace
	sleep 1;
	[((units _g) select 0), true, player] execVM "\z\ace\addons\captives\functions\fnc_setHandcuffed.sqf";			// captif ace
	
	MissionProps pushBack (units _g select 0);
	Objectif pushback (units _g select 0);
	
	// cree un groupe en protection 
	_group = selectRandom fireTeam;
	
	_g = [position _TgBuild, EAST, _group] call BIS_fnc_spawnGroup;
	MissionIA pushBack _g;
	GarnisonIA pushBack _g; 	// met dans la liste et met tout les gars en garnison au meme moment
	if (!(IsNil "HC1")) then {
			// systemChat "HC1 présent";
			_HCID = owner HC1;

			_g setGroupOwner _HCID;
			{ _x setOwner _HCID; } forEach (units _g);
		};
	
	[position _TgBuild, nil, units _g, 10, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; // Garnison Ace
	
};	//*/
//*
if (_Mission == TargetTypeName select 6) then {	// Secure VL
	//["TEST NOUVELLE MISSIONS"] remoteExec ["systemChat", 0];
	// array de differente possibilité de texte 
	_textPrisoniers = [
		"Un véhicule ennemi comportant une technologie importante a été repéré à proximité de %1, aller le récupéré et ramenez le a la FOB."
	];

	// cree la tache
	_task = [true, "Task", [Format[selectRandom _textPrisoniers, text _zo], "Securisé le véhicule", "ODDOBJ"], objNull, "ASSIGNED", 2] call BIS_fnc_taskCreate;
	["Task","scout"] call BIS_fnc_taskSetType;
	
	_vl = selectRandom TgVehicule; //choisie un vl

	// recupère les route proche du centre de l'objectif
	//_roads = position _zo nearRoads 300;
	//_road = selectRandom _roads;	//choisi une route random

	_pos = position _TgBuild;	//recup la pos
	
	_dir = getDir _TgBuild;

	//_pos = _pos getPos [5 ,(_dir + 90 + ((round (random 2))* 180)) % 360];	//pose le vl sur le coté 
	
	_posvl = _pos findEmptyPosition [4, 100, _vl]; //, "B_Heli_Transport_01_F"

	// _posVl = _pos;
	// _posVl set[3, (_posVl select 3) + 2];
	
	// _posvl = _posvl getpos [2, [_pos, _posvl] call BIS_fnc_dirTo];

	_g = _vl createVehicle _posvl;	// créé le VL 

	_g setDir _dir;
	
	sleep 0.5; 
	_g setfuel 1;
	_g setdamage 0;

	sleep 1;
	if (!alive _g) then {
		_pos = position _g;

		deleteVehicle _g;

		sleep 1;

		_g = _vl createVehicle _posvl;	// créé le VL 
		
		_g setDir _dir;
		
		sleep 0.5;
		_g setfuel 1;
		_g setdamage 0;
	};

	MissionProps pushback _g;
	Objectif pushback  _g;
	
	sleep 1;
	// cree un groupe en protection 
	_group = selectRandom fireTeam;
	
	_g = [_pos, EAST, _group] call BIS_fnc_spawnGroup;
	MissionIA pushBack _g;
	GarnisonIA pushBack _g; 	// met dans la liste et met tout les gars en garnison au meme moment
	if (!(IsNil "HC1")) then {
			// systemChat "HC1 présent";
			_HCID = owner HC1;

			_g setGroupOwner _HCID;
			{ _x setOwner _HCID; } forEach (units _g);
		};
	
	[_pos, nil, units _g, 5, 1, false, false] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; // Garnison Ace
	
};
publicVariable "Objectif";
publicVariable "MissionProps";
//*/

//Renvoie le type de missions
_Mission
