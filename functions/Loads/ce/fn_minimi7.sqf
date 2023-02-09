params ["_unit"];

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon "rhs_weap_m240B";
_unit addPrimaryWeaponItem "rhsusf_acc_ELCAN";
_unit addPrimaryWeaponItem "rhsusf_100Rnd_762x51";
_unit addWeapon "rhsusf_weap_glock17g4";
_unit addHandgunItem "rhsusf_mag_17Rnd_9x19_JHP";

_unit forceAddUniform "unif_SWEAT_ce_impact";
_unit addVest "6094_HEAVY_od";
_unit addBackpack "KIT_BAG_od";

for "_i" from 1 to 10 do {_unit addItemToUniform "ACE_elasticBandage";};
_unit addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_tourniquet";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_CableTie";};
for "_i" from 1 to 3 do {_unit addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";};
for "_i" from 1 to 4 do {_unit addItemToVest "rhsusf_100Rnd_762x51";};
for "_i" from 1 to 5 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 3 do {_unit addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "ACE_splint";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_plasmaIV_500";};
for "_i" from 1 to 5 do {_unit addItemToBackpack "ACE_morphine";};
for "_i" from 1 to 5 do {_unit addItemToBackpack "ACE_epinephrine";};
for "_i" from 1 to 20 do {_unit addItemToBackpack "ACE_packingBandage";};
_unit addItemToBackpack "rhsusf_100Rnd_762x51";
_unit addHeadgear "Mohawk_Core_S_OD";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "TFAR_anprc152_10";

if(true) exitWith{};
