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
params[["_source", 0], ["_dist", 50]];

private _colorPool = ["colorIndependent", "colorCivilian", "colorOPFOR"];
private _markerPool = ["Contact_circle1", "Contact_circle2", "Contact_circle3", "Contact_circle4", "Contact_pencilTask1", "Contact_pencilTask2",
	"Contact_pencilTask3", "Contact_pencilCircle1", "Contact_pencilCircle2", "Contact_pencilCircle3"];

private _msg = "";
private _color = _colorPool select _source;
private _markerType = "";


if (round (random 1) == 0) then {
	_msg = "J'ai des informations.";
	
	_intelType = selectRandom ODD_var_IntelType;
	ODD_var_IntelType = ODD_var_IntelType + (ODD_var_IntelType - [_intelType]);
	private _pos = [0,0,0];

	//["ObjectifPos", "VLCivilPos", "IEDPos", "CheckpointPos", "VLEnemiePos", "MedicalCratePos"];
	switch (_intelType) do {
		case (ODD_var_IntelType select 5): {	// Medical Crate 
			_msg = "Il y a une caisse médicale là bas !";
			_pos = position (selectRandom ODD_var_MedicalCrates);
			_markerType = "loc_heal";
		};
		case (ODD_var_IntelType select 4): {	// VL Enemie pos 
			_msg = "J'ai vu un de leurs véhicules !";
			_pos = position (selectRandom ODD_var_IAVehicles);
			_markerType = "loc_defend";
		};
		case (ODD_var_IntelType select 3): {	// checkpoint 
			_msg = "Cette route est surveillée.";
			_pos = position (selectRandom ODD_var_MissionCheckPoint);
			_markerType = "loc_Bunker";
		};
		case (ODD_var_IntelType select 2): {	// IED Pos 
			_msg = "Il y a des explosifs sur le bord de cette route !";
			_pos = position (selectRandom ODD_var_MissionIED);
			_markerType = "loc_mine";
		};
		case (ODD_var_IntelType select 1): {	// VL civil Pos 
			_msg = "C'est ici que j'ai garé ma voiture.";
			_pos = position (selectRandom ODD_var_MissionCivilianVehicles);
			_markerType = "loc_Truck";
		};
		case (ODD_var_IntelType select 0);
		default {		//ObjectifPos
			_msg = "Je crois que ce que vous cherchez est là.";
			if (ODD_var_SelectedMissionType == (ODD_var_MissionType select 2)) then {
				_pos = position (units (ODD_var_Objective select 0) select 0);
			}
			else {
				_pos = position (ODD_var_Objective select 0);
			};
			
			["Task", "UPDATED"] call BIS_fnc_taskHint;

			_markerType = (selectRandom _markerPool)
		};
	};

	_posIntel = _pos getPos [(random 1 * _dist), random 360];

	_marker = createMarker [format["ODDTG %1 %2 %3", (_posIntel select 0), (_posIntel select 1), (_posIntel select 2)], _posIntel];
	_marker setMarkertype _markerType;
	_marker setMarkerColor _color;
	_marker setMarkerAlpha 0.8125;
}
else {
	_msg = "Je ne dirais rien.";
};

[_msg] remoteExec ["systemChat", 0];
_msg;

	// private _daytime = daytime;
	// private _hours = floor _daytime;
	// private _minutes = floor ((_daytime - _hours) * 60);
	// private _seconds = floor ((((_daytime - _hours) * 60) - _minutes) * 60);
	// _marker = createMarker [format["ODDTG %1:%2, %3", _hours, _minutes, _seconds], _pos];
	// _marker setMarkertype (selectRandom _markerPool);
	// _marker setMarkerColor (selectRandom _colorPool);
	// _marker setMarkertext format["Objectif à %1:%2", _hours, _minutes];
	// ["Task", _pos] call BIS_fnc_taskSetDestination;

/*
Objectif				=> ODD_var_Objective
Véhicule civil 231		=> ODD_var_MissionCivilianVehicles
IED 205					=> ODD_var_MissionIED
Checkpoint 168 ou 154	=> ODD_var_MissionCheckPoint
vehicule ennemi 165		=> ODD_var_IAVehicles
caisse med 172			=> ODD_var_MedicalCrates
maison garnison 218
tour radio 214
*/

