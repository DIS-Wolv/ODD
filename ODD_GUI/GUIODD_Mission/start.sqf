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
publicVariable "ODD_var_SelectedTarget";
ODD_var_SelectedSector = ODDGUI_var_SelPos;
publicVariable "ODD_var_SelectedSector";

ODD_var_NbPlayer = lbValue[ODDGUI_var_IdcComboPlayer, (lbCurSel ODDGUI_var_IdcComboPlayer)];
ODD_var_SelectedFaction = lbValue[ODDGUI_var_IdcComboFaction, (lbCurSel ODDGUI_var_IdcComboFaction)];

if (ODD_var_SelectedFaction == 0) then {
	ODD_var_SelectedFaction = -1;
};
publicVariable "ODD_var_SelectedFaction";

/////////////////////////////////////////////////////////////////////////////////////////////////

[ODD_var_SelectedFaction, false, true] remoteExec ["ODD_fnc_varEne", 2];

[] execVM 'ODD_GUI\GUIODD_Mission\heureEtMeteo.sqf';

[] remoteExec ["ODD_fnc_missions", 2];

sleep 0.5;

call compile preprocessFile "ODD_GUI\GUIODD_Mission\statut.sqf";

//systemChat format["Secteur : %1", ODD_var_SelectedSector];
//systemChat format["Type d'odd_var_objectif : %1", ODD_var_SelectedTarget];
//systemChat format["Faction :  %1", ODD_var_SelectedFaction];
//systemChat format["Nb Joueur :  %1", ODD_var_NbPlayer];
// systemChat format["Heure :  %1", ODDGUI_var_Heure];
// systemChat format["Meteo :  %1", ODDGUI_var_meteo];