/*
* Auteur : Wolv
* Fonction pour effectué 'un pas' dans la progression de la missions
*
* Arguments :
* 
* Valeur renvoyée :
*
* Exemple :
* 	[] call ODDCTI_fnc_progressMap
*
* Variable publique :
* 
*/

private _frontLineModifier = 1.3;

{
	private _tgtEni = _x getVariable ["ODD_var_OccTgtEni", 2];
	private _actEni = _x getVariable ["ODD_var_OccActEni", 0];

	private _nearloc = _x getVariable ["ODD_var_nearLocations", []];

	// si la zone est capturé par les bleus
	if (_actEni/_tgtEni < ODDCTI_var_capturePrc) then {
		_x setVariable ["ODD_var_isBlue", true];
		_x setVariable ["ODD_var_isFrontLine", true];
		{
			_x setVariable ["ODD_var_isFrontLine", true];
		} forEach _nearloc;
	}
	// si la zone est capturé par les rouges
	else {
		_x setVariable ["ODD_var_isBlue", false];
		_x setVariable ["ODD_var_isFrontLine", false];
		// on devrais recalculer les frontline 
	};


	// partie zone Rouge 
	if ((_x getVariable ["ODD_var_isBlue", false]) == false) then {
		_nearloc pushBack _x;

		// partie Infantrie
		// la zone peux recevoir / envoyer max 20% de ses effectifs max
		private _renfort = floor (_tgtEni * 0.2);
		_renfort = _renfort max 0;
		
		// si il y a des effectifs a envoyer
		while {_renfort > 0} do {
			// on calcule le prc de remplissage de la zone
			_actEni = _x getVariable ["ODD_var_OccActEni", 0];
			private _prc = _actEni / _tgtEni;
			// on détermine que par default la zone a renforcer est la zone elle même
			private _loc = _x;
			private _locNeedRenfort = _x;
			private _locNeedRenfortPrc = _prc;

			{
				// pour chaque zone a proximité
				// vérifie si la zone est pas capturé par les bleus
				private _locEni = _x getVariable ["ODD_var_OccActEni", 0];
				private _locTgt = _x getVariable ["ODD_var_OccTgtEni", 2];
				if ((_x getVariable ["ODD_var_isBlue", false] == false) and (_locEni/_locTgt > ODDCTI_var_capturePrc)) then {
					// si la zone est toujours sous controle ennemi
					
					// augmente le nombre de renfort a envoyer si c'est sur la ligne de front
					if (_x getVariable ["ODD_var_isFrontLine", false]) then {
						_locTgt = _locTgt * _frontLineModifier;
					};

					// on calcule le prc de remplissage de la zone
					private _locPrc = _locEni / _locTgt;

					// si la zone a plus besoin de renforts que les autres
					if ((_locNeedRenfortPrc > _locPrc)) then {
						// la défini comme zone a renforcer
						_locNeedRenfort = _x;
						_locNeedRenfortPrc = _locPrc;
					};
				}
				else {
					// si la zone est capturé par les bleus
					// variable pour la capture de la zone
					_x setVariable ["ODD_var_isBlue", true];
            		_loc setVariable ["ODD_var_isFrontLine", true];
				};
			} forEach _nearloc;
			
			// une fois que la zone a renforcer est déterminé on envoie un groupe
			private _locNeedRenfortEni = _locNeedRenfort getVariable ["ODD_var_OccActEni", 0];
			_locNeedRenfort setVariable ["ODD_var_OccActEni", _locNeedRenfortEni + 1];
			
			// on enlève le groupe de la zone d'origine
			_actEni = _x getVariable ["ODD_var_OccActEni", 0];
			_actEni = _actEni - 1;
			_x setVariable ["ODD_var_OccActEni", _actEni];
			// on décrémente le nombre de renfort a envoyer
			_renfort = _renfort - 1;
		};

		// partie Recrutement
		private _tgtEni = _x getVariable ["ODD_var_OccTgtEni", 2];
		private _actEni = _x getVariable ["ODD_var_OccActEni", 0];
		private _prcRecrut = _x getVariable ["ODD_var_OccPrcRecrut", 0];

		if ((_prcRecrut > 0) and (_x getVariable ["ODD_var_isBlue", false] == false) and (_actEni < _tgtEni)) then {
			// systemChat format ["%1 is a military location", text _x];
			_actEni = _actEni + round (_actEni * _prcRecrut) + 1;
			_x setVariable ["ODD_var_OccActEni", _actEni];
		};

		// partie Vehicule
		private _vehtgt = _x getVariable ["ODD_var_OccTgtEniVeh", 0];
		private _vehact = _x getVariable ["ODD_var_OccActEniVeh", []];
	}
	// partie zone Bleu
	else {
		// si la zone est capturé par les bleus	
		// la zone est considéré comme ligne de front
		_x setVariable ["ODD_var_isFrontLine", true];
		// les zones a proximité sont aussi considéré comme ligne de front
		{
			_x setVariable ["ODD_var_isFrontLine", true];
		}forEach _nearloc;

		// partie Infantrie
		// on récupère les effectifs de la zone
		private _actEni = _x getVariable ["ODD_var_OccActEni", 0];
		// tant qu'il reste des effectifs a envoyer
		while {_actEni > 0} do {
			// on détermine la zone a renforcer
			private _locNeedRenfort = _nearloc select 0;
			// on calcule le pourcentage de remplissage de la zone
			private _locNeedRenfortPrc = ((_nearloc select 0) getVariable ["ODD_var_OccActEni", 0]) / ((_nearloc select 0) getVariable ["ODD_var_OccTgtEni", 2]);
			{
				// pour chaque zone a proximité
				if (_x getVariable ["ODD_var_isBlue", false] == false) then {
					// si la zone est sous controle ennemi
					private _locEni = _x getVariable ["ODD_var_OccActEni", 0];
					private _locTgt = _x getVariable ["ODD_var_OccTgtEni", 2];
					// on calcule le pourcentage de remplissage de la zone
					private _locPrc = _locEni / _locTgt;
					// si la zone a plus besoin de renforts que les autres
					if ((_locNeedRenfortPrc > _locPrc)) then {
						// la défini comme zone a renforcer
						_locNeedRenfort = _x;
						_locNeedRenfortPrc = _locPrc;
					};
				};
			} forEach _nearloc;
			// on envoie un groupe de la zone a renforcer
			_locNeedRenfort setVariable ["ODD_var_OccActEni", (_locNeedRenfort getVariable ["ODD_var_OccActEni", 0]) + 1];
			// on enlève un groupe de la zone d'origine
			_actEni = _actEni - 1;
		};
		// on met a jour les effectifs de la zone
		_x setVariable ["ODD_var_OccActEni", _actEni];

		// partie Vehicule
	};
} forEach ODD_var_AllLocations;

// update des markers sur la carte
[ODD_var_CTIMarkerInfo] call ODDCTI_fnc_updateMap;

