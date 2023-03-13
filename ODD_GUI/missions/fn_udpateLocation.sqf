params ["_var"];

private _indexLocation = lbCurSel ODDGUIMissions_Combo_Location_IDC;
private _valLocationType = "";
if (_indexLocation >= 0 and _indexLocation < count (ODDGUIMissions_var_LocationClassName)) then {
	_valLocationType = ODDGUIMissions_var_LocationClassName select _indexLocation;
}
else {
	_valLocationType = -1;
};

private _indexArea = lbCurSel ODDGUIMissions_Combo_Area_IDC;
private _valArea = "";
if (_indexArea >= 0 and _indexArea < count (ODDGUIMissions_var_SecteurMarker)) then {
	_valArea = ODDGUIMissions_var_SecteurMarker select _indexArea;
}else {
	_valArea = -1;
};

// systemChat format ["%1 %2", _valLocationType, _valArea];

private _posA = [15000, 15000];
private _radA = 30000;
if ((typeName _valArea) == "STRING") then {
	_posA = getMarkerPos _valArea;
	_radA = 5000;
};

private _locType = ODDGUIMissions_var_LocationClassName;
if ((typeName _valLocationType) == "STRING") then {
	_locType = [_valLocationType];
};

// systemChat format ["%1 %2 %3", _posA, _locType, _radA];
private _loc = nearestLocations[_posA, _locType, _radA];
// systemChat str _loc;

{
	private _Buildings = nearestobjects[position _x, ODD_var_Houses, 200];
	if ((text _x in ODD_var_BlackistedLocation) or (count _Buildings == 0)) then {
		_loc = _loc - [_x];
	};
} forEach _loc;

_loc = _loc apply {[text _x, _x]};

private _needAdd = ["quarry", "power plant", "military", "factory", "Kastro"];
{
	if ((_x select 0) in _needAdd) then {
		private _add = (nearestLocations [position (_x select 1), ['NameCityCapital', 'NameCity', 'NameVillage', 'Name'], 4000, position (_x select 1)]) select 0;
		private _textAdd = format ["%1 %2", text _add, (_x select 0)];
		_loc set [_forEachIndex, [_textAdd, ((_loc select _forEachIndex) select 1)]];
	};
} forEach _loc;

_loc sort True;

lbClear ODDGUIMissions_List_Location_IDC;
{
	lbAdd [ODDGUIMissions_List_Location_IDC, (_x select 0)];
} forEach _loc;

ODDGUIMissions_var_FilteredLocations = _loc;
publicVariableServer "ODDGUIMissions_var_FilteredLocations";
