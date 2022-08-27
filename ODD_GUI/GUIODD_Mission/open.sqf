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

[] call WOLV_fnc_var;

// definition des IDD et IDC en variable 
ODDGUI_var_IddDisplay = 270822;

ODDGUI_var_IdcListObjAll = 1500;
ODDGUI_var_IdcListObjSel = 1501;
ODDGUI_var_IdcListPosAll = 1502;
ODDGUI_var_IdcListPosSel = 1503;

ODDGUI_var_IdcComboPlayer = 2100;
ODDGUI_var_IdcComboFaction = 2101;
ODDGUI_var_IdcComboHeure = 2102;
ODDGUI_var_IdcComboMeteo = 2103;


private _isCreate = False;

//Variable
ODDGUI_var_heure = [00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
ODDGUI_var_NbJoueur = [01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25];
ODDGUI_var_Secteur = ["Nord-Ouest", "Ouest", "Sud-Ouest", "Nord", "Centre", "Sud", "Nord-Est", "Est", "Sud-Est"];
ODDGUI_var_Meteo = ["Ciel Bleu", "Nuageux", "Gris"]; // 0, 0.5, 1
_meteoValue = [2, 5, 10];

ODDGUI_var_SelTarg = [];
ODDGUI_var_SelPos = [];

// Creation de la fenetre
_isCreate = createDialog "ODDGUI_Mission";

//si la fenetre est créé
if (_isCreate) then {

	{
		lbAdd [ODDGUI_var_IdcListObjAll, _x];
	} forEach TargettypeName;
	{
		lbAdd [ODDGUI_var_IdcListObjSel, _x];
		ODDGUI_var_SelTarg pushBack _x;
	} forEach TargettypeName;

	{
		lbAdd [ODDGUI_var_IdcListPosAll, _x];
	} forEach ODDGUI_var_Secteur;
	{
		lbAdd [ODDGUI_var_IdcListPosSel, _x];
		ODDGUI_var_SelPos pushBack _x;
	} forEach ODDGUI_var_Secteur; 

	{
		lbAdd [ODDGUI_var_IdcComboPlayer, str(_x)];
		lbSetValue [ODDGUI_var_IdcComboPlayer, _forEachIndex, _x];
	} forEach ODDGUI_var_NbJoueur;
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcComboPlayer) lbSetCurSel ((playersNumber west)-1);

	{
		lbAdd [ODDGUI_var_IdcComboFaction, _x];
		lbSetValue[ODDGUI_var_IdcComboFaction, _forEachIndex, (_forEachIndex + 1)];
	} forEach nomFaction;
	lbAdd [ODDGUI_var_IdcComboFaction, "Aleatoire"];
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcComboFaction) lbSetCurSel (count nomFaction);

	{
		lbAdd [ODDGUI_var_IdcComboHeure, Format["%1:00", _x]];
		lbSetValue[ODDGUI_var_IdcComboHeure, _forEachIndex, _x];
	} forEach ODDGUI_var_heure;
	lbAdd [ODDGUI_var_IdcComboHeure, "Actuel"];
	lbSetValue[ODDGUI_var_IdcComboHeure, count ODDGUI_var_heure, -1];
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcComboHeure) lbSetCurSel (count ODDGUI_var_heure);

	{
		lbAdd [ODDGUI_var_IdcComboMeteo, _x];
		lbSetValue[ODDGUI_var_IdcComboMeteo, _forEachIndex, (_meteoValue select _forEachIndex)];
	} forEach ODDGUI_var_Meteo;
	lbAdd [ODDGUI_var_IdcComboMeteo, "Actuel"];
	lbSetValue[ODDGUI_var_IdcComboMeteo, count ODDGUI_var_Meteo, -1];
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcComboMeteo) lbSetCurSel ((count ODDGUI_var_Meteo));
};

// Ajoute les eventHandler
((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcListObjAll) ctrlSetEventHandler ["LBDblClick", "[ODDGUI_var_IdcListObjAll] execVM 'ODD_GUI\GUIODD_Mission\add.sqf'"];		// double click pour Add Obj
((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcListObjSel) ctrlSetEventHandler ["LBDblClick", "[ODDGUI_var_IdcListObjSel] execVM 'ODD_GUI\GUIODD_Mission\rem.sqf'"];		// double click pour Rem Obj
((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcListPosAll) ctrlSetEventHandler ["LBDblClick", "[ODDGUI_var_IdcListPosAll] execVM 'ODD_GUI\GUIODD_Mission\add.sqf'"];		// double click pour Add Obj
((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcListPosSel) ctrlSetEventHandler ["LBDblClick", "[ODDGUI_var_IdcListPosSel] execVM 'ODD_GUI\GUIODD_Mission\rem.sqf'"];		// double click pour Rem Obj
