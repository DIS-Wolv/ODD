/*
* Author: Wolv
* Script permetant d'ouvrir le GUI
* 
* Argument :
* 
* Return Value:
* nil
*
*/

ODD_var_SelectedTarget = ODDGUI_var_SelTarg;
ODD_var_SelectedSector = ODDGUI_var_SelPos;

ODD_var_NbPlayer = lbValue[ODDGUI_var_IdcComboPlayer, (lbCurSel ODDGUI_var_IdcComboPlayer)];
ODD_var_SelectedFaction = lbValue[ODDGUI_var_IdcComboFaction, (lbCurSel ODDGUI_var_IdcComboFaction)];
ODDGUI_var_Heure = lbValue[ODDGUI_var_IdcComboHeure, (lbCurSel ODDGUI_var_IdcComboHeure)];
ODDGUI_var_meteo = lbValue[ODDGUI_var_IdcComboMeteo, (lbCurSel ODDGUI_var_IdcComboMeteo)];

if (ODD_var_SelectedFaction == 0) then {
	ODD_var_SelectedFaction = -1;
};
/////////////////////////////////////////////////////////////////////////////////////////////////

[ODD_var_SelectedFaction] call ODD_fnc_varEne;

if (ODDGUI_var_meteo != -1) then {
	[0, (ODDGUI_var_meteo/10)] remoteExec["setOvercast", 0];
	[] remoteExec["forceWeatherChange", 0];
};
if (ODDGUI_var_Heure != -1) then {
	[(ODDGUI_var_Heure - dayTime + 24)%24] remoteExec["skipTime", 0];
};

[] remoteExec ["ODD_fnc_missions", 2];

//systemChat format["Secteur : %1", ODD_var_SelectedSector];
//systemChat format["Type d'odd_var_objectif : %1", ODD_var_SelectedTarget];
//systemChat format["Faction :  %1", ODD_var_SelectedFaction];
//systemChat format["Nb Joueur :  %1", ODD_var_NbPlayer];
// systemChat format["Heure :  %1", ODDGUI_var_Heure];
// systemChat format["Meteo :  %1", ODDGUI_var_meteo];