/*
* Auteur : QuentinN42
* Fonction pour init les VLs
*
* Arguments :
* 0: Trigger <Obj>
*/

params ["_trigger"];

private _pad = _trigger getVariable ["trig_ODD_var_Pad", -1];

_pad setVariable ["trig_ODD_var_Vls", ["rhssaf_army_o_t72s"], true];
