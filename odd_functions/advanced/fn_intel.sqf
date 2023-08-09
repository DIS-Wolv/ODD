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


/******** choix de si on vas donner un intel ou pas ********/
// si _proba = 0 on donne un intel
// sinon on donne un message de refus
private _proba = 1;
if (_source == 2) then {
	private _torture = _author getVariable ["ace_medical_medications", []];
	if (count (_torture) > 0) then {
		_proba = round (random 0.9); // tweek la valeur
	} else {
		_proba = round (random 2);
	};
} else {
	_proba = round (random 1);
};
// _proba = 0;


/******** choix ce qu'on donne comme intel ********/
private _pos = [0,0,0];
if (_proba == 0) then {
	_msg = "J'ai des informations.";
	_intelType = selectRandom ODD_var_IntelType;
	// _intelType = ODD_var_IntelType select 5; // force le type d'intel
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
				_pos = [_intelType, getPos _author, 1500] call ODDcommon_fnc_sortintels;
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
				_pos = [_intelType, getPos _author, 2500] call ODDcommon_fnc_sortintels;
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
				_pos = [_intelType, getPos _author, 2000] call ODDcommon_fnc_sortintels;
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
				_pos = [_intelType, getPos _author, 750] call ODDcommon_fnc_sortintels;
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
				_pos = [_intelType, getPos _author, 500] call ODDcommon_fnc_sortintels;
				_markerType = "loc_Truck";
			};
		};
		case (ODD_var_IntelType select 0);
		default {		//ObjectifPos
			_msg = selectRandom _msgObj;
			_pos = [0, getPos _author, 2000] call ODDcommon_fnc_sortintels;
			["ODD_task_mission", "UPDATED"] call BIS_fnc_taskHint;

			_markerType = (selectRandom _markerPool)
		};
	};
	if (!isNil "_pos") then {
		if ((count (_pos)) < 2) then {
			_needMarker = False;
			_msgNon = _allmsg select 11;
			_msg = selectRandom _msgNon;
		};
		if (_needMarker) then {
			_posMarker = _pos getPos [(random 1 * _dist), random 360];

			_marker = createMarker [format["ODDTG %1 %2 %3", (_posMarker select 0), (_posMarker select 1), (_posMarker select 2)], _posMarker,1];
			_marker setMarkertype _markerType;
			_marker setMarkerColor _color;
			_marker setMarkerAlpha 0.8125;
			ODD_var_IntelMarker pushBack _marker;
		};
	}
	else {
		[["Erreur INTEL => Type : %1", _intelType]] call ODDcommon_fnc_log;
		_msgNon = _allmsg select 11;
		_msg = selectRandom _msgNon;
	};
}
else {
	_msgNon = _allmsg select 11;
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

