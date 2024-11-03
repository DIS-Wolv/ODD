/*
* Auteur : Wolv
* Fonction pour mettre a jour les missions disponible en fonction des paramètres
*
* Arguments :
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call OddGuiMissions_fnc_updateMission;
*
* Variable publique :
* 
*/

private _missionType = ODD_var_MissionType;

// type de mission
private _indexZone = lbCurSel ODDGUIMissions_Combo_Area_IDC;
private _valZone = -1;
if (_indexZone >= 0 and _indexZone < count ODDGUIMissions_var_zoneName) then {
	_valZone = ODDGUIMissions_var_zoneName select _indexZone;
};

switch (_valZone) do {
    case "Zone allié": {
        _missionType = ODD_var_MissionTypeBlue;
    };
    case "Ligne de front": {
        _missionType = ODD_var_MissionTypeFrontLine;
    };
    case "Zone énemie": {
        _missionType = ODD_var_MissionTypeEnemy;
    };
    default {
        _missionType = ODD_var_MissionType;
    };
};


// Location de la mission
private _indexLoc = lbCurSel ODDGUIMissions_Combo_Location_IDC;
private _valLoc = lbValue [ODDGUIMissions_Combo_Location_IDC, lbCurSel ODDGUIMissions_Combo_Location_IDC];
if (_valLoc != -1) then {
    private _selectedLoc = ODD_var_AllLocations select _valLoc;

    if ((_selectedLoc getVariable ["ODD_var_isBlue", false]) == true) then {
        _missionType = ODD_var_MissionTypeBlue;
    } else {
        if ((_selectedLoc getVariable ["ODD_var_isFrontLine", false]) == true) then {
            _missionType = ODD_var_MissionTypeFrontLine;
        } else {
            _missionType = ODD_var_MissionTypeEnemy;
        };
    };
};

// récupération du display
private _display = (findDisplay ODDGUIMissions_IddDisplay);

// supprime l'event Handler sur le combo objectif
(_display displayCtrl ODDGUIMissions_Combo_Objectif_IDC) ctrlRemoveAllEventHandlers "LBSelChanged";

// met a jours l'objectif
lbClear ODDGUIMissions_Combo_Objectif_IDC;
{
	lbAdd [ODDGUIMissions_Combo_Objectif_IDC, _x];
	lbSetValue[ODDGUIMissions_Combo_Objectif_IDC, _forEachIndex, (ODD_var_MissionType find _x)];
} forEach _missionType;
lbAdd [ODDGUIMissions_Combo_Objectif_IDC, "Aléatoire"];
lbSetValue[ODDGUIMissions_Combo_Objectif_IDC, count _missionType, -1];

// update de la position du curseur
private _index = lbCurSel ODDGUIMissions_Combo_Objectif_IDC;
if ((_index == -1) or (_index > (count _missionType))) then {
    (_display displayCtrl ODDGUIMissions_Combo_Objectif_IDC) lbSetCurSel (count _missionType);
};

// remet l'event Handler sur le combo objectif
(_display displayCtrl ODDGUIMissions_Combo_Objectif_IDC) ctrlAddEventHandler ["LBSelChanged",{[] spawn OddGuiMissions_fnc_updateLocation;}];

// renvoie le(s) type(s) de mission
_missionType;

