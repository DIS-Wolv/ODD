params ["_zo"];
private _loctype = [_zo] call ODDcommon_fnc_ZoType;;
private _patrolLimit = 0;

switch (_loctype) do {
	case 0: {_patrolLimit = 6;};
	case 1: {_patrolLimit = 7;};
	case 2: {_patrolLimit = 8;};
	case 3: {_patrolLimit = 11;};
	case 4: {_patrolLimit = 15;};
	case 5: {_patrolLimit = 15;};
};

_patrolLimit;