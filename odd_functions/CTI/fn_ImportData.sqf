/*
* Auteur : Wolv
* Fonction pour importé les donnée de la mission
*
* Arguments :
*	0 : Donnée a importé (Array)
* 
* Valeur renvoyée :
*
* Exemple :
* 	[_data] call ODDCTI_fnc_ImportData
*
* Variable publique :
* 
*/

params [["_data", createHashMap]];

if (!isServer) exitWith {true;};
if (isNil "ODD_var_INITMAP") exitWith {true;};

if (typeName _data != "HASHMAP") then {
	_data = createHashMapFromArray _data;
};

private _locData = _data get "LocData";
if (!isNil "_locData") then {
	_locData = createHashMapFromArray _locData;
	{
		_maLocData = _locData get (text _x);
		_maLocData = createHashMapFromArray _maLocData;

		private _varToSet = ["ODD_var_OccActEniVeh", "ODD_var_OccTgtEniVeh", "ODD_var_CivActPax", "ODD_var_CivTgtPax", "ODD_var_OccActEni", "ODD_var_OccTgtEni", "ODD_var_OccPrcRecrut", "ODD_var_isBlue", "ODD_var_isFrontLine"];
		if(!isNil "_maLocData") then {
			private _maLoc = _x;
			{
				private _value = _maLocData get _x;
				if (!isNil "_value") then {
					_maLoc setVariable [_x, _value];
				};

			} forEach _varToSet;
		};
		[_x, ODD_var_CTIMarkerInfo] call ODDCTI_fnc_updateMapLocation;
	} forEach ODDvar_AllLocations;
};

private _objectData = _data get "ObjectData";
if (!isNil "_objectData") then {
	_objectData = createHashMapFromArray _objectData;
	{
		if(!isNil _x) then {
			private _value = createHashMapFromArray ((_objectData get _x));
			private _MonObj = call compile _x;
			private _dir = _value get "dir";
			private _pos = _value get "pos";

			_pos = [(_pos select 0), (_pos select 1), (_pos select 2) + 0.2];

			_MonObj setDir _dir;
			_MonObj setPosATL _pos;
		};
	} forEach (keys _objectData);
};

_varToSet = ["ODD_var_CivilianReputation","ODD_var_CTIMarkerInfo"];
{
	private _value = _data get _x;
	if (!isNil "_value") then {
		_x setVariable [_x, _value];
	};

} forEach _varToSet;


sleep 1;
[ODD_var_CTIMarkerInfo] call ODDCTI_fnc_updateMap;


