/*
* Author: Wolv
* Fonction permetant de supprimer le vehicule le plus proche de la position passe en argument
*
* Arguments:
* 0: Zone souhaité <Obj>
* 1: Es ce la zone principale <BOOL>
* 2: Activation du debug dans le chat <BOOL>
*
* Return Value:
* nil
*
* Example:
* [_zo] call WOLV_fnc_civil
* [_zo, true, false] call WOLV_fnc_civil
*
*/
params [["_pos", [0,0,0]]];

_list = nearestObjects  [_pos, ["car","tank","plane","ship", "helicopter"], 100];
systemChat str count _list;

deleteVehicle (_list select 0); //delete le plus proche

/*
{
	deleteVehicle _x;
} forEach _list;
//*/