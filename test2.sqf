//Eclair = {  
	//params ["_road", "_roadPool"]; 
	
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

/*
_roadPool = [];
_pos = position player;

_nearRoad = _pos nearRoads 20;
_roadPool = [_nearRoad select 0];
[_nearRoad select 0] call Eclair;
//*/
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
