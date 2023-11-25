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
*
* Variable publique :
*/
params [["_type",0], ["_center",[15000,15000,0]], ["_maxRange",1500]];

private _allIntels = [];
private _sortedIntels = [];
private _sortedWeights = [];
private _intelPos = [0,0,0];

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

if (count(_allIntels) > 0) then {
	[_allIntels, [_center, _maxRange], {_input0 distance2D _x}, "ASCEND", {(_input0 distance2D _x) <= _input1}] call BIS_fnc_sortBy;
	_sortedIntels = _allIntels;
} else {
	[["ERROR fn_sortIntel : _allIntels = []"]] call ODDcommon_fnc_log;
};

/*Il faut conter les _sortedIntels pour créer une array sortedweights pour pouvoir utiliser BIS_fnc_selectRandomWeighted */
private _length = count(_sortedIntels);
if (_length > 0) then {
	{
		_sortedWeights set [_forEachIndex, ((_length - _forEachIndex)/ _length)];
	} forEach _sortedIntels;
};

private _intel = _sortedIntels selectRandomWeighted _sortedWeights;

private _posIntel = position _intel;

_posIntel;
