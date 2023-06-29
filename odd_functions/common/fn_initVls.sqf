/*
* Auteur : QuentinN42
* Fonction pour init les VLs
*
* Arguments :
* 0: Trigger <Obj>
*/

params ["_trigger"];

private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];

private _to_spawn = [];

// ajouter logique
_to_spawn pushBack "rhssaf_army_o_t72s";
_to_spawn pushBack "rhssaf_army_o_t72s";

_pad setVariable ["trig_ODD_var_VlsPool", _to_spawn, true];
_pad setVariable ["trig_ODD_var_VlsSpawned", [], true];
