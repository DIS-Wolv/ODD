/*
* Auteur : Wolv
* Fonction pour choisir ci un civil ou un captif à des informations
*
* Arguments :
* 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODDadvanced_fnc_intel
*
* Variable publique :
*/
params[["_source", 0], ["_dist", 50]];

private _colorPool = ["colorIndependent", "colorCivilian", "colorOPFOR"];
private _markerPool = ["Contact_circle1", "Contact_circle2", "Contact_circle3", "Contact_circle4", "Contact_pencilTask1", "Contact_pencilTask2",
	"Contact_pencilTask3", "Contact_pencilCircle1", "Contact_pencilCircle2", "Contact_pencilCircle3"];

//Toutes les réponses que je crée sont plutot axée pour des CIVILS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! faut il faire une autre fonction pour les ennemis que l'on interroge ou juste rajouter un if ?

private _msg = "";
private _msgMedical = ["Il y a une caisse médicale là-bas.", "J'ai vu une caisse médicale là-bas.", "C'est là bas qu'ils soignent leurs blessés !", "J'ai entendu que leur matériel médical étaient stocké à cette position", "Si vous cherchez de quoi vous soigner, cherchez dans ce quartier", "Je sais qu'ils entreposent du matériel médical à cette position"];
private _msgNoMedical = ["Je n'ai pas vu de caisse médicale.","Je n'ai repéré aucune caisse médicale.","Je ne pense pas qu'ils aient de matériel médical.","Ils sont a court de matériel médical.","Ils n'ont plus de matériel médical !","Leurs infirmeries sont à sec !","Le ravitaillement de matériel médical est attendu depuis plusieurs semaines."];
private _msgVl = ["J'ai vu un de leur véhicules.","Ils sont passés en véhicule ce matin.","Je crois que vos ennemis sont soutenus par des véhicules","J'ai entendu dire que des véhicules patrouillent la zone.","Leurs véhicules patrouillent la zone !","Leurs véhicules ont sifflé tout le fuel de la station service !","J'ai entendu une patrouille dire que leur véhicule avait été réparé."];
private _msgNoVl = ["Ils n'ont pas de véhicules.","Les insurgés n'ont pas de véhicules.", "La station service est encore bien approvisionnée","Je n'ai pas vu de véhicule.","J'ai entendu que leurs véhicules étaient en réparation", "Ils ont pris ma voiture parce qu'ils ne voulaient pas marcher"];
private _msgChkpt = ["J'ai vu qu'ils controllaient des véhicules là-bas.","J'ai été arrêté à ce checkpoint ce matin !","L'apiculteur s'est fait arrêter à ce checkpoint.","J'ai vu un carton magnifique à ce point de contrôle, y'en a qui conduisent vraiment comme des pieds","Les rebelles controllent les accès à la ville à cet endroit.","Cette route est surveillée."];
private _msgNoChkpt = ["Vos ennemis ne controllent pas les routes.","Je n'ai pas vu de checkpoints.","Je ne crois pas qu'ils aient installé de barrages routiers.","Les routes ne sont pas contrôllées","Nous pouvons circuler librement."];
private _msgIed = ["J'ai vu les insurgés piéger cette route.","Il y a des explosifs sur le bord de cette route.","J'ai vu des explosifs là-bas !","Attention au pièges sur cette route.","J'ai entendu qu'ils avaient posé une bombe là-bas.","Evitez cette route là !"];
private _msgNoIed = ["Je n'ai pas vu de pièges.","Je crois que les routes ne sont pas piégées.","J'ai entendu les rebelles se plaindre qu'ils n'avaient pas d'explosifs.","Les insurgents essayent de respecter les LOAC."];
private _msgTransport = ["C'est ici que j'ai garé ma voiture.", "J'ai garé ma voiture là-bas", "Prenez ma voiture elle n'est pas fermée !", "Il y a un véhicule que personne n'utilise pas loin","Utilisez ce véhicule si vous voulez.", "Si vous voulez, ce véhicule peut vous aider à vous déplacer plus vite","Si vous allez là-bas, vous pouvez prendre le véhicule de la mairie"];
private _msgNoTransport = ["Je n'ai pas de voiture.","Je ne vais pas vous dire ou j'ai garé","Vous n'allez pas tirer ma caisse","Je vous donnerais pas mes clefs","Personne ne circule en voiture ici, on pense à la planète nous !"];
private _msgObj = ["Je crois que j'ai vu ce que vous cherchez"];

clientOwner publicVariableClient "ODD_var_SelectedMissionType";
private _missionType = ODD_var_SelectedMissionType;
// ["Caisse", "Tuer un HVT", "Capturer un HVT", "Sécurisation de zone", "intel", "Helico", "Prisonniers", "Sécurisation de véhicule", "Destruction de véhicule"];
switch (_missionType) do {
	case "Caisse": {_msgObj append ["J'ai vu des caisses là-bas.","Ils stockent du matériel dans ce bâtiment.","Je crois que ce que vous cherchez est là-bas.","J'ai vu un camion transporter du matériel vers ce quartier.","Ils ont récemment déchargé un camion ici.","Leur ravitaillement est stockée dans cette maison","J'ai entendu une patrouille parler de matériel stocké là bas"] };
	case "Tuer un HVT"; 
	case "Capturer un HVT": {_msgObj append ["Je crois que ce que vous cherchez est là-bas.","Leur chef se trouve là-bas.","Je crois que les patrouilles rendent compte dans ce bâtiment","J'ai entendu dire qu'un officier réside dans ce quartier.","Leur leader ce cache ici !","J'ai vu un homme payer leur soldats !","J'ai entendu que ceux qui avaient besoin d'ordres allaient dans ce quartier."] };
	case "Sécurisation de zone": {_msgObj append ["J'ai vu des rebelles planqués dans ce quartier.","J'ai entendu dire qu'il y avait des patrouilles dans ce secteur","Certains de vos ennemis se cachent là-bas"] };
	case "intel": {_msgObj append ["Je crois que ce que vous cherchez est là-bas.","Le poste de commandement des rebelles se trouve dans cette maison.","J'ai entendu dire que les ordres étaient donnés dans ce quartier.","J'ai entendu une patrouille parler d'un centre de données dans ce secteur.","L'entreprise d'informatique de la ville a récemment fait des travaux dans ce quartier.","Je dois donner des cours d'informatique à un groupe dans cette maison mardi prochain !","J'ai vu plein de cables près de cette maison."] };
	case "Helico": {_msgObj append ["Je crois que ce que vous cherchez est là-bas.","J'ai vu l'hélicopttère essayer de se poser dans ce secteur","J'ai entendu une explosion, le bruit venait de là-bas !","J'ai vu de la fumée par là-bas.","J'ai entendu qu'un sergeant avait abattu un hélicoptère dans cette zone.","Je l'ai vu votre hélicoptère, il est là !"] };
	case "Prisonniers": {_msgObj append ["Je crois que ce que vous cherchez est là-bas.","J'ai entendu une patrouille se plaindre du prisonier qui serait detenu dans ce secteur.","Les insurgés ont récemment renforcés leur patrouilles dans cette zone.","J'ai vu le prisonnier arriver en véhicule, c'était là-bas.","J'ai entendu dire qu'un pilote était détenu dans ce quartier.","Le garagiste a été détenu pendant trois jours dans cette maison !"] };
	case "Sécurisation de véhicule";
	case "Destruction de véhicule": {_msgObj append ["Je crois que ce que vous cherchez est là-bas.","Il y a un véhicule bizarre dans cette zone.","Je suis passé devant leur véhicule en allant faire des course, il était ici !","J'ai entendu qu'un véhicule était stationné dans ce quartier.","J'ai vu un convoi s'arrêter ici.","Oui j'ai vu le tank, près de cette maison !"] };
	default { };
};


private _color = _colorPool select _source;
private _markerType = "";

if (round (random 1) == 0) then {
	_msg = "J'ai des informations.";
	_intelType = selectRandom ODD_var_IntelType;
	ODD_var_IntelType = ODD_var_IntelType + (ODD_var_IntelType - [_intelType]);
	private _pos = [0,0,0];
	private _needMarker = True;

	//["ObjectifPos", "VLCivilPos", "IEDPos", "CheckpointPos", "VLEnemiePos", "MedicalCratePos"];
	switch (_intelType) do {
		case (ODD_var_IntelType select 5): {	// Medical Crate 
			if (count ODD_var_MedicalCrates <= 0) then {
				_msg = selectRandom _msgNoMedical;
				_needMarker = False;
			}
			else {
				_msg = selectRandom _msgMedical;
				_pos = position (selectRandom ODD_var_MedicalCrates);
				_markerType = "loc_heal";
			};
		};
		case (ODD_var_IntelType select 4): {	// VL Enemie pos 
			if (count ODD_var_IAVehicles <= 0) then {
				_msg = selectRandom _msgNoVl;
				_needMarker = False;
			}
			else {
				_msg = selectRandom _msgVl;
				_pos = position (selectRandom ODD_var_IAVehicles);
				_markerType = "loc_defend";
			};
		};
		case (ODD_var_IntelType select 3): {	// checkpoint 
			if (count ODD_var_MissionCheckPoint <= 0) then {
				_msg = selectRandom _msgNoChkpt;
				_needMarker = False;
			}
			else {
				_msg = selectRandom _msgChkpt;
				_pos = position (selectRandom ODD_var_MissionCheckPoint);
				_markerType = "loc_Bunker";
			}
		};
		case (ODD_var_IntelType select 2): {	// IED Pos 
			if (count ODD_var_MissionIED <= 0) then {
				_msg = selectRandom _msgNoIed;
				_needMarker = False;
			}
			else {
				_msg = selectRandom _msgIed;
				_pos = position (selectRandom ODD_var_MissionIED);
				_markerType = "loc_mine";
			};
		};
		case (ODD_var_IntelType select 1): {	// VL civil Pos 
			if (count ODD_var_MissionCivilianVehicles <= 0) then {
				_msg = selectRandom _msgNoTransport;
				_needMarker = False;
			}
			else {
				_msg = selectRandom _msgTransport;
				_pos = position (selectRandom ODD_var_MissionCivilianVehicles);
				_markerType = "loc_Truck";
			};
		};
		case (ODD_var_IntelType select 0);
		default {		//ObjectifPos
			_msg = selectRandom _msgObj;
			if (ODD_var_SelectedMissionType == (ODD_var_MissionType select 2)) then {
				_pos = position (units (ODD_var_Objective select 0) select 0);
			}
			else {
				_pos = position (ODD_var_Objective select 0);
			};
			
			["ODD_task_mission", "UPDATED"] call BIS_fnc_taskHint;

			_markerType = (selectRandom _markerPool)
		};
	};

	if (_needMarker) then {
		_posIntel = _pos getPos [(random 1 * _dist), random 360];

		_marker = createMarker [format["ODDTG %1 %2 %3", (_posIntel select 0), (_posIntel select 1), (_posIntel select 2)], _posIntel,1];
		_marker setMarkertype _markerType;
		_marker setMarkerColor _color;
		_marker setMarkerAlpha 0.8125;
		ODD_var_IntelMarker pushBack _marker;
	};
}
else {
	_msgNon = ["Je ne dirais rien.", "Je ne dirais rien.", "Je ne veux pas vous parler.","Je n'ai rien vu.", "Je ne veux pas parler.","Si je vous parle ma famille est en danger.","VIVA LA REVOLUTION !!","Ils nous écoutent.","Quels manteaux ?","I can't speak french"];
	_msg = selectRandom _msgNon;
};

[_msg] remoteExec ["systemChat", 0];
_msg;

	// private _daytime = daytime;
	// private _hours = floor _daytime;
	// private _minutes = floor ((_daytime - _hours) * 60);
	// private _seconds = floor ((((_daytime - _hours) * 60) - _minutes) * 60);
	// _marker = createMarker [format["ODDTG %1:%2, %3", _hours, _minutes, _seconds], _pos,1];
	// _marker setMarkertype (selectRandom _markerPool);
	// _marker setMarkerColor (selectRandom _colorPool);
	// _marker setMarkertext format["Objectif à %1:%2", _hours, _minutes];
	// ["ODD_task_mission", _pos] call BIS_fnc_taskSetDestination;

/*
Objectif				=> ODD_var_Objective
Véhicule civil 231		=> ODD_var_MissionCivilianVehicles
IED 205					=> ODD_var_MissionIED
Checkpoint 168 ou 154	=> ODD_var_MissionCheckPoint
vehicule ennemi 165		=> ODD_var_IAVehicles
caisse med 172			=> ODD_var_MedicalCrates
maison garnison 218
tour radio 214
*/

