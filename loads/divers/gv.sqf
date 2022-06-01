private _unit = player;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon "rhs_weap_hk416d145";
_unit addPrimaryWeaponItem "rhsusf_acc_g33_xps3";
_unit addPrimaryWeaponItem "rhs_mag_30Rnd_556x45_M855A1_Stanag";
_unit addWeapon "rhsusf_weap_glock17g4";
_unit addHandgunItem "rhsusf_mag_17Rnd_9x19_JHP";

_unit forceAddUniform "U_B_Wetsuit";
_unit addVest "RECYCLEUR_FULL_TL";
_unit addBackpack "rhssaf_kitbag_smb";

for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_tourniquet";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_CableTie";};
for "_i" from 1 to 10 do {_unit addItemToUniform "ACE_elasticBandage";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_morphine";};
_unit addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 20 do {_unit addItemToUniform "ACE_packingBandage";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 6 do {_unit addItemToUniform "ACE_splint";};
for "_i" from 1 to 3 do {_unit addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_plasmaIV_500";};
_unit addItemToBackpack "6094_HEAVY_od";
for "_i" from 1 to 10 do {_unit addItemToBackpack "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShell";};
_unit addHeadgear "Mohawk_Core_S_OD";
_unit addGoggles "G_B_Diving";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "TFAR_anprc152";

if(true) exitWith{};
