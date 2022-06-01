
//Recupère toute les villes, villages, Capitales
private _location = nearestLocations[[15000,15000], locationType, 30000];

//choisi un objectif random
private _obj = selectRandom _location;
private _Buildings = nearestObjects[position _obj, Maison, 200];

while {(text _obj in locationBlkList) or (count _Buildings == 0)} do {	//tant que on est dans une location intredit ou qu'il y a 0 
	_obj = selectRandom _location;
	_Buildings = nearestObjects[position _obj, Maison, 200];
};	//*/

/*
while {text _obj != "Abdera"} do {
	[text _obj] remoteExec ["systemChat", 0];
	_obj = selectRandom _location;
}; // */
 
//Recupère la position de l'objectif
private _pos = position _obj;

_pos set [0, ((_pos select 0) + ((size _obj) select 0)/2)];
_pos set [1, ((_pos select 1) + ((size _obj) select 0)/2)];


//Ajoute un marker 
_marker = createMarker ["ODDOBJ", _pos]; 
_marker setMarkerType "hd_objective";
_marker setMarkerColor "colorOPFOR";
_marker setMarkerText "O";

[text _obj] remoteExec ["systemChat", 0];



//Renvoie la location
_obj
