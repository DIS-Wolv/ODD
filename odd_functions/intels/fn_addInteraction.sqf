/*
* Auteur : QuentinN42
* Fonction pour ajouter l'interaction d'interrogation sur un unité
*
* Example:

"C_man_p_fugitive_F" createUnit [position player, createGroup civilian, "myUnit = this"];
[myUnit] call ODDintels_fnc_addInteraction;

[_unit] call ODDintels_fnc_addInteraction;

{ [_x] call ODDintels_fnc_addInteraction; } forEach (units _grp);

*/

params ["_unit"];

[ _unit ] remoteExec ["ODDintels_fnc_addInteractionLocal", 0, True];
