/*
* Author: Wolv
* Script permetant d'update la list avec l'inventaire 
* 
* Return Value:
* nil
*
*/

// systemchat 'Inventaire.sqf';
((findDisplay IddDisplay) displayCtrl IdcListSpawn) lbSetCurSel -1;		// deselectionne le vl dans la liste de spawn 

lbClear IdcListInv;								// nettoie la liste inventaire 
_index = lbCurSel IdcListVL;					// recupère l'index du vl
_display = findDisplay IddDisplay;				// Recupère le GUI
_ctrlBar = _display displayCtrl IdcBarreInv;	// recupe la barre de charge du vl
_ctrlBar progressSetPosition 0;					//set la progression de la barre a 0

if (_index != -1) then {  // si un élément est séléctioné
	_vl = ListVL select _index; 	// recupère le vl 
	// systemchat (Format ["%1 / %2 = %3", loadAbs _vl, maxLoad _vl, load _vl]);

	// recupère les armes du vl et les met dans la liste
	_ListInvWeap = getWeaponCargo _vl;
	{
		lbAdd [IdcListInv, 
			Format ["%1 × %2", str ((_ListInvWeap select 1) select _forEachIndex), getText (configFile >> "CfgWeapons" >> _x >> "displayName")
		]];
	} forEach (_ListInvWeap select 0);

	// recupère les chargeurs du vl et les met dans la liste
	_ListInvMag = getMagazineCargo _vl;
	{
		lbAdd [IdcListInv, 
			Format ["%1 × %2", str ((_ListInvMag select 1) select _forEachIndex), getText (configFile >> "CfgMagazines" >> _x >> "displayName")
		]];
	} forEach (_ListInvMag select 0);

	// recupère les items du vl et les met dans la liste
	_ListInvItems = getItemCargo _vl;
	{
		lbAdd [IdcListInv, 
			Format ["%1 × %2", str ((_ListInvItems select 1) select _forEachIndex), getText (configFile >> "CfgWeapons" >> _x >> "displayName")
		]];
	} forEach (_ListInvItems select 0);

	//definie la progression de la barre 
	_ctrlBar progressSetPosition (load _vl);
};


