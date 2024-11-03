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

if (!isServer) then {
	[clientOwner, "ODD_var_MissionType"] remoteExec ["publicVariableClient", 2];
	[clientOwner, "ODD_var_MissionTypeBlue"] remoteExec ["publicVariableClient", 2];
	[clientOwner, "ODD_var_MissionTypeFrontLine"] remoteExec ["publicVariableClient", 2];
	[clientOwner, "ODD_var_MissionTypeEnemy"] remoteExec ["publicVariableClient", 2];
};

if (isNil "ODD_var_AllLocations") then {
    [] call ODDCTI_fnc_getAllLocs;
};


// récupération de la localité
private _locIndex = lbCurSel ODDGUIMissions_Combo_Location_IDC;
private _locID = lbValue [ODDGUIMissions_Combo_Location_IDC, _locIndex];
private _missionType = ODD_var_MissionType;

// si pas de localité sélectionné, on prend une localité aléatoire en fonction des paramètres
if (_locID == -1) then {
    
    // récupération des locations compatible avec les choix
    private _loc = [] call OddGuiMissions_fnc_updateLocation;

    _locID = (selectRandom _loc) getVariable ["ODD_var_LocId", -1];
};

// récupération de la localité Objectif
private _selectedLoc = ODD_var_AllLocations select _locID;

private _missionName = "DEFAULT";

// information de la missions
private _index = lbCurSel ODDGUIMissions_Combo_Objectif_IDC;
private _value = lbValue [ODDGUIMissions_Combo_Objectif_IDC, _index];

// si une missions est sélectionné
if (_value != -1) then {
    // récupération de la mission
	_missionName = ODD_var_MissionType select _value;
}
else {
    // sinon choisir une mission aléatoire en fonction de la localité
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

if ((_selectedLoc getVariable ["ODD_var_isBlue", false]) == true) then {
    systemChat "_fnc_createMissionBlue";
} else {
    if ((_selectedLoc getVariable ["ODD_var_isFrontLine", false]) == true) then {
        systemChat "_fnc_createMissionFrontLine";
    } else {
        systemChat "_fnc_createMissionEnemy";
    };
};

// [_selectedLoc, _missionName] call _fnc_createMission;
