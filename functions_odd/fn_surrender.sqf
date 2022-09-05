/*
* Author: Wolv
* Fonction permetant de faire se rendre les bots a proximité
*
* Arguments:
* unité tué 
*
* Return Value:
* nil
*
* Example:
* [Alpha1:1] call ODD_fnc_surrender
*
* Public:
*/
params [[_units], [_killer]];


if (side _killer == WEST ) then {	//si tué par blufort
	// distance de recherche
	_distSurrender = 20;
	_distBlue = 15;  
	_distRed = 30;

	_nearSurrender = position _unit nearEntities[["SoldierGB"], _distRed];   		//nb de soldat Red

	{
		_nearBlue = count (position _x nearEntities[["SoldierWB"], _distBlue]);  	//nb de soldat Blue
		_nearRed = count (position _x nearEntities[["SoldierGB"], _distRed]) - 1;   //nb de soldat Red (sauf lui)

		_seuil = (exp((_nearRed/3)-(2.5 + _nearBlue /2)))/1.5;  //calcule du seuil

		if ((random 1) < _seuil) then {  //si rdm < seuil
			if (vehicle _x != _x) then {
				{
					moveout _x; //débarque
					[_x, true, player] execVM "\z\ace\addons\captives\functions\fnc_setSurrendered.sqf";  //redition Ace
					_id = _x getVariable "ODD_var_SurrenderHandler";		//recupe l'ID de sont eventHandler
					_x removeEventHandler ["Killed", _id];					//remove l'eventHandler (pourra pas donné envie au autre de se rentre)
				} forEach crew vehicle _x;
			}
			else {
				[_x, true, player] execVM "\z\ace\addons\captives\functions\fnc_setSurrendered.sqf";  //redition Ace
				_id = _x getVariable "ODD_var_SurrenderHandler";		//recupe l'ID de sont eventHandler
				_x removeEventHandler ["Killed", _id];					//remove l'eventHandler (pourra pas donné envie au autre de se rentre)
			};

			//Ajout de eventHandler pour baisé la reputation civil

		};

	} forEach _nearSurrender;

};
