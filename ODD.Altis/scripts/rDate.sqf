_cm = [1, 12] call BIS_fnc_randomInt;
_cd = 0;
if (_cm == 2) 
then {
	_cd = [1, 28] call BIS_fnc_randomInt;
} 
else { 
	if (_cm == 4 or _cm == 6 or _cm == 9 or _cm == 11) 
	then {
		_cd = [1, 30] call BIS_fnc_randomInt;
	} 
	else {
		_cd = [1, 31] call BIS_fnc_randomInt;
	};
};

setDate [2017, _cm, _cd, 9, 0];
