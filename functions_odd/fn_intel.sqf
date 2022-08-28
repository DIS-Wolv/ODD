private _markerPool = ["Contact_circle1", "Contact_circle2", "Contact_circle3", "Contact_circle4", "Contact_pencilTask1", "Contact_pencilTask2",
	"Contact_pencilTask3", "Contact_pencilCircle1", "Contact_pencilCircle2", "Contact_pencilCircle3"];
private _colorPool = ["ColorBlack", "ColorRed", "ColorBrown", "Colororange", "ColorBlue", "colorcivilian"];

 if (round (random 1) == 0) then {
	systemChat ("J'ai des info.");
	private _daytime = daytime;
	private _hours = floor _daytime;
	private _minutes = floor ((_daytime - _hours) * 60);
	private _seconds = floor ((((_daytime - _hours) * 60) - _minutes) * 60);
	private _pos = [0,0,0];
	if (target == ODD_var_TargetTypeName select 2) then {
		_pos = position (units (ODD_var_Objectif select 0) select 0);
	}
	else {
		_pos = position (ODD_var_Objectif select 0);
	};
	
	_marker = createMarker [format["ODDTG %1:%2, %3", _hours, _minutes, _seconds], _pos];
	_marker setMarkertype (selectRandom _markerPool);
	_marker setMarkerColor (selectRandom _colorPool);
	_marker setMarkertext format["ODD_var_Objectif à %1:%2", _hours, _minutes];
} else {
	systemChat ("J'ai pas d'info.");
};