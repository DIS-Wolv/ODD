/*
* Auteur : QuentinN42
* Fonction pour init les VLs
*
* Vas choisir des vehicules aleatoirement dans les 2 listes :
* - ODD_var_SpawnableVehicles
* - ODD_var_SpawnableHeavyVehicles
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
private _SpawnableVehicles = 0;
private _SpawnableHeavyVehicles = 0;

// Pour 9 joureurs, on genere les vehicules suivant :
if (type _loc == 'NameCityCapital') then {
	_SpawnableHeavyVehicles = [1/2] call _r;
	_SpawnableVehicles = selectRandom [2, 2, 3, 3, 4];
};
if (type _loc == 'NameCity') then {
	_SpawnableVehicles = 1 + ([1/2] call _r) + ([1/2] call _r) + ([1/2] call _r);
};
if (type _loc == 'NameVillage') then {
	_SpawnableVehicles = 1 + ([1/2] call _r);
};
if (type _loc == 'Name') then {
	_SpawnableVehicles = 1 + ([1/3] call _r);
};
if (type _loc == 'NameLocal') then {
	_SpawnableVehicles = ([2/3] call _r) + ([1/3] call _r);
};
if (type _loc == 'Hill') then {
	_SpawnableVehicles = ([1/4] call _r) + ([1/5] call _r);
};

// si le nombre de joueurs != 9, on modifie le nombre de vehicules
private _human_players = count(allPlayers - entities "HeadlessClient_F"); // removing Headless Clients
// on calcule le ratio de spawn en fonction du nombre de joueurs
private _scaling_ratio = _human_players / 9;
// Puis on applique le ratio (pour la partie a virgule, on prend de maniere aleatoire)
// Example : 6 joueurs et 2 vehicules, 2*6/9 = 1.33, on va donc avoir 1 vehicule [+ 1 avec 33%]
_SpawnableVehicles = floor(_SpawnableVehicles * _scaling_ratio) + ([_SpawnableVehicles * _scaling_ratio - floor(_SpawnableVehicles * _scaling_ratio)] call _r);

private _to_spawn = [];

for "_i" from 1 to _SpawnableVehicles do {
	_to_spawn pushBack ((selectRandom ODD_var_SpawnableVehicles) select 0);
};
for "_i" from 1 to _SpawnableHeavyVehicles do {
	_to_spawn pushBack ((selectRandom ODD_var_SpawnableHeavyVehicles) select 0);
};

_pad setVariable ["trig_ODD_var_VlsPool", _to_spawn, true];
_pad setVariable ["trig_ODD_var_VlsSpawned", [], true];
