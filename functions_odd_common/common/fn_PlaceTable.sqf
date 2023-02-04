/*
* Auteur : Wolv
*
* Arguments :
* 0: Batiment
*
* Valeur renvoyée :
* table créé
*
* Exemple:
* [_bat] call ODDcommon_fnc_placeTable
*
*/

params ["_bat"];

if (isnil "ODDdata_var_tableBuildType") then {
	[] call ODDdata_fnc_Table;
};

private _posh = getpos _bat;
private _dirh = getdir _bat;

_typebat = typeOf _bat;
_index = ODDdata_var_tableBuildType find _typebat;

_table = selectrandom ((ODDdata_var_table select _index) select 1);

private _dirt = _table select 1; 
private _dirht = _table select 2;
private _disht = _table select 3;
private _altt = _table select 4;

private _ndirt = _dirt + _dirh;
private _npost = _bat getPos [_disht, (_dirht + _dirh)];
_npost set [2, ((_posh select 2) + _altt + 0.2)];


_t = createVehicle [(_table select 0), _npost, [], 0, "CAN_COLLIDE"];
_t setDir _ndirt;

_t;

