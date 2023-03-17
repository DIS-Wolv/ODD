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
private _msgNoTransport1 = ["Je n'ai pas de voiture.","Je ne vais pas vous dire ou j'ai garé","Vous n'allez pas tirer ma caisse !","Je vous donnerais pas mes clefs.","Personne ne circule en voiture ici, on pense à la planète nous !"];
private _msgObj1 = ["Je crois que j'ai vu ce que vous cherchez"];
private _msgNon1 = ["Je ne veux pas vous parler.","Je n'ai rien vu.", "Je ne veux pas parler.","Si je vous parle ma famille est en danger.","Ils nous écoutent.","Quels manteaux ?","I can't speak french"];

// ["Caisse", "Tuer un HVT", "Capturer un HVT", "Sécurisation de zone", "intel", "Helico", "Prisonniers", "Sécurisation de véhicule", "Destruction de véhicule"];
switch (_missionType) do {
	case (ODD_var_MissionType select 0): {_msgObj1 append ["J'ai vu des caisses là-bas.","Ils stockent du matériel dans ce bâtiment.","J'ai vu un camion transporter du matériel vers ce quartier.","Ils ont récemment déchargé un camion ici.","Leur ravitaillement est stocké dans cette maison","J'ai entendu une patrouille parler de matériel stocké là bas"] };
	case (ODD_var_MissionType select 1); 
	case (ODD_var_MissionType select 2): {_msgObj1 append ["Leur chef se trouve là-bas.","Je crois que les patrouilles rendent compte dans ce bâtiment","J'ai entendu dire qu'un officier réside dans ce quartier.","Leur leader ce cache ici !","J'ai vu un homme payer leur soldats !","J'ai entendu que ceux qui avaient besoin d'ordres allaient dans ce quartier."] };
	case (ODD_var_MissionType select 3): {_msgObj1 append ["J'ai vu des rebelles planqués dans ce quartier.","J'ai entendu dire qu'il y avait des patrouilles dans ce secteur","Certains de vos ennemis se cachent là-bas"] };
	case (ODD_var_MissionType select 4): {_msgObj1 append ["Le poste de commandement des rebelles se trouve dans cette maison.","J'ai entendu dire que les ordres étaient donnés dans ce quartier.","J'ai entendu une patrouille parler d'un centre de données dans ce secteur.","L'entreprise d'informatique de la ville a récemment fait des travaux dans ce quartier.","Je dois donner des cours d'informatique à un groupe dans cette maison mardi prochain !","J'ai vu plein de cables près de cette maison."] };
	case (ODD_var_MissionType select 5): {_msgObj1 append ["J'ai vu l'hélicopttère essayer de se poser dans ce secteur.","J'ai entendu une explosion, le bruit venait de là-bas !","J'ai vu de la fumée par là-bas.","J'ai entendu qu'un sergeant avait abattu un hélicoptère dans cette zone.","Je l'ai vu votre hélicoptère, il est là !"] };
	case (ODD_var_MissionType select 6): {_msgObj1 append ["J'ai entendu une patrouille se plaindre du prisonier qui serait detenu dans ce secteur.","Les insurgés ont récemment renforcés leur patrouilles dans cette zone.","J'ai vu le prisonnier arriver en véhicule, c'était là-bas.","J'ai entendu dire qu'un pilote était détenu dans ce quartier.","Le garagiste a été détenu pendant trois jours dans cette maison !"] };
	case (ODD_var_MissionType select 7);
	case (ODD_var_MissionType select 8): {_msgObj1 append ["Il y a un véhicule bizarre dans cette zone.","Je suis passé devant leur véhicule en allant faire des course, il était ici !","J'ai entendu qu'un véhicule était stationné dans ce quartier.","J'ai vu un convoi s'arrêter ici.","Oui j'ai vu le tank, près de cette maison !"] };
	default { };
};


private _msgMedical2 = ["Il y a une caisse médicale là-bas.", "C'est là bas que nos blessés sont soignés !", "Le matériel médical est stocké à cette position", "Le matériel médical de surplus est entreposé dans ce bâtiment.","Notre infirmerie se situe dans ce quartier.","Je me souviens avoir été soigné dans ce coin.","Je n'ai pas vu de caisse médicale récemment, mais il y a peut-être une cachée dans ce quartier !"];
private _msgNoMedical2 = ["Je ne sais pas de quoi vous parlez, je n'ai jamais vu de caisse médicale.","Je n'ai pas vu de caisse médicale, et même si je l'avais vue, je ne vous dirais rien.","Je ne pense pas que nous aillons été ravitaillé en matériel médical.","L'infirmerie est à court de matériel médical.","Les infirmeries sont à sec !","Je suis pas un fragile, moi je vais pas a l'infirmerie !"];
private _msgVl2 = ["Un véhicule était stationné ici.","Une patrouille est partie d'ici en véhicule ce matin.","J'espère que vous êtes prêt, on a un char avec nous !","Le véhicule s'arrête souvent là-bas pour se la couler douce.","Un des véhicule est parti là-bas, parce que la station service est à sec !","Un de nos véhicules a pour ordre de tenir cette position."];
private _msgNoVl2 = ["Tout ça pour ça ? Mais on n'a pas de véhicules.","Non, pas de véhicules : on avait pas le budget.", "Le garagiste veut pas travailler pour nous depuis qu'on lui a volé son pickup.","J'ai entendu que les véhicules sont tous en réparation suite a une fausse manoeuvre sur le parking.", "Aucun véhicule ne vous attends."];
private _msgChkpt2 = ["Il y a un point de contrôle là-bas.","J'étais en poste à ce checkpoint ce matin !","J'ai arrêter un mec bizzare avec des abeilles sur cette route.","On a un poste de contrôle routier dans ce secteur","Les les accès à la ville sont filtrés à cet endroit.","Cette route est surveillée."];
private _msgNoChkpt2 = ["Nous ne controllons pas les routes.","Je jamais été de garde a un checkpoint.","Je ne crois pas qu'ont ai déjà des barrages routiers.","Contrôller les routes est au dessus de nos forces.","Nous laissons les civils circuler librement."];
private _msgIed2 = ["J'ai vu des plans, cette route est piégée.","Il y a des explosifs sur le bord de cette route.","J'ai posé des explosifs là-bas !","Le petit nouveau a posé une bombe là-bas.",];
private _msgNoIed2 = ["Nous n'avons pas posé de pièges.","Les routes ne sont pas piégées.","Il n'y a pas d'explosifs pour faire des bombes, sinon vous seriez dejà en morceaux.","Je ne suis pas du génie, et si c'était le cas je vous dirais d'aller vous faire fouttre."];
private _msgTransport2 = ["C'est ici que j'ai garé ma voiture.", "J'ai garé ma voiture là-bas", "Prenez la voiture qui traîne, elle n'est pas fermée !", "Il y a un véhicule que personne n'utilise pas loin","Si vous voulez vous casser, prenez ce véhicule et fouttez moi la paix","Si vous allez là-bas, vous pouvez prendre le véhicule de la mairie"];
private _msgNoTransport2 = ["Je n'ai pas de voiture.","Je ne vais pas vous dire ou j'ai garé la voiture qu'on m'a prêtté","Vous n'allez pas tirer ma caisse nouvelle caisse, je l'ai gagné à la roulette russe contre le maire.","Personne ne circule en voiture ici, on s'en est assuré !","Vous aussi vous volez les voitures aux civils ? Il y en a une pas mal là-bas !"];
private _msgObj2 = ["Je crois que j'ai vu ce que vous cherchez"];
private _msgNon2 = ["Je ne dirais rien.", "Je ne veux pas parler.","VIVA LA REVOLUTION !!","Quels manteaux ?","Je ne trahirais pas mes compagnons.","I can't speak french"];

// ["Caisse", "Tuer un HVT", "Capturer un HVT", "Sécurisation de zone", "intel", "Helico", "Prisonniers", "Sécurisation de véhicule", "Destruction de véhicule"];
switch (_missionType) do {
	case (ODD_var_MissionType select 0): {_msgObj2 append ["J'ai monté la garde devant les caisses de ravitaillement là-bas.","Le matériel est stocké dans ce bâtiment.","J'ai aidé à décharger le camion transportant le matériel dans ce quartier.","Les civils ont récemment aidé au déchargement d'un camion ici.","Le ravitaillement est stocké dans cette maison"] };
	case (ODD_var_MissionType select 1); 
	case (ODD_var_MissionType select 2): {_msgObj2 append ["Notre chef se trouve là-bas.","Notre officier nous donne les ordres dans ce bâtiment","L'officier réside dans ce quartier.","Nous sommes payés en main propre par notre leader dans cette maison !"] };
	case (ODD_var_MissionType select 3): {_msgObj2 append ["J'ai entendu que certains peureux avaient prévu de se cacher dans ce quartier.","J'ai vu qu'il y avait des patrouilles prévues dans ce secteur"] };
	case (ODD_var_MissionType select 4): {_msgObj2 append ["Le poste de commandement se trouve dans cette maison.","Les radios nous sont données dans ce quartier.","J'ai entendu parler d'un centre de données dans ce secteur.","J'ai déroulé plein de cables près de cette maison."] };
	case (ODD_var_MissionType select 5): {_msgObj2 append ["J'ai vu l'hélicopttère essayer de se poser dans ce secteur","J'ai entendu une explosion, le bruit venait de là-bas !","J'ai vu de la fumée par là-bas.","J'ai entendu que le sergeant avait abattu un hélicoptère dans cette zone.","Je l'ai vu votre hélicoptère, il est là !"] };
	case (ODD_var_MissionType select 6): {_msgObj2 append ["J'ai entendu une patrouille se plaindre du prisonier qui serait detenu dans ce secteur.","J'ai vu le prisonnier arriver en véhicule, c'était là-bas.","J'ai entendu dire qu'un pilote était détenu dans ce quartier, j'espère que j'aurais le droit de le torturer aussi.","Les détenus sont enfermés dans cette maison !"] };
	case (ODD_var_MissionType select 7);
	case (ODD_var_MissionType select 8): {_msgObj2 append ["Il y a un véhicule bizarre dans cette zone.","J'ai que le prototype était stationné dans ce quartier.","J'ai vu un convoi s'arrêter ici.","Oui j'ai vu le tank, près de cette maison !"] };
	default { };
};

private _allmsg = []; 
switch (_source) do {
	case 1: { //civils
		_allmsg set [0,_msgMedical1];
		_allmsg set [1,_msgNoMedical1];
		_allmsg set [2,_msgVl1];
		_allmsg set [3,_msgNoVl1];
		_allmsg set [4,_msgChkpt1];
		_allmsg set [5,_msgNoChkpt1];
		_allmsg set [6,_msgIed1];
		_allmsg set [7,_msgNoIed1];
		_allmsg set [8,_msgTransport1];
		_allmsg set [9,_msgNoTransport1];
		_allmsg set [10,_msgObj1];
		_allmsg set [11,_msgNon1];
	};
	case 2: { //opfor
		_allmsg set [0,_msgMedical2];
		_allmsg set [1,_msgNoMedical2];
		_allmsg set [2,_msgVl2];
		_allmsg set [3,_msgNoVl2];
		_allmsg set [4,_msgChkpt2];
		_allmsg set [5,_msgNoChkpt2];
		_allmsg set [6,_msgIed2];
		_allmsg set [7,_msgNoIed2];
		_allmsg set [8,_msgTransport2];
		_allmsg set [9,_msgNoTransport2];
		_allmsg set [10,_msgObj2];
		_allmsg set [11,_msgNon2];
	default { };
};

_allmsg;
