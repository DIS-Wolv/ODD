/*
	Auteur : Wolv
	Fonction permettant de compter les joueurs sur base + FOB
	Arguments :

	Valeur renvoyée :
	<INT>
	Exemple:
	[] call ODDcommon_fnc_CountOnBase
*/
params [["_rad", 50]];

private _nbPlayer = 0;
_nbPlayer = {(_x inArea [position fob, _rad, _rad, 0, False]) or (_x inArea [position base, _rad, _rad, 0, False])} count allPlayers;

private _headlessClients = {(_x inArea [position fob, _rad, _rad, 0, False]) or (_x inArea [position base, _rad, _rad, 0, False])} count (entities "HeadlessClient_F");
_nbPlayer = _nbPlayer - _headlessClients;

if (_nbPlayer <= 0) then {
	_nbPlayer = 0;
}; 

_nbPlayer;
