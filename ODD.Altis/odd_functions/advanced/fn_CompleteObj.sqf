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

params[["_state", True], ["_obj", objNull]];

sleep ((random 25) + 5);

if (_state) then {		// La tâche est accomplie ou non selon l'état
	["ODD_task_mission", "SUCCEEDED"] call BIS_fnc_tasksetState;
} else {
	["ODD_task_mission", "FAILED"] call BIS_fnc_tasksetState;
};

switch (ODD_var_SelectedMissionType) do {
	case (ODD_var_MissionType select 0): {		// L'objectif est de détruire des caisses
		[] call ODDadvanced_fnc_TrigCreateRtb;
	};
	case (ODD_var_MissionType select 1): {		// L'objectif est de tuer une HVT
		[] call ODDadvanced_fnc_TrigCreateRtb;
	};
	case (ODD_var_MissionType select 2): {		// L'objectif est de capturer une HVT
		if (_state) then {		// La tâche est accomplie ou non selon l'état
			[_obj] call ODDadvanced_fnc_TrigCreateExtract;
		} else {
			[] call ODDadvanced_fnc_TrigCreateRtb;
		};
	};
	case (ODD_var_MissionType select 3): {		// L'objectif est une zone à sécuriser
		[] call ODDadvanced_fnc_TrigCreateRtb;
	};
	case (ODD_var_MissionType select 4);
	case (ODD_var_MissionType select 5): {		// L'objectif sont des informations ou des boites noires
		[] call ODDadvanced_fnc_TrigCreateRtb;
	};
	case (ODD_var_MissionType select 6): {		// L'objectif est un prisonier
		if (_state) then {		// La tâche est accomplie ou non selon l'état
			[_obj] call ODDadvanced_fnc_TrigCreateExtract;
		} else {
			[] call ODDadvanced_fnc_TrigCreateRtb;
		};
	};
	case (ODD_var_MissionType select 7): {		// L'objectif est de sécuriser un véhicule
		if (_state) then {		// La tâche est accomplie ou non selon l'état
			[_obj] call ODDadvanced_fnc_TrigCreateExtract;
		} else {
			[] call ODDadvanced_fnc_TrigCreateRtb;
		};
	};
	case (ODD_var_MissionType select 8): {		// L'objectif est de détruire un véhicule
		[] call ODDadvanced_fnc_TrigCreateRtb;
	};
	case (ODD_var_MissionType select 9): {		// Mission de convoi d'un véhicule amie
		[] call ODDadvanced_fnc_TrigCreateRtb;
	};
};






