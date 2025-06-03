/*
* Auteur : Wolv
* Permet de créer un bateau sur le marker
*
* Arguments :
* 0 : OBJECT : marker
* 
* Valeur renvoyée :
* OBJECT : bateau
*
* Exemple:
* ["DIS_mrk_FOB_0"] call DISCommon_fnc_PosFob;
*
*/
params [["_pos", getpos BoatSpawn]];

private _nbBoat = count nearestObjects [_pos, ["rhsgref_hidf_rhib"], 25, True];
private _boat = nil;

if (_nbBoat > 3) 
then {
	systemChat "Trop de bateaux, \n eloignez les bateaux !";
	sleep 10;
	hintSilent "";
}
else {
	_boat = createVehicle ["rhsgref_hidf_rhib", _pos, [], 5, "CAN_COLLIDE"];
};

_boat;
