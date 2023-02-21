/*	Document : Wolv_Lights\fn_mapGen.sqf
 *	Fonction : permet d'indiqué sur carte les générateur
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Argument : 
		- _power		:	état souhaité 
 *	Appellé par : addAction
 *		- this addAction ["Cacher les lights",{[0] spawn "scripts\lights\lightsMap.sqf";},[],1.5,True,True,"","True",5];
 *	Apelle : 0/
 */
 
params ["_power"];

private _lamps = nearestObjects [[15000, 15000, 0], WolvLights_var_lampsType, 30000]; //recupère les générateur de la carte
private _markerGP = [0];

{
	_posG = position _x;
	if (_power == 0) then {
		{
			// systemchat(_x);
			//
			if (_x == format ["Lamps P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]) then{
				deleteMarker (format ["Lamps P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]);
			}//*/
			
		}forEach allMapMarkers;
	}
	else {
		if (_power == 1) then {
			_markerGP set [_forEachindex, 
				createMarker [(format ["Lamps P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]
			]; 
			(_markerGP select _forEachindex) setMarkerType "hd_dot";
			(_markerGP select _forEachindex) setMarkerColor "ColorPink";
		}
	}
	
	
	
}foreach _lamps
