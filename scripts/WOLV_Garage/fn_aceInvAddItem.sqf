/*
* Auteur: Wolv
* Script pour mettre à jour la liste de l'inventaire 
* 
* Return Value:
* nil
*
*/
params [["_nb", 1]];

_index = lbCurSel WolvGarage_var_IdcChoixVl;						// Récupère l'index du véhicule

if ((_index != -1) and (count(WolvGarage_var_ListSpawn) > 0)) then {  	// Si un élément est séléctioné
	_vl = WolvGarage_var_ListSpawn select _index;

	_indexObj = lbCurSel WolvGarage_var_IdcListAresnalAce;	
	// Récupère l'index de l'objet

	if (_indexObj != -1) then {
		_inv = WolvGarage_var_ItemAce select _indexObj;
		[_inv, _vl, _nb] call ace_cargo_fnc_addCargoItem;
	};
};

call WolvGarage_fnc_aceInvUpdate;
