/*	Document : Wolv_Lights\fn_mapGen.sqf
 *	Fonction : permet d'indiqué sur carte les générateur
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Argument : 
		- _power		:	état souhaité 
 */

params ["_power"];

private _markerGP = [];

private _center = [worldSize/2, worldSize/2, 0]; //centre de la carte

switch (_power) do {
	case 1: {
		private _Poteau = nearestObjects [_center, [], worldSize]; // recupère tout les obj
		{
			_objType = (getModelInfo _x) select 0;
			
			_isGrandPoteaux = WolvLights_var_grandPoteauType find _objType;
			
			if(_isGrandPoteaux != -1) then {
				_posG = position _x;
				
				_markerGP set [_forEachindex, 
					createMarker [(format ["Poteaux Moyen P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]
				];
				(_markerGP select _forEachindex) setMarkerType "hd_dot";
				(_markerGP select _forEachindex) setMarkerColor "ColorOrange";
					
			};
			
			_isMoyenPoteaux = WolvLights_var_moyenPoteauType find _objType;
			
			if(_isMoyenPoteaux != -1) then {
				_posG = position _x;
				
				_markerGP set [_forEachindex, 
					createMarker [(format ["Poteaux Moyen P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]
				];
				(_markerGP select _forEachindex) setMarkerType "hd_dot";
				(_markerGP select _forEachindex) setMarkerColor "ColorBlue";
					
			};
			
			_isPetitPoteaux = WolvLights_var_petitPoteauType find _objType;
			
			if(_isPetitPoteaux != -1) then {
				_posG = position _x;
				
				_markerGP set [_forEachindex, 
					createMarker [(format ["Poteaux Petit P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]
				];
				(_markerGP select _forEachindex) setMarkerType "hd_dot";
				(_markerGP select _forEachindex) setMarkerColor "ColorGreen";
				//systemChat typeOf _x;
			};
		}forEach _Poteau;
	};
	case 0;
	default {
		{
			_markerN = _x splitString " ";
			if (("Poteaux" in _markerN) or ("" in _markerN)) then {
				deleteMarker(_x);
			};
			sleep 0.05;
			systemChat(str(_forEachIndex));
		}forEach allMapMarkers;
	};
};

systemChat("Map mise à jour !")