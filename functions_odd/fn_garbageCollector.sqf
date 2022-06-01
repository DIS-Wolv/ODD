params ["_nbItt"];

//["Test Garbage Coll"] remoteExec ["systemChat", 0];

if (_nbItt/30 == round ( _nbItt/30)) then {
	{				//garbage collector du cul
		if (count(units(group _x)) <= 1) then {	
			sleep 2;
			deleteVehicle _x;		//supprime le corps
		};
	} forEach alldead;			//pour chaque corps 
};

