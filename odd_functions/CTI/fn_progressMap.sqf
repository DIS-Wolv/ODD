/*
* Auteur : Wolv
* Fonction pour effectué 'un pas' dans la progression de la missions
*
* Arguments :
* 
* Valeur renvoyée :
*
* Exemple :
* 
*
* Variable publique :
* 
*/

private _frontLineModifier = 1.3;

{
	private _tgtEni = _x getVariable ["ODD_var_tgtEni", 2];
	private _actEni = _x getVariable ["ODD_var_actEni", 0];

	private _nearloc = _x getVariable ["ODD_var_nearLocations", []];

	// dans l'idée devrait etre remplacer par un trigger sur la zone
	if (_actEni/_tgtEni < ODDCTI_var_capturePrc) then {
		_x setVariable ["ODD_var_isBlue", true];
		_x setVariable ["ODD_var_isFrontLine", true];
		{
			_x setVariable ["ODD_var_isFrontLine", true];
		}forEach _nearloc;
	};

	if ((_x getVariable ["ODD_var_isBlue", false]) == false) then {
		_nearloc pushBack _x;

		// partie Infantrie
		private _renfort = floor (_actEni * 0.2);
		_renfort = _renfort max 0;

		while {_renfort > 0} do {
			_actEni = _x getVariable ["ODD_var_actEni", 0];
			private _prc = _actEni / _tgtEni;
			private _loc = _x;
			private _locNeedRenfort = _x;
			private _locNeedRenfortPrc = _prc;

			{
				private _locEni = _x getVariable ["ODD_var_actEni", 0];
				private _locTgt = _x getVariable ["ODD_var_tgtEni", 2];
				if ((_x getVariable ["ODD_var_isBlue", false] == false) and (_locEni/_locTgt > ODDCTI_var_capturePrc)) then {

					if (_x getVariable ["ODD_var_isFrontLine", false]) then {
						_locTgt = _locTgt * _frontLineModifier;
					};

					private _locPrc = _locEni / _locTgt;
					if ((_locNeedRenfortPrc > _locPrc)) then {
						_locNeedRenfort = _x;
						_locNeedRenfortPrc = _locPrc;
					};
				}
				else {
					_x setVariable ["ODD_var_isBlue", true];
            		_loc setVariable ["ODD_var_isFrontLine", true];
				};
			} forEach _nearloc;

			private _locNeedRenfortEni = _locNeedRenfort getVariable ["ODD_var_actEni", 0];
			_locNeedRenfort setVariable ["ODD_var_actEni", _locNeedRenfortEni + 1];

			_actEni = _x getVariable ["ODD_var_actEni", 0];
			_renfort = _renfort - 1;
			_actEni = _actEni - 1;
			_x setVariable ["ODD_var_actEni", _actEni];

		};


		private _isFrontLine = false;
		{
			if (_x getVariable ["ODD_var_isBlue", false]) then {
				_isFrontLine = true;
			};
		} forEach _nearloc;
		_x setVariable ["ODD_var_isFrontLine", _isFrontLine];

		private _tgtEni = _x getVariable ["ODD_var_tgtEni", 2];
		private _actEni = _x getVariable ["ODD_var_actEni", 0];
		private _prcRecrut = _x getVariable ["ODD_var_prcRecrut", 0];

		if ((_prcRecrut > 0) and (_x getVariable ["ODD_var_isBlue", false] == false) and (_actEni < _tgtEni)) then {
			// systemChat format ["%1 is a military location", text _x];
			_actEni = _actEni + round (_actEni * _prcRecrut) + 1;
			_x setVariable ["ODD_var_actEni", _actEni];
		};

		// partie Vehicule
		private _vehtgt = _x getVariable ["ODD_var_vehtgt", 0];
		private _vehact = _x getVariable ["ODD_var_vehact", []];
	}
	else {
		_x setVariable ["ODD_var_isFrontLine", true];
		{
			_x setVariable ["ODD_var_isFrontLine", true];
		}forEach _nearloc;

		private _actEni = _x getVariable ["ODD_var_actEni", 0];
		
		while {_actEni > 0} do {
			private _locNeedRenfort = _nearloc select 0;
			private _locNeedRenfortPrc = ((_nearloc select 0) getVariable ["ODD_var_actEni", 0]) / ((_nearloc select 0) getVariable ["ODD_var_tgtEni", 2]);
			{
				if (_x getVariable ["ODD_var_isBlue", false] == false) then {
					private _locEni = _x getVariable ["ODD_var_actEni", 0];
					private _locTgt = _x getVariable ["ODD_var_tgtEni", 2];

					private _locPrc = _locEni / _locTgt;
					if ((_locNeedRenfortPrc > _locPrc)) then {
						_locNeedRenfort = _x;
						_locNeedRenfortPrc = _locPrc;
					};
				};
			} forEach _nearloc;
			_locNeedRenfort setVariable ["ODD_var_actEni", (_locNeedRenfort getVariable ["ODD_var_actEni", 0]) + 1];
			_actEni = _actEni - 1;
		};
		_x setVariable ["ODD_var_actEni", _actEni];
	};

	// update du marker sur la carte

} forEach ODDvar_mesLocations;

[ODD_var_CTIMarkerInfo] call ODDCTI_fnc_updateMap;

