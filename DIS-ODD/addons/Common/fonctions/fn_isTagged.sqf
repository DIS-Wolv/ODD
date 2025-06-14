/*
* Auteur : Wolv 
* Fonction pour savoir si un objet est tagué
*
* Arguments :
* 0: object
* 1: (optionnel) distance de recherche (par défaut 10m)
*
* Valeur renvoyée :
* 0: booléen (true si l'objet est tagué, false sinon)
*
* Exemple:
* [_obj, 15] call ODDcommon_fnc_isTagged;
*
* Variable publique :
*/
params ["_object", ["_distance", 10]];

private _ObjNear = nearestObjects [_object, [], _distance];

private _isTagged = False;

if (_object getVariable ["ace_tagging_hasTag", false]) then {
	_isTagged = True;
} else {
	{

		if (((getObjectTextures _x) select 0 find "z\ace\addons\tagging\ui\tags") == 0) then {
			_isTagged = True;
		
		};

	} forEach _ObjNear;
};

_isTagged;
