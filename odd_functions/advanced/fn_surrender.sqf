/*
* Auteur : Wolv
* Fonction pour que certaines AIs se rendent
*
* Dans les zones de rayon definit en [1] (calculee en [2])
* S'il ce trouve quils sont plus de 10, personne ne se rend [3]
* Sinon, suivant le nombre d'IA, on applique la fonction :
*
*     chances = (NB_blue/3)/((NB_blue/3) + NB_red)    [4]
*
*  le bot doit avoir x chance de se rendre :
*  | NB_blue | NB_red | chances  	 |
*  | 0+      | 10+    | 0            |
*  | 9       | 10     | 3/13 = 0.23  |
*  | 3       | 10     | 1/11 = 0.09  |
*  | 9       | 1      | 3/4  = 0.75  |
*  | 18      | 1      | 6/7  = 0.86  |
*  | 3       | 1      | 1/2  = 0.50  |
*  | 1       | 1      | 1/4  = 0.25  |
*  | 1       | 6      |        0.05  |
*
* Au total entre 2 et 10 pax peuvent se rende [5].
* Arguments :
* 0: Unité qui vient de mourir <OBJ> 
* 1: Unité venant de tuer 0 <OBJ>
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [Alpha1:1] call ODDadvanced_fnc_surrender
*
* Variable publique :
*/
params ["_unit", "_killer"];

private _maxSurrender = 2;

// [1] Distance sur lesquelles on recherche
private _distSurrender = 20;
private _distBlue = 15;  
private _distRed = 30;

if (side _killer == WEST ) then {
	_pos = position _unit;

	_nearSurrender = [];

	{
		if (((_x distance2D _pos) <= _distRed) and (lifeState _x != 'INCAPACITATED') and !(captive _x)) then {
			_nearSurrender pushBack _x;
		};
	} forEach (units opfor);

	if (count _nearSurrender != 0) then {
		private _nbSurrender = 0;
		// [2] Calcul des nbs de :
		// BLUFOR
		_nearBlue = {((_x distance2D _pos) <= _distBlue) and (lifeState _x != 'INCAPACITATED') and !(captive _x)} count (units blufor);
		// OPFOR moins l'AI venant de décéder
		_nearRed = {((_x distance2D _pos) <= _distRed) and (lifeState _x != 'INCAPACITATED') and !(captive _x) and !(_x getVariable ['ace_captives_issurrendering', False])} count (units opfor);

		{
			if (
				(_nearRed > 10) // [3] plus de 10 = no surrender
				and
				(_nbSurrender <= ((_nearRed/5) min 10) max 2)  // [5] Max ennemis qui peuvent se rendre
				and
				((random 1) < (_nearBlue/3)/((_nearBlue/3) + _nearRed))  // [4] seuil
			) then {
				if (vehicle _x != _x) then {
					{
						moveout _x; // Débarquement du véhicule
						[_x, True, player] execVM "\z\ace\addons\captives\functions\fnc_setSurrendered.sqf";  // Redition Ace
						_id = _x getVariable "ODD_var_SurrenderHandler";		// Récupère l'ID de son eventHandler
						_x removeEventHandler ["Killed", _id];					// Pour empêcher que l'éxécution d'un prisonier crée plus de prisoniers
					} forEach crew vehicle _x;
				}
				else {
					[_x, True, player] execVM "\z\ace\addons\captives\functions\fnc_setSurrendered.sqf";  // Redition Ace
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
						params ["_target", "_caller", "_actionId", "_arguments"];
						[2, _target] remoteExec ["ODDadvanced_fnc_intel", 2];
						[(_this select 0)] remoteExec ["removeAllActions", 0, True];
					}, {}, [], 
					(random[2, 10, 15]), nil, True, False
				] remoteExec ["BIS_fnc_holdActionAdd", 0, True];

				// A FAIRE : eventHandler pour baisser la reputation civil lors de l'exécution d'un prisonnier

				_x addEventHandler ["Hit", {
					params ["_unit", "_source", "_damage", "_instigator"];
					if (((side _instigator) == WEST) and ((captive _unit) or (_unit getVariable ['ace_captives_issurrendering', False]))) then { 
						ODD_var_CivilianReputation = ODD_var_CivilianReputation - 1;
					};
				}];

				_nbSurrender = _nbSurrender + 1;
			};
			// sleep ((random 1) / 10);
		} forEach _nearSurrender;
	};
};
