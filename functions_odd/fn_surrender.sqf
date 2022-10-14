/*
* Auteur : Wolv
* Fonction pour que certaines AIs se rendent
*
* Arguments :
* 0: Unité qui vient de mourir <OBJ> 
* 1: Unité venant de tuer 0 <OBJ>
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [Alpha1:1] call ODD_fnc_surrender
*
* Variable publique :
*/
params ["_unit", "_killer"];

if (side _killer == WEST ) then {	
	// Si L'IA a été tuée par un BLUFOR
	_distSurrender = 20;
	_distBlue = 15;  
	_distRed = 30;
	// Distance sur lesquelles on recherche 
	_pos = position _unit;

	_nearSurrender = {((_x distance2D _pos) <= _distRed) and (lifeState _x != 'INCAPACITATED') and !(captive _x)} count (units opfor);
	// Nombre d' OPFOR
	if (count _nearSurrender != 0) then {
		{
			_nearBlue = {((_x distance2D _pos) <= _distBlue) and (lifeState _x != 'INCAPACITATED') and !(captive _x)} count (units blufor);
			// Nombre de BLUFOR
			_nearRed = {((_x distance2D _pos) <= _distRed) and (lifeState _x != 'INCAPACITATED') and !(captive _x)} count (units opfor);
			// Nombre d' OPFOR moins l'AI venant de décéder

			_seuil = (exp((_nearRed/3)-(2.5 + _nearBlue /2)))/1.5; 
			// Calcul du seuil

			if ((random 1) < _seuil) then {  
				if (vehicle _x != _x) then {
					{
						moveout _x; // Débarquement du véhicule
						[_x, true, player] execVM "\z\ace\addons\captives\functions\fnc_setSurrendered.sqf";  // Redition Ace
						_id = _x getVariable "ODD_var_SurrenderHandler";		// Récupère l'ID de son eventHandler
						_x removeEventHandler ["Killed", _id];					// Pour empêcher que l'éxécution d'un prisonier crée plus de prisoniers
					} forEach crew vehicle _x;
				}
				else {
					[_x, true, player] execVM "\z\ace\addons\captives\functions\fnc_setSurrendered.sqf";  // Redition Ace
					_id = _x getVariable "ODD_var_SurrenderHandler";		// Récupère l'ID de son eventHandler
					_x removeEventHandler ["Killed", _id];					// Pour empêcher que l'éxécution d'un prisonier crée plus de prisoniers
				};
				
				[
					_x, 
					"<t color='#FF0000'>Interoger le prisonier</t>", 
					"\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa",
					"\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", 
					"(alive (_target)) and (_target distance _this < 3) and (lifeState _target != 'INCAPACITATED')", 
					"True",
					{},	{},
					{

						[2] remoteExec ["ODD_fnc_intel", 2];
						[(_this select 0)] remoteExec ["removeAllActions"];
					}, {}, [], 
					(random[2, 10, 15]), nil, True, False
				] remoteExec ["BIS_fnc_holdActionAdd"];

				// A FAIRE : eventHandler pour baisser la reputation civil lors de l'exécution d'un prisonnier

			};
			sleep ((random 1) / 10);
		} forEach _nearSurrender;
	};
};
