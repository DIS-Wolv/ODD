params ["_unit"];

private _EXP3_Player = ["Wolv", "Taka", "Slade"];
private _ACO_Player = [];
private _aimpoint_Player = [];


if ((name _unit) in _EXP3_Player) then {
	_unit addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
}
else {
	if ((name _unit) in _EXP3_Player) then {
		_unit addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
	}
	else {
		if ((name _unit) in _aimpoint_Player) then {
			_unit addPrimaryWeaponItem "rhsusf_acc_compm4";
		}
		else {
			if ((name _unit) in _ACO_Player) then {
				_unit addPrimaryWeaponItem "optic_ACO_grn";
			}
			else {
				_unit addPrimaryWeaponItem "rhsusf_acc_g33_xps3";
			};
		};
	};
};
