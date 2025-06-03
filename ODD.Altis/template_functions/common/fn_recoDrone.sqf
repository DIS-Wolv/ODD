/*
* Auteur : Wolv
* Permet de faire venir un drone d'observation sur la position du marqueur
*
* Arguments :
* 0 : string : type de drone (optionnel, défaut : "B_UAV_02_F")
* 1 : number : rayon du cercle (optionnel, défaut : 1000)
* 2 : number : altitude de vol (optionnel, défaut : 2000)
* 3 : array : position de base (optionnel, défaut : [0,0,0])
*
* Valeur renvoyée :
* nil
*
* Exemple:
* [] call DISCommon_fnc_recoDrone;
*
*/

params [["_droneType", "B_UAV_02_F"], ["_range", 2000], ["_altitude", 2000], ["_posBase", [0,0,2000]], ["_redeploy", -1]];

private _markerDrone = [];
private _drone = [];

private _fnc_RTB = {
	params ["_ThisDrone","_posBase", "_params"];

	private _vh = vehicle ((units _ThisDrone) select 0);
	//Attente du niveau de carburant
	waitUntil {sleep 1; (fuel _vh) < 0.25};

	//Message de retour
	[((units _ThisDrone) select 0), "Bingo FUEL - RTB"] remoteExec ["sideChat", 0, false];
	
	//WP de retour
	private _WPIndex = (currentWaypoint _ThisDrone) + 1;
	_ThisDrone addWaypoint [_posBase, _WPIndex];
	[_ThisDrone, _WPIndex] setWaypointType "MOVE";
	_ThisDrone setCurrentWaypoint [_ThisDrone, _WPIndex];

	waitUntil {sleep 1; (_vh distance2D _posBase) < 100};
	deleteVehicle _vh;


	// redéploiement
	private _redeploy = _params select 4;
	if (_redeploy > 0) then {
		// recuperation des params
		private _droneType = _params select 0;
		private _range = _params select 1;
		private _altitude = _params select 2;
		private _posBase = _params select 3;

		// décrémentation du nombre de redéploiement
		// systemChat format ["A %1", _redeploy];
		_redeploy = _redeploy - 1;
		// systemChat format ["B %1", _redeploy];
		// call du redéploiement
		systemChat format ["Redéploiement du drone, reste %1", _redeploy];
		[_droneType, _range, _altitude, _posBase, _redeploy] call DISCommon_fnc_recoDrone;
	};
};

private _fnc_OnSite = {
	params ["_ThisDrone", "_posSite", "_range"];

	private _vh = vehicle ((units _ThisDrone) select 0);

	// Attente de l'arrivée sur site
	waitUntil {sleep 1; (_vh distance2D _posSite) < (_range + 200)};
	[((units _ThisDrone) select 0), "Arrivée sur Zone"] remoteExec ["sideChat", 0, false];
};

private _fnc_groupName = {
	// récupération des group blufor
	private _allBluforGroups = groups blufor;

	private _fauconGroup = [];
	{
		private _groupName = groupID _x;
		if (_groupName find "Faucon-" == 0) then {
			_fauconGroup pushBack _x;
		};
	} forEach _allBluforGroups;

	private _groupName = "Faucon-" + str((count _fauconGroup) + 1);
	_groupName;
};

// récupération des marqueurs
{
	private _markerText = (markerText _x splitString " ");
	if ("RCD" in _markerText) then {
		_markerDrone pushBack _x;
	};
} forEach allMapMarkers;

// si aucun marqueur de drone de reconnaissance n'est trouvé, on arrête
if (count _markerDrone == 0) exitWith {systemChat "Aucun marqueur de drone de reconnaissance trouvé";};

{
	// récupération des données du marqueur
	_pos = getMarkerPos _x;
	_pos = [_pos select 0, _pos select 1, _altitude];
	
	if (_redeploy == -1) then {
		// systemChat "read Marker";
		_redeploy = 0;
		private _markerText = (markerText _x splitString " ");
		if (count _markerText > 1) then {
			_range = parseNumber (_markerText select 1);
			if (count _markerText > 2) then {
				_altitude = parseNumber (_markerText select 2);
			};
			if ((count _markerText > 3)) then {
				_redeploy = parseNumber (_markerText select 3);
			};
		};
	};

	// position de spawn
	private _spawnPos = _posBase getPos [50, ((360/count _markerDrone) * _forEachIndex)];
	private _spawnPos = [_posBase select 0, _posBase select 1, (_altitude + (10 * _forEachIndex))];

	//spawn du drone
	private _result = [_spawnPos, (_spawnPos getdir _pos), _droneType, blufor] call BIS_fnc_spawnVehicle;
	private _vh = _result select 0;
	private _ThisDrone = _result select 2;

	// on retire l'armement
	_vh setVehicleAmmo 0;
	_vh setAmmo ["Laserdesignator_mounted", 1000000];

	_drone pushBack _ThisDrone;

	// Event Handler de destruction
	_vh setVariable ["DIScommon_var_posBase", _posBase, true];
	_vh addEventHandler ["Hit", {
		params ["_unit", "_source", "_damage", "_instigator"];

		// Suppression de l'event handler
		_unit removeEventHandler [_thisEvent, _thisEventHandler];

		// Message de destruction
		[_unit, "Drone endomagé, RTB"] remoteExec ["sideChat", 0, false];

		//WP de retour
		private _posBase = _unit getVariable ["DIScommon_var_posBase", [0,0,0]];
		private _drone = group _unit;

		//WP de retour
		private _WPIndex = (currentWaypoint _drone) + 1;
		_drone addWaypoint [_posBase, _WPIndex];
		[_drone, _WPIndex] setWaypointType "MOVE";
		_drone setCurrentWaypoint [_drone, _WPIndex];

		private _fnc_RTB = {
			params ["_ThisDrone","_posBase"];
			waitUntil {sleep 1; (_ThisDrone distance2D _posBase) < 100};
			deleteVehicle _ThisDrone;
		};

		[_drone, _posBase] spawn _fnc_RTB;
	}];

	// définition du groupe
	private _groupName = [] call _fnc_groupName;
	//systemChat format ["%1", _groupName];
	_ThisDrone setGroupIdGlobal [_groupName];

	// Message de départ
	[((units _ThisDrone) select 0), "En vol"] remoteExec ["sideChat", 0, false];

	// définition de l'altitude de vol
	_vh flyInHeight _altitude;

	//WP d'observation
	_ThisDrone addWaypoint [_pos, 1];
	private _WPIndex = (currentWaypoint _ThisDrone);
	[_ThisDrone, _WPIndex] setWaypointType "LOITER";
	[_ThisDrone, _WPIndex] setWaypointLoiterAltitude _altitude;
	[_ThisDrone, _WPIndex] setWaypointLoiterType "CIRCLE_L";
	[_ThisDrone, _WPIndex] setWaypointLoiterRadius _range;

	// Attente de l'arrivée sur site
	[_ThisDrone, _pos, _range] spawn _fnc_OnSite;

	//WP de retour
	[_ThisDrone, _spawnPos, [_droneType, _range, _altitude, _posBase, _redeploy]] spawn _fnc_RTB;

} forEach _markerDrone;

