/*	Document : scripts\lights\lamps.sqf
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
_lampsType = [
    "Land_LampAirport_off_F", 
    "Land_LampAirport_F", 
    "Land_LampDecor_off_F",
    "Land_LampDecor_F",
    "Land_LampHalogen_off_F",
    "Land_LampHalogen_F",
    "Land_LampHarbour_off_F",
    "Land_LampHarbour_F",
    "Land_LampShabby_off_F",
    "Land_LampShabby_F",
    "Land_LampSolar_off_F",
    "Land_LampSolar_F",
    "Land_LampStadium_F",
    "Land_LampStreet_off_F",
    "Land_LampStreet_F",
    "Land_LampStreet_small_off_F",
    "Land_LampStreet_small_F",
    "Land_PowerPoleWooden_L_off_F",
    "Land_PowerPoleWooden_L_F",
    "Land_PowerLine_01_pole_lamp_F",
    "Land_PowerLine_01_pole_lamp_off_F",
    "Land_fs_roof_F",
	//DLC contact
		"Land_LampStreet_02_F", 
		"Land_LampStreet_02_off_F", 
		"Land_LampStreet_02_triple_F", 
		"Land_LampStreet_02_triple_off_F", 
		"Land_LampStreet_02_amplion_F",
		"Land_LampStreet_02_amplion_off_F",
		"Land_LampStreet_02_double_F",
		"Land_LampStreet_02_double_off_F",
		"Land_LampIndustrial_02_F",
		"Land_LampIndustrial_02_off_F",
		"Land_LampIndustrial_01_F",
		"Land_LampIndustrial_01_off_F",
		"Land_PowerLine_02_pole_small_lamp_off_F",
		"Land_PowerLine_02_pole_small_lamp_F"
]; //liste des lamps

 private _l1 = [];
 private _l2 = [];
 private _switch = true;

_center = param[0];
_state = param[1];
_max_range = param[2];
_speed = param[3];

if (_state <= 1) then {
	
	if (_state == 1) then {
		_switch = true;
	};
	if (_state == 0) then {
		_switch = false;
	};
	
	for "_r" from 0 to _max_range do {
		uiSleep (_speed);
		_l1 = nearestObjects[_center, _lampsType, _r, true];
		_l2 = nearestObjects [_center, _lampsType, _r + 1, true];
		private _lamps = _l2 - _l1;
		//private _lamps = nearestObjects[_center, _lampsType, _r, true];
		//systemChat format["%1 lamps", _lamps];
		if ((count _lamps) != 0) then 
		{
			{
				[_x, _switch] remoteExecCall["BIS_fnc_switchLamp"];
			} forEach _lamps; 
		}
	};
};