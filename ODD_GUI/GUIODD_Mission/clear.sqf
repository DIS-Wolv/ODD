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
	[] remoteExec ["ODDadvanced_fnc_clearZO", 2];
};

sleep 0.5 

call compile preprocessFile "odd_gui\GUIODD_Mission\statut.sqf";