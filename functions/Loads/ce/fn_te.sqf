params ["_unit"];

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon "rhs_weap_M107";
_unit addPrimaryWeaponItem "rhsusf_acc_M8541_mrds";
_unit addPrimaryWeaponItem "rhsusf_mag_10Rnd_STD_50BMG_M33";
_unit addWeapon "rhsusf_weap_glock17g4";
_unit addHandgunItem "rhsusf_mag_17Rnd_9x19_JHP";
_unit addWeapon "ACE_Vector";

_unit forceAddUniform "unif_SWEAT_ce_impact_L";
_unit addVest "6094_SCOUT_od";
_unit addBackpack "KIT_BAG_Alpin_OD";

for "_i" from 1 to 10 do {_unit addItemToUniform "ACE_elasticBandage";};
_unit addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_tourniquet";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_CableTie";};
_unit addItemToUniform "ACE_RangeCard";
for "_i" from 1 to 3 do {_unit addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";};
_unit addItemToVest "rhs_mag_m67";
for "_i" from 1 to 4 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 4 do {_unit addItemToVest "rhsusf_mag_10Rnd_STD_50BMG_M33";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_plasmaIV_500";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "ACE_splint";};
for "_i" from 1 to 5 do {_unit addItemToBackpack "ACE_epinephrine";};
for "_i" from 1 to 5 do {_unit addItemToBackpack "ACE_morphine";};
for "_i" from 1 to 20 do {_unit addItemToBackpack "ACE_packingBandage";};
for "_i" from 1 to 3 do {_unit addItemToBackpack "ACE_10Rnd_127x99_AMAX_Mag";};
_unit addHeadgear "Mohawk_Core_S_OD";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "TFAR_anprc152";

if(true) exitWith{};
