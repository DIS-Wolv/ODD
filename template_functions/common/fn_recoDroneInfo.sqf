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

player createDiaryRecord ["Diary", ["Explications Reco Drone", "Pour utiliser la reco drone, placez un point sur la carte à l'endroit où vous souhaitez que le drone fasse sa reco. Vous pouvez également définir le rayon et l'altitude à laquelle vous souhaitez que le drone fasse ca reconnaissance en plaçant simplement un point carte nommé ""RCD X Y Z"" où X est le rayon du cerle, Y l'altitude et Z le nombre de fois ou le drone est redeployer (X, Y et Z sont facultatif)."]];

