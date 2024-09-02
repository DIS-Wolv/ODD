/*
* Auteur : Wolv
* Fonction pour mettre a jour les locations disponible en fonction des paramètres
*
* Arguments :
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call OddGuiMissions_fnc_updateLocation;
*
* Variable publique :
* 
*/


// Zone de la localité
private _indexZone = lbCurSel ODDGUIMissions_Combo_Area_IDC;
private _valZone = -1;
if (_indexZone >= 0 and _indexZone < count ODDGUIMissions_var_zoneName) then {
	_valZone = ODDGUIMissions_var_zoneName select _indexZone;
};


// Type de Localité
private _indexLocation = lbCurSel ODDGUIMissions_Combo_TailleZO_IDC;
private _valLocationType = -1;
if (_indexLocation >= 0 and _indexLocation < count (ODDGUIMissions_var_LocationClassName)) then {
	_valLocationType = ODDGUIMissions_var_LocationClassName select _indexLocation;
};


// get ODD_var_AllLocations from Serv
if (!isServer) then {
	[clientOwner, "ODD_var_AllLocations"] remoteExec ["publicVariableClient", 2];
};

private _loc = ODD_var_AllLocations;

// Trie des locations en fonction de la zone
switch (_valZone) do {
	case "Zone allié": {
		_loc = ["ODD_var_isBlue", true] call ODDCTI_fnc_getLocWhere;
	};
	case "Ligne de front": {
		_loc = (["ODD_var_isFrontLine", true] call ODDCTI_fnc_getLocWhere) - (["ODD_var_isBlue", true] call ODDCTI_fnc_getLocWhere);
	};
	case "Zone énemie": {
		_loc = (["ODD_var_isFrontLine", false] call ODDCTI_fnc_getLocWhere) - (["ODD_var_isBlue", true] call ODDCTI_fnc_getLocWhere);
	};
	default {
		_loc = ODD_var_AllLocations;
	};
};


// trie des locations en fonction du type de localité
if (typeName _valLocationType == "STRING") then {
	_loc = _loc apply {if ((type _x) == _valLocationType) then {_x} else {objNull;};};
	_loc = _loc - [objNull];
};



_loc = _loc apply {[text _x, _x]};

private _needAdd = ["quarry", "power plant", "military", "factory", "Kastro", "castle", "storage", "dump", "mine"];
{
	if ((_x select 0) in _needAdd) then {
		private _add = (nearestLocations [position (_x select 1), ['NameCityCapital', 'NameCity', 'NameVillage', 'Name'], 4000, position (_x select 1)]) select 0;
		private _textAdd = format ["%1 %2", text _add, (_x select 0)];
		_loc set [_forEachIndex, [_textAdd, ((_loc select _forEachIndex) select 1)]];
	};
} forEach _loc;
_loc sort True;

private _display = (findDisplay ODDGUIMissions_IddDisplay);

lbClear ODDGUIMissions_Combo_Location_IDC;
{
	lbAdd [ODDGUIMissions_Combo_Location_IDC, (_x select 0)];
	lbSetValue[ODDGUIMissions_Combo_Location_IDC, _forEachIndex, ((_x select 1) getVariable ["ODD_var_AllLocations_index", -1])];
} forEach _loc;
lbAdd [ODDGUIMissions_Combo_Location_IDC, "Aléatoire"];
lbSetValue[ODDGUIMissions_Combo_Location_IDC, count _loc, -1];
(_display displayCtrl ODDGUIMissions_Combo_Location_IDC) lbSetCurSel ((count _loc));

_loc;
