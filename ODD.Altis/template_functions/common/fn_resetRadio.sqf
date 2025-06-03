/*
* Auteur : Wolv
* change la radio
*
* Arguments :
* 0: player
*
* Valeur renvoyée :
* nil
*
* Exemple:
* [player] call DISCommon_fnc_resetRadio
*
* Variable publique :
*/
params ["_unit"];

// bugé ?

_radio = (assignedItems _unit) select 3;
_channel = player getVariable "tfar_freq_sr";

_unit unassignItem _radio;
_unit removeItem _radio;

sleep 0.5;

//player setVariable["tfar_freq_sr", _channel, True];
_unit linkItem "TFAR_anprc152";


