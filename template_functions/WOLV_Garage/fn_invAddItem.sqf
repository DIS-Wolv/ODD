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
		if (isClass (configFile >> "CfgWeapons" >> WolvGarage_var_ListArsenal select _indexObj)) then {
		// Si c'est une arme
			if((maxLoad _vl - loadAbs _vl)>= (getNumber (configFile >> "CfgWeapons" >>  WolvGarage_var_ListArsenal select _indexObj >> "WeaponSlotsInfo" >> "mass") * _Nb)) then { 
			// Vérifie s'il y a la place
				// Ajoute l'arme au véhicule
				_vl addItemCargoGlobal [ WolvGarage_var_ListArsenal select _indexObj, _nb];	
			};
		} else {
		// Si c'est un chargeur
			if((maxLoad _vl - loadAbs _vl)>= (getNumber (configFile >> "CfgMagazines" >>  WolvGarage_var_ListArsenal select _indexObj >> "mass") * _Nb)) then { 
			// Vérifie s'il y a la place
				_vl addItemCargoGlobal [ WolvGarage_var_ListArsenal select _indexObj, _nb]; 
				// Ajoute le chargeur au véhicule 
			};
		};
	};
};

[] remoteexec ["WolvGarage_fnc_invUpdate", 0];
// Met à jour la liste des inventaires
