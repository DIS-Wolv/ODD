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

// Creation de la fenetre
_isCreate = createDialog "ODDGUI_Mission";

//si la fenetre est créé
if (_isCreate) then {

	{
		lbAdd [ODDGUI_var_IdcListObjAll, _x];
	} forEach TargettypeName;

	{
		lbAdd [ODDGUI_var_IdcComboPlayer, str(_x)];
	} forEach ODDGUI_var_NbJoueur;
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcComboPlayer) lbSetCurSel ((playersNumber west)-1);

	{
		lbAdd [ODDGUI_var_IdcComboFaction, _x];
	} forEach nomFaction;
	lbAdd [ODDGUI_var_IdcComboFaction, "Aleatoire"];
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcComboFaction) lbSetCurSel (count nomFaction);

	{
		lbAdd [ODDGUI_var_IdcComboHeure, Format["%1:00", _x]];
	} forEach ODDGUI_var_heure;
	((findDisplay ODDGUI_var_IddDisplay) displayCtrl ODDGUI_var_IdcComboHeure) lbSetCurSel 12;
};

/*/ Ajoute les eventHandler
((findDisplay IddDisplay) displayCtrl IdcListSpawn) ctrlSetEventHandler ["LBDblClick", "execVM 'scripts\WOLV_garage\spawnVL.sqf'"];		// double click pour spawn le vl
((findDisplay IddDisplay) displayCtrl IdcListArs) ctrlSetEventHandler ["LBDblClick", "[1] execVM 'scripts\WOLV_garage\AddItem.sqf'"];		// double click pour Ajouté un item
((findDisplay IddDisplay) displayCtrl IdcListInv) ctrlSetEventHandler ["LBDblClick", "[1] execVM 'scripts\WOLV_garage\RemoveItem.sqf'"];	// double click pour retiré un item
((findDisplay IddDisplay) displayCtrl IdcListVL) ctrlSetEventHandler ["LBSelChanged","execVM 'scripts\WOLV_garage\Inventaire.sqf';"];		// lorsque la liste des vl a proximité update la liste inventaire 

