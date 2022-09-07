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
params ["_unit", "_killer"];


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
			
			[
				_x, 
				"<t color='#FF0000'>Interoger le prisonier</t>", 
				"\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa",
				"\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", 
				"(alive (_target)) and (_target distance _this < 3)", 
				"True",
				{
					//[(_this select 0), "PATH"] remoteExec ["disableAI", 2];
					// (_this select 0) disableAI "PATH"
				}, 
				{},
				{
					//[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
					// (_this select 0) enableAI "PATH";

					[] remoteExec ["ODD_fnc_intel", 2];
					[(_this select 0)] remoteExec ["removeAllActions"];
				}, {
					// (_this select 0) enableAI "PATH";
					//[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
				}, [], (random[2, 10, 15]), nil, True, False
			] remoteExec ["BIS_fnc_holdActionAdd"];

			//Ajout de eventHandler pour baisé la reputation civil

		};

	} forEach _nearSurrender;

};
