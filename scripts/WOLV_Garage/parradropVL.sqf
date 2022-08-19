/*
* Author: Wolv
* Fonction permetant de supprimer le vehicule le plus proche de la position passe en argument
*
* Arguments:
* 0: Position <Array>
*
* Return Value:
* nil
*/
// systemChat str 'Test Parradrop VL';

_index = lbCurSel IdcListVL;
if (_index != -1) then { 
	_vl = ListVL select _index;

	private _coord2D = [0,0,0];
	private _coordZ = [0,0,0];
	private _alt = 0;

	{
	private _markerHalo = (markerText _x splitString " ");
	//hint str(_markerHalo); sleep 3; hintSilent "";
	//hint str(_markerHalo select 1); sleep 3; hintSilent "";
	//hint str(parseNumber str(_markerHalo select 1)); sleep 3; hintSilent "";
	if ("VLDZ" in _markerHalo)
	then {
		_coord2D = getMarkerPos _x;
		//hint str(_coord2D); sleep 3; hintSilent "";
		_alt = parseNumber (_markerHalo select 1);
		if (_alt <= 200) then {
			systemChat "Altitude trop basse, redéfinissez la zone de saut";
			hint "Altitude trop basse, \n redéfinissez la zone de saut";
			sleep 10;
			hintSilent "";
		}
		else {
			_coordZ = [0,0, _alt];
		}
		//hint str(_coordZ select 2); sleep 3; hintSilent "";
	};
	}forEach allMapMarkers;

	private _posHalo = _coord2D vectorAdd _coordZ;
	//hint str(_posHalo); sleep 3; hintSilent "";

	if (_posHalo isEqualTo [0,0,0]) then {
	systemChat "Pas de zone de saut, définissez une zone de saut";
	hint "Pas de zone de saut, \n définissez une zone de saut";
	sleep 10;
	hintSilent "";
	}
	else {
		_vl setPos _posHalo; 
		// systemChat "VL en l'air";

		// met a jour la liste des vl proche
		call compile preprocessFile 'scripts\WOLV_garage\VLProx.sqf';
		
		// sleep 1;
		// waitUntil{sleep 1; position _vl select 2 <= 100};

		_posChute = [position _vl select 0, position _vl select 1, (position _vl select 2) + 2];
		_chute = createvehicle ["i_parachute_02_f", position _vl,[],0,"can_collide"];
		_vl attachto [_chute,[0,0,2.5]];

		waitUntil{sleep 1; position _vl select 2 <= 10};

		_smoke = "SmokeShellGreen" createVehicle _posChute;
		_smoke attachto [_vl,[1,1,0]];

	};
};


