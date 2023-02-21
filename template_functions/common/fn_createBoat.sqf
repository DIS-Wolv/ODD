private _pos = getpos BoatSpawn; //A renseigner en fonction de la carte
private _nbBoat = count nearestObjects [_pos, ["rhsgref_hidf_rhib"], 25, true];

if (_nbBoat > 3) 
then {
	systemChat "Trop de bateaux, \n eloignez les bateaux !";
	sleep 10;
	hintSilent "";
}
else {
	createVehicle ["rhsgref_hidf_rhib", _pos, [], 5, "CAN_COLLIDE"];
};
