Readme_FR
Attention, lisez entièrement le fichier avant de demander de l'aide

Merci d'avoir téléchargé mon script

Sommaire :
I. Utilisation
II. Installation
III. Contact

I. Utilisation :
Au lancement de la mission, pour vérifier l'initialisation du script le message suivant apparaît : "Script de lumière par [DIS]Wolv initialisé".
Si ce n'est pas votre cas, redémarrez votre mission, recommencez l'installation, puis demandez moi de l'aide si les problemes persistent.
Si le script s'est correctement exécuté, lorsque vous vous approchez d'un transformateur électrique, vous aurez les options suivantes dans le menue molette :
	- "Turn ON" : active le transformateur, les lumières à proximité, ainsi que toutes les lumières à proximité des poteaux électriques à proximité jusqu'au transformateur suivant, 
	- "Turn OFF" : désactive le transformateur, les lumières à proximité, ainsi que toutes les lumières à proximité des poteaux électrique à proximité jusqu'au transformateur suivant.

Si vous le souhaitez, vous pouvez faire afficher sur la carte les informations suivantes, au choix, grâce à une interaction sur un objet prédéfini (voir installation).
Les différente action sont les suivantes :
	- soit les transformateurs (conseillé)
	- soit le transformateur et leur rayon d'action sur les lampes 
	- soit les transformateurs ainsi que tous les poteaux connectés (déconseillé car cause des chutes de FPS)


II. Installation :
Afin d'installer correctement le script, veuillez suivre le protocole suivant :
	1. Créez une mission en 3den et la sauvegarder, avec si souhaité un objet avec un nom de variable pour afficher les informations (voir Utilisation)
	2. Ouvrez le dossier de la mission (dans C:\Utilisateur\<VotreUtilisateur>\Documents\Arma 3 - Other Profiles\<VotreProfil>\mpmissions\<NomDeLaMission>)
	3. Créez un dossier nommé "scripts"
	4. Mettez le dossier "lights" dedans
	5. Mise en place du lancement du script
		5.a) A côté du dossier script crée le fichier "initPlayerLocal.sqf"
		5.b) Dedans mettre la ligne de commande suivante : "[] execVM "scripts\lights\init.sqf";"
		5.c) Si vous souhaitez avoir des informations disponibles sur un panneau, ajouté : "<MaVariable> addAction ["Cacher les générateur",{[0] execVM "scripts\lights\mapGen.sqf";},[],1.5,true,true,"","true",5];"
			Ainsi que UNE des lignes suivantes au choix :
			- Pour avoir UNIQUEMENT les transformateurs sur la carte :
				"<MaVariable> addAction ["Afficher les générateur",{[1] execVM "scripts\lights\mapGen.sqf";},[],1.5,true,true,"","true",5];"
			- Pour avoir les transformateurs et leur rayon d'action sur les lampes sur la carte :
				"<MaVariable> addAction ["Afficher les générateur",{[2] execVM "scripts\lights\mapGen.sqf";},[],1.5,true,true,"","true",5];"
			- Pour les transformateurs ainsi que tous les poteaux connectés sur la carte :
				"<MaVariable> addAction ["Afficher les générateur",{[3] execVM "scripts\lights\mapGen.sqf";},[],1.5,true,true,"","true",5];"
			Remplacez <MaVariable> par le nom de l'objet sur le quelles vos voulé les actions pour affiché ou cache les informations.
	6. Lancez la mission et vérifié si le message d'initialisation s'affiche.
	7. Profitez
	
III. Contact :
Si vous souhaitez une aide quelconque pour la mise en place ou le dépannage du script, je vous invite à me mettre un message sur discord : Wolv#2393
Si vous souhaitez rejoindre un team de simulation militaire française, je vous invite à rejoindre la DIS : https://discord.gg/7wHQqe7cXX

Merci d'avoir téléchargé mon script
