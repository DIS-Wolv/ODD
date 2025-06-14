/*
* Auteur : Wolv
* Fonction pour renvoyer le nombre de jours depuis 1/01/2000
*
* Arguments :
*	0 : Date
* 
* Valeur renvoyée :
*
* Exemple :
*	[] call ODDCommon_fnc_dateInNumber
*
* Variable publique :
* 
*/
params [["_date", nil]];

// si la date est pas défini on la met a la date actuel
if (isnil "_date") then {
    _date = date;
};

// renvoie un nombre de jour depuis 2000
// cf https://community.bistudio.com/wiki/dateToNumber
_timedate = ((_date select 0) - 2000) * 365 + ((dateToNumber _date) * 365);


_timedate;
