/*
	//Eclair = {  
		//params ["_road", "_roadPool"]; 
	//*
	_road = param[0];
	_roadPool = param[1];

		_inPool = _roadPool find _road;
		//systemChat(str(_inPool));
		
		if (_inPool == -1) then {
			sleep 0.0001; 
			_roadPool append [_road]; 
			_coroad = roadsConnectedTo _road;
			_info = getRoadInfo _road; 
			
			{  
				if (_info select 0 != "HIDE") then {  
					_pos = position _road;  
					_marker = createMarker [Format["road x : %1, y : %2, z : %3", _pos select 0, _pos select 1, _pos select 2], _pos];   
					_marker setMarkerType "hd_dot";  
					_marker setMarkerText "";  
					if (_info select 0 == "MAIN ROAD") then {  
						_marker setMarkerColor "ColorRed";  
					};  
					if (_info select 0 == "ROAD") then {  
						_marker setMarkerColor "ColorPink";  
					};  
					if (_info select 0 == "TRACK") then {  
						_marker setMarkerColor "ColorOrange";  
					};  
					if (_info select 0 == "TRAIL") then {  
						_marker setMarkerColor "ColorYellow";  
					};
					[_x, _roadPool] execVM "test2.sqf"; 
				};
			} forEach _coroad;  

		};
	//}; 

	//*
	_roadPool = [];
	_pos = position player;

	_nearRoad = _pos nearRoads 20;
	_roadPool = [_nearRoad select 0];
	[_nearRoad select 0] call Eclair;
	//* /
	//*
	_allroad = [15000, 15000, 0] nearRoads 30000;
	sleep 3;
	{
		_info = getRoadInfo _x;
		if (_info select 0 != "HIDE") then {
			_pos = position _x;
			_marker = createMarker [Format["road x : %1, y : %2, z : %3", _pos select 0, _pos select 1, _pos select 2], _pos]; 
			_marker setMarkerType "hd_dot";
			_marker setMarkerText "";
			if (_info select 0 == "MAIN ROAD") then {
				_marker setMarkerColor "ColorRed";
			};
			if (_info select 0 == "ROAD") then {
				_marker setMarkerColor "ColorPink";
			};
			if (_info select 0 == "TRACK") then {
				_marker setMarkerColor "ColorOrange";
			};
			if (_info select 0 == "TRAIL") then {
				_marker setMarkerColor "ColorYellow";
			};
		};
		sleep 0.0001;
	} forEach _allroad;
// */

{
	deleteMarker(_x);
}foreach allMapMarkers; 

private _pos = position player;
private _size = 500;

_markerG = createMarker [(format ["obj Z x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
_markerG setMarkerShape "ELLIPSE";
_markerG setMarkerSize [_size, _size];
_markerG setMarkerBrush "SolidBorder";
_markerG setMarkerAlpha 0.5; 
_markerG setMarkerColor "colorOPFOR";

private _max = 100;
private _nb = 0;
private _minDist = _size * 2;
for "_i" from 1 to _max do {  
	private _randomPos = [[[_pos, _size]],[]] call BIS_fnc_randomPos;

	_randomPos = ATLToASL _randomPos;
	_marker = createMarker [(format ["obj P x %1, y %2, z %3", (_randomPos select 0), (_randomPos select 1), (_randomPos select 2)]), _randomPos];
	_marker setMarkerType "hd_dot_noShadow";
	_marker setMarkerColor "colorBLUFOR";
	//_marker setMarkerText format["%1, %2, %3", (_randomPos select 0), (_randomPos select 1), (_randomPos select 2)];

	systemChat(str(_randomPos));
	if (_randomPos select 2 < 0 ) then {
		_nb = _nb + 1;
		if (_minDist > (_pos distance2D _randomPos)) then {
			_marker setMarkerColor "colorGREEN";
		};
		_minDist = _minDist min (_pos distance2D _randomPos);
	};
};

private _prc = _nb /_max * 100;
_msg = format["%1 prc | %2", _prc, _minDist];
systemChat(_msg);

_msg


