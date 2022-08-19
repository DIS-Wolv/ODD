/*
* Author: Wolv
* Script permetant de supprimé le vl selectioné 
* 
* Return Value:
* nil
*
*/
// systemChat 'Test Delete VL';

_index = lbCurSel IdcListVL; // recup l'index du vl

// systemChat str _index;
if (_index != -1) then {	// si un vl est selectioné
	_vl = ListVL select _index;	 // recupère le vl sélectioné
	//systemChat str _index;
	deleteVehicle _vl;		// supprime le vl

	lbDelete [IdcListVL, _index];	// supprime le vl de la list

	ListVL deleteAt _index;			// supprime le vl de la list des vl a proxmité
};

sleep 0.5;
// met a jour l'inventaire 
call compile preprocessFile 'scripts\WOLV_garage\VLProx.sqf';