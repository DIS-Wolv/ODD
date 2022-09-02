/*
* Author: Wolv
* Script permetant de mettre a jour le statut de la missions
* 
* Argument :
* 
* Return Value:
* nil
*
*/

_MissionsStatus = parseText "<t size='1.5' align='center'><t/>";
switch (ODD_var_CurrentMission) do {
	case 0: {_MissionsStatus = parseText "<t size='1.5' align='center'>Pas de missions en cours<t/>";};
	case 1: {_MissionsStatus = parseText "<t size='1.5' align='center'>Missions en cours<t/>";};
	case 2: {_MissionsStatus = parseText "<t size='1.5' align='center'>Missions en préparation / nettoyage<t/>";};
	default {_MissionsStatus = parseText "<t size='1.5' align='center'><t/>";};
};

((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcMissionStatus) ctrlSetStructuredText _MissionsStatus;