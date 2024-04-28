/*
* Auteur : Wolv
* Fonction pour mettre a jours les markers sur la carte
*
* Arguments :
* 0: _info: niveaux de detaille des infos
* 
* Valeur renvoyée :
*
* Exemple :
* 
*
* Variable publique :
* 
*/

params [["_info", 0]];

private _markerText = '';
private _color = "ColorRed";
private _type = "mil_dot";
private _alpha = 1;

switch _info do {
	case 0: {
		{
			// update du marker sur la carte
			private _tgtEni = _x getVariable ["ODD_var_tgtEni", 2];
			private _actEni = _x getVariable ["ODD_var_actEni", 0];
			private _prc = _actEni / _tgtEni * 100;

			_color = "ColorRed"; 
			if (_prc > 25) then {_color = "ColorYellow"}; 
			if (_prc > 75) then {_color = "ColorGreen"}; 
			if (_prc > 90) then {_color = "ColorGUER"}; 
			if (_prc > 100) then {_color = "colorCivilian"};

			_type = "mil_dot";
			if (_x getVariable ["ODD_var_isBlue", false]) then {
				_type = "b_unknown";
				_color = "colorBLUFOR";
			}
			else {
				if (_x getVariable ["ODD_var_isFrontLine", false]) then {
					_type = "o_inf";
				} else {
					_type = "o_unknown";
				};
			};

			_markerText = format ["%1/%2", _actEni, _tgtEni];
			private _prcRecrut = _x getVariable ["ODD_var_prcRecrut", 0];
			if (_prcRecrut > 0) then {
				_markerText = format ["%1/%2 + %3", _actEni, _tgtEni, (round (_actEni * _prcRecrut) + 1)];
			}
			else {
				_markerText = format ["%1/%2", _actEni, _tgtEni];
			};

			private _marker = _x getVariable ["ODD_var_marker", objNull];
			_marker setMarkerTypeLocal _type; 
			_marker setMarkerColorLocal _color; 
			_marker setMarkerSizeLocal [0.5, 0.5]; 
			_marker setMarkerTextLocal _markerText; 
			_marker setMarkerAlpha _alpha;
		} forEach ODDvar_mesLocations;
	};
	case 1: {
		{
			_color = "ColorOpfor";
			if (_x getVariable ["ODD_var_isBlue", false]) then {
				_type = "b_unknown";
				_color = "colorBLUFOR";
			}
			else {
				if (_x getVariable ["ODD_var_isFrontLine", false]) then {
					_type = "o_inf";
				} else {
					_type = "o_unknown";
				};
			};

			private _marker = _x getVariable ["ODD_var_marker", objNull];
			_marker setMarkerTypeLocal _type; 
			_marker setMarkerColorLocal _color; 
			_marker setMarkerSizeLocal [0.5, 0.5]; 
			_marker setMarkerTextLocal _markerText; 
			_marker setMarkerAlpha _alpha;
		} forEach ODDvar_mesLocations;
	};
	case 2: {
		{
			_color = "ColorOpfor";
			if (_x getVariable ["ODD_var_isBlue", false]) then {
				_type = "b_unknown";
				_color = "colorBLUFOR";
			}
			else {
				_type = "o_unknown";
				_color = "ColorOpfor";
			};

			private _marker = _x getVariable ["ODD_var_marker", objNull];
			_marker setMarkerTypeLocal _type; 
			_marker setMarkerColorLocal _color; 
			_marker setMarkerSizeLocal [0.5, 0.5]; 
			_marker setMarkerTextLocal _markerText; 
			_marker setMarkerAlpha _alpha;
		} forEach ODDvar_mesLocations;
	};
	
};
		




