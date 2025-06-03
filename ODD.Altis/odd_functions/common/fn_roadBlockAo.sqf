/*
* Auteur : Wolv
*
* Arguments :
* 0: position de la route
* 1: Direction de la route
* 2: Structure du Road Block
*
* Valeur renvoyée :
* [<props du Road Block>, <props cacher>]
*
* Exemple:
* [_pos, _roadDir, _structure] call ODDcommon_fnc_roadBlockAo
*
*/

params ["_roadPos", "_roadDir", "_structure"];

_props = [_roadPos, _roadDir, _structure] call BIS_fnc_objectsMapper;

_aCacher = [];
{
	_closeProps = nearestTerrainObjects [position _x, [], 10];
	// Récupère les objets proximité de la position voulue pour le barrage
	
	_closeProps = _closeProps - _aCacher;
	_closeProps = _closeProps - _props;	
	
	_aCacher = _aCacher + _closeProps;
	// Défini les objets à cacher sur la position pour acceuillir le checkpoint 
}forEach _props;

{
	ODD_var_HiddenObjects pushBack _x;
	_x hideObjectGlobal True;
}forEach _aCacher;

[_props, _aCacher];
