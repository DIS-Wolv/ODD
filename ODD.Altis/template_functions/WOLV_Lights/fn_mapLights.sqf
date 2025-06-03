/*	Document : Wolv_Lights\fn_mapGen.sqf
 *	Fonction : permet d'indiqué sur carte les générateur
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Argument : 
		- _power		:	état souhaité 
 */
 
params ["_power"];

private _center = [worldSize/2, worldSize/2, 0]; //centre de la carte
private _lamps = nearestObjects [_center, WolvLights_var_lampsType, worldSize]; //recupère les générateur de la carte
private _markerGP = [];

{
	_posG = position _x;
	switch (_power) do {
		case 1: {
			_markerGP set [_forEachindex, 
				createMarker [(format ["Lamps P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]
			]; 
			(_markerGP select _forEachindex) setMarkerType "hd_dot";
			(_markerGP select _forEachindex) setMarkerColor "ColorPink";
		};
		case 0;
		default {
			{
				if (_x == format ["Lamps P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]) then{
					deleteMarker (format ["Lamps P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]);
				}
			}forEach allMapMarkers;
		};
	};
	
}foreach _lamps
