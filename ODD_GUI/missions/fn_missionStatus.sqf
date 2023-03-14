params [["_prep",False,[True]]];
//systemChat TypeName _prep;
private _missionParams = ODDGUIMissions_var_SelectedParams;
private _MissionsStatus = "";

switch (ODD_var_CurrentMission) do {
	
	case 0: {
		if (_prep == True) then { // pas de mission
			_MissionsStatus = parseText (format ["<t size='1' align='center'> Zone : %1 // Type : %2 // Location : %3 // Objectif : %4 // Faction : %5 // Joueurs : %6<t/>", _valArea, _valLocationType,text _selectedLoc,_selectedObj,_selectedFaction,_nbPlayers]);
		} else { // récap mission préparée
			_MissionsStatus = parseText "<t size='1.5' align='center'>Pas de mission en cours, choisissez les paramètres et cliquez sur générer ou appliquez des fitres et préparez la mission pour un tirage alétaoire.<t/>";
		};
	};
	
	case 1: { // mission générée
		private _zo = ODD_var_SelectedArea;
		_zo = text _zo;
		private _obj = ODD_var_SelectedMissionType;
		private _nbPlayers = ODD_var_PlayerCount;
		private _faction = ODD_var_SelectedFaction;
		_MissionsStatus = formatText [
			"Mission en cours, %1 Centre de la zone : %2, %1 Objectif : %3, %1 Faction ennemie : %4, %1 Mission générée pour %5 joueurs.",
			lineBreak,
			_zo,
			_obj,
			_faction,
			_nbPlayers
		];
	};

	case 2: { 	// mission en préparation
		_MissionsStatus = parseText "<t size='2.5' align='center'>Mission en préparation, merci d'attendre la fin de la génération !<t/>";
	};

	case 3: {	// mission en cours de nettoyage
	_MissionsStatus = parseText "<t size='2.5' align='center'>Mission en cours de nettoyage, merci d'attendre la fin du nettoyage !<t/>";
	};
	
	default {_MissionsStatus = parseText "<t size='1.5' align='center'><t/>";};
};

(_display displayCtrl ODDGUIMissions_SText_Recap_IDC) ctrlSetStructuredText _MissionsStatus;
