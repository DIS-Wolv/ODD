/*
* Auteur: Wolv
* Fonction pour supprimer le véhicule le plus proche
*
* Arguments:
* 0: Position <ARRAY>
*
* Return Value:
* nil
*/
_index = lbCurSel IdcListVL;
if (_index != -1) then { 
	_vl = ListVL select _index;

	private _coord2D = [0,0,0];
	private _coordZ = [0,0,0];
	private _alt = 0;

	{
	private _markerHalo = (markerText _x splitString " ");
	if ("VLDZ" in _markerHalo)
	then {
		_coord2D = getMarkerPos _x;
		_alt = parseNumber (_markerHalo select 1);
		if (_alt <= 50) then {
			systemChat "Altitude trop basse, redéfinissez la zone de saut";
			hint "Altitude trop basse, \n redéfinissez la zone de saut";
			sleep 10;
			hintSilent "";
		}
		else {
			_coordZ = [0,0, _alt];
		}
	};
	}forEach allMapMarkers;

	private _posHalo = _coord2D vectorAdd _coordZ;

	if (_posHalo isEqualTo [0,0,0]) then {
	systemChat "Pas de zone de saut, définissez une zone de saut";
	hint "Pas de zone de saut, \n définissez une zone de saut";
	sleep 10;
	hintSilent "";
	}
	else {
		_vl setPos _posHalo; 

		call compile preprocessFile 'scripts\WOLV_garage\VLProx.sqf';
		// Met à jour la liste des véhicules à proximité
		
		_posChute = [position _vl select 0, position _vl select 1, (position _vl select 2) + 2];
		_chute = createvehicle ["i_parachute_02_f", position _vl,[],0,"can_collide"];
		_vl attachto [_chute,[0,0,2.5]];

		waitUntil{
			sleep 1; 
			(((position _vl) select 2) <= 10)
		};

		_smoke = "SmokeShellGreen" createVehicle _posChute;
		_smoke attachto [_vl,[1,1,0]];
	};
};


