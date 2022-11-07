/*
* Auteur : Wolv & Hhaine
* Fonction pour nettoyer la zone
*
* Arguments :
* 0: Joueur qui demande l'arret
*
* Valeur renvoyée :
* nil
*
* Exemple :
* 
*
* Variable publique :
*/
params["_units"];

_distance = 30;

_fnc_StopCivil = {
	params["_civil"];

	_civil setVariable ["odd_var_stopped", true, true];
	_civil disableAI "PATH";
	if ((floor random 3) == 0 ) then {
		_civieSurrenderSound = ["civSurrender1","civSurrender2","civSurrender3","civSurrender4"];
		_sound = getMissionPath "ODDSound\" + (selectRandom _civieSurrenderSound) + ".ogg";
		playSound3D [_sound, _civil, false, getPosASL _civil, 3, 1, 30];
	};
	[_civil, 31, false] remoteExec ["zen_modules_fnc_moduleAmbientAnimStart",2];

	_endAnim = serverTime + (30 + round (random 150));
	waitUntil{
		sleep 1;
		((serverTime >= _endAnim) or (captive _civil))
	};

	[_civil] remoteExec ["zen_modules_fnc_moduleAmbientAnimStart",2];

	sleep 5;
	_civil enableAI "PATH";
	
	_civil setVariable ["odd_var_stopped", false, true];
};

_pos = position _units;

_nearEntitie = _pos nearEntities _distance;
{
	if ((side _x) == civilian) then {

		if (!("odd_var_stopped" in (allVariables _x))) then {
			_x setVariable ["odd_var_stopped", false, true];
		};

		if ((false == (_x getVariable "odd_var_stopped")) and !(captive _x) and (lifeState _x != 'INCAPACITATED') ) then {
			[_x] spawn _fnc_StopCivil;
		};
	};
} forEach _nearEntitie;

 