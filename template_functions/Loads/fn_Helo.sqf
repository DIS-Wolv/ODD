params ["_unit"];

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon "rhsusf_weap_MP7A2";
_unit addPrimaryWeaponItem "rhsusf_mag_40Rnd_46x30_FMJ";
_unit addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
_unit addWeapon "rhsusf_weap_glock17g4";
_unit addHandgunItem "rhsusf_mag_17Rnd_9x19_JHP";

_unit forceAddUniform "Tenue_pilote_CARACAL_CE";
_unit addVest "V_TacVestIR_blk";

_unit addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_tourniquet";};
for "_i" from 1 to 10 do {_unit addItemToUniform "ACE_elasticBandage";};
for "_i" from 1 to 3 do {_unit addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 10 do {_unit addItemToUniform "ACE_packingBandage";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_quikclot";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_morphine";};
_unit addItemToUniform "ACE_CableTie";
for "_i" from 1 to 2 do {_unit addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};
for "_i" from 1 to 3 do {_unit addItemToVest "rhsusf_mag_40Rnd_46x30_FMJ";};
_unit addItemToVest "SmokeShellBlue";
_unit addItemToVest "SmokeShellGreen";
for "_i" from 1 to 4 do {_unit addItemToVest "SmokeShell";};
_unit addItemToVest "ACE_Chemlight_HiGreen";
_unit addHeadgear "rhsusf_ihadss";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "TFAR_anprc152";
_unit linkItem "ItemGPS";
//_unit linkItem "ACE_NVG_Wide";

if(True) exitWith{};
