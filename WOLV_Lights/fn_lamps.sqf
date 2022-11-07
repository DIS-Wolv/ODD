/*	Document : Wolv_Lights\fn_lamps.sqf
 *	Fonction : execute les action sur les lamps
 *	Auteur : Wolv (discord : Wolv#2393) et Number42
 *	Argument : 
		- _center		:	Position du poteaux/générateur
		- _state		:	état souhaité 
		- _max_range	:	porté du poteaux/générateur
		- _speed		:	vitesse 
 
 *	Appellé par : scripts\lights\generators.sqf, scripts\lights\grandPoteaux.sqf, scripts\lights\moyenPoteaux.sqf, scripts\lights\petitPoteaux.sqf
 *	Apelle : 0/
 */
params["_center", "_state", "_max_range", "_speed"];

 private _l1 = [];
 private _l2 = [];
 private _switch = true;

if (_state <= 1) then {
	
	if (_state == 1) then {
		_switch = true;
	};
	if (_state == 0) then {
		_switch = false;
	};
	
	for "_r" from 0 to _max_range do {
		uiSleep (_speed);
		_l1 = nearestObjects[_center, WolvLights_var_lampsType, _r, true];
		_l2 = nearestObjects [_center, WolvLights_var_lampsType, _r + 1, true];
		private _lamps = _l2 - _l1;
		//private _lamps = nearestObjects[_center, WolvLights_var_lampsType, _r, true];
		//systemChat format["%1 lamps", _lamps];
		if ((count _lamps) != 0) then 
		{
			{
				[_x, _switch] remoteExecCall["BIS_fnc_switchLamp"];
			} forEach _lamps; 
		}
	};
};