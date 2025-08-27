/*
* Auteur : Wolv
* Fonction pour choisir un batiment dans une liste
*
* Arguments :
*
* Valeur renvoyée :
* Batiment
*
* Exemple:
* [] call ODDcommon_fnc_SelectBuildingInList;
*
* Variable publique :
*	- ODD_var_BuildingGood = []
*   - ODD_var_BuildingNormal = []
*   - ODD_var_BuildingBad = []
*	- ODD_var_BuildingWeightGood = 0.8;
*   - ODD_var_BuildingWeightNormal = 0.5;
*   - ODD_var_BuildingWeightBad = 0.2;
*/
params ["_buildingsList"];

// crée un couple [batiment, poids] pour chaque batiment dans la liste
private _buildWithWeight = _buildingsList apply {
    private _weight = ODD_var_BuildingWeightNormal;
    if (typeOf _x in [ODD_var_BuildingWeightGood]) then {
        _weight = ODD_var_BuildingWeightGood;
    } else {
        if (typeOf _x in [ODD_var_BuildingWeightBad]) then {
            _weight = ODD_var_BuildingWeightBad;
        } else {
            _weight = ODD_var_BuildingWeightNormal;
        };
    };
    [_x, _weight];
};

// flatten de l'array
_buildWithWeight = flatten _buildWithWeight;
// systemChat str _buildWithWeight;

// tire un batiment au hasard en fonction des poids
private _SelectedBuilding = selectRandomWeighted _buildWithWeight;

// retourne le batiment sélectionné
_SelectedBuilding;


