

_index = lbCurSel WolvGarage_var_IdcListVlProx;
if (_index != -1) then {
	_vl = WolvGarage_var_ListVL select _index;

	private _coord2D = [0,0,0];
	private _coordZ = [0,0,0];
	private _alt = 0;
	private _dropTime = 0;

	{
		private _markerHalo = (markerText _x splitString " ");
		if ("VLDZ" in _markerHalo) then {
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
				_dropTime = parseNumber (_markerHalo select 2);
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
		if (!isNil "_dropTime") then {
			_dropTimeH = floor (_dropTime / 100);
			_dropTimeM = _dropTime - 100 * _dropTimeH;
			waitUntil {
				sleep 59;
				_timeNow = date;
				((((_timeNow select 3) == _dropTimeH) && ((_timeNow select 4) == _dropTimeM)) or ((_vl distance2D WolvGarage_var_OBJ) >= 150))
			};
		};
		if ((_vl distance2D WolvGarage_var_OBJ) < 150) then {
			_vl setPos _posHalo; 

			sleep 0.1;
			call WolvGarage_fnc_garUpdateVlProx;
			
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
};

