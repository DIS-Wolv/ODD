/*
* Auteur : QuentinN42
* Fonction pour init les VLs
*
* Vas choisir des vehicules aleatoirement dans les 3 listes :
* - ODD_var_Vehicles
* - ODD_var_HeavyVehicles
* - ODD_var_TransportVehicles
*
* Arguments :
* 0: Trigger <Obj>
*/

private _r = {
	// renvoit 1 ou 0 avec proba _r
	params ["_tr"];
	private _val = random 1;
	if (_val < _tr) then {1} else {0};
};

params ["_trigger"];

private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];
private _loc = _pad getVariable ["trig_ODD_var_loc", nil];
if (isNil "_loc") exitWith {systemChat "Erreur : Pas de location pour le pad";};

// Le nb de vehicules par type
private _Vehicles = 0;
private _HeavyVehicles = 0;
private _TransportVehicles = 0;

if (type _loc == 'NameCityCapital') then {
	_Vehicles = 2;
	_HeavyVehicles = 1;
	_TransportVehicles = 1;
};
if (type _loc == 'NameCity') then {
	_Vehicles = 1 + ([2/3] call _r);
	_HeavyVehicles = [1/2] call _r;
	_TransportVehicles = [1/2] call _r;
};
if (type _loc == 'NameVillage') then {
	_Vehicles = 1 + ([1/3] call _r);
	_HeavyVehicles = [1/3] call _r;
	_TransportVehicles = [1/3] call _r;
};
if (type _loc == 'Name') then {
	_Vehicles = [2/3] call _r;
	_HeavyVehicles = [1/3] call _r;
};
if (type _loc == 'NameLocal') then {
	_Vehicles = [2/3] call _r;
	_TransportVehicles = [1/3] call _r;
};
if (type _loc == 'Hill') then {
	_Vehicles = [1/4] call _r;
	_TransportVehicles = [1/5] call _r;
};

private _to_spawn = [];

for "_i" from 1 to _Vehicles do {
	_to_spawn pushBack ((selectRandom ODD_var_Vehicles) select 0);
};
for "_i" from 1 to _HeavyVehicles do {
	_to_spawn pushBack ((selectRandom ODD_var_HeavyVehicles) select 0);
};
for "_i" from 1 to _TransportVehicles do {
	_to_spawn pushBack ((selectRandom ODD_var_TransportVehicles) select 0);
};

_pad setVariable ["trig_ODD_var_VlsPool", _to_spawn, true];
_pad setVariable ["trig_ODD_var_VlsSpawned", [], true];
