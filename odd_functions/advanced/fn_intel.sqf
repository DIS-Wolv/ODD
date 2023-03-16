/*
* Auteur : Wolv
* Fonction pour choisir ci un civil ou un captif à des informations
*
* Arguments :
* 
*_msg
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODDadvanced_fnc_intel
*
* Variable publique :
*/
params[["_source", 0], ["_author",objNull],["_dist", 50]];

private _colorPool = ["colorIndependent", "colorCivilian", "colorOPFOR"];
private _markerPool = ["Contact_circle1", "Contact_circle2", "Contact_circle3", "Contact_circle4", "Contact_pencilTask1", "Contact_pencilTask2",
	"Contact_pencilTask3", "Contact_pencilCircle1", "Contact_pencilCircle2", "Contact_pencilCircle3"];

//Toutes les réponses que je crée sont plutot axée pour des CIVILS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! faut il faire une autre fonction pour les ennemis que l'on interroge ou juste rajouter un if ?
clientOwner publicVariableClient "ODD_var_SelectedMissionType";
private _missionType = ODD_var_SelectedMissionType;

private _allmsg = [_source, _missionType] call ODDdata_fnc_intelText;

private _msg = "";
private _msgMedical = _allmsg select 0;
private _msgNoMedical = _allmsg select 1;
private _msgVl = _allmsg select 2;
private _msgNoVl = _allmsg select 3;
private _msgChkpt = _allmsg select 4;
private _msgNoChkpt = _allmsg select 5;
private _msgIed = _allmsg select 6;
private _msgNoIed = _allmsg select 7;
private _msgTransport = _allmsg select 8;
private _msgNoTransport = _allmsg select 9;
private _msgObj = _allmsg select 10;

private _color = _colorPool select _source;
private _markerType = "";


private _proba = 1;
if (_source == 2) then {
	private _torture = _author getVariable ["ace_medical_medications", []];
	if (count (_torture) > 0) then {
		_proba = 0; 
	} else {
		_proba = round (random 2);
	};
} else {
	_proba = round (random 1);
};
if (_proba == 0) then {
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
				_pos = [_intelType, getPos _author, 1500] call ODDcommon_fnc_sortIntels;
				_markerType = "loc_heal";
			};
		};
		case (ODD_var_IntelType select 4): {	// VL Enemie pos 
			if (count ODD_var_IAVehicles <= 0) then {
				_msg = selectRandom _msgNoVl;
				_needMarker = False;
			}
			else {
				_msg = selectRandom _msgVl;
				_pos = [_intelType, getPos _author, 2500] call ODDcommon_fnc_sortIntels;
				_markerType = "loc_defend";
			};
		};
		case (ODD_var_IntelType select 3): {	// checkpoint 
			if (count ODD_var_MissionCheckPoint <= 0) then {
				_msg = selectRandom _msgNoChkpt;
				_needMarker = False;
			}
			else {
				_msg = selectRandom _msgChkpt;
				_pos = [_intelType, getPos _author, 2000] call ODDcommon_fnc_sortIntels;
				_markerType = "loc_Bunker";
			}
		};
		case (ODD_var_IntelType select 2): {	// IED Pos 
			if (count ODD_var_MissionIED <= 0) then {
				_msg = selectRandom _msgNoIed;
				_needMarker = False;
			}
			else {
				_msg = selectRandom _msgIed;
				_pos = [_intelType, getPos _author, 750] call ODDcommon_fnc_sortIntels;
				_markerType = "loc_mine";
			};
		};
		case (ODD_var_IntelType select 1): {	// VL civil Pos 
			if (count ODD_var_MissionCivilianVehicles <= 0) then {
				_msg = selectRandom _msgNoTransport;
				_needMarker = False;
			}
			else {
				_msg = selectRandom _msgTransport;
				_pos = [_intelType, getPos _author, 500] call ODDcommon_fnc_sortIntels;
				_markerType = "loc_Truck";
			};
		};
		case (ODD_var_IntelType select 0);
		default {		//ObjectifPos
			_msg = selectRandom _msgObj;
			_pos = [0, getPos _author, 2000] call ODDcommon_fnc_sortIntels;
			["ODD_task_mission", "UPDATED"] call BIS_fnc_taskHint;

			_markerType = (selectRandom _markerPool)
		};
	};

	if (_needMarker) then {
		_posIntel = _pos getPos [(random 1 * _dist), random 360];

		_marker = createMarker [format["ODDTG %1 %2 %3", (_posIntel select 0), (_posIntel select 1), (_posIntel select 2)], _posIntel,1];
		_marker setMarkertype _markerType;
		_marker setMarkerColor _color;
		_marker setMarkerAlpha 0.8125;
		ODD_var_IntelMarker pushBack _marker;
	};
}
else {
	_msgNon = ["Je ne dirais rien.", "Je ne dirais rien.", "Je ne veux pas vous parler.","Je n'ai rien vu.", "Je ne veux pas parler.","Si je vous parle ma famille est en danger.","VIVA LA REVOLUTION !!","Ils nous écoutent.","Quels manteaux ?","I can't speak french"];
	_msg = selectRandom _msgNon;
};

[_msg] remoteExec ["systemChat", 0];
_msg;

	// private _daytime = daytime;
	// private _hours = floor _daytime;
	// private _minutes = floor ((_daytime - _hours) * 60);
	// private _seconds = floor ((((_daytime - _hours) * 60) - _minutes) * 60);
	// _marker = createMarker [format["ODDTG %1:%2, %3", _hours, _minutes, _seconds], _pos,1];
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

