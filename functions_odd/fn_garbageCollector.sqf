params ["_nbItt", ["_Debug", false]];

//["Test Garbage Coll"] remoteExec ["systemChat", 0];
if (_nbItt/30 == round ( _nbItt/30)) then {
	private _nbEle = 0;
	{				//garbage collector du cul
		if (count(units(group _x)) <= 1) then {
			if (count (position _x nearEntities[["SoldierWB"], 100]) == 0) then {	
				sleep 2;
				deleteVehicle _x;		//supprime le corps
				_nbEle = _nbEle + 1;
			};
		};
	} forEach alldead;			//pour chaque corps 
	if (_Debug) then {
		[Format["Nombre d'élement supprimé : %1", _nbEle]] remoteExec ["systemChat", 0];
	};
};

