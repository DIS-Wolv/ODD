/*
* Auteur: Wolv
* Function pour récupérer les véhicules a proximité
* 
* Return Value:
* nil
*
*/

_listVL = nearestObjects [WolvGarage_var_pos, ["car", "tank", "plane", "ship", "helicopter", "ReammoBox_F", "StaticWeapon"], WolvGarage_var_Range];
_listVL = _listVL - [WolvGarage_var_OBJ,armesFob,medicalFob,lanceursFob];
_listVL;

