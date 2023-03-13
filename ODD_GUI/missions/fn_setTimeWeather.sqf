private _sliderValue = sliderPosition ODDGUIMissions_Slider_Time_IDC; // Récupère la valeur du slider pour passer le temps
private _comboValue = lbCurSel ODDGUIMissions_Combo_Weather_IDC; // Récupère la valeur du menu deroulant de la météo

private _display = (findDisplay ODDGUIMissions_IddDisplay);
private _date = date;

private _hourOffset = floor(_sliderValue / 60);
private _minuteOffset = floor(_sliderValue % 60);

private _toSkip = _hourOffset + (_minuteOffset/60);

[_toSkip] remoteExec ["skipTime", 2];

private _weather = lbValue [ODDGUIMissions_Combo_Weather_IDC, _comboValue];

if (_weather > 0) then {
[0, (_weather/10)] remoteExec["setOvercast", 0];
        if (fog >= 0.15) then {
        _foglvl = random 0.15;
        [15, _foglvl] remoteExec["setFog", 0];
    };
    [] remoteExec["forceWeatherChange", 0];
};
