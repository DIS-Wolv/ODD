/*
* Auteur : Wolv
* Fonction pour lancer la création de mission
*
* Arguments :
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call OddGuiMissions_fnc_createMission;
*
* Variable publique :
*   - ODD_var_AllLocations
*   - ODD_var_MissionType
*   - ODD_var_MissionTypeBlue
*   - ODD_var_MissionTypeFrontLine
*   - ODD_var_MissionTypeEnemy
* 
*/

systemChat "fn_createMission.sqf";

if (!isServer) then {
	[clientOwner, "ODD_var_AllLocations"] remoteExec ["publicVariableClient", 2];
	[clientOwner, "ODD_var_MissionType"] remoteExec ["publicVariableClient", 2];
	[clientOwner, "ODD_var_MissionTypeBlue"] remoteExec ["publicVariableClient", 2];
	[clientOwner, "ODD_var_MissionTypeFrontLine"] remoteExec ["publicVariableClient", 2];
	[clientOwner, "ODD_var_MissionTypeEnemy"] remoteExec ["publicVariableClient", 2];
};


private _locID = lbValue [ODDGUIMissions_Combo_Location_IDC, lbCurSel ODDGUIMissions_Combo_Location_IDC];
private _missionType = ODD_var_MissionType;

// si pas de localité sélectionné, on prend une localité aléatoire en fonction des paramètres
if (_locID == -1) then {
    
    // récupération des locations compatible avec les choix
    private _loc = [] call OddGuiMissions_fnc_updateLocation;

    _locID = (selectRandom _loc) getVariable ["ODD_var_AllLocations_index", -1];
};

// récupération de la localité Objectif
private _selectedLoc = ODD_var_AllLocations select _locID;

private _missionName = "DEFAULT";

// information de la missions
private _index = lbCurSel ODDGUIMissions_Combo_Objectif_IDC;
private _value = lbValue [ODDGUIMissions_Combo_Objectif_IDC, _index];
// si une missions est sélectionné
if (_value != -1) then {

	_missionName = ODD_var_MissionType select _value;
    
}
else {
    // systemChat format ["| %1 |", _missionName];
    _missionName = "RANDOM";
    if ((_selectedLoc getVariable ["ODD_var_isBlue", false]) == true) then {
        _missionName = selectRandom ODD_var_MissionTypeBlue;
    } else {
        if ((_selectedLoc getVariable ["ODD_var_isFrontLine", false]) == true) then {
            _missionName = selectRandom ODD_var_MissionTypeFrontLine;
        } else {
            _missionName = selectRandom ODD_var_MissionTypeEnemy;
        };
    };
};

systemChat format ["%1 | %2", text _selectedLoc, _missionName];

//text (ODD_var_AllLocations select _locID)


// systemChat format ["%1 | %2 | %3 | %4", _missionType, _valLocationType, _valZone, _locID];



// private _missionParams = ODDGUIMissions_var_SelectedParams;

// [_missionParams select 0,_missionParams select 1,True,_missionParams select 2] remoteExec ["ODDadvanced_fnc_missions", 2];
// type de mission, Zone d'opération, ZO+ ou non, faction

/*


*/