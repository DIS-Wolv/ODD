/*
* Auteur: Wolv
* Script pour retirer x items de l'inventaire
* 
* Argument :
* 0: nombre d'éléments à retirer <INT>
* 
* Return Value:
* nil
*
*/
params [["_Nb", 1]];
_indexVL = lbCurSel WolvGarage_var_IdcChoixVl;
// Récupère l'index du véhicule 

if (_indexVL != -1) then {
// Si un véhicule est selectionner 
	_vl = WolvGarage_var_ListSpawn select _indexVL;		
	// Récupère le véhicule 
	
	_indexObj = lbCurSel WolvGarage_var_IdcListInv;	
	// Récupère l'index de l'objet
	
	if (_indexObj != -1) then {		// Si un objet est selectionné
		_ListInvWeap = getWeaponCargo _vl;	// Récupère les armes dans le véhicule
		_ListInvMag = getMagazineCargo _vl;	// Récupère les chargeurs dans le véhicule
		_ListInvItems = getItemCargo _vl;	// Récupère les items dans le véhicule

		if (_indexObj < (count (_ListInvWeap select 0))) then {	
			// Si une arme est sélectionée

			clearWeaponCargoGlobal _vl;		
			// Supprime toutes les armes
			(_ListInvWeap select 1) set [_indexObj, (((_ListInvWeap select 1) select _indexObj) - _nb max 0)]; 
			// Modifie la liste des armes
			{
				_vl addWeaponCargoGlobal [_x , ((_ListInvWeap select 1) select _forEachIndex)]; 	// Ajoute les armes 
			} forEach (_ListInvWeap select 0);
		} else {
			_indexObj = _indexObj - (count (_ListInvWeap select 0));	// Modifie l'index

			if (_indexObj  < (count (_ListInvMag select 0))) then {		
				// Si un chargeur est sélectioné
				clearMagazineCargoGlobal _vl;			
				// Enlève tous les chargeurs

				(_ListInvMag select 1) set [_indexObj, (((_ListInvMag select 1) select _indexObj) - _nb max 0)]; 
				// Modifie la liste des chargeurs
				{
					_vl addMagazineCargoGlobal [_x, ((_ListInvMag select 1) select _forEachIndex)]; // Ajoute les chargeurs
				} forEach (_ListInvMag select 0);

			} else { 
				// Si un item est sélectionné
				_indexObj = _indexObj - (count (_ListInvMag select 0));	// modifie l'index

				clearItemCargoGlobal _vl;		
				// Enlève tous les items

				(_ListInvItems select 1) set [_indexObj, (((_ListInvItems select 1) select _indexObj) - _nb max 0)]; 
				// Modifie la liste des items
				{
					_vl addItemCargoGlobal [_x, ((_ListInvItems select 1) select _forEachIndex)]; // Ajoute les items
				} forEach (_ListInvItems select 0);
			};
		};

	};
};

[] remoteexec ["WolvGarage_fnc_invUpdate", 0];
// Met à jour la liste des inventaires
