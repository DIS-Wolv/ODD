ODDGUIMissions_IddDisplay = 090223;
//Liste des IDC (permet de pointer les controlleurs)
ODDGUIMissions_Combo_Area_IDC = 2100;		// OK
ODDGUIMissions_Combo_Location_IDC = 2101;	// OK
ODDGUIMissions_Combo_Mission_IDC = 2102;	// OK
ODDGUIMissions_Combo_Faction_IDC = 2103;	// OK
ODDGUIMissions_Combo_Players_IDC = 2104;	// OK
ODDGUIMissions_Combo_Weather_IDC = 2105;	// OK
ODDGUIMissions_Slider_Time_IDC = 1900;		// OK
ODDGUIMissions_List_Location_IDC = 1500;	// OK
ODDGUIMissions_SText_Time_IDC = 1102;		// OK
ODDGUIMissions_SText_Recap_IDC = 1101;

ODDGUI_var_NbJoueur = [01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25];

private _meteoName = ["Ciel bleu", "Nuageux", "Mauvais temps"];
private _meteoValue = [2, 5, 8];

private _Secteur = ["Nord-Ouest", "Ouest", "Sud-Ouest", "Nord", "Centre", "Sud", "Nord-Est", "Est", "Sud-Est"];
ODDGUIMissions_var_SecteurMarker = ["ODD_MarkerNW", "ODD_MarkerW", "ODD_MarkerSW", "ODD_MarkerN", "ODD_MarkerC", "ODD_MarkerS", "ODD_MarkerNE", "ODD_MarkerE", "ODD_MarkerSE"];

private _location = ['Capitale', 'Grande ville', 'Ville', 'Village', 'Lieu-dit', 'Colline'];
ODDGUIMissions_var_LocationClassName = ODD_var_LocationType;

private _isCreate = createDialog "ODDGUIMission";
if (_isCreate) then {
	private _display = (findDisplay ODDGUIMissions_IddDisplay);

	// combo joueurs
	{
		lbAdd [ODDGUIMissions_Combo_Players_IDC, str(_x)]; 				// ajoute l'entrée
		lbSetValue [ODDGUIMissions_Combo_Players_IDC, _forEachIndex, _x]; 	// ajoute une valeur à l'entrée
	} forEach ODDGUI_var_NbJoueur;
	(_display displayCtrl ODDGUIMissions_Combo_Players_IDC) lbSetCurSel ((playersNumber west)-1);

	// combo météo
	{
		lbAdd [ODDGUIMissions_Combo_Weather_IDC, _x];
		lbSetValue[ODDGUIMissions_Combo_Weather_IDC, _forEachIndex, (_meteoValue select _forEachIndex)];
	} forEach _meteoName;
	lbAdd [ODDGUIMissions_Combo_Weather_IDC, "Actuel"];
	lbSetValue[ODDGUIMissions_Combo_Weather_IDC, count _meteoName, -1];
	(_display displayCtrl ODDGUIMissions_Combo_Weather_IDC) lbSetCurSel ((count _meteoName));

	// combo secteur
	{
		lbAdd [ODDGUIMissions_Combo_Area_IDC, _x];
		lbSetValue[ODDGUIMissions_Combo_Area_IDC, _forEachIndex, _forEachIndex];
	} forEach _Secteur;
	lbAdd [ODDGUIMissions_Combo_Area_IDC, "Aléatoire"];
	lbSetValue[ODDGUIMissions_Combo_Area_IDC, count _Secteur, -1];
	(_display displayCtrl ODDGUIMissions_Combo_Area_IDC) lbSetCurSel ((count _Secteur));
	(_display displayCtrl ODDGUIMissions_Combo_Area_IDC) ctrlAddEventHandler ["LBSelChanged",{params ["_control", "_lbCurSel", "_lbSelection"];[_lbCurSel] call OddGuiMissions_fnc_udpateLocation;}];
	
	// combo localité type
	{
		lbAdd [ODDGUIMissions_Combo_Location_IDC, _x];
		lbSetValue[ODDGUIMissions_Combo_Location_IDC, _forEachIndex, _forEachIndex];
	} forEach _location;
	lbAdd [ODDGUIMissions_Combo_Location_IDC, "Aléatoire"];
	lbSetValue[ODDGUIMissions_Combo_Location_IDC, count _location, -1];
	(_display displayCtrl ODDGUIMissions_Combo_Location_IDC) lbSetCurSel ((count _location));
	(_display displayCtrl ODDGUIMissions_Combo_Location_IDC) ctrlAddEventHandler ["LBSelChanged",{params ["_control", "_lbCurSel", "_lbSelection"];[_lbCurSel] call OddGuiMissions_fnc_udpateLocation;}];
	

	// combo factions
	{
		lbAdd [ODDGUIMissions_Combo_Faction_IDC, _x];
		lbSetValue[ODDGUIMissions_Combo_Faction_IDC, _forEachIndex, (_forEachIndex + 1)];
	} forEach ODD_var_FactionNames;
	lbAdd [ODDGUIMissions_Combo_Faction_IDC, "Aléatoire"];
	(_display displayCtrl ODDGUIMissions_Combo_Faction_IDC) lbSetCurSel (count ODD_var_FactionNames);

	// combo missions
	{
		lbAdd [ODDGUIMissions_Combo_Mission_IDC, _x];
		lbSetValue[ODDGUIMissions_Combo_Mission_IDC, _forEachIndex, _forEachIndex];
	} forEach ODD_var_MissionType;
	lbAdd [ODDGUIMissions_Combo_Mission_IDC, "Aléatoire"];
	lbSetValue[ODDGUIMissions_Combo_Mission_IDC, (count ODD_var_MissionType), -1];
	(_display displayCtrl ODDGUIMissions_Combo_Mission_IDC) lbSetCurSel (count ODD_var_MissionType);

	// slider time
	sliderSetRange [ODDGUIMissions_Slider_Time_IDC, 0, 1440];
	(_display displayCtrl ODDGUIMissions_Slider_Time_IDC) ctrlAddEventHandler ["SliderPosChanged",{params ["_control", "_newValue"];[_newValue] call OddGuiMissions_fnc_updateTime;}];

	// sText time
	[0] call OddGuiMissions_fnc_updateTime;

	// list Location
	[] call OddGuiMissions_fnc_udpateLocation;
	
} else {
	systemChat "t'es mauvais Jack, appelles @Wolv (il adore les GUIs)";
};
