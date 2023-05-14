_location = nearestLocations[[15000,15000], ['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill'], 30000];
_locationBlkList = ODD_var_BlackistedLocation;
{
	deleteMarker _x;
}forEach allMapMarkers;

{
	// Current result is saved in variable _x
	_pos = getpos _x;
	_zo = _x;
	if (!(text _x in _locationBlkList)) then {
		_markerG = createMarker [(format ["obj Z x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
		_markerG setMarkerShape "ELLIPSE";
		_markerG setMarkerSize [(size _x select 0), (size _x select 0)];
		_markerG setMarkerBrush "SolidBorder";
		_markerG setMarkerAlpha 0.4; 
		_markerG setMarkerColor "colorOPFOR";

		private _garisonPool = 4;
		private _typeModifier = 0;
		private _proxModifier = 0;
		private _objModifier = 0;
		private _batModifier = 0;

		private _Buildings = nearestObjects [position _zo, ODD_var_Houses, size _zo select 0];
		switch (type _zo) do { //['NameCityCapital', 'NameCity', 'NameVillage', 'Name', 'NameLocal', 'Hill']
			case (ODD_var_LocationType select 5): {
				_typeModifier = 0;
				_batModifier = (count _Buildings) / 3;
			};
			case (ODD_var_LocationType select 4): {
				_typeModifier = 5;
				_batModifier = (count _Buildings) / 5;
			};
			case (ODD_var_LocationType select 3): {
				_typeModifier = 5;
				_batModifier = (count _Buildings) / 10;
			};
			case (ODD_var_LocationType select 2): {
				_typeModifier = 6;
				_batModifier = (count _Buildings) / 15;
			};
			case (ODD_var_LocationType select 1): {
				_typeModifier = 7;
				_batModifier = (count _Buildings) / 15;
			};
			case (ODD_var_LocationType select 0): {
				_typeModifier = 10;
				_batModifier = (count _Buildings) / 20;
			};
		};
		_garisonPool = _garisonPool + _typeModifier + _batModifier;

		private _prox = nearestLocations [position _zo, ODD_var_LocationType, 2000];
		private _proxModifier = 0;
		{
			_mod = 0;
			switch (type _x) do {
				case (ODD_var_LocationType select 5): {_mod = 0;};
				case (ODD_var_LocationType select 4): {_mod = 0.5;};
				case (ODD_var_LocationType select 3): {_mod = 0.6;};
				case (ODD_var_LocationType select 2): {_mod = 1;};
				case (ODD_var_LocationType select 1): {_mod = 1.2;};
				case (ODD_var_LocationType select 0): {_mod = 2;};
			};
			_proxModifier = _proxModifier + _mod
		} forEach _prox;
		_garisonPool = _garisonPool + _proxModifier;

		_garisonPool = round _garisonPool;

		_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
		_marker setMarkerType "hd_objective";
		_marker setMarkerColor "colorOPFOR";
		_marker setMarkerText format["%1.%2 : %3 | %4 | %5 | %6", _forEachIndex, text _x, _batModifier, _typeModifier, _proxModifier, _garisonPool];
	}
} forEach _location;
