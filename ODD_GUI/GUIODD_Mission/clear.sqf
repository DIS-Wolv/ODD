/*
* Author: Wolv
* Script permetant de clear la mission
* 
* Argument :
* 
* Return Value:
* nil
*
*/

if (ODD_var_CurrentMission==1) then {
	[] remoteExec ["ODD_fnc_clearZO", 2];
};