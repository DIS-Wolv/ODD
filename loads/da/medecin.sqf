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

_unit forceAddUniform "unif_SWEAT_daguet_impact";
_unit addVest "6094_MEDIC_tan";
_unit addBackpack "KIT_BAG_MC";

for "_i" from 1 to 10 do {_unit addItemToUniform "ACE_elasticBandage";};
_unit addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_tourniquet";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_CableTie";};
_unit addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";
for "_i" from 1 to 10 do {_unit addItemToUniform "ACE_morphine";};
for "_i" from 1 to 25 do {_unit addItemToVest "ACE_elasticBandage";};
for "_i" from 1 to 10 do {_unit addItemToVest "ACE_epinephrine";};
for "_i" from 1 to 15 do {_unit addItemToVest "ACE_bloodIV_500";};
for "_i" from 1 to 7 do {_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
for "_i" from 1 to 4 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 15 do {_unit addItemToBackpack "ACE_packingBandage";};
for "_i" from 1 to 14 do {_unit addItemToBackpack "ACE_splint";};
_unit addItemToBackpack "ACE_surgicalKit";
for "_i" from 1 to 10 do {_unit addItemToBackpack "ACE_bloodIV";};
_unit addHeadgear "Mohawk_Core_MANTA_tan";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "TFAR_anprc152";

if(true) exitWith{};
