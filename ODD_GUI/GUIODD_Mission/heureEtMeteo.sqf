/*
* Auteur : Wolv
* Script pour modifier l'heure et la meteo
* 
* Argument :
* 
* Valeur renvoyée :
* nil
*
*/
ODDGUI_var_Heure = lbValue[ODDGUI_var_IdcComboHeure, (lbCurSel ODDGUI_var_IdcComboHeure)];
ODDGUI_var_meteo = lbValue[ODDGUI_var_IdcComboMeteo, (lbCurSel ODDGUI_var_IdcComboMeteo)];

if (ODDGUI_var_meteo != -1) then {
	[0, (ODDGUI_var_meteo/10)] remoteExec["setOvercast", 0];
	[] remoteExec["forceWeatherChange", 0];
};
if (ODDGUI_var_Heure != -1) then {
	[(ODDGUI_var_Heure - dayTime + 24)%24] remoteExec["skipTime", 0];
};