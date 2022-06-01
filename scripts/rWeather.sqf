_date = date; //get date
_mth = _date select 1; //get month
_S = [300, 2100] call BIS_fnc_randomInt;

_Oc = 0;
if (_mth < 4 or _mth > 9) 
then {
_Oc = [8, 16] call BIS_fnc_randomInt;
	} 
else {
_Oc = [0, 12] call BIS_fnc_randomInt;
	};
_Oc1 = _Oc/20;

//hint str(_oct1);
30 setOvercast _Oc1 ;
sleep _S;


while {isServer} do 
{
Oc_ = overcast;
_s = [300, 2100] call BIS_fnc_randomInt;
_t = [60, 600] call BIS_fnc_randomInt;
_oc1 = random [0, _Oc, 20];
_oc2 = _oc1/20;
//hint str(_oct1);
_t setOvercast _oc2 ;
sleep _s;
};
