/*
* Auteur : Wolv
* permet de set up l'arsenal Ace
*
* Arguments :
*
* Exemple:
* [] call DISLoad_fnc_ArsenalAce;
*
* Variable publique :
*/


if (isNil "DISLoad_var_piloteAvions") then {
    [] call DISLoad_fnc_Varload;
};

private _allLoadName = [
    DISLoad_var_piloteAvions, DISLoad_var_piloteHelo,
    DISLoadMc_var_CDBR, DISLoadMc_var_CDB, DISLoadMc_var_CdE, DISLoadMc_var_CdG, DISLoadMc_var_CdS, DISLoadMc_var_EOD, DISLoadMc_var_EOD_Light, DISLoadMc_var_Equipier, DISLoadMc_var_Grenadier, DISLoadMc_var_GV, DISLoadMc_var_GvBck, DISLoadMc_var_Medecin, DISLoadMc_var_Minimi5, DISLoadMc_var_Minimi7, DISLoadMc_var_TP, DISLoadMc_var_Zeus,
    DISLoadPL_var_CDE, DISLoadPL_var_CDG, DISLoadPL_var_GV, DISLoadPL_var_Medecin, DISLoadPL_var_Minimi5
];

//ajout de tout les loads dans l'arsenal
["Pilote Avions", DISLoad_var_piloteAvions, true] call ace_arsenal_fnc_addDefaultLoadout;
["Pilote Helico", DISLoad_var_piloteHelo, true] call ace_arsenal_fnc_addDefaultLoadout;

["MC CDB(inf)", DISLoadMc_var_CDBR, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC CDB", DISLoadMc_var_CDBR, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC CdE", DISLoadMc_var_CDB, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC CdG", DISLoadMc_var_CdG, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC CdS", DISLoadMc_var_CdS, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC EOD", DISLoadMc_var_EOD, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC EOD Light", DISLoadMc_var_EOD_Light, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC Equipier", DISLoadMc_var_Equipier, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC Grenadier", DISLoadMc_var_Grenadier, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC GV", DISLoadMc_var_GV, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC GvBck", DISLoadMc_var_GvBck, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC Medecin", DISLoadMc_var_Medecin, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC Minimi5", DISLoadMc_var_Minimi5, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC Minimi7", DISLoadMc_var_Minimi7, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC TP", DISLoadMc_var_TP, true] call ace_arsenal_fnc_addDefaultLoadout;
["MC Zeus", DISLoadMc_var_Zeus, true] call ace_arsenal_fnc_addDefaultLoadout;

["PL CDE", DISLoadPL_var_CDE, true] call ace_arsenal_fnc_addDefaultLoadout;
["PL CDG", DISLoadPL_var_CDG, true] call ace_arsenal_fnc_addDefaultLoadout;
["PL GV", DISLoadPL_var_GV, true] call ace_arsenal_fnc_addDefaultLoadout;
["PL Medecin", DISLoadPL_var_Medecin, true] call ace_arsenal_fnc_addDefaultLoadout;
["PL Minimi5", DISLoadPL_var_Minimi5, true] call ace_arsenal_fnc_addDefaultLoadout;

// récup tout les items des loads
_allItemArray = [];
{
    _allItemArray pushBack _x;
} forEach _allLoadName;

// récup tout les items des caisses
_caisse = 'B_supplyCrate_F' createVehicle [0,0,0];
_caisseItems = [];
// Caisse Armes
[_caisse] call DISLoadCrate_fnc_armes;
sleep 1;
_caisseItems pushBack ((getItemCargo _caisse) select 0);
_caisseItems pushBack ((getWeaponCargo _caisse) select 0);
_caisseItems pushBack ((getMagazineCargo _caisse) select 0);
_caisseItems pushBack ((getBackPackCargo _caisse) select 0);

// caisse Tube
[_caisse] call DISLoadCrate_fnc_lanceurs;
sleep 1;
_caisseItems pushBack ((getItemCargo _caisse) select 0);
_caisseItems pushBack ((getWeaponCargo _caisse) select 0);
_caisseItems pushBack ((getMagazineCargo _caisse) select 0);
_caisseItems pushBack ((getBackPackCargo _caisse) select 0);

// caisse Medical
[_caisse] call DISLoadCrate_fnc_medical;
sleep 1;
_caisseItems pushBack ((getItemCargo _caisse) select 0);
_caisseItems pushBack ((getWeaponCargo _caisse) select 0);
_caisseItems pushBack ((getMagazineCargo _caisse) select 0);
_caisseItems pushBack ((getBackPackCargo _caisse) select 0);

// caisse Items
[_caisse] call DISLoadCrate_fnc_items;
sleep 0.1;
_caisseItems pushBack ((getItemCargo _caisse) select 0);
_caisseItems pushBack ((getWeaponCargo _caisse) select 0);
_caisseItems pushBack ((getMagazineCargo _caisse) select 0);
_caisseItems pushBack ((getBackPackCargo _caisse) select 0);

// caisse para
[_caisse] call DISLoadCrate_fnc_para;
sleep 0.1;
_caisseItems pushBack ((getItemCargo _caisse) select 0);
_caisseItems pushBack ((getWeaponCargo _caisse) select 0);
_caisseItems pushBack ((getMagazineCargo _caisse) select 0);
_caisseItems pushBack ((getBackPackCargo _caisse) select 0);

deleteVehicle _caisse;

// en prend 1 seul de chaque
private _items = flatten (_allItemArray + _caisseItems);
_items = (_items arrayIntersect _items) select {_x isEqualType "" && {_x != ""}};

// on ajoute les items dans l'arsenal
[pPil, []] call ace_arsenal_fnc_initBox;
[pPil, _items] remoteExec ["ace_arsenal_fnc_addVirtualItems", 0, True] ;

