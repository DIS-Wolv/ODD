private _missionParams = ODDGUIMissions_var_SelectedParams;

// pas de mission

// récap mission préparée

// mission en préparation

// mission générée

// mission en cours de nettoyage



/*

private _recap = parseText (format ["<t size='1' align='center'> Zone : %1 // Type : %2 // Location : %3 // Objectif : %4 // Faction : %5 // Joueurs : %6<t/>", _valArea, _valLocationType,text _selectedLoc,_selectedObj,_selectedFaction,_nbPlayers]);
(_display displayCtrl ODDGUIMissions_SText_Recap_IDC) ctrlSetStructuredText _recap;


private _display = (findDisplay ODDGUIMissions_IddDisplay);
_MissionsStatus = parseText "<t size='1.5' align='center'><t/>";
switch (ODD_var_CurrentMission) do {
	case 0: {_MissionsStatus = parseText "<t size='1.5' align='center'>Pas de mission en cours<t/>";};
	case 1: {_MissionsStatus = parseText "<t size='1.5' align='center'>Mission en cours<t/>";};
	case 2: {_MissionsStatus = parseText "<t size='1.5' align='center'>Mission en préparation<t/>";};
	case 3: {_MissionsStatus = parseText "<t size='1.5' align='center'>Mission en cours de nettoyage<t/>";};
	default {_MissionsStatus = parseText "<t size='1.5' align='center'><t/>";};
};
