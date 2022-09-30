/*
* Auteur : Wolv
* Script pour nettoyer la mission
* 
* Argument :
* 
* Valeur renvoyée :
* nil
*
*/

if (ODD_var_CurrentMission==1) then {
	[] remoteExec ["ODD_fnc_clearZO", 2];
};

sleep 0.5 

call compile preprocessFile "ODD_GUI\GUIODD_Mission\statut.sqf";