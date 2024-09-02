/*
* Auteur : Wolv
* Fonction pour ouvrir le GUI de création de mission
*
* Arguments :
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call OddGuiMissions_fnc_open;
*
* Variable publique :
* 
*/

// si la carte est pas init exit
if (isNil "ODD_var_INITMAP") exitWith { systemChat "Initialisation pas fini"; true;};

// liste des IDC
ODDGUIMissions_IddDisplay = 31082024;
//Liste des IDC (permet de pointer les controlleurs)
ODDGUIMissions_Combo_Area_IDC = 2100;		// OK
ODDGUIMissions_Combo_TailleZO_IDC = 2101;	// OK
ODDGUIMissions_Combo_Location_IDC = 2102;	// OK
ODDGUIMissions_Combo_Objectif_IDC = 2103;	// OK
ODDGUIMissions_Combo_Weather_IDC = 2105;	// OK
ODDGUIMissions_Combo_Fog_IDC = 2106;		// OK
ODDGUIMissions_Slider_Time_IDC = 1900;		// OK
ODDGUIMissions_SText_Recap_IDC = 1101;		// OK
ODDGUIMissions_SText_Time_IDC = 1102;		// OK

// Var pour la localité
ODDGUIMissions_var_zoneName = ["Zone allié", "Ligne de front", "Zone énemie"];


private _location = ['Capitale', 'Grande ville', 'Ville', 'Village', 'Lieu-dit', 'Colline'];
ODDGUIMissions_var_LocationClassName = ODD_var_LocationType;

// Var pour la Météo
private _meteoName = ["Ciel bleu", "Nuageux", "Mauvais temps"];
private _meteoValue = [2, 5, 8];
private _foglvlName = ["Pas de brouillard", "Brouillard très léger", "Brouillard léger", "Brouillard moyen", "Gros Brouillard", "Purée de poid"];
private _foglvlValue = [0, 1, 2, 3, 4, 5];

// Création du GUI
private _isCreate = createDialog "ODDGUI_Control";
// si le GUI est créé
if (_isCreate) then {
	// récupération du display
	private _display = (findDisplay ODDGUIMissions_IddDisplay);

	// combo zone
	{
		lbAdd [ODDGUIMissions_Combo_Area_IDC, _x];
		lbSetValue[ODDGUIMissions_Combo_Area_IDC, _forEachIndex, _forEachIndex];
	} forEach ODDGUIMissions_var_zoneName;
	lbAdd [ODDGUIMissions_Combo_Area_IDC, "Aléatoire"];
	lbSetValue[ODDGUIMissions_Combo_Area_IDC, count ODDGUIMissions_var_zoneName, -1];
	(_display displayCtrl ODDGUIMissions_Combo_Area_IDC) lbSetCurSel ((count _location));
	(_display displayCtrl ODDGUIMissions_Combo_Area_IDC) ctrlAddEventHandler ["LBSelChanged",{[] spawn OddGuiMissions_fnc_updateLocation;[] spawn OddGuiMissions_fnc_updateMission;}];


	// combo localité type
	{
		lbAdd [ODDGUIMissions_Combo_TailleZO_IDC, _x];
		lbSetValue[ODDGUIMissions_Combo_TailleZO_IDC, _forEachIndex, _forEachIndex];
	} forEach _location;
	lbAdd [ODDGUIMissions_Combo_TailleZO_IDC, "Aléatoire"];
	lbSetValue[ODDGUIMissions_Combo_TailleZO_IDC, count _location, -1];
	(_display displayCtrl ODDGUIMissions_Combo_TailleZO_IDC) lbSetCurSel ((count _location));
	(_display displayCtrl ODDGUIMissions_Combo_TailleZO_IDC) ctrlAddEventHandler ["LBSelChanged",{[] call OddGuiMissions_fnc_updateLocation;}];
	
	// localité
	[] call OddGuiMissions_fnc_updateLocation;

	// combo objectif
	[] call OddGuiMissions_fnc_updateMission;

	// PARTIE Météo

	// slider time
	sliderSetRange [ODDGUIMissions_Slider_Time_IDC, 0, 1440];
	(_display displayCtrl ODDGUIMissions_Slider_Time_IDC) ctrlAddEventHandler ["SliderPosChanged",{params ["_control", "_newValue"];[_newValue] call OddGuiMissions_fnc_updateTime;}];

	// combo météo
	{
		lbAdd [ODDGUIMissions_Combo_Weather_IDC, _x];
		lbSetValue[ODDGUIMissions_Combo_Weather_IDC, _forEachIndex, (_meteoValue select _forEachIndex)];
	} forEach _meteoName;
	lbAdd [ODDGUIMissions_Combo_Weather_IDC, "Actuel"];
	lbSetValue[ODDGUIMissions_Combo_Weather_IDC, count _meteoName, -1];
	(_display displayCtrl ODDGUIMissions_Combo_Weather_IDC) lbSetCurSel ((count _meteoName));
	{
		lbAdd [ODDGUIMissions_Combo_Fog_IDC, _x];				// ajoute l'entrée
		lbSetValue [ODDGUIMissions_Combo_Fog_IDC, _forEachIndex, (_foglvlValue select _forEachIndex)]; 	// ajoute une valeur à l'entrée
	} forEach _foglvlName;
	lbAdd [ODDGUIMissions_Combo_Fog_IDC, "Actuel"];
	lbSetValue[ODDGUIMissions_Combo_Fog_IDC, count _meteoName, -1];
	(_display displayCtrl ODDGUIMissions_Combo_Fog_IDC) lbSetCurSel ((count _foglvlValue));

	// sText time
	[0] call OddGuiMissions_fnc_updateTime;


	ODDGUIMissions_var_SelectedParams = [-1,"",-1,"Aléatoire","Aléatoire"];
	[] call OddGuiMissions_fnc_missionStatus;
} else {
	systemChat "t'es mauvais Jack, appelles @Wolv (il adore les GUIs)";
};

