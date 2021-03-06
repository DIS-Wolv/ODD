/*
* Author: Wolv
* Fonction permetant de faire sortir de garnison sous certaine condition 
*
* Arguments:
* 0: Activation du debug dans le chat <BOOL>
*
* Return Value:
* nil
*
* Example:
* [] call WOLV_fnc_sortieGarnison
* [true] call WOLV_fnc_sortieGarnison
*
* Public:
*/
params [["_Debug", false]];
//["Test Sortie Garnison"] remoteExec ["systemChat", 0];

{
	if (count (units _x) > 2) then {		//si il reste + de 2 units dans le groupe 
		if (count(getpos ((units _x) select 0) nearEntities[["SoldierWB"], 40]) > 0) then { // si au moins 1 blue a moins de 40 m
			if(floor(random 20) == 0) then {	//5 % de chance
				if (_Debug) then {
					["TAIO"] remoteExec ["systemChat", 0];
				};
				[units _x] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf"; // sortir de la garnison
				// { _x enableAI "PATH"; } forEach (units _g);
			};
		};
	}
	else {
		if (count(getpos ((units _x) select 0) nearEntities[["SoldierWB"], 10]) > 0) then { // si au moins 1 blue a moins de 10 m
			if(floor(random 5) <= 1) then {	//40 % de chance
				if (_Debug) then {
					["TAIO"] remoteExec ["systemChat", 0];
				};
				[units _x] execVM "\z\ace\addons\ai\functions\fnc_unGarrison.sqf"; // sortir de la garnison
				// { _x enableAI "PATH"; } forEach (units _g);
			};
		};
	};
}forEach GarnisonIA;
