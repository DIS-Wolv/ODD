/*
* Auteur : Hhaine
* Fonction qui trie les ARRAYS pour les intels
*
* Arguments :
* 0: type d'intel a trier <INT>
* 1: position centrale
* 2: portée max des intels <NUMBER>
*
* Valeur renvoyée :
* <ARRAY>
*
* Exemple :
* ["MedicalCratePos", position player, 2000] call ODDcommon_fnc_sortintels;
*
* Variable publique :
*/
params [["_type",0], ["_center",[15000,15000,0]], ["_maxRange",1500]];

private _allIntels = [];

switch (_type) do {
	case (ODD_var_IntelType select 5): {
		clientOwner publicVariableClient "ODD_var_Crates";
		_allIntels = ODD_var_Crates; 
		};
	case (ODD_var_IntelType select 4): {
		clientOwner publicVariableClient "ODD_var_IAVehicles";
		_allIntels = ODD_var_IAVehicles;
		};
	case (ODD_var_IntelType select 3):  {
		clientOwner publicVariableClient "ODD_var_MissionCheckPoint";
		_allIntels = ODD_var_MissionCheckPoint;
		};
	case (ODD_var_IntelType select 2):  {
		clientOwner publicVariableClient "ODD_var_MissionIED";
		_allIntels = ODD_var_MissionIED;
		};
	case (ODD_var_IntelType select 1):  {
		clientOwner publicVariableClient "ODD_var_MissionCivilianVehicles";
		_allIntels = ODD_var_MissionCivilianVehicles;
		};
	case (ODD_var_IntelType select 0):  {
		clientOwner publicVariableClient "ODD_var_SelectedMissionType";
		clientOwner publicVariableClient "ODD_var_Objective";
		if (ODD_var_SelectedMissionType == (ODD_var_MissionType select 2)) then {
				{
					_allIntels append [(selectRandom (units _x))];
					
				} forEach ODD_var_Objective;
			}
			else {
				_allIntels = [ODD_var_Objective select 0];
			};
		};
	default { };
};

private _only_in_range = _allIntels select {(_center distance2D _x) <= _maxRange};
private _to_sort = _only_in_range apply {[_center distance2D _x, _x]};
_to_sort sort true;
private _sortedIntels = _to_sort apply {_x select 1};

// Poid decroissant avec la distance
private _sortedWeights = _sortedIntels apply { 1/(_center distance2D _x) };

private _intel = _sortedIntels selectRandomWeighted _sortedWeights;

private _posIntel = position _intel;

_posIntel
