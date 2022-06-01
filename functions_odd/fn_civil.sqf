_action = false;
private _zo = _this select 0;
private _action = _this select 1;	// es ce l'obj Principale

private _locType = 0;
if (type _zo == locationType select 5) then { _locType = 0;};
if (type _zo == locationType select 4) then { _locType = 1;};
if (type _zo == locationType select 3) then { _locType = 2;};
if (type _zo == locationType select 2) then { _locType = 3;};
if (type _zo == locationType select 1) then { _locType = 4;};
if (type _zo == locationType select 0) then { _locType = 5;};

private _Buildings = nearestObjects [position _zo, Maison, size _zo select 0];	//Nombre de maison dans la localité

private _nbCivil = 0;
if (_locType == 5) then {
	_nbCivil = (count _Buildings) / 24;
};
if (_locType == 4) then {
	_nbCivil = (count _Buildings) / 25;
};
if (_locType == 3) then {
	_nbCivil = (count _Buildings) / 16;
};
if (_locType == 2) then {
	_nbCivil = 0;
};
if (_locType == 1) then {
	_nbCivil = (count _Buildings) / 10;
};
/*
1. nb de civils :
	selon le type : round 
	5 (capital) nb batiment/24
	4 nbbat/25
	3 nbbat/8
	2 0
	1 nbbat / 10
	pensé a forcé 0 si negatif
2. donne la position de la caisse :
	2/nb civils 
*/

// systemchat("Spawn des civils");
if (not _action) then {
	_nbCivil = _nbCivil / 2;
	
};

_nbCivil = (round (0 max _nbCivil));


// systemchat(format["Civils : %1", _nbCivil]);

private _civil = [];
_civil resize (_nbCivil);
{
	// choisi un groupe
	private _group = selectRandom Civils;
	
	// choisi un batiment aléatoirement
	_GBuild = selectRandom _Buildings;
	
	//spawn le groupe
	_g = [getPos _GBuild, Civilian, _group] call BIS_fnc_spawnGroup;
	_civil set[_foreachindex, _g];
	
	MissionCivil pushback _g;
	
	sleep 0.5;
	
	[ 
		((units _g)select 0), "<t color='#FF0000'>Interoger le civil</t>", "\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa",  
		"\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", "alive (_target)", "true",
		{
			[(_this select 0), "PATH"] remoteExec ["disableAI", 2];
			// (_this select 0) disableAI "PATH"
		},{},
		{
			private _markerPool = ["Contact_circle1","Contact_circle2","Contact_circle3","Contact_circle4", "Contact_pencilTask1", "Contact_pencilTask2", 
				"Contact_pencilTask3", "Contact_pencilCircle1", "Contact_pencilCircle2", "Contact_pencilCircle3"];
			private _colorPool = ["ColorBlack", "ColorRed", "ColorBrown", "ColorOrange", "ColorBlue", "colorCivilian"];
			
			[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
			// (_this select 0) enableAI "PATH"; 
			if (round (random 1) == 0) then { 
				systemChat ("J'ai des info."); 
				private _daytime = dayTime;
				private _hours = floor _daytime;
				private _minutes = floor ((_daytime - _hours) * 60);
				private _seconds = floor ((((_daytime - _hours) * 60) - _minutes) * 60);
				private _pos = position (Objectif select 0);
				
				_marker = createMarker [Format["ODDTG %1:%2,%3", _hours, _minutes, _seconds], _pos]; 
				_marker setMarkerType (selectRandom _markerPool);
				_marker setMarkerColor (selectRandom _colorPool);
				_marker setMarkerText Format["Objectif à %1:%2", _hours, _minutes];
			} 
			else {
				systemChat ("J'ai pas d'info.");
			};
			[(_this select 0)] remoteExec ["removeAllActions"];
		}, {
			// (_this select 0) enableAI "PATH";
			[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
		},[], (random[2,10,15]), nil, true, false 
	] remoteExec ["BIS_fnc_holdActionAdd"];
	
	/*[
		_helico,"<t color='#FF0000'>Recupérer les boîtes noires</t>",	"\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_search_ca.paa", 
		"\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_search_ca.paa","true", "true",{},{},{Objectif set[1, false]; ["Task","SUCCEEDED"] call BIS_fnc_taskSetState; publicVariable "Objectif";},
		{},[], (random[10,20,30]), nil, true, false
	] remoteExec ["BIS_fnc_holdActionAdd"];*/
	
}foreach _civil;

sleep 2;
{
	[position ((units _x) select 0), nil, units _x, 100, 1, false, true] execVM "\z\ace\addons\ai\functions\fnc_garrison.sqf"; // Garnison Ace
} foreach _civil;

sleep 2; 
{
	[units _x] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf";
} foreach _civil;


//for "_i" from 1 to 3 do 
{	
	/*
	_roads = position _zo nearRoads 300;
	_road = selectRandom _roads;

	_pos = position _road;

	_GBuild = selectRandom _Buildings;
	
	_roadDir = 0;
	_connectedRoad = roadsConnectedTo [_road, false]; 
	if (count (_connectedRoad) >= 1) then { // si il y a une route acollÃ©  
		_roadDir = [_road, (_connectedRoad select 0)] call BIS_fnc_DirTo; // recup la direction  
		 
		_roadDir = (_roadDir + ((round (random 2))* 180)) % 360;	// + 0 ou + 180 Â° 
	};

	_vl = selectRandom CivilsVL;

	_pos = _pos getPos [6 ,(_roadDir + 90 + ((round (random 2))* 180)) % 360];

	_pos = _pos findEmptyPosition [0, 100, _vl];

	_g = _vl createVehicle _pos;
	
	// _g setDir _roadDir;
	
	//_g = [_pos, _roadDir, _group, EMPTY] call BIS_fnc_spawnVehicle;
	// sleep 1;
	//deleteVehicle (units (_g select 0) select 0);//*/

	_vl = selectRandom CivilsVL; //choisie un vl

	_GBuild = selectRandom _Buildings;
	_dir = getDir _GBuild;
	if (_dir == 0) then {
		_dir = getDirVisual _GBuild;
	};

	_pos = position _GBuild;	//recup la pos

	_pos = _pos findEmptyPosition [3, 100, _vl]; //, "B_Heli_Transport_01_F"

	// _pos = _pos getpos [3, [position _GBuild, _pos] call BIS_fnc_dirTo];

	_g = _vl createVehicle _pos;	// créé le VL 
	
	_g setDir _dir;
	
	sleep 0.5;

	_g setfuel 1;

	_g setdamage 0;
	MissionProps pushback _g;

	
}foreach _civil;

publicVariable "MissionCivil";
publicVariable "MissionProps";




