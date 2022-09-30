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

_indexVL = lbCurSel IdcListVL;
// Récupère l'index du véhicule

if (_indexVL != -1) then {	
	// Si un véhicule est séléctioné
	_vl = ListVL select _indexVL;	
	// Récupère le véhicule 

	_indexObj = lbCurSel IdcListArs;	
	// Récupère l'index de l'objet

	if (_indexObj != -1) then {	
		// Si un objet est séléctioné 
		if (_indexObj + 1 <= (count ListArsenalWeap)) then {	
			// Si c'est une arme 
			if((maxLoad _vl - loadAbs _vl)>= (getNumber (configFile >> "CfgWeapons" >> ListArsenalWeap select _indexObj >> "WeaponSlotsInfo" >> "mass") * _Nb)) then { 
				// Vérifie s'il y a la place
				_vl addWeaponCargoGlobal [ListArsenalWeap select _indexObj, _nb];	
				// Ajoute l'arme au véhicule
			};
		} else {
			_indexObj = _indexObj - (count ListArsenalWeap);	// modifie l'index 

			if (_indexObj + 1 <= (count ListArsenalMag)) then {		
			// Si c'est un chargeur
				if((maxLoad _vl - loadAbs _vl)>= (getNumber (configFile >> "CfgMagazines" >> ListArsenalMag select _indexObj >> "mass") * _Nb)) then { 
				// Vérifie s'il y a la place
					_vl addMagazineCargoGlobal [ListArsenalMag select _indexObj, _nb]; 
					// Ajoute le chargeur au véhicule 
				};
			} else { 
				// Si c'est un item
				_indexObj = _indexObj - (count ListArsenalMag);	// modifie l'index 

				if((maxLoad _vl - loadAbs _vl)>= (getNumber (configFile >> "CfgWeapons" >> ListArsenalItem select _indexObj >> "itemInfo" >> "mass") * _Nb)) then {
				// Vérifie s'il y a la place
					_vl addItemCargoGlobal [ListArsenalItem select _indexObj, _nb];	
					// Ajoute l'item au véhicule
				};
			};
		};
	};
};

call compile preprocessFile "scripts\WOLV_garage\Inventaire.sqf";
// Met à jour la liste des inventaires
