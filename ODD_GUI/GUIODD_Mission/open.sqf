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

//[-1, True] call ODD_fnc_varEne;

// definition des IDD et IDC en variables
ODDGUI_var_IddDisplay = 270822;
ODDGUI_var_IdcMissionStatus = 1107;

ODDGUI_var_IdcListObjAll = 1500;
ODDGUI_var_IdcListObjSel = 1501;
ODDGUI_var_IdcListPosAll = 1502;
ODDGUI_var_IdcListPosSel = 1503;

ODDGUI_var_IdcComboPlayer = 2100;
ODDGUI_var_IdcComboFaction = 2101;
ODDGUI_var_IdcComboHeure = 2102;
ODDGUI_var_IdcComboMeteo = 2103;


private _isCreate = False;

if (isNil "ODD_var_MissionType" or isNil "ODD_var_FactionNames") then {
	_localID = clientOwner;
	[_localID] remoteExec ["publicVariableClient 'ODD_var_MissionType';", 0];
	[_localID] remoteExec ["publicVariableClient 'ODD_var_FactionNames';", 0];
};

//Variable
ODDGUI_var_heure = [00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
ODDGUI_var_NbJoueur = [01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25];
ODDGUI_var_Secteur = ["Nord-Ouest", "Ouest", "Sud-Ouest", "Nord", "Centre", "Sud", "Nord-Est", "Est", "Sud-Est"];
publicVariableServer "ODDGUI_var_Secteur";
ODDGUI_var_SecteurMarker = ["ODD_MarkerNW", "ODD_MarkerW", "ODD_MarkerSW", "ODD_MarkerN", "ODD_MarkerC", "ODD_MarkerS", "ODD_MarkerNE", "ODD_MarkerE", "ODD_MarkerSE"];
publicVariableServer "ODDGUI_var_SecteurMarker";
_meteoName = ["Ciel Bleu", "Nuageux", "Gris"]; // 0, 0.5, 1
_meteoValue = [2, 5, 8];

ODDGUI_var_SelTarg = [];
ODDGUI_var_SelPos = [];

// Création de la fenêtre
private _isCreate = createDialog "ODDGUI_Mission";

// Si la fenêtre est créée
if (_isCreate) then {

	{
		lbAdd [ODDGUI_var_IdcListObjAll, _x];
	} forEach ODD_var_MissionType;
	{
		lbAdd [ODDGUI_var_IdcListObjSel, _x];
		ODDGUI_var_SelTarg pushBack _x;
	} forEach ODD_var_MissionType;

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
	} forEach ODD_var_FactionNames;
	lbAdd [ODDGUI_var_IdcComboFaction, "Aleatoire"];
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcComboFaction) lbSetCurSel (count ODD_var_FactionNames);

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

	// Ajoute les eventHandler
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcListObjAll) ctrlSetEventHandler ["LBDblClick", "[ODDGUI_var_IdcListObjAll] execVM 'odd_gui\GUIODD_Mission\add.sqf'"];		// double click pour Add Obj
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcListObjSel) ctrlSetEventHandler ["LBDblClick", "[ODDGUI_var_IdcListObjSel] execVM 'odd_gui\GUIODD_Mission\rem.sqf'"];		// double click pour Rem Obj
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcListPosAll) ctrlSetEventHandler ["LBDblClick", "[ODDGUI_var_IdcListPosAll] execVM 'odd_gui\GUIODD_Mission\add.sqf'"];		// double click pour Add Obj
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcListPosSel) ctrlSetEventHandler ["LBDblClick", "[ODDGUI_var_IdcListPosSel] execVM 'odd_gui\GUIODD_Mission\rem.sqf'"];		// double click pour Rem Obj
};

while {!(isNull (findDisplay ODDGUI_var_IddDisplay))} do {
	call compile preprocessFile "odd_gui\GUIODD_Mission\statut.sqf";
	sleep 1;
};