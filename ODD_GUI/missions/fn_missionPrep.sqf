private _display = (findDisplay ODDGUIMissions_IddDisplay);
private _indexLocation = lbCurSel ODDGUIMissions_Combo_Location_IDC;
private _valLocationType = "";
private _listLocations = [""];
private _indexArea = lbCurSel ODDGUIMissions_Combo_Area_IDC;
private _valArea = "";
private _index = lbCurSel ODDGUIMissions_List_Location_IDC;
private _selectedLoc = "";
private _indexObj = lbCurSel ODDGUIMissions_Combo_Mission_IDC;
private _selectedObj = "";
private _indexFaction = lbCurSel ODDGUIMissions_Combo_Faction_IDC;
private _selectedFaction = "";
private _indexPlayers = lbCurSel ODDGUIMissions_Combo_Players_IDC;

_listLocations = [] call OddGuiMissions_fnc_udpateLocation;

if (_indexLocation >= 0 and _indexLocation < count (ODDGUIMissions_var_LocationClassName)) then {
	_valLocationType = ODDGUIMissions_var_LocationClassName select _indexLocation;
}
else {
	_valLocationType = "Aléatoire";
};

if (_indexArea >= 0 and _indexArea < count (ODDGUIMissions_var_SecteurMarker)) then {
	_valArea = ODDGUIMissions_var_SecteurMarker select _indexArea;
}else {
	_valArea = "Aléatoire";
};

if (_index >= 0) then {
	_selectedLoc = (_listLocations select _index) select 1;
} else {
	_selectedLoc = (selectRandom _listLocations) select 1;
};

if (_indexObj >= 0 and _indexObj < count (ODD_var_MissionType)) then {
	_selectedObj = ODD_var_MissionType select _indexObj;
}
else {
	_selectedObj = selectRandom ODD_var_MissionType;
};

if (_indexFaction >= 0 and _indexFaction < count (ODD_var_FactionNames)) then {
	_selectedFaction = ODD_var_FactionNames select _indexFaction;
}
else {
	_selectedFaction = selectRandom ODD_var_FactionNames;
};

private _nbPlayers = lbValue [ODDGUIMissions_Combo_Players_IDC, _indexPlayers];

if (_indexObj >= 0 and _indexObj < count (ODD_var_MissionType)) then {
	_selectedObj = _indexObj;
}
else {
	_selectedObj = ODD_var_MissionType find _selectedObj;
};

if (_indexFaction >= 0 and _indexFaction < count (ODD_var_FactionNames)) then {
	_selectedFaction = _indexFaction;
}
else {
	_selectedFaction = ODD_var_FactionNames find _selectedFaction;
};

ODD_var_PlayerCount = _nbPlayers;
publicVariableServer "ODD_var_PlayerCount";

ODDGUIMissions_var_SelectedParams = [_selectedObj,_selectedLoc,_selectedFaction,_valArea,_valLocationType];
[True] call OddGuiMissions_fnc_missionStatus;
