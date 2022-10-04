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

	_inv = _vl getVariable "ace_cargo_loaded";
	_indexObj = lbCurSel WolvGarage_var_IdcListInvAce;	
	// Récupère l'index de l'objet
	if ((_indexObj != -1) and (_indexObj < count(_inv))) then {
		_obj = _inv select _indexObj;
		if (count _inv >= _nb) then {
			[_obj, _vl, _nb] call ace_cargo_fnc_removeCargoItem;
		}
		else {
			[_obj, _vl, count _inv] call ace_cargo_fnc_removeCargoItem;
		};
	};
};

call WolvGarage_fnc_aceInvUpdate;
