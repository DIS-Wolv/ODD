/*
	Auteur : Wolv
	Fonction permettant de mettre a jours la tache et préparé l'appel du rtb
	Arguments :
	0: Reussite ou échec de la missions <BOOL>

	Valeur renvoyée :
	<Null>
	Exemple:
	[] call ODDadvanced_fnc_CompleteObj
 */

params[["_state", True]];

sleep ((random 25) + 5);

if (_state) then {		// La tâche est accomplie ou non selon l'état
	["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState;
} else {
	["ODD_task_mission", "FAILED"] call BIS_fnc_tasksetState;
};

[] call ODDadvanced_fnc_TrigCreateRtb;



