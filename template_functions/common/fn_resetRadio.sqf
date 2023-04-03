


params ["_unit"];

_radio = (assignedItems _unit) select 3;
_channel = player getVariable "tfar_freq_sr";

_unit unassignItem _radio;
_unit removeItem _radio;

sleep 0.5;

//player setVariable["tfar_freq_sr", _channel, True];
_unit linkItem "TFAR_anprc152";


