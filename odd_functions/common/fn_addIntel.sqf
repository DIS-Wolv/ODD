
/*
 * [((units _g)select 0)] call ODDcommon_fnc_addIntel;
 */
params ["_unit"];
[
	_unit, 
	"<t color='#FF0000'>interoger le civil</t>", 
	"\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa",
	"\A3\Ui_f\data\IGUI\Cfg\actions\talk_ca.paa", 
	"(alive (_target)) and (_target distance _this < 3) and (lifeState _target != 'INCAPACITATED')", 
	"True",
	{
		[(_this select 0), "PATH"] remoteExec ["disableAI", 2];
		// (_this select 0) disableAI "PATH"
	}, 
	{},
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
		// (_this select 0) enableAI "PATH";
		
		[1, _target] remoteExec ["ODDAdvanced_fnc_intel", 2];
		[(_this select 0)] remoteExec ["removeAllActions", 0, True];
	}, {
		// (_this select 0) enableAI "PATH";
		[(_this select 0), "PATH"] remoteExec ["enableAI", 2];
	}, [], (random[2, 5, 10]), nil, True, False
] remoteExec ["BIS_fnc_holdActionAdd", 0, True];
