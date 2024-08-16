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

// la save ne doit être fait que sur le serveur
if (!isServer) exitWith {true;};
// si la variable n'existe pas on a rien a save
if (isNil "ODD_var_INITMAP") exitWith {true;};

// si ce n'est pas un hashmap on le transforme
if (typeName _data != "HASHMAP") then {
	_data = createHashMapFromArray _data;
};

// on récupère les données des zones
private _locData = _data get "LocData";

if (!isNil "_locData") then {
	// si ce n'est pas un hashmap on le transforme
	if (typeName _locData != "HASHMAP") then {
		_locData = createHashMapFromArray _locData;
	};
	// pour chaque location de la map
	{
		// récupération des données dans l'array
		_maLocData = _locData get (text _x);
		// si ce n'est pas un hashmap on le transforme
		if (typeName _maLocData != "HASHMAP") then {
			_maLocData = createHashMapFromArray _maLocData;
		};

		// liste des variable a set
		private _varToSet = [
			"ODD_var_OccActEniVeh",
			"ODD_var_OccTgtEniVeh",
			"ODD_var_CivActPax",
			"ODD_var_CivTgtPax",
			"ODD_var_OccActEni",
			"ODD_var_OccTgtEni",
			"ODD_var_OccPrcRecrut",
			"ODD_var_OccRecrutVeh",
			"ODD_var_isBlue",
			"ODD_var_isFrontLine"
		];
		// si la si la variable existe on la set
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
	} forEach ODD_var_AllLocations;
};

// on récupère les données des object
private _objectData = _data get "ObjectData";
if (!isNil "_objectData") then {
	// si ce n'est pas un hashmap on le transforme
	if (typeName _objectData != "HASHMAP") then {
		_objectData = createHashMapFromArray _objectData;
	};
	// pour chaque object sauvegardé
	{
		// si l'object existe
		if(!isNil _x) then {
			// récupération des données dans l'array
			private _value = (_objectData get _x);

			// si ce n'est pas un hashmap on le transforme
			if (typeName _value != "HASHMAP") then {
				_value = createHashMapFromArray _value;
			};
			// set des variable
			private _MonObj = call compile _x;
			private _dir = _value get "dir";
			private _pos = _value get "pos";

			_pos = [(_pos select 0), (_pos select 1), (_pos select 2) + 0.2];

			_MonObj setDir _dir;
			_MonObj setPosASL _pos;
		};
	} forEach (keys _objectData);
};

// on récupère les données des variables globales
_varToSet = ["ODD_var_CivilianReputation","ODD_var_CTIMarkerInfo"];
{
	private _value = _data get _x;
	if (!isNil "_value") then {
		_x = _value;
	};
} forEach _varToSet;

private _date = _data get "ODD_var_DateTime";
setDate _date;

sleep 1;
[ODD_var_CTIMarkerInfo] call ODDCTI_fnc_updateMap;


