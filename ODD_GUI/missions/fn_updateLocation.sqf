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


// get ODD_var_AllLocations from Serv
if (!isServer) then {
	[clientOwner, "ODD_var_AllLocations"] remoteExec ["publicVariableClient", 2];
};

// Zone de la localité
private _indexZone = lbCurSel ODDGUIMissions_Combo_Area_IDC;
private _valZone = -1;
if (_indexZone >= 0 and _indexZone < count ODDGUIMissions_var_zoneName) then {
	_valZone = ODDGUIMissions_var_zoneName select _indexZone;
};

// Trie des locations en fonction de la zone
private _locZone = ODD_var_AllLocations;

switch (_valZone) do {
	case "Zone allié": {
		_locZone = ["ODD_var_isBlue", true] call ODDCTI_fnc_getLocWhere;
	};
	case "Ligne de front": {
		_locZone = (["ODD_var_isFrontLine", true] call ODDCTI_fnc_getLocWhere) - (["ODD_var_isBlue", true] call ODDCTI_fnc_getLocWhere);
	};
	case "Zone énemie": {
		_locZone = (["ODD_var_isFrontLine", false] call ODDCTI_fnc_getLocWhere) - (["ODD_var_isBlue", true] call ODDCTI_fnc_getLocWhere);
	};
	default {
		_locZone = ODD_var_AllLocations;
	};
};

// Type de Localité
private _locType = ODD_var_AllLocations;

private _indexLocation = lbCurSel ODDGUIMissions_Combo_TailleZO_IDC;
private _valLocationType = -1;
if (_indexLocation >= 0 and _indexLocation < count (ODDGUIMissions_var_LocationClassName)) then {
	_valLocationType = ODDGUIMissions_var_LocationClassName select _indexLocation;
};

// trie des locations en fonction du type de localité
if (typeName _valLocationType == "STRING") then {
	_locType = _locType apply {if ((type _x) == _valLocationType) then {_x} else {objNull;};};
	_locType = _locType - [objNull];
};

// trie en fonction de la missions
private _locMissions = [];

private _index = lbCurSel ODDGUIMissions_Combo_Objectif_IDC;
private _value = lbValue [ODDGUIMissions_Combo_Objectif_IDC, _index];
// si une missions est sélectionné
if (_value != -1) then {
	private _missionName = ODD_var_MissionType select _value;

	// si la missions est de type allié
	if (ODD_var_MissionTypeBlue find _missionName > -1) then {
		// rajoute les locations allié
		_locMissions = ["ODD_var_isBlue", true] call ODDCTI_fnc_getLocWhere;
	};
	// si la missions est de type ligne de front
	if (ODD_var_MissionTypeFrontLine find _missionName > -1) then {
		// rajoute les locations de la ligne de front
		_locMissions = _locMissions + ((["ODD_var_isFrontLine", true] call ODDCTI_fnc_getLocWhere) - (["ODD_var_isBlue", true] call ODDCTI_fnc_getLocWhere));
	};
	// si la missions est de type ennemie
	if (ODD_var_MissionTypeEnemy find _missionName > -1) then {
		// rajoute les locations ennemie
		_locMissions = _locMissions + ((["ODD_var_isFrontLine", false] call ODDCTI_fnc_getLocWhere) - (["ODD_var_isBlue", true] call ODDCTI_fnc_getLocWhere));
	};
	// les locations sont cumulative car une missions peux etre allié et ligne de front
};

// intersection des listes
private _loc = _locZone arrayIntersect _locType;
if (count _locMissions > 0) then {
	_loc = _loc arrayIntersect _locMissions;
};

// prépare les loc pour l'affichage 
private _locDisplay = _loc apply {[text _x, _x]};

private _needAdd = ["quarry", "power plant", "military", "factory", "Kastro", "castle", "storage", "dump", "mine"];
{
	if ((_x select 0) in _needAdd) then {
		private _add = (nearestLocations [position (_x select 1), ['NameCityCapital', 'NameCity', 'NameVillage', 'Name'], 4000, position (_x select 1)]) select 0;
		private _textAdd = format ["%1 %2", text _add, (_x select 0)];
		_locDisplay set [_forEachIndex, [_textAdd, ((_locDisplay select _forEachIndex) select 1)]];
	};
} forEach _locDisplay;
_locDisplay sort True;

//mise a jour du combo location
private _display = (findDisplay ODDGUIMissions_IddDisplay);

//suprime l'event handler sur la location
(_display displayCtrl ODDGUIMissions_Combo_Location_IDC) ctrlRemoveAllEventHandlers "LBSelChanged";

// met a jours le combo location
lbClear ODDGUIMissions_Combo_Location_IDC;
{
	lbAdd [ODDGUIMissions_Combo_Location_IDC, (_x select 0)];
	lbSetValue[ODDGUIMissions_Combo_Location_IDC, _forEachIndex, ((_x select 1) getVariable ["ODD_var_AllLocations_index", -1])];
} forEach _locDisplay;
lbAdd [ODDGUIMissions_Combo_Location_IDC, "Aléatoire"];
lbSetValue[ODDGUIMissions_Combo_Location_IDC, count _locDisplay, -1];
(_display displayCtrl ODDGUIMissions_Combo_Location_IDC) lbSetCurSel ((count _locDisplay));

// remet l'event handler 
(_display displayCtrl ODDGUIMissions_Combo_Location_IDC) ctrlAddEventHandler ["LBSelChanged",{[] spawn OddGuiMissions_fnc_updateMission;}];

_loc;
