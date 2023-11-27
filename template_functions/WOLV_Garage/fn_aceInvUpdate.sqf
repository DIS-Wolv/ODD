/*
* Auteur: Wolv
* Script pour mettre à jour la liste de l'inventaire 
* 
* Return Value:
* nil
*
*/

if (!isNull(findDisplay WolvGarage_var_IddDisplayInvAce)) then {

lbClear WolvGarage_var_IdcListInvAce;								// Nettoie la liste inventaire 
_index = lbCurSel WolvGarage_var_IdcChoixVl;						// Récupère l'index du véhicule
_display = findDisplay WolvGarage_var_IddDisplayInvAce;				// Récupère le GUI
_ctrlBar = _display displayCtrl WolvGarage_var_BarreInvAce;			// Récupère la barre de charge du véhicule
_ctrlBar progressSetPosition 0;										// Met la progression de la barre a 0

if ((_index != -1) and (count(WolvGarage_var_ListSpawn) > 0)) then {  	// Si un élément est séléctioné
	_vl = WolvGarage_var_ListSpawn select _index; 						// Récupère le véhicule 

	_inv = _vl getVariable "ace_cargo_loaded";
	{
		if (typeName _x == "STRING") then {
			lbAdd [WolvGarage_var_IdcListInvAce, getText (configFile >> "CfgVehicles" >> _x >> "displayName")];
		}
		else {
			lbAdd [WolvGarage_var_IdcListInvAce, getText (configFile >> "CfgVehicles" >> (typeof _x) >> "displayName")];
		};
	} forEach _inv;

	_maxLoad = call WolvGarage_fnc_aceInvSize;
	_progress = 1;
	if (_maxLoad > 0) then {
		_freeSpace = _vl getVariable "ace_cargo_space";
		_progress = ((_maxLoad - _freeSpace)/_maxLoad);
	};

	_ctrlBar progressSetPosition _progress;
	// Défini la progression de la barre de chargement
	((findDisplay WolvGarage_var_IddDisplayInvAce) displayCtrl WolvGarage_var_AceInvSize) ctrlSetStructuredText (parseText format["<t size='2' align='center'>Capacité : %1</t>", _maxLoad]);
};

};
