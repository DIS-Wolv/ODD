{
    deleteMarker(_x);
} foreach allMapMarkers;
private _zo = nearestLocations[position player, ['NameCityCapital','NameCity','NameVillage','Name','NameLocal','Hill'], 1000] select 0;

try {
	{
		deleteVehicle(_x);
	} foreach ODD_var_MissionProps;
} catch { hint str _exception };

// variable globales
[] call ODDdata_fnc_varOutpost;
[] call ODDdata_fnc_var;
[] call ODDdata_fnc_varEneArd;

// debut func
// ### params
// private _flavors = ["Medevac"];
// private _pos = position _zo;
private _outpost_nb = 5;
// ### params

[position player, _outpost_nb] call ODDadvanced_fnc_createOutpostsAroundZo;

// private _created = [position player] call ODDadvanced_fnc_createOutpostAtPos;
// if (_created) then {
// 	systemChat "Created.";
// } else {
// 	systemChat "Unable to find a position to spawn the outpost.";
// };

// ["C_Van_01_box_F", ((position player) getpos [10, 0]), random 360] call ODDcommon_fnc_createAndLockVl;
