/*
* Auteur : Wolv
* Fonction pour créer des barrages sur les routes
*
* Arguments :
* 0: Zone objectif <OBJ>
* 1: Nombre de barrages souhaités <INT>
* 2: 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [position player] call ODDadvanced_fnc_createOutpostAtPos
*/
params ["_pos", ["_flavors", []]];

systemChat format ["OUTPOST %1 %2", _pos, _flavors];
