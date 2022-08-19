/*
* Author: Wolv
* Script permetant de retiré x items de l'inventaire
* 
* Argument :
* nombre d'élément a retiré 
* 
* Return Value:
* nil
*
*/
params [["_Nb", 1]];

// systemChat 'TestRmItem';
// recupère l'index du vl 
_indexVL = lbCurSel IdcListVL;

// si un vl est selectionner 
if (_indexVL != -1) then {
	_vl = ListVL select _indexVL;		// recup le vl 
	
	_indexObj = lbCurSel IdcListInv;	// recup l'index de l'obj
	
	if (_indexObj != -1) then {		// si un obj est selectionner 
		//systemChat str _indexObj;
		_ListInvWeap = getWeaponCargo _vl;	// recup les armes dans le vl
		_ListInvMag = getMagazineCargo _vl;	// recup les chargeurs dans le vl
		_ListInvItems = getItemCargo _vl;	// recup les items dans le vl

		if (_indexObj < (count (_ListInvWeap select 0))) then {	// si une arme est séléctioné 

			clearWeaponCargoGlobal _vl;		// enleve toute les armes
			(_ListInvWeap select 1) set [_indexObj, (((_ListInvWeap select 1) select _indexObj) - _nb max 0)]; // modifie la liste des armes
			{
				_vl addWeaponCargoGlobal [_x , ((_ListInvWeap select 1) select _forEachIndex)]; 	// rajoute les armes 
			} forEach (_ListInvWeap select 0);	// pour chaque arme

		} else {		//sinon
			_indexObj = _indexObj - (count (_ListInvWeap select 0));	//modifie l'index

			if (_indexObj  < (count (_ListInvMag select 0))) then {		//si un chargeurs est séléctioné
				clearMagazineCargoGlobal _vl;			// enleve tout les chargeurs

				(_ListInvMag select 1) set [_indexObj, (((_ListInvMag select 1) select _indexObj) - _nb max 0)]; // modifie la liste des chargeur
				{
					_vl addMagazineCargoGlobal [_x, ((_ListInvMag select 1) select _forEachIndex)]; // rajoute les chargeurs
				} forEach (_ListInvMag select 0);	// pour chaque chargeurs

			} else { // sinon (c'est un item)
				_indexObj = _indexObj - (count (_ListInvMag select 0));	// modifie l'index

				clearItemCargoGlobal _vl;		// enleve tout les items

				(_ListInvItems select 1) set [_indexObj, (((_ListInvItems select 1) select _indexObj) - _nb max 0)]; // modifie la liste des items
				{
					_vl addItemCargoGlobal [_x, ((_ListInvItems select 1) select _forEachIndex)]; // rajoute les items
				} forEach (_ListInvItems select 0);		// pour chaque items

			};
		};

	};
};

// update la liste des inventaire
call compile preprocessFile "scripts\WOLV_garage\Inventaire.sqf";