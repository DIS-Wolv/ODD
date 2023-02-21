/*
* Auteur : Wolv
* Fonction pour faire sortir les AIs de leur garnison sous certaines conditions
*
* Arguments :
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODDadvanced_fnc_sortieGarnison
* [True] call ODDadvanced_fnc_sortieGarnison
*
* Variable publique :
*/
params [];

{
	if (count (units _x) > 2) then {
		//s'il reste plus de deux unités dans le groupe 
		if (count(getpos ((units _x) select 0) nearEntities[["SoldierWB"], 40]) > 0) then { 
			// s'il y a au moins un joueur à moins de 40 m
			if (floor(random 20) == 0) then {
				[["TAIO"]] call ODDcommon_fnc_log;
				[units _x] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf"; 
				_x setVariable ["ODD_var_IsInGarnison", False, True];
				// Avec 5% de chance, les AIs quittent leur garnison
			};
		};
	}
	else {
		if (count(getpos ((units _x) select 0) nearEntities[["SoldierWB"], 10]) > 0) then { 
			// s'il y a au moins un joueur à moins de 10 m
			if (floor(random 5) <= 1) then {	//40 % de chance
				[["TAIO"]] call ODDcommon_fnc_log;
				[units _x] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf"; 
				_x setVariable ["ODD_var_IsInGarnison", False, True];
				// Avec 40% de chance, les AIs quittent leur garnison
			};
		};
	};
}forEach ODD_var_GarnisonnedIA;
