/*
* Author: Wolv
* Script permetant d'ajouté x items de l'inventaire
* 
* Argument :
* nombre d'élément a ajouté 
* 
* Return Value:
* nil
*
*/
params [["_Nb", 1]];

// systemChat 'TestAddItem';
// recup l'index du vl
_indexVL = lbCurSel IdcListVL;

if (_indexVL != -1) then {	//si un vl est séléctioné
	_vl = ListVL select _indexVL;	// recup le vl 

	_indexObj = lbCurSel IdcListArs;	//recup l'index de l'objet

	if (_indexObj != -1) then {	//si un objet est séléctioné 
		if (_indexObj + 1 <= (count ListArsenalWeap)) then {	// si c'est une arme 
			if((maxLoad _vl - loadAbs _vl)>= (getNumber (configFile >> "CfgWeapons" >> ListArsenalWeap select _indexObj >> "WeaponSlotsInfo" >> "mass") * _Nb)) then { // verifie si il y a la place
				_vl addWeaponCargoGlobal [ListArsenalWeap select _indexObj, _nb];	// ajoute l'arme au vl 
			};
		} else {
			_indexObj = _indexObj - (count ListArsenalWeap);	// modifie l'index 

			if (_indexObj + 1 <= (count ListArsenalMag)) then {		// si c'est un chargeur
				if((maxLoad _vl - loadAbs _vl)>= (getNumber (configFile >> "CfgMagazines" >> ListArsenalMag select _indexObj >> "mass") * _Nb)) then { // verifie si il y a la place
					_vl addMagazineCargoGlobal [ListArsenalMag select _indexObj, _nb]; // ajoute le chargeur au vl 
				};
			} else { // sinon (est un item)
				_indexObj = _indexObj - (count ListArsenalMag);	// modifie l'index 

				if((maxLoad _vl - loadAbs _vl)>= (getNumber (configFile >> "CfgWeapons" >> ListArsenalItem select _indexObj >> "itemInfo" >> "mass") * _Nb)) then {// verifie si il y a la place
					_vl addItemCargoGlobal [ListArsenalItem select _indexObj, _nb];	// ajoute l'item au vl 
				};
			};
		};
	};
};

// update la liste des inventaire
call compile preprocessFile "scripts\WOLV_Garrage\Inventaire.sqf";
