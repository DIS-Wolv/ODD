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
_unit addPrimaryWeaponItem "30Rnd_556x45_Stanag_red";
_unit addWeapon "rhs_weap_M136";
_unit addWeapon "rhsusf_weap_glock17g4";
_unit addHandgunItem "rhsusf_mag_17Rnd_9x19_JHP";
_unit addWeapon "Laserdesignator";
_unit addMagazine "Laserbatteries";

_unit forceAddUniform "U_B_Wetsuit";
_unit addVest "V_RebreatherB";
_unit addBackpack "rhssaf_kitbag_smb";

_unit addHeadgear "rhsusf_opscore_mc";
_unit addGoggles "G_B_Diving";

// treillis
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_tourniquet";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_CableTie";};
for "_i" from 1 to 10 do {_unit addItemToUniform "ACE_elasticBandage";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_morphine";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 6 do {_unit addItemToUniform "ACE_splint";};
for "_i" from 1 to 20 do {_unit addItemToUniform "ACE_packingBandage";};
for "_i" from 1 to 2 do {_unit addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";};
_unit addItemToUniform "ACE_EarPlugs";
_unit addItemToUniform "R3F_ITEM_ODP";

// sac
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_plasmaIV_500";};
for "_i" from 1 to 10 do {_unit addItemToBackpack "30Rnd_556x45_Stanag_red";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "rhs_mag_m67";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShell";};
_unit addItemToBackpack "rhsusf_plateframe_light";
_unit addItemToBackpack "SmokeShellGreen";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "TFAR_anprc152";
_unit linkItem "R3F_ITEM_DAGR";

_unit setVariable ["ace_hasearplugsin",true];

if(True) exitWith{};
