/*
	Auteur : Wolv, Hhaine
	Fonction permettant de crée les triggers de RTB
	Arguments :

	Valeur renvoyée :
	<Null>
	Exemple:
	[] call ODDadvanced_fnc_TrigCreateRtb
*/
[["Creation des triggers de RTB"]] call ODDcommon_fnc_log;


ODD_var_TimeObj = servertime;
publicVariable "ODD_var_TimeObj";
[["Objectif Acomplie"]] call ODDcommon_fnc_log;
sleep(5);

if (ODD_var_CurrentMission == 1) then {
	[True, ["ODD_task_Extract", "ODD_task_main"], ["Rentrez à la base", "RTB", "RTB"], objNull, "ASSIGNED", 2, True, "move"] call BIS_fnc_taskCreate;
	// Crée la tâche de retour à la base
	sleep(1);
	Private _Trigger = [];

	Private _TrigFob = createTrigger ["EmptyDetector", fob, True];
	_TrigFob setTriggerArea [15, 15, 0, False, 2];
	_TrigFob setTriggerActivation ["ANYPLAYER", "PRESENT", True];
	_TrigFob setTriggerStatements ["this", "[True] call ODDadvanced_fnc_TrigWaitRtb","[False] call ODDadvanced_fnc_TrigWaitRtb"];
	_Trigger pushBack _TrigFob;

	Private _TrigBase = createTrigger ["EmptyDetector", base, True];
	_TrigBase setTriggerArea [20, 20, 0, False, 2];
	_TrigBase setTriggerActivation ["ANYPLAYER", "PRESENT", True];
	_TrigBase setTriggerStatements ["this", "[True] call ODDadvanced_fnc_TrigWaitRtb","[False] call ODDadvanced_fnc_TrigWaitRtb"];
	_Trigger pushBack _TrigBase;

	Private _TrigCount = createTrigger ["EmptyDetector", [100, 100], True];
	_TrigCount setTriggerStatements ["(Base getVariable ['ODD_var_CountActive', False]) && round (time %5) == 5", "[] call ODDadvanced_fnc_TrigOkRtb;",""];
	_Trigger pushBack _TrigCount;

	Base setVariable ["ODD_var_TrigRTB", _Trigger, True];

	[["Creation des triggers de RTB OK"]] call ODDcommon_fnc_log;
};