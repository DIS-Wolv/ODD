params ["_unit"];

_EXP3_Player = ["Wolv", "Taka", "Slade"];

if ((name _unit) in _EXP3_Player) then {
	_unit addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
}
else {
	_unit addPrimaryWeaponItem "rhsusf_acc_g33_xps3"; 
};
