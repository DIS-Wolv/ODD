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
	// Supprime le véhicule
	deleteVehicle _vl;

	// Supprime le véhicule de la liste
	(owner player) publicVariableClient "WolvGarage_var_AllVl";
	WolvGarage_var_AllVl = WolvGarage_var_AllVl - [_vl];
	publicVariableServer "WolvGarage_var_AllVl";

	lbDelete [WolvGarage_var_IdcListVlProx, _index];	
	// Supprime le véhicule de la liste

	WolvGarage_var_ListVL deleteAt _index;			
	// Supprime le véhicule de la liste des véhicules a proxmité
};
sleep 0.5;

[] remoteexec ["WolvGarage_fnc_garUpdateVlProx", 0];

