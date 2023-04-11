params ["_loc"];
private _loctype = 0;
private _patrolLimit = 0;

switch (type _loc) do {
	case (ODD_var_LocationType select 5): {_loctype = 0;};
	case (ODD_var_LocationType select 4): {_loctype = 1;};
	case (ODD_var_LocationType select 3): {_loctype = 2;};
	case (ODD_var_LocationType select 2): {_loctype = 3;};
	case (ODD_var_LocationType select 1): {_loctype = 4;};
	case (ODD_var_LocationType select 0): {_loctype = 5;};
};

switch (_loctype) do {
	case 0: {_patrolLimit = 6;};
	case 1: {_patrolLimit = 7;};
	case 2: {_patrolLimit = 8;};
	case 3: {_patrolLimit = 11;};
	case 4: {_patrolLimit = 15;};
	case 5: {_patrolLimit = 15;};
};

_patrolLimit;