
// Message a donner quand on a pas d'intels
ODD_var_intel_msgs_NO = createHashMapFromArray [
	["CIVIL", [
		"Je ne veux pas vous parler.",
		"Je ne veux pas parler.",
		"Je n'ai rien vu.",
		"Si je vous parle ma famille est en danger.",
		"Ils nous écoutent.",
		"Quels manteaux ?",
		"I can't speak french"
	]],
	["OPFOR",[
		"Je ne dirais rien.",
		"Je ne veux pas parler.",
		"VIVA LA REVOLUTION !!",
		"Je ne trahirais pas mes compagnons.",
		"Je ne trahirais pas mes camarades.",
		"I can't speak french",
		"Jean, au secours !",
		"C'est vous les méchants !"
	]],
	["PRENS",[
		"Nous ne savons rien.",
		"Nous n'avons pas d'informations.",
		"Nous n'avons pas d'intels."
	]]
];


// Messages quand pas de caisse médicale ou d'armement
ODD_var_intel_msgs_NO_Crates = createHashMapFromArray [
	["CIVIL", flatten [
		[
			"Leurs infirmeries sont à sec !",
			"Le ravitaillement de matériel médical est attendu depuis plusieurs semaines."
		],
		[
			[
				"Il y a pas",
				"Il n'y a pas",
				"Y a pas",
				"Je ne vois pas",
				"Je n'ai pas vu",
				"Ils n'ont pas",
				"Ils n'ont pas rapporté",
				"Ils n'ont pas stocké",
				"Ils n'ont pas entreposé",
				"Ils n'ont pas déchargé",
				"Ils n'ont plus"
			] apply {
				_debut=_x;
				[
					"caisse médicale",
					"caisse d'armes",
					"caisse de munitions",
					"caisse de ravitaillement",
					"ravitaillement",
					"caisse",
					"materiel médical"
				] apply {
					_caisse=_x;
					[
						"",
						"dans le coin",
						"ici",
						"par ici",
						"par là"
					] apply {
						_debut + " de " + _caisse + _x
					}
				}
			}
		]
	]],
	["OPFOR",flatten [
		[
			[
				"Il y a pas",
				"Il n'y a pas",
				"On a pas",
				"On a pas rapporté"
			] apply {
				_debut=_x;
				[
					"caisse médicale",
					"caisse d'armes",
					"caisse de munitions",
					"caisse de ravitaillement",
					"ravitaillement",
					"caisse"
				] apply {
					_caisse=_x;
					[
						"",
						" ici",
						" par ici",
						" par là",
						", que voullez-vous...",
						". Vous nous prennez pour des faibles ?",
						". Vous nous prennez pour qui ?"
					] apply {
						_debut + " de " + _caisse + _x
					}
				}
			}
		],
		[
			[
				"Ils ne nous ont pas",
				"Ils ont oublie de nous",
				"Ils nous ont pas"
			] apply {
				_debut=_x;
				[
					"ravitaillé",
					"réapprovisionné"
				] apply {
					_caisse=_x;
					[
						"",
						" en armes",
						" en equipement",
						" en munitions",
						" en matériel",
						" en medicaments",
						" en soins"
					] apply {
						_debut + " de " + _caisse + _x
					}
				}
			}
		]
	]],
	["PRENS", flatten [
		[
			[
				"Il n'y a pas",
				"Nos informateurs n'ont pas vu",
				"Nos informateurs n'ont rendu compte"
			] apply {
				_debut=_x;
				[
					" caisse médicale",
					" caisse d'armes",
					" caisse de munitions",
					" caisse de ravitaillement",
					" ravitaillement"
				] apply {
					_caisse=_x;
					[
						"",
						"dans la zone"
					] apply {
						_debut + " de " + _caisse + _x
					}
				}
			}
		]
	]]
];


// Messages quand pas d'ied a proximité
ODD_var_intel_msgs_NO_IED = createHashMapFromArray [
	["CIVIL", flatten [
		[
			[
				"Il y a pas",
				"Il n'y a pas",
				"Y a pas",
				"Je ne vois pas",
				"Je n'ai pas vu"
			] apply {
				_debut=_x;
				[
					"d'IED",
					"d'engins explosifs",
					"de mines"
				] apply {
					_caisse=_x;
					[
						"",
						" dans le coin",
						" ici",
						" par ici",
						" par là"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]],
	["OPFOR",flatten [
		[
			[
				"Il y a pas",
				"Il n'y a pas",
				"On a pas placé"
			] apply {
				_debut=_x;
				[
					"d'IED",
					"d'engins explosifs",
					"de mines"
				] apply {
					_caisse=_x;
					[
						"",
						" ici",
						" par ici",
						" par là",
						", que voullez-vous...",
						". Vous nous prennez pour des faibles ?",
						". Vous nous prennez pour qui ?"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]],
	["PRENS", flatten [
		[
			[
				"Il n'y a pas",
				"Nos informateurs n'ont pas vu",
				"Nos informateurs n'ont rendu compte"
			] apply {
				_debut=_x;
				[
					"d'IED",
					"d'engins explosifs",
					"de mines"
				] apply {
					_caisse=_x;
					[
						"",
						" dans la zone"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]]
];


// Messages quand pas de véhicules enemis
ODD_var_intel_msgs_NO_IAVehicles = createHashMapFromArray [
	["CIVIL", flatten [
		[
			[
				"J'ai entendu",
				"J'ai entendu dire"
			] apply {
				_debut=_x;
				[
					"que leurs véhicules étaient en réparation",
					"que leurs véhicules étaient en panne",
					"que leurs véhicules étaient en train d'être réparés",
					"qu'ils n'avaient pas de véhicules",
					"qu'ils n'ont pas de véhicules"
				] apply {
					_debut + " " + _x
				}
			}
		],
		[
			[
				"Ils ont pris",
				"Ils m'ont pris",
				"Ils m'ont volé"
			] apply {
				_debut=_x;
				[
					"mon véhicule",
					"ma voiture",
					"mon 4x4",
					"mon camion"
				] apply {
					_caisse=_x;
					[
						" car ils n'en avaient pas",
						" car ils n'en ont pas",
						" car ils n'en ont plus"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		],
		[
			[
				"Ils n'ont pas",
				"Les insurgés n'ont pas",
				"Je n'ai pas vu"
			] apply {
				_debut=_x;
				[
					"de véhicules",
					"leurs véhicules"
				] apply {
					_caisse=_x;
					[
						"",
						" ici",
						" par ici"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]],
	["OPFOR",flatten [
		[
			[
				"Nous n'avons pas",
				"On a pas"
			] apply {
				_debut=_x;
				[
					"de vehicule",
					"de tank",
					"de pick up",
					"de BTR"
				] apply {
					_caisse=_x;
					[
						"",
						" ici",
						" par ici",
						" par là",
						", que voullez-vous...",
						". Vous nous prennez pour des faibles ?",
						". Vous nous prennez pour qui ?"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]],
	["PRENS", flatten [
		[
			[
				"Il n'y a pas",
				"Nos informateurs n'ont pas vu",
				"Nos informateurs n'ont rendu compte"
			] apply {
				_debut=_x;
				[
					"de vehicule",
					"de tank",
					"de pick up",
					"de BTR"
				] apply {
					_caisse=_x;
					[
						"",
						" dans la zone"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]]
];


// Messages quand pas de checkpoint
ODD_var_intel_msgs_NO_MissionCheckPoint = createHashMapFromArray [
	["CIVIL", flatten [
		[
			[
				"Ils n'ont pas",
				"Les insurgés n'ont pas",
				"Je n'ai pas vu"
			] apply {
				_debut=_x;
				[
					"de checkpoint",
					"de barrage",
					"de point de contrôle",
					"de poste de contrôle"
				] apply {
					_caisse=_x;
					[
						"",
						" ici",
						" par ici"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]],
	["OPFOR",flatten [
		[
			[
				"Nous n'avons pas",
				"On a pas"
			] apply {
				_debut=_x;
				[
					"de checkpoint",
					"de barrage",
					"de point de contrôle",
					"de poste de contrôle"
				] apply {
					_caisse=_x;
					[
						"",
						" ici",
						" par ici",
						" par là",
						", que voullez-vous...",
						". Vous nous prennez pour des faibles ?",
						". Vous nous prennez pour qui ?"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]],
	["PRENS", flatten [
		[
			[
				"Il n'y a pas",
				"Nos informateurs n'ont pas vu",
				"Nos informateurs n'ont rendu compte"
			] apply {
				_debut=_x;
				[
					"de checkpoint",
					"de barrage",
					"de point de contrôle",
					"de poste de contrôle"
				] apply {
					_caisse=_x;
					[
						"",
						" dans la zone"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]]
];


// Messages quand pas de VL civil
ODD_var_intel_msgs_NO_MissionCivilianVehicles = createHashMapFromArray [
	["CIVIL", flatten [
		[
			[
				"Je n'ai pas",
				"Je n'ai pas vu"
			] apply {
				_debut=_x;
				[
					"de véhicule",
					"de voiture",
					"de 4x4",
					"de camion"
				] apply {
					_debut + " " + _x
				}
			}
		]
	]],
	["OPFOR",flatten [
		[
			[
				"Vous croyez que",
				"Vous vous trompez si vous pensez que"
			] apply {
				_debut=_x;
				[
					"les civils",
					"les habitants",
					"la population locale",
					"les locaux"
				] apply {
					_grp=_x;
					[
						"un véhicule",
						"une voiture",
						"un 4x4",
						"un camion"
					] apply {
						_caisse=_x;
						[
							"",
							", on a déja tout volé !",
							". C'est le tier monde ici."
						] apply {
							_debut + " "+ _grp +  " ont " + _caisse + _x
						}
					}
				}
			}
		]
	]],
	["PRENS", flatten [
		[
			[
				"Il n'y a pas",
				"Nos informateurs n'ont pas vu",
				"Nos informateurs n'ont rendu compte"
			] apply {
				_debut=_x;
				[
					"de véhicule",
					"de voiture",
					"de 4x4",
					"de camion"
				] apply {
					_caisse=_x;
					[
						" civil", 
						" civil dans la zone"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]]
];


// Messages quand pas de camps a proximité
ODD_var_intel_msgs_NO_Outposts = createHashMapFromArray [
	["CIVIL", flatten [
		[
			[
				"Il y a pas",
				"Il n'y a pas",
				"Y a pas",
				"Je ne vois pas",
				"Je n'ai pas vu"
			] apply {
				_debut=_x;
				[
					"de camps",
					"de bases",
					"de postes avancés"
				] apply {
					_caisse=_x;
					[
						"",
						" dans le coin",
						" ici",
						" par ici",
						" par là"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]],
	["OPFOR",flatten [
		[
			[
				"Nous n'avons pas",
				"Nous n'avons pas installé",
				"On a pas installé",
				"On a pas"
			] apply {
				_debut=_x;
				[
					"de camps",
					"de bases",
					"de postes avancés"
				] apply {
					_caisse=_x;
					[
						"",
						" ici",
						" par ici",
						" par là",
						", que voullez-vous...",
						". Vous nous prennez pour des faibles ?",
						". Vous nous prennez pour qui ?"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]],
	["PRENS", flatten [
		[
			[
				"Il n'y a pas",
				"Nos informateurs n'ont pas vu",
				"Nos informateurs n'ont rendu compte"
			] apply {
				_debut=_x;
				[
					"de camps",
					"de bases",
					"de postes avancés"
				] apply {
					_caisse=_x;
					[
						"",
						" dans la zone"
					] apply {
						_debut + " " + _caisse + _x
					}
				}
			}
		]
	]]
];


// le civil est un peu con donc il donne rarrement une grid
ODD_var_intel_proba_civ_grid = 0.2;
// le milouf donne plutot une grid
ODD_var_intel_proba_mil_grid = 0.8;

ODD_var_intel_part_mil_a_vu = [
	"Nous avons placé",
	"Hier, nous avons placé",
	"Ce matin, nous avons placé",
	"La semaine dernière, nous avons placé",
	"Il y a une semaine, nous avons placé",
	"Nous avons installé",
	"Hier, nous avons installé",
	"Ce matin, nous avons installé",
	"La semaine dernière, nous avons installé",
	"Il y a une semaine, nous avons installé",
	"Nous avons",
	"Il y a",
	"Je crois qu'il y a"
];

ODD_var_intel_part_civ_a_vu = [
	"En me balladant, j'ai vu",
	"En me balladant, je crois avoir vu",
	"En me promenant, j'ai vu",
	"En me promenant, je crois avoir vu",
	"Hier, j'ai vu",
	"Hier, je crois avoir vu",
	"Ce matin, j'ai vu",
	"Ce matin, je crois avoir vu",
	"J'ai vu",
	"Je crois avoir vu",
	"Il y a",
	"Je crois qu'il y a"
];
ODD_var_intel_part_civ_a_vu_caisse = ODD_var_intel_part_civ_a_vu + [
	"Je les ai vu stocker",
	"Je les ai vu ranger",
	"Je les ai vu entreposer",
	"Je crois que je les ai vu stocker",
	"Je crois que je les ai vu ranger",
	"Je crois que je les ai vu entreposer",
	"Je crois les avoir vu stocker",
	"Je crois les avoir vu ranger",
	"Je crois les avoir vu entreposer"
];

ODD_var_intel_part_mil_name_IED = [
	"une mine",
	"un piege",
	"un explosif",
	"un engin explosif"
];
ODD_var_intel_part_civ_name_IED = ODD_var_intel_part_mil_name_IED + [
	"un engin de mort"
];

ODD_var_intel_part_mil_name_checkpoint = [
	"un checkpoint",
	"un barrage",
	"un point de contrôle",
	"un poste de contrôle"
];
ODD_var_intel_part_civ_name_checkpoint = ODD_var_intel_part_mil_name_checkpoint;

ODD_var_intel_part_mil_name_outpost = [
	"un camp",
	"une base",
	"un postes avancé"
];
ODD_var_intel_part_civ_name_outpost = ODD_var_intel_part_mil_name_outpost + [
	"un campement",
	"des batiments inconnus",
	"des batiments inhabituels"
];
