params [["_source",0],["_missionType",(ODD_var_MissionType select 0)]];

private _msgMedical1 = ["Il y a une caisse médicale là-bas.", "J'ai vu une caisse médicale là-bas.", "C'est là bas qu'ils soignent leurs blessés !", "J'ai entendu que leur matériel médical étaient stocké à cette position", "Si vous cherchez de quoi vous soigner, cherchez dans ce quartier", "Je sais qu'ils entreposent du matériel médical à cette position"];
private _msgNoMedical1 = ["Je n'ai pas vu de caisse médicale.","Je n'ai repéré aucune caisse médicale.","Je ne pense pas qu'ils aient de matériel médical.","Ils sont a court de matériel médical.","Ils n'ont plus de matériel médical !","Leurs infirmeries sont à sec !","Le ravitaillement de matériel médical est attendu depuis plusieurs semaines."];
private _msgVl1 = ["J'ai vu un de leur véhicules.","Ils sont passés en véhicule ce matin.","Je crois que vos ennemis sont soutenus par des véhicules","J'ai entendu dire que des véhicules patrouillent la zone.","Leurs véhicules patrouillent la zone !","Leurs véhicules ont sifflé tout le fuel de la station service !","J'ai entendu une patrouille dire que leur véhicule avait été réparé."];
private _msgNoVl1 = ["Ils n'ont pas de véhicules.","Les insurgés n'ont pas de véhicules.", "La station service est encore bien approvisionnée","Je n'ai pas vu de véhicule.","J'ai entendu que leurs véhicules étaient en réparation", "Ils ont pris ma voiture parce qu'ils ne voulaient pas marcher"];
private _msgChkpt1 = ["J'ai vu qu'ils controllaient des véhicules là-bas.","J'ai été arrêté à ce checkpoint ce matin !","L'apiculteur s'est fait arrêter à ce checkpoint.","J'ai vu un carton magnifique à ce point de contrôle, y'en a qui conduisent vraiment comme des pieds","Les rebelles controllent les accès à la ville à cet endroit.","Cette route est surveillée."];
private _msgNoChkpt1 = ["Vos ennemis ne controllent pas les routes.","Je n'ai pas vu de checkpoints.","Je ne crois pas qu'ils aient installé de barrages routiers.","Les routes ne sont pas contrôllées","Nous pouvons circuler librement."];
private _msgIed1 = ["J'ai vu les insurgés piéger cette route.","Il y a des explosifs sur le bord de cette route.","J'ai vu des explosifs là-bas !","Attention au pièges sur cette route.","J'ai entendu qu'ils avaient posé une bombe là-bas.","Evitez cette route là !"];
private _msgNoIed1 = ["Je n'ai pas vu de pièges.","Je crois que les routes ne sont pas piégées.","J'ai entendu les rebelles se plaindre qu'ils n'avaient pas d'explosifs.","Les insurgents essayent de respecter les LOAC.","Je n'ai pas posé d'IED récemment !"];
private _msgTransport1 = ["C'est ici que j'ai garé ma voiture.", "J'ai garé ma voiture là-bas", "Prenez ma voiture elle n'est pas fermée !", "Il y a un véhicule que personne n'utilise pas loin","Utilisez ce véhicule si vous voulez.", "Si vous voulez, ce véhicule peut vous aider à vous déplacer plus vite","Si vous allez là-bas, vous pouvez prendre le véhicule de la mairie"];
private _msgNoTransport1 = ["Je n'ai pas de voiture.","Je ne vais pas vous dire ou j'ai garé","Vous n'allez pas tirer ma caisse","Je vous donnerais pas mes clefs","Personne ne circule en voiture ici, on pense à la planète nous !"];
private _msgObj1 = ["Je crois que j'ai vu ce que vous cherchez"];

// ["Caisse", "Tuer un HVT", "Capturer un HVT", "Sécurisation de zone", "intel", "Helico", "Prisonniers", "Sécurisation de véhicule", "Destruction de véhicule"];
switch (_missionType) do {
	case (ODD_var_MissionType select 0): {_msgObj1 append ["J'ai vu des caisses là-bas.","Ils stockent du matériel dans ce bâtiment.","Je crois que ce que vous cherchez est là-bas.","J'ai vu un camion transporter du matériel vers ce quartier.","Ils ont récemment déchargé un camion ici.","Leur ravitaillement est stockée dans cette maison","J'ai entendu une patrouille parler de matériel stocké là bas"] };
	case (ODD_var_MissionType select 1); 
	case (ODD_var_MissionType select 2): {_msgObj1 append ["Je crois que ce que vous cherchez est là-bas.","Leur chef se trouve là-bas.","Je crois que les patrouilles rendent compte dans ce bâtiment","J'ai entendu dire qu'un officier réside dans ce quartier.","Leur leader ce cache ici !","J'ai vu un homme payer leur soldats !","J'ai entendu que ceux qui avaient besoin d'ordres allaient dans ce quartier."] };
	case (ODD_var_MissionType select 3): {_msgObj1 append ["J'ai vu des rebelles planqués dans ce quartier.","J'ai entendu dire qu'il y avait des patrouilles dans ce secteur","Certains de vos ennemis se cachent là-bas"] };
	case (ODD_var_MissionType select 4): {_msgObj1 append ["Je crois que ce que vous cherchez est là-bas.","Le poste de commandement des rebelles se trouve dans cette maison.","J'ai entendu dire que les ordres étaient donnés dans ce quartier.","J'ai entendu une patrouille parler d'un centre de données dans ce secteur.","L'entreprise d'informatique de la ville a récemment fait des travaux dans ce quartier.","Je dois donner des cours d'informatique à un groupe dans cette maison mardi prochain !","J'ai vu plein de cables près de cette maison."] };
	case (ODD_var_MissionType select 5): {_msgObj1 append ["Je crois que ce que vous cherchez est là-bas.","J'ai vu l'hélicopttère essayer de se poser dans ce secteur","J'ai entendu une explosion, le bruit venait de là-bas !","J'ai vu de la fumée par là-bas.","J'ai entendu qu'un sergeant avait abattu un hélicoptère dans cette zone.","Je l'ai vu votre hélicoptère, il est là !"] };
	case (ODD_var_MissionType select 6): {_msgObj1 append ["Je crois que ce que vous cherchez est là-bas.","J'ai entendu une patrouille se plaindre du prisonier qui serait detenu dans ce secteur.","Les insurgés ont récemment renforcés leur patrouilles dans cette zone.","J'ai vu le prisonnier arriver en véhicule, c'était là-bas.","J'ai entendu dire qu'un pilote était détenu dans ce quartier.","Le garagiste a été détenu pendant trois jours dans cette maison !"] };
	case (ODD_var_MissionType select 7);
	case (ODD_var_MissionType select 8): {_msgObj1 append ["Je crois que ce que vous cherchez est là-bas.","Il y a un véhicule bizarre dans cette zone.","Je suis passé devant leur véhicule en allant faire des course, il était ici !","J'ai entendu qu'un véhicule était stationné dans ce quartier.","J'ai vu un convoi s'arrêter ici.","Oui j'ai vu le tank, près de cette maison !"] };
	default { };
};


private _msgMedical2 = ["Il y a une caisse médicale là-bas.", "C'est là bas que nos blessés sont soignés !", "Le matériel médical est stocké à cette position", "Le matériel médical de surplus est entreposé dans ce bâtiment."];
private _msgNoMedical2 = ["Je n'ai pas vu de caisse médicale.","Je n'ai repéré aucune caisse médicale.","Je ne pense pas qu'ils aient de matériel médical.","Ils sont a court de matériel médical.","Ils n'ont plus de matériel médical !","Leurs infirmeries sont à sec !","Le ravitaillement de matériel médical est attendu depuis plusieurs semaines."];
private _msgVl2 = ["J'ai vu un de leur véhicules.","Ils sont passés en véhicule ce matin.","Je crois que vos ennemis sont soutenus par des véhicules","J'ai entendu dire que des véhicules patrouillent la zone.","Leurs véhicules patrouillent la zone !","Leurs véhicules ont sifflé tout le fuel de la station service !","J'ai entendu une patrouille dire que leur véhicule avait été réparé."];
private _msgNoVl2 = ["Ils n'ont pas de véhicules.","Les insurgés n'ont pas de véhicules.", "La station service est encore bien approvisionnée","Je n'ai pas vu de véhicule.","J'ai entendu que leurs véhicules étaient en réparation", "Ils ont pris ma voiture parce qu'ils ne voulaient pas marcher"];
private _msgChkpt2 = ["J'ai vu qu'ils controllaient des véhicules là-bas.","J'ai été arrêté à ce checkpoint ce matin !","L'apiculteur s'est fait arrêter à ce checkpoint.","J'ai vu un carton magnifique à ce point de contrôle, y'en a qui conduisent vraiment comme des pieds","Les rebelles controllent les accès à la ville à cet endroit.","Cette route est surveillée."];
private _msgNoChkpt2 = ["Vos ennemis ne controllent pas les routes.","Je n'ai pas vu de checkpoints.","Je ne crois pas qu'ils aient installé de barrages routiers.","Les routes ne sont pas contrôllées","Nous pouvons circuler librement."];
private _msgIed2 = ["J'ai vu les insurgés piéger cette route.","Il y a des explosifs sur le bord de cette route.","J'ai vu des explosifs là-bas !","Attention au pièges sur cette route.","J'ai entendu qu'ils avaient posé une bombe là-bas.","Evitez cette route là !"];
private _msgNoIed2 = ["Je n'ai pas vu de pièges.","Je crois que les routes ne sont pas piégées.","J'ai entendu les rebelles se plaindre qu'ils n'avaient pas d'explosifs.","Les insurgents essayent de respecter les LOAC."];
private _msgTransport2 = ["C'est ici que j'ai garé ma voiture.", "J'ai garé ma voiture là-bas", "Prenez ma voiture elle n'est pas fermée !", "Il y a un véhicule que personne n'utilise pas loin","Utilisez ce véhicule si vous voulez.", "Si vous voulez, ce véhicule peut vous aider à vous déplacer plus vite","Si vous allez là-bas, vous pouvez prendre le véhicule de la mairie"];
private _msgNoTransport2 = ["Je n'ai pas de voiture.","Je ne vais pas vous dire ou j'ai garé","Vous n'allez pas tirer ma caisse","Je vous donnerais pas mes clefs","Personne ne circule en voiture ici, on pense à la planète nous !"];
private _msgObj2 = ["Je crois que j'ai vu ce que vous cherchez"];

// ["Caisse", "Tuer un HVT", "Capturer un HVT", "Sécurisation de zone", "intel", "Helico", "Prisonniers", "Sécurisation de véhicule", "Destruction de véhicule"];
switch (_missionType) do {
	case (ODD_var_MissionType select 0): {_msgObj2 append ["J'ai vu des caisses là-bas.","Ils stockent du matériel dans ce bâtiment.","Je crois que ce que vous cherchez est là-bas.","J'ai vu un camion transporter du matériel vers ce quartier.","Ils ont récemment déchargé un camion ici.","Leur ravitaillement est stockée dans cette maison","J'ai entendu une patrouille parler de matériel stocké là bas"] };
	case (ODD_var_MissionType select 1); 
	case (ODD_var_MissionType select 2): {_msgObj2 append ["Je crois que ce que vous cherchez est là-bas.","Leur chef se trouve là-bas.","Je crois que les patrouilles rendent compte dans ce bâtiment","J'ai entendu dire qu'un officier réside dans ce quartier.","Leur leader ce cache ici !","J'ai vu un homme payer leur soldats !","J'ai entendu que ceux qui avaient besoin d'ordres allaient dans ce quartier."] };
	case (ODD_var_MissionType select 3): {_msgObj2 append ["J'ai vu des rebelles planqués dans ce quartier.","J'ai entendu dire qu'il y avait des patrouilles dans ce secteur","Certains de vos ennemis se cachent là-bas"] };
	case (ODD_var_MissionType select 4): {_msgObj2 append ["Je crois que ce que vous cherchez est là-bas.","Le poste de commandement des rebelles se trouve dans cette maison.","J'ai entendu dire que les ordres étaient donnés dans ce quartier.","J'ai entendu une patrouille parler d'un centre de données dans ce secteur.","L'entreprise d'informatique de la ville a récemment fait des travaux dans ce quartier.","Je dois donner des cours d'informatique à un groupe dans cette maison mardi prochain !","J'ai vu plein de cables près de cette maison."] };
	case (ODD_var_MissionType select 5): {_msgObj2 append ["Je crois que ce que vous cherchez est là-bas.","J'ai vu l'hélicopttère essayer de se poser dans ce secteur","J'ai entendu une explosion, le bruit venait de là-bas !","J'ai vu de la fumée par là-bas.","J'ai entendu qu'un sergeant avait abattu un hélicoptère dans cette zone.","Je l'ai vu votre hélicoptère, il est là !"] };
	case (ODD_var_MissionType select 6): {_msgObj2 append ["Je crois que ce que vous cherchez est là-bas.","J'ai entendu une patrouille se plaindre du prisonier qui serait detenu dans ce secteur.","Les insurgés ont récemment renforcés leur patrouilles dans cette zone.","J'ai vu le prisonnier arriver en véhicule, c'était là-bas.","J'ai entendu dire qu'un pilote était détenu dans ce quartier.","Le garagiste a été détenu pendant trois jours dans cette maison !"] };
	case (ODD_var_MissionType select 7);
	case (ODD_var_MissionType select 8): {_msgObj2 append ["Je crois que ce que vous cherchez est là-bas.","Il y a un véhicule bizarre dans cette zone.","Je suis passé devant leur véhicule en allant faire des course, il était ici !","J'ai entendu qu'un véhicule était stationné dans ce quartier.","J'ai vu un convoi s'arrêter ici.","Oui j'ai vu le tank, près de cette maison !"] };
	default { };
};

private _allmsg = []; 
switch (_source) do {
	case 1: { //civils
		_allmsg set [0,_msgMedical1];
		_allmsg set [0,_msgNoMedical1];
		_allmsg set [0,_msgVl1];
		_allmsg set [0,_msgNoVl1];
		_allmsg set [0,_msgChkpt1];
		_allmsg set [0,_msgNoChkpt1];
		_allmsg set [0,_msgIed1];
		_allmsg set [0,_msgNoIed1];
		_allmsg set [0,_msgTransport1];
		_allmsg set [0,_msgNoTransport1];
		_allmsg set [0,_msgObj1];
	};
	case 2: { //opfor
		_allmsg set [0,_msgMedical2];
		_allmsg set [0,_msgNoMedical2];
		_allmsg set [0,_msgVl2];
		_allmsg set [0,_msgNoVl2];
		_allmsg set [0,_msgChkpt2];
		_allmsg set [0,_msgNoChkpt2];
		_allmsg set [0,_msgIed2];
		_allmsg set [0,_msgNoIed2];
		_allmsg set [0,_msgTransport2];
		_allmsg set [0,_msgNoTransport2];
		_allmsg set [0,_msgObj2];};
	default { };
};

_allmsg;
