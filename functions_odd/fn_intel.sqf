/*
* Auteur : Wolv
* Fonction pour choisir ci un civil ou un captif à des informations
*
* Arguments :
* 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODD_fnc_intel
*
* Variable publique :
*/

private _markerPool = ["Contact_circle1", "Contact_circle2", "Contact_circle3", "Contact_circle4", "Contact_pencilTask1", "Contact_pencilTask2",
	"Contact_pencilTask3", "Contact_pencilCircle1", "Contact_pencilCircle2", "Contact_pencilCircle3"];
private _colorPool = ["ColorBlack", "ColorRed", "ColorBrown", "Colororange", "ColorBlue", "colorcivilian"];

_msg = "";
 if (round (random 1) == 0) then {
	_msg = "J'ai des informations.";

	private _daytime = daytime;
	private _hours = floor _daytime;
	private _minutes = floor ((_daytime - _hours) * 60);
	private _seconds = floor ((((_daytime - _hours) * 60) - _minutes) * 60);
	private _pos = [0,0,0];
	if (ODD_var_SelectedMissionType == ODD_var_MissionType select 2) then {
		_pos = position (units (ODD_var_Objective select 0) select 0);
	}
	else {
		_pos = position (ODD_var_Objective select 0);
	};
	
	_marker = createMarker [format["ODDTG %1:%2, %3", _hours, _minutes, _seconds], _pos];
	_marker setMarkertype (selectRandom _markerPool);
	_marker setMarkerColor (selectRandom _colorPool);
	_marker setMarkertext format["Objectif à %1:%2", _hours, _minutes];

	["Task", "UPDATED"] call BIS_fnc_taskHint;
	["Task", _pos] call BIS_fnc_taskSetDestination;

}
else {
	_msg = "Je ne dirais rien.";
};

[_msg] remoteExec ["systemChat", 0];
