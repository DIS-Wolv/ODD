/*
* Auteur : Wolv
* Fonction pour faire bouger les patrouilles entre les zones secondaires
*
* Arguments :
* 0: Groupe en patrouille <OBJ>
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [_g] call ODDadvanced_fnc_patrolZoM
*
* Variable publique :
*/
params ["_g"];

if ((typeName _g) == "GROUP") then  {
	private _leader = ((units _g) select 0);
	private _pos = position _leader;
	// Récupère le chef du groupe et sa position

	private _zoList = nearestLocations[getpos ODD_var_SelectedArea, ODD_var_LocationType, 4000, _pos]; 
	// Liste des localités à proximité (4km) de la zone objectif

	private _pZo = _zoList select 0;
	_zoList = _zoList - [_pZo];
	// Retire la localité dans laquelle il se trouve de la liste

	private _nextZo = selectrandom _zoList;
	while {count ((position _nextZo) nearRoads 300) <= 0} do {
		_zoList = _zoList - [_nextZo];
		_nextZo = selectrandom _zoList;
	};
	// Choisi la localité suivante parmis la liste en s'assurant qu'elle compore des routes pour les véhicules

	_roadZo = (position _pZo nearRoads 600);

	private _nbWP = (round((random 1) * (((size _pZo) select 0) / 100))) + 2;

	// _nbWP = _nbWP min (count (_roadZo));

	for "_i" from 0 to (_nbWP) do {

		_selectroad = (selectrandom _roadZo);

		_roadZo = _roadZo - [_selectroad];

		_posWP = getPos _selectroad;

		_g addWaypoint [_posWP, 5];

	};

	_posWP = getPos (selectrandom ((position _nextZo) nearRoads 300));
	// Récupère la position pour le point de passage sur la prochaine zone

	_g addWaypoint [_posWP, 5];

	waitUntil {
		sleep 5;
		((_leader distance2D (getPos _nextZo)) < 350)
	};

	if (ODD_var_CurrentMission == 1 or ODD_var_CurrentMission == 2) then {
		[_g] spawn ODDadvanced_fnc_patrolZoM;
	};
}
else {
	[["Erreur : ODDadvanced_fnc_patrolZoM, pas un groupe : %1 (type : %2)", _g, typeName _g]] call ODDcommon_fnc_log;
};