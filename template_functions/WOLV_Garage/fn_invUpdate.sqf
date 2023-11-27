/*
* Auteur: Wolv
* Script pour mettre à jour la liste de l'inventaire Arma
* 
* Return Value:
* nil
*
*/

if (!isNull(findDisplay WolvGarage_var_IddDisplayInv)) then {

lbClear WolvGarage_var_IdcListInv;								// Nettoie la liste inventaire 
_index = lbCurSel WolvGarage_var_IdcChoixVl;					// Récupère l'index du véhicule
_display = findDisplay WolvGarage_var_IddDisplayInv;			// Récupère le GUI
_ctrlBar = _display displayCtrl WolvGarage_var_BarreInv;		// Récupère la barre de charge du véhicule
_ctrlBar progressSetPosition 0;									// Met la progression de la barre a 0

if ((_index != -1) and (count(WolvGarage_var_ListSpawn) > 0)) then {  // Si un élément est séléctioné
	_vl = WolvGarage_var_ListSpawn select _index; 	// Récupère le véhicule 

	_ListInvWeap = getWeaponCargo _vl;
	{
		lbAdd [WolvGarage_var_IdcListInv, 
			Format ["%1 × %2", str ((_ListInvWeap select 1) select _forEachIndex), getText (configFile >> "CfgWeapons" >> _x >> "displayName")
		]];
	} forEach (_ListInvWeap select 0);
	// Récupère les armes dans l'inventaire du véhicule et les met dans la liste

	_ListInvMag = getMagazineCargo _vl;
	{
		lbAdd [WolvGarage_var_IdcListInv, 
			Format ["%1 × %2", str ((_ListInvMag select 1) select _forEachIndex), getText (configFile >> "CfgMagazines" >> _x >> "displayName")
		]];
	} forEach (_ListInvMag select 0);
	// Récupère les chargeurs l'inventaire du véhicule et les met dans la liste

	_ListInvItems = getItemCargo _vl;
	{
		lbAdd [WolvGarage_var_IdcListInv, 
			Format ["%1 × %2", str ((_ListInvItems select 1) select _forEachIndex), getText (configFile >> "CfgWeapons" >> _x >> "displayName")
		]];
	} forEach (_ListInvItems select 0);
	// Récupère les items l'inventaire du véhicule et les met dans la liste

	_ctrlBar progressSetPosition (load _vl);
	// Défini la progression de la barre de chargement
};


};