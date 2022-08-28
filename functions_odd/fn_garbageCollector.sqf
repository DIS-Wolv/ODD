/*
* Author: Wolv
* Fonction permetant de supprimé les corps 
*
* Arguments:
* 0: nb de minute depuis le lancement de la mission <INT>
* 1: Activation du ODD_var_DEBUG dans le chat <BOOL>
*
* Return Value:
* Nom de la localité
*
* Example:
* [_itt] call ODD_fnc_garbageCollector
* [_itt, _Debug] call ODD_fnc_garbageCollector
*
* Public:
*/
params ["_nbItt", ["_Debug", false]];

_tGarbage = 45; // temps entre chaque execution du garbage collector

//["Test Garbage Coll"] remoteExec ["systemChat", 0];
if (_nbItt/_tGarbage == round ( _nbItt/_tGarbage)) then {
	private _nbEle = 0;
	{				//garbage collector du cul
		if (count(units(group _x)) <= 1) then {
			if (count (position _x nearEntities[["SoldierWB"], 100]) == 0) then {	
				sleep 2;
				deleteVehicle _x;		//supprime le corps
				_nbEle = _nbEle + 1;
			};
		};
	} forEach alldead;			//pour chaque corps 
	[["Nombre d'élement supprimé : %1", _nbEle]] call ODD_fnc_log;
};

