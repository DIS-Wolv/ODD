/*
* Author: Wolv
* Fonction pour afficher les information des ODD sur la carte
*
* Arguments:
* 
*
* Return Value:
* nil
*
* Example:
* [] call WOLV_fnc_infoOdd
*
* Public:
*/
player createDiaryRecord ["Diary", ["Crédits ODD", "Un grand merci à Hhaine et Number42 pour leur aide pour la conception et le developpement de scripts, ainsi qu'à tous les joueurs qui ont eu la patiente de tester et de me faire remonter les bugs. Autre participant au develloppement des ODDs : Ascestus, Aqualisa, Bernard"]];
sleep 3;
player createDiaryRecord ["Diary", ["Explications ODD", "Pour générer une mission, approchez vous simplement du panneau des ODDs et utilisez l'addAction 'Générer une mission'. Vous pouvez également supprimer une mission qui ne vous convient pas avec l'interaction 'Nettoyer l'opération'."]];
sleep 3;
player createDiaryRecord ["Diary", ["Présentation ODD", "Les Operations Dynamiques de la DIS, sont des missions générées automatiquement pour la DIS. Cette version, dévellopée par [DIS]Wolv, s'appuie sur le template de mission de la DIS, et est inspirée des célèbres Dynamic Recon Ops d'Epsilon1138."]];
sleep 3;
