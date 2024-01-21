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

_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
_unit addVest "V_Rangemaster_belt";
_unit addBackpack "TFAR_rt1523g_green";

_unit addHeadgear "H_MilCap_mcamo";

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
for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_556x45_Stanag_red";};


_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "TFAR_anprc152";

_unit setVariable ["ace_hasearplugsin",true];

if(True) exitWith{};



