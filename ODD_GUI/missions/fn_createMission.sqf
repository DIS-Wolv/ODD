[] call OddGuiMissions_fnc_missionPrep;

private _missionParams = ODDGUIMissions_var_SelectedParams;

[_missionParams select 0,_missionParams select 1,True,_missionParams select 2] remoteExec ["ODDadvanced_fnc_missions", 2];
// type de mission, Zone d'opération, ZO+ ou non, faction