/*
* Auteur : Wolv
* Fonction pour supprimer les corps et véhicules au cours de la mission
*
* Arguments :
* 0: nombre de minutes depuis le lancement de la mission <INT>
*
* Valeur renvoyée :
* Nom de la localité
*
* Exemple :
* [_itt] call ODD_fnc_garbageCollector
*
* Variable publique :
*/
params ["_nbItt"];

_tGarbage = 45; 
// Temps entre chaque éxécution

//["Test Garbage Coll"] remoteExec ["systemChat", 0];
if (_nbItt/_tGarbage == round ( _nbItt/_tGarbage)) then {
	private _nbEle = 0;
	{
		if (count(units(group _x)) <= 1) then {
			if (count (position _x nearEntities[["SoldierWB"], 400]) == 0) then {	
			// Vérification que les joueurs ne sont pas à proximité
				sleep 2;
				deleteVehicle _x;
			// Supprime l'élément
				_nbEle = _nbEle + 1;
			};
		};
	} forEach alldead;
	// Pour chaque élément
	[["ODD_Quantité : Nombre d'élement supprimé : %1", _nbEle]] call ODD_fnc_log;
};
