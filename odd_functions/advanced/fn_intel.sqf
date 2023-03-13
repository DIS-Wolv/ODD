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
* [] call ODDadvanced_fnc_intel
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
	private _needMarker = True;

	//["ObjectifPos", "VLCivilPos", "IEDPos", "CheckpointPos", "VLEnemiePos", "MedicalCratePos"];
	switch (_intelType) do {
		case (ODD_var_IntelType select 5): {	// Medical Crate 
			if (count ODD_var_MedicalCrates <= 0) then {
				_msg = selectRandom _msgNoMedical;
				_needMarker = False;
			}
			else {
				_msg = selectRandom _msgMedical;
				_pos = position (selectRandom ODD_var_MedicalCrates);
				_markerType = "loc_heal";
			};
		};
		case (ODD_var_IntelType select 4): {	// VL Enemie pos 
			if (count ODD_var_IAVehicles <= 0) then {
				_msg = "Les ennemis n'ont pas de véhicules !";
				_needMarker = False;
			}
			else {
				_msg = "J'ai vu un de leurs véhicules !";
				_pos = position (selectRandom ODD_var_IAVehicles);
				_markerType = "loc_defend";
			};
		};
		case (ODD_var_IntelType select 3): {	// checkpoint 
			if (count ODD_var_MissionCheckPoint <= 0) then {
				_msg = "Les énemie n'on pas de Checkpoint !";
				_needMarker = False;
			}
			else {
				_msg = "Cette route est surveillée.";
				_pos = position (selectRandom ODD_var_MissionCheckPoint);
				_markerType = "loc_Bunker";
			}
		};
		case (ODD_var_IntelType select 2): {	// IED Pos 
			if (count ODD_var_MissionIED <= 0) then {
				_msg = "Les énemie n'utilise pas d'IED !";
				_needMarker = False;
			}
			else {
				_msg = "Il y a des explosifs sur le bord de cette route !";
				_pos = position (selectRandom ODD_var_MissionIED);
				_markerType = "loc_mine";
			};
		};
		case (ODD_var_IntelType select 1): {	// VL civil Pos 
			if (count ODD_var_MissionCivilianVehicles <= 0) then {
				_msg = "Je n'ai pas vue de voiture !";
				_needMarker = False;
			}
			else {
				_msg = "C'est ici que j'ai garé ma voiture.";
				_pos = position (selectRandom ODD_var_MissionCivilianVehicles);
				_markerType = "loc_Truck";
			};
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
			
			["ODD_task_mission", "UPDATED"] call BIS_fnc_taskHint;

			_markerType = (selectRandom _markerPool)
		};
	};

	if (_needMarker) then {
		_posIntel = _pos getPos [(random 1 * _dist), random 360];

		_marker = createMarker [format["ODDTG %1 %2 %3", (_posIntel select 0), (_posIntel select 1), (_posIntel select 2)], _posIntel];
		_marker setMarkertype _markerType;
		_marker setMarkerColor _color;
		_marker setMarkerAlpha 0.8125;
		ODD_var_IntelMarker pushBack _marker;
	};
}
else {
	_msgNon = ["Je ne dirais rien.", "Je ne dirais rien.", "Je ne veux pas vous parler."];
	_msg = selectRandom _msgNon;
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
	// ["ODD_task_mission", _pos] call BIS_fnc_taskSetDestination;

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

