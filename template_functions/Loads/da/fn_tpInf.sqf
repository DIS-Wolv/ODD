params ["_unit"];

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon "rhs_weap_mk17_LB";
_unit addPrimaryWeaponItem "rhsusf_acc_ACOG_MDO";
_unit addPrimaryWeaponItem "rhs_mag_20Rnd_SCAR_762x51_m80_ball";
_unit addPrimaryWeaponItem "rhsusf_acc_harris_bipod";
_unit addWeapon "rhsusf_weap_glock17g4";
_unit addHandgunItem "rhsusf_mag_17Rnd_9x19_JHP";

_unit forceAddUniform "unif_SWEAT_daguet_impact";
_unit addVest "6094_HEAVY_tan";
_unit addBackpack "KIT_BAG_TAN";

// Partie commune
for "_i" from 1 to 15 do {_unit addItemToUniform "ACE_elasticBandage";};
for "_i" from 1 to 20 do {_unit addItemToUniform "ACE_packingBandage";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_tourniquet";};
_unit addItemToVest "ACE_EarPlugs";
for "_i" from 1 to 5 do {_unit addItemToVest "ACE_packingBandage";};
for "_i" from 1 to 2 do {_unit addItemToVest "ACE_epinephrine";};
for "_i" from 1 to 2 do {_unit addItemToVest "ACE_morphine";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_plasmaIV_500";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_splint";};
// Partie armement
for "_i" from 1 to 5 do {_unit addItemToBackpack "ACE_CableTie";};
for "_i" from 1 to 3 do {_unit addItemToBackpack "rhs_mag_m67";};
for "_i" from 1 to 5 do {_unit addItemToBackpack "SmokeShell";};
for "_i" from 1 to 10 do {_unit addItemToVest "rhs_mag_20Rnd_SCAR_762x51_m80_ball";};
for "_i" from 1 to 5 do {_unit addItemToBackpack "rhs_mag_20Rnd_SCAR_762x51_m80_ball";};
_unit addHeadgear "Mohawk_Core_S_TAN";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "TFAR_anprc152";

if(True) exitWith{};
