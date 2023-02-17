/*
* Auteur: Wolv
* Script pour supprimer le véhicule selectioné 
* 
* Return Value:
* nil
*
*/

_index = lbCurSel WolvGarage_var_IdcListVlProx; 
// Récupère l'index du véhicule

if (_index != -1) then {	
	// Si un véhicule est selectioné
	_vl = WolvGarage_var_ListVL select _index;	 
	// Récupère le véhicule sélectioné
	deleteVehicle _vl;		
	// Supprime le véhicule

	lbDelete [WolvGarage_var_IdcListVlProx, _index];	
	// Supprime le véhicule de la liste

	WolvGarage_var_ListVL deleteAt _index;			
	// Supprime le véhicule de la liste des véhicules a proxmité
};
sleep 0.5;

call WolvGarage_fnc_garUpdateVlProx;
// Met à jour l'inventaire 
