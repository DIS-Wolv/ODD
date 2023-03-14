params ["_sliderValue"];

private _display = (findDisplay ODDGUIMissions_IddDisplay);
private _date = date;

private _hourOffset = floor(_sliderValue / 60);
private _minuteOffset = floor(_sliderValue % 60);
private _newHour = (((_date select 3) + _hourOffset + (floor(((_date select 4) + _minuteOffset)/60))) % 24);
private _newMin = (((_date select 4) + _minuteOffset) % 60);

private _timeStatus = "";
private _newMinstr = "";
private _newHourstr = "";

if (_newMin < 10) then {
	_newMinstr = format ["0%1", _newMin]
} 
else {
	_newMinstr = str (_newMin);
};
if (_newHour < 10) then {
	_newHourstr = format ["0%1", _newHour]
} 
else {
	_newHourstr = str (_newHour);
};

_timeStatus = parseText (format ["<t size='1' align='center'> H %1%2 <t/>", _newHourstr, _newMinstr]);
(_display displayCtrl ODDGUIMissions_SText_Time_IDC) ctrlSetStructuredText _timeStatus;
