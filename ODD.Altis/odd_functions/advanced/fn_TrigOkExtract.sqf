/*
	Auteur : Wolv, Hhaine
	Fonction permettant de nettoyer la mission une fois que tout le monde est sur base
	Arguments :

	Valeur renvoyée :
	<INT>
	Exemple:
	[] call ODDadvanced_fnc_TrigOkExtract
*/
params [["_obj", objNull]];
private _headlessClients = count (entities "HeadlessClient_F");
private _humanPlayers = count (allPlayers) - _headlessClients;

private _playercheck = [] call ODDcommon_fnc_CountOnBase;
// systemChat format["%1 | %2", _playercheck, _humanPlayers];

if (_playercheck >= _humanPlayers) then {
	_trig = Base getVariable ["ODD_var_TrigRTB", False];
	{
		deleteVehicle _x;
	} forEach _trig;
	Base setVariable ["ODD_var_TrigRTB", [], True];
	if (ODD_var_CurrentMission == 1) then {
		["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState;
		// La tâche est accomplie
		
		ODD_var_TimeEnd = servertime;
		publicVariable "ODD_var_TimeEnd";
		
		// Nettoie la mission
		[] spawn ODDadvanced_fnc_clearZO;
	};
};

