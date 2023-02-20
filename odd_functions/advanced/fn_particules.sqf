/*
* Auteur : Wolv
* Fonction pour créer les colonnes de fumées LOCALEMENT
*
* Arguments :
* 0: Est-on en mode ajout (True) ou suppression (False) <BOOL> 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [_pos] remoteExec ["ODDadvanced_fnc_particules", 0]
* [_pos, False] remoteExec ["ODDadvanced_fnc_particules", 0];
*
* Variable publique :
*/

params[["_add", True]];

_localID = clientOwner;
[_localID] remoteExec ["publicVariable 'ODD_var_MissionSmokePillar';", 0];

if (!isNil 'ODD_var_MissionSmokePillar') then {
	if (_add) then {
		if (isNil 'LocalParticuleList') then {
			LocalParticuleList = [];
		};

		if ((count ODD_var_MissionSmokePillar) != 0) then {
			{
				// systemChat str _x;
				_pos = _x;
				private _ps1 = "#particlesource" createVehicleLocal _pos; 
				_ps1 setParticleParams [ 
					["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 7, 1], "", "Billboard", 
					1, 10, [0, 0, 0.5], [0, 0, 2.9], 1, 1.275, 1, 0.066, [4, 5, 10, 10], 
					[[0.3, 0.3, 0.3, 0.33], [0.4, 0.4, 0.4, 0.33], [0.2, 0.2, 0, 0]], 
					[0, 1], 1, 0, "", "", _ps1]; 
				_ps1 setParticleRandom [0, [0, 0, 0], [0.33, 0.33, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.05], 0, 0]; 
				_ps1 setDropInterval 0.5;
				LocalParticuleList pushBack _ps1;

				private _ps2 = "#particlesource" createVehicleLocal _pos; 
				_ps2 setParticleParams [ 
					["\A3\Data_F\ParticleEffects\Universal\Universal", 16, 9, 1], "", "Billboard", 
					1, 15, [0, 0, 0.5], [0, 0, 2.9], 1, 1.275, 1, 0.066, [4, 5, 10, 10], 
					[[0.1, 0.1, 0.1, 0.75], [0.4, 0.4, 0.4, 0.5], [1, 1, 1, 0.2]], 
					[0], 1, 0, "", "", _ps2]; 
				_ps2 setParticleRandom [0, [0, 0, 0], [0.5, 0.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.05], 0, 0]; 
				_ps2 setDropInterval 0.25;

				LocalParticuleList pushBack _ps2;
			// La colonne de fumée est en deux partie une fumée grise (_ps1) et une fumée noire (_ps2)
			} forEach ODD_var_MissionSmokePillar;
		};
	}
	else {
		if (!isNil 'LocalParticuleList') then {
			{
				deleteVehicle _x;
			} forEach LocalParticuleList;
		};
	};

};

