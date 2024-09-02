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

// Zone de la localité
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


// récupération du display
private _display = (findDisplay ODDGUIMissions_IddDisplay);

lbClear ODDGUIMissions_Combo_Objectif_IDC;
{
	lbAdd [ODDGUIMissions_Combo_Objectif_IDC, _x];
	lbSetValue[ODDGUIMissions_Combo_Objectif_IDC, _forEachIndex, _x];
} forEach _missionType;
lbAdd [ODDGUIMissions_Combo_Objectif_IDC, "Aléatoire"];
lbSetValue[ODDGUIMissions_Combo_Objectif_IDC, count _missionType, -1];
(_display displayCtrl ODDGUIMissions_Combo_Objectif_IDC) lbSetCurSel ((count _missionType));

_missionType;

