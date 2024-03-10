/*
* Ajoute les infos pour la reco drone dans le journal
*
* Arguments :
*
* Valeur renvoyée :
* nil
*
* Exemple:
* [] call DISCommon_fnc_recoDroneInfo
*/

player createDiaryRecord ["Diary", ["Explications Reco Drone", "Pour utiliser la reco drone, placé un point sur la carte à l'endroit où vous souhaitez que le drone fasse sa reco. Vous pouvez également définir la position et l'altitude à laquelle vous souhaitez sauter en plaçant simplement un point carte nommé ""RCD #"" où # est le rayon du cerle."]];

