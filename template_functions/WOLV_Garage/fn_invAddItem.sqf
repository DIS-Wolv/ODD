/*
* Auteur: Wolv
* Script pour ajouter x items dans l'inventaire
* 
* Argument :
* 0: nombre d'éléments à ajouter
* 
* Return Value:
* nil
*
*/
params [["_Nb", 1]];

_indexVL = lbCurSel WolvGarage_var_IdcChoixVl;
// Récupère l'index du véhicule

if (_indexVL != -1) then {	
	// Si un véhicule est séléctioné
	_vl = WolvGarage_var_ListVL select _indexVL;	
	// Récupère le véhicule 

	_indexObj = lbCurSel WolvGarage_var_IdcListAresnal;	
	// Récupère l'index de l'objet

	if (_indexObj != -1) then {
		// Si un objet est séléctioné 
		if (_indexObj + 1 <= (count  WolvGarage_var_ListArsenalWeap)) then {	
			// Si c'est une arme 
			if((maxLoad _vl - loadAbs _vl)>= (getNumber (configFile >> "CfgWeapons" >>  WolvGarage_var_ListArsenalWeap select _indexObj >> "WeaponSlotsInfo" >> "mass") * _Nb)) then { 
				// Vérifie s'il y a la place
				_vl addWeaponCargoGlobal [ WolvGarage_var_ListArsenalWeap select _indexObj, _nb];	
				// Ajoute l'arme au véhicule
			};
		} else {
			_indexObj = _indexObj - (count  WolvGarage_var_ListArsenalWeap);	// modifie l'index 

			if (_indexObj + 1 <= (count  WolvGarage_var_ListArsenalMag)) then {		
			// Si c'est un chargeur
				if((maxLoad _vl - loadAbs _vl)>= (getNumber (configFile >> "CfgMagazines" >>  WolvGarage_var_ListArsenalMag select _indexObj >> "mass") * _Nb)) then { 
				// Vérifie s'il y a la place
					_vl addMagazineCargoGlobal [ WolvGarage_var_ListArsenalMag select _indexObj, _nb]; 
					// Ajoute le chargeur au véhicule 
				};
			} else { 
				// Si c'est un item
				_indexObj = _indexObj - (count  WolvGarage_var_ListArsenalMag);	// modifie l'index 

				if((maxLoad _vl - loadAbs _vl)>= (getNumber (configFile >> "CfgWeapons" >>  WolvGarage_var_ListArsenalItem select _indexObj >> "itemInfo" >> "mass") * _Nb)) then {
				// Vérifie s'il y a la place
					_vl addItemCargoGlobal [ WolvGarage_var_ListArsenalItem select _indexObj, _nb];	
					// Ajoute l'item au véhicule
				};
			};
		};
	};
};

[] remoteexec ["WolvGarage_fnc_invUpdate", -2];
// Met à jour la liste des inventaires
