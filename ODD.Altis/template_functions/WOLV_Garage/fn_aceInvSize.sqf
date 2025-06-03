/*
* Auteur: Wolv
* Script pour mettre à jour la liste de l'inventaire 
* 
* Return Value:
* nil
*
*/

private _maxLoad = -1;

if (!isNull(findDisplay WolvGarage_var_IddDisplayInvAce)) then {
_index = lbCurSel WolvGarage_var_IdcChoixVl;						// Récupère l'index du véhicule

_maxLoad = -1;

if ((_index != -1) and (count(WolvGarage_var_ListSpawn) > 0)) then {  	// Si un élément est séléctioné
	_vl = WolvGarage_var_ListSpawn select _index; 						// Récupère le véhicule 

	_inv = _vl getVariable "ace_cargo_loaded";
	_weight = 0;
	{
		if (typeName _x == "STRING") then {
			_weight = _weight + getNumber (configFile >> "CfgVehicles" >> _x >> "ace_cargo_size");
		}
		else {
			_weight = _weight + getNumber (configFile >> "CfgVehicles" >> (typeof _x) >> "ace_cargo_size");
		};
	} forEach _inv;

	_freeSpace = _vl getVariable "ace_cargo_space";
	_maxLoad = (_weight + _freeSpace);

};
};

_maxLoad;
