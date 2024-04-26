/*
* Auteur : Wolv
* Fonction pour importé les donnée de la mission
*
* Arguments :
*	0 : Donnée a importé (Array)
* 
* Valeur renvoyée :
*
* Exemple :
* 
*
* Variable publique :
* 
*/


params [["_data", createHashMap]];
_data = createHashMapFromArray _data;

private _locData = _data get "LocData";
if (!isNil "_locData") then {
	_locData = createHashMapFromArray _locData;
	{
		_maLocData = _locData get (text _x);
		_maLocData = createHashMapFromArray _maLocData;

		private _varToSet = ["odd_var_acteni", "odd_var_tgteni", "ODD_var_prcRecrut", "ODD_var_isBlue", "ODD_var_isFrontLine"];
		
		if(!isNil "_maLocData") then {
			private _maLoc = _x;
			{
				private _value = _maLocData get _x;
				if (!isNil "_value") then {
					_maLoc setVariable [_x, _value];
				};

			} forEach _varToSet;
		};

	} forEach ODDvar_mesLocations;
};

_varToSet = ["ODD_var_CivilianReputation"];
{
	private _value = _data get _x;
	if (!isNil "_value") then {
		_x setVariable [_x, _value];
	};

} forEach _varToSet;

