params ["_unit"];

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon "rhs_weap_hk416d10";
[_unit] call DISLoad_fnc_standartScope;
_unit addPrimaryWeaponItem "30Rnd_556x45_Stanag_red";
_unit addWeapon "rhsusf_weap_glock17g4";
_unit addHandgunItem "rhsusf_mag_17Rnd_9x19_JHP";
_unit addWeapon "rhs_weap_M136";
_unit addWeapon "Laserdesignator";
_unit addMagazine "Laserbatteries";

_unit forceAddUniform "rhs_uniform_g3_mc";
_unit addVest "rhsusf_plateframe_teamleader";
_unit addBackpack "TFAR_rt1523g_rhs";

_unit addHeadgear "rhsusf_opscore_mc_cover_pelt_cam";

// treillis
_unit addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 10 do {_unit addItemToUniform "ACE_CableTie";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_splint";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_tourniquet";};
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_morphine";};
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 20 do {_unit addItemToUniform "ACE_packingBandage";};
for "_i" from 1 to 12 do {_unit addItemToUniform "ACE_elasticBandage";};

// Veste
_unit addItemToVest "ACE_MapTools";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "acex_intelitems_notepad";
for "_i" from 1 to 8 do {_unit addItemToVest "30Rnd_556x45_Stanag_red";};
for "_i" from 1 to 10 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 3 do {_unit addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 2 do {_unit addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};

// Sac a dos
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_plasmaIV_500";};
_unit addItemToBackpack "ACE_EntrenchingTool";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "TFAR_anprc152";
_unit linkItem "R3F_ITEM_DAGR";


_unit setVariable ["ace_hasearplugsin",true];

if(True) exitWith{};
