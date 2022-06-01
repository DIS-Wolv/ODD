/*	Document : scripts\lights\mapGen.sqf
 *	Fonction : permet d'indiqué sur carte les générateur
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Argument : 
		- _power		:	état souhaité 
 *	Appellé par : addAction
 *		- this addAction ["Cacher les lights",{[0] execVM "scripts\lights\lightsMap.sqf";},[],1.5,true,true,"","true",5];
 *	Apelle : 0/
 */
 
_lampsType = [
    "Land_LampAirport_off_F", 
    "Land_LampAirport_F", 
    "Land_LampDecor_off_F",
    "Land_LampDecor_F",
    "Land_LampHalogen_off_F",
    "Land_LampHalogen_F",
    "Land_LampHarbour_off_F",
    "Land_LampHarbour_F",
    "Land_LampShabby_off_F",
    "Land_LampShabby_F",
    "Land_LampSolar_off_F",
    "Land_LampSolar_F",
    "Land_LampStadium_F",
    "Land_LampStreet_off_F",
    "Land_LampStreet_F",
    "Land_LampStreet_small_off_F",
    "Land_LampStreet_small_F",
    "Land_PowerPoleWooden_L_off_F",
    "Land_PowerPoleWooden_L_F",
    "Land_PowerLine_01_pole_lamp_F",
    "Land_PowerLine_01_pole_lamp_off_F",
    "Land_fs_roof_F",
	//DLC contact
		"Land_LampStreet_02_F",
		"Land_LampStreet_02_off_F",
		"Land_LampStreet_02_triple_F",
		"Land_LampStreet_02_triple_off_F",
		"Land_LampStreet_02_amplion_F",
		"Land_LampStreet_02_amplion_off_F",
		"Land_LampStreet_02_double_F",
		"Land_LampStreet_02_double_off_F",
		"Land_LampIndustrial_02_F",
		"Land_LampIndustrial_02_off_F",
		"Land_LampIndustrial_01_F",
		"Land_LampIndustrial_01_off_F",
		"Land_PowerLine_02_pole_small_lamp_off_F",
		"Land_PowerLine_02_pole_small_lamp_F"
		
]; //liste des lamps

private _lamps = nearestObjects [[15000, 15000, 0], _lampsType, 30000]; //recupère les générateur de la carte
private _markerGP = [0];

private _power = param[0];

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
