/*
* Auteur : Wolv
* Fonction pour assigner le nombre de patrouilles, garnisons et véhicules en réserve dans une zone. 
*
* Arguments :
* 0: Centre de la zone (localité de l'obj) <Objet>
* 1: Activation du débug dans le chat <BOOL>
*
* Valeur renvoyée :
* <ARRAY> [patrolPool, objActive]
*
* Exemple:
* [_zo] call ODDadvanced_fnc_initPatrol
* [_zo, True, False] call ODDadvanced_fnc_initPatrol
*
* Variable publique :
*/

// récupère la taille de la zone d'opération ODD_var_MissionArea

// crée des hélipads invisibles sur chaque localité autout de l'objectif avec ODD_var_MissionArea (+500m ?)

// utilise les fonctions pour calculer les reserves sur chaque localité

// crée et assigne a chaque hélipad une variable contenant les valeurs de reserve pour la zone