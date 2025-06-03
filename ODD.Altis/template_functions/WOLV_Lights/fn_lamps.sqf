/*	Document : Wolv_Lights\fn_lamps.sqf
 *	Fonction : execute les action sur les lamps
 *	Auteur : Wolv (discord : Wolv#2393) et Number42
 *	Argument : 
		- _center		:	Position du poteaux/générateur
		- _state		:	état souhaité 
		- _max_range	:	porté du poteaux/générateur
		- _speed		:	vitesse 
 */
params["_center", "_state", "_max_range", "_speed"];

 private _l1 = [];
 private _l2 = [];
 private _switch = True;

if (_state <= 1) then {
	
	if (_state == 1) then {
		_switch = True;
	};
	if (_state == 0) then {
		_switch = False;
	};
	
	for "_r" from 0 to _max_range do {
		uiSleep (_speed);
		_l1 = nearestObjects[_center, WolvLights_var_lampsType, _r, True];
		_l2 = nearestObjects [_center, WolvLights_var_lampsType, _r + 1, True];
		private _lamps = _l2 - _l1;
		//private _lamps = nearestObjects[_center, WolvLights_var_lampsType, _r, True];
		//systemChat format["%1 lamps", _lamps];
		if ((count _lamps) != 0) then 
		{
			{
				[_x, _switch] remoteExecCall["BIS_fnc_switchLamp", 0, True];
			} forEach _lamps; 
		}
	};
};