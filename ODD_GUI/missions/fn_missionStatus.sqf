params [["_prep",False,[True]]];
//systemChat TypeName _prep;
private _missionParams = ODDGUIMissions_var_SelectedParams;
systemChat str(_missionParams);
//ODDGUIMissions_var_SelectedParams = [_selectedObj,_selectedLoc,_selectedFaction,_valArea,_valLocationType];
private _valArea = _missionParams select 3;
private _valLocationType = _missionParams select 4;
private _selectedLoc = _missionParams select 1;
private _selectedObj = _missionParams select 0;
private _selectedFaction = _missionParams select 2;
private _nbPlayers = 0;
private _MissionsStatus = "";

if(!isNil "ODD_var_PlayerCount") then {
	_nbPlayers = ODD_var_PlayerCount;
} else {
	ODD_var_PlayerCount = (playersNumber west);
	_nbPlayers = ODD_var_PlayerCount;
	publicVariableServer "ODD_var_PlayerCount";
};

clientOwner publicVariableClient "ODD_var_CurrentMission";
switch (ODD_var_CurrentMission) do {
	
	case 0: {
		if (_prep == True) then { // pas de mission
			_MissionsStatus = parseText (format [
				"<t size='1' align='center' valign='middle'> Mission préparée, <br/> Zone : %2 <br/> Type : %3 <br/> Location : %4 <br/> Objectif : %5 <br/> Faction : %6 <br/> Joueurs : %7<t/>", 
				lineBreak,
				_valArea, 
				_valLocationType,
				text _selectedLoc,
				ODD_var_MissionType select _selectedObj,
				ODD_var_FactionNames select _selectedFaction,
				_nbPlayers]
				);
		} else { // récap mission préparée
			_MissionsStatus = parseText "<t size='1' align='center' valign='middle'>Pas de mission en cours ! <br/> Vous pouvez choisir des paramètres précis pour générer la mission que vous voulez. <br/> Alternativement, vous pouvez appliquer des fitres ou laisser tout en aléatoire et cliquer sur 'préparer la mission' pour que le jeu tire des paramètres alétoirement. Une fois que les paramètres tirés vous conviennent, vous pouvez générer votre mission. <br/><br/> La gestion de l'heure et de la météo sont complètement indépendants de la génération de la mission et peuvent être ajustés a tout moment !<t/>";
		};
	};
	
	case 1: { // mission générée
		clientOwner publicVariableClient "ODD_var_SelectedArea";
		clientOwner publicVariableClient "ODD_var_SelectedMissionType";
		clientOwner publicVariableClient "ODD_var_PlayerCount";
		clientOwner publicVariableClient "ODD_var_SelectedFaction";
		private _zo = ODD_var_SelectedArea;
		_zo = text _zo;
		private _obj = ODD_var_SelectedMissionType;
		private _nbPlayers = ODD_var_PlayerCount;
		private _faction = ODD_var_SelectedFaction;
		_MissionsStatus = parseText (format [
			"<t size='1' align='center' valign='middle'> Mission en cours, <br/> assurez vous que la mission n'est pas utilisée avant de nettoyer ! <br/><br/> Centre de la zone : %2, <br/> Objectif : %3, <br/> Faction ennemie : %4, <br/> Mission générée pour %5 joueurs.<t/>",
			lineBreak,
			_zo,
			_obj,
			_faction,
			_nbPlayers]
		);

	};

	case 2: { 	// mission en préparation
		_MissionsStatus = parseText "<t size='2.5' align='center' valign='middle'>Mission en préparation, merci d'attendre la fin de la génération !<t/>";
	};

	case 3: {	// mission en cours de nettoyage
	_MissionsStatus = parseText "<t size='2.5' align='center' valign='middle'>Mission en cours de nettoyage, merci d'attendre la fin du nettoyage !<t/>";
	};
	
	default {_MissionsStatus = parseText "<t size='1.5' align='center' valign='middle'><t/>";};
};

(_display displayCtrl ODDGUIMissions_SText_Recap_IDC) ctrlSetStructuredText _MissionsStatus;
