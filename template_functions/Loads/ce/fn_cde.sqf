params ["_unit"];

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon "rhs_weap_hk416d145";
[_unit] call DISLoad_fnc_StandartScope;
_unit addPrimaryWeaponItem "rhs_mag_30Rnd_556x45_M855A1_Stanag";
_unit addWeapon "rhs_weap_M136";
_unit addWeapon "rhsusf_weap_glock17g4";
_unit addHandgunItem "rhsusf_mag_17Rnd_9x19_JHP";
_unit addWeapon "Binocular";

_unit forceAddUniform "unif_SWEAT_ce_impact";
_unit addVest "6094_HEAVY_od";
_unit addBackpack "KIT_BAG_od";

// Partie commune
for "_i" from 1 to 15 do {_unit addItemToUniform "ACE_elasticBandage";};
for "_i" from 1 to 20 do {_unit addItemToUniform "ACE_packingBandage";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_tourniquet";};
_unit addItemToVest "ACE_EarPlugs";
for "_i" from 1 to 5 do {_unit addItemToVest "ACE_packingBandage";};
for "_i" from 1 to 3 do {_unit addItemToVest "ACE_epinephrine";};
for "_i" from 1 to 3 do {_unit addItemToVest "ACE_morphine";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_plasmaIV_500";};
for "_i" from 1 to 5 do {_unit addItemToBackpack "ACE_splint";};
// Partie armement
for "_i" from 1 to 5 do {_unit addItemToBackpack "ACE_CableTie";};
for "_i" from 1 to 3 do {_unit addItemToBackpack "rhs_mag_m67";};
for "_i" from 1 to 5 do {_unit addItemToBackpack "SmokeShell";};
for "_i" from 1 to 10 do {_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
for "_i" from 1 to 3 do {_unit addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};

_unit addItemToVest "ACE_MapTools";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "ACE_Flashlight_XL50";
_unit addItemToBackpack "ACE_EntrenchingTool";
_unit addHeadgear "Mohawk_Core_S_OD";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "TFAR_anprc152";
_unit linkItem "R3F_ITEM_DAGR";

if(True) exitWith{};
