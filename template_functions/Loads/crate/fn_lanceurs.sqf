params ["_crate"];

clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

_crate addWeaponCargoGlobal ["rhs_weap_M136", 5];
_crate addWeaponCargoGlobal ["rhs_weap_M136_hp", 5];
_crate addWeaponCargoGlobal ["launch_MRAWS_green_F", 5];
_crate addWeaponCargoGlobal ["rhs_weap_fgm148", 5];
_crate addWeaponCargoGlobal ["rhs_weap_fim92", 5];
_crate addMagazineCargoGlobal ["rhs_mag_maaws_HEAT", 10];
_crate addMagazineCargoGlobal ["rhs_mag_maaws_HE", 10];
_crate addMagazineCargoGlobal ["MRAWS_HE_F", 10];
_crate addMagazineCargoGlobal ["rhs_fgm148_magazine_AT", 10];
_crate addMagazineCargoGlobal ["rhs_fim92_mag", 10];

// LGI
_crate addWeaponCargoGlobal ["avm224_W_M224_mortar_carry", 2];
_crate addMagazineCargoGlobal ["avm224_M_6Rnd_60mm_HE_0_csw", 20];
_crate addMagazineCargoGlobal ["avm224_M_6Rnd_60mm_HE_csw", 20];
