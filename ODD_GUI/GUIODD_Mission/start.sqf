/*
* Auteur : Wolv
* Script pour ouvrir le GUI
* 
* Argument :
* 
* Valeur renvoyée :
* nil
*
*/

ODD_var_SelectedTarget = ODDGUI_var_SelTarg;
publicVariable "ODD_var_SelectedTarget";
ODD_var_SelectedSector = ODDGUI_var_SelPos;
publicVariable "ODD_var_SelectedSector";

ODD_var_PlayerCount = lbValue[ODDGUI_var_IdcComboPlayer, (lbCurSel ODDGUI_var_IdcComboPlayer)];
ODD_var_SelectedFaction = lbValue[ODDGUI_var_IdcComboFaction, (lbCurSel ODDGUI_var_IdcComboFaction)];

if (ODD_var_SelectedFaction == 0) then {
	ODD_var_SelectedFaction = -1;
};
publicVariable "ODD_var_SelectedFaction";

// [ODD_var_SelectedFaction, False, True] remoteExec ["ODD_fnc_varEne", 2];

[] execVM 'odd_gui\GUIODD_Mission\heureEtMeteo.sqf';

[-1, "", True, ODD_var_SelectedFaction] remoteExec ["ODD_fnc_missions", 2];

sleep 0.5;

call compile preprocessFile "odd_gui\GUIODD_Mission\statut.sqf";
