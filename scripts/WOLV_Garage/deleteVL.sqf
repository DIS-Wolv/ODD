/*
* Auteur: Wolv
* Script pour supprimer le véhicule selectioné 
* 
* Return Value:
* nil
*
*/

_index = lbCurSel IdcListVL; 
// Récupère l'index du véhicule

if (_index != -1) then {	
	// Si un véhicule est selectioné
	_vl = ListVL select _index;	 
	// Récupère le véhicule sélectioné
	deleteVehicle _vl;		
	// Supprime le véhicule

	lbDelete [IdcListVL, _index];	
	// Supprime le véhicule de la liste

	ListVL deleteAt _index;			
	// Supprime le véhicule de la liste des véhicules a proxmité
};

sleep 0.5;
call compile preprocessFile 'scripts\WOLV_garage\VLProx.sqf';
// Met à jour l'inventaire 
