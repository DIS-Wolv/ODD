/*
* Auteur : Hhaine
* Fonction qui trie les ARRAYS pour les intels
*
* Arguments :
* 0: type d'intel a trier <INT>
* 1: portée max des intels <NUMBER>
*
* Valeur renvoyée :
* <ARRAY>
*
* Exemple :
*
* Variable publique :
*/
params [,]

private _allIntels = [];
private _sortedIntels = [];
private _sortedWeights = [];

switch (/*ARGUMENT 0 */) do {
	case "value": {_allIntels = /*recup la variable ex : ODD_var_MedicalCrates */ };
	default { };
};

if (/*_allIntels pas juste [] */) then {
	_sortedIntels = [_allIntels, [getPos /*Le mec qu'on interroge */], {_input0 distance2D _x}, "ASCEND", {(_input0 distance2D _x) <= /*La portée max */}] call BIS_fnc_sortBy;
} else {
	/*Bah ca peut pas marcher */
};

/*Il faut conter les _sortedIntels pour créer une array sortedweights pour pouvoir utiliser BIS_fnc_selectRandomWeighted */
private _length = count(_sortedIntels)
if (_length > 0) then {
	for "_i" from 0 to _length do { 
		_sortedWeights set ["_i", /*some maths that give weights */]
	};
} else {
	/*Ca marchera pas */
};
_sortedIntels
