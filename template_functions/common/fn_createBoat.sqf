private _pos = getpos BoatSpawn; //A renseigner en fonction de la carte
private _nbBoat = count nearestObjects [pierLadder, ["rhsgref_hidf_rhib"], 100, true];

if (_nbBoat > 3) 
then {
	hint "Trop de bateaux, \n eloignez les bateaux !";
	sleep 10;
	hintSilent "";
}
else {
	createVehicle ["rhsgref_hidf_rhib", _pos, [], 5, "CAN_COLLIDE"];
};
};
