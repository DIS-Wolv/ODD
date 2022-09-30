/*
* Auteur: Wolv
* Script pour mettre à jour la liste de l'inventaire 
* 
* Return Value:
* nil
*
*/

((findDisplay IddDisplay) displayCtrl IdcListSpawn) lbSetCurSel -1;		
// Désélectionne le véhicule dans la liste de création

lbClear IdcListInv;								// Nettoie la liste inventaire 
_index = lbCurSel IdcListVL;					// Récupère l'index du véhicule
_display = findDisplay IddDisplay;				// Récupère le GUI
_ctrlBar = _display displayCtrl IdcBarreInv;	// Récupère la barre de charge du véhicule
_ctrlBar progressSetPosition 0;					// Met la progression de la barre a 0

if ((_index != -1) and (count(ListVL) > 0)) then {  // Si un élément est séléctioné
	_vl = ListVL select _index; 	// Récupère le véhicule 

	_ListInvWeap = getWeaponCargo _vl;
	{
		lbAdd [IdcListInv, 
			Format ["%1 × %2", str ((_ListInvWeap select 1) select _forEachIndex), getText (configFile >> "CfgWeapons" >> _x >> "displayName")
		]];
	} forEach (_ListInvWeap select 0);
	// Récupère les armes dans l'inventaire du véhicule et les met dans la liste

	_ListInvMag = getMagazineCargo _vl;
	{
		lbAdd [IdcListInv, 
			Format ["%1 × %2", str ((_ListInvMag select 1) select _forEachIndex), getText (configFile >> "CfgMagazines" >> _x >> "displayName")
		]];
	} forEach (_ListInvMag select 0);
	// Récupère les chargeurs l'inventaire du véhicule et les met dans la liste

	_ListInvItems = getItemCargo _vl;
	{
		lbAdd [IdcListInv, 
			Format ["%1 × %2", str ((_ListInvItems select 1) select _forEachIndex), getText (configFile >> "CfgWeapons" >> _x >> "displayName")
		]];
	} forEach (_ListInvItems select 0);
	// Récupère les items l'inventaire du véhicule et les met dans la liste

	_ctrlBar progressSetPosition (load _vl);
	// Défini la progression de la barre de chargement
};


