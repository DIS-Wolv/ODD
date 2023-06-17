/*	Document : Wolv_Lights\fn_petitPoteaux.sqf
 *	Fonction : execute les action sur les petits Poteaux
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Argument : 
		- _posPoteau		:	Position du poteau
		- _petitPoteauPool	:	Liste des grand Poteaux déja changé d'etat
		- _forEachindex		:	numéro du poteau (sert au debug)
		- _rPetitL			:	raduis de désactivation des lamps
		- _rPetitP			:	raduis de désactivation des poteaux
		- _rGenP			:	raduis de désactivation des poteaux sur les générateur
		- _state			:	état voulue (0 = eteint, 1 = allumé, 3 = affiché sur carte)
		- _speedL			:	delay entre l'extinction (m/s) des lamps
		- _speedP 			:	delay entre l'extinction (m/s) des poteaux
 
 *	Appellé par : scripts\lights\generators.sqf, scripts\lights\petitPoteaux.sqf
 *	Apelle : scripts\lights\petitPoteaux.sqf, scripts\lights\lamps.sqf
 */

//récupération des parametre 
params["_posPoteau", "_petitPoteauPool", "_i", "_rPetitL", "_rPetitP", "_rGenP", "_state", "_speedL", "_speedP"];

private _marker = [];
private _markerP = [];

//liste des grand poteaux et des générateur a proximité
private _gen = [];

private _map = (findDisplay 12 displayCtrl 51);  // récupères le control de ta map.
private _count = 0;


private _isInPool = _petitPoteauPool find _posPoteau; 	//test si le poteau est deja dans la liste

if (_isInPool == -1) then {		//si le poteaux n'est pas dans la liste 

	_petitPoteauPool set [(count _petitPoteauPool),_posPoteau];	// ajoute a la liste
	if (_state == 3) then {		// si state = 3 alors on veux affiché des marker sur la carte et ne pas changé l'état des poteaux
		//crée les 2 marker 
		/*_marker set [_i, createMarker [(format ["Petit Poteaux Z x %1, y %2, z %3", (_posPoteau select 0), (_posPoteau select 1), (_posPoteau select 2)]), _posPoteau]]; 
		(_marker select _i) setMarkerShape "ELLIPSE";
		(_marker select _i) setMarkerSize [_rPetitL,_rPetitL];
		(_marker select _i) setMarkerBrush "SolidBorder";
		(_marker select _i) setMarkerAlpha 0.2; 
		(_marker select _i) setMarkerColor "ColorGreen";//*/
		
		_markerP set [_i, createMarker [(format ["Petit Poteaux P x %1, y %2, z %3", (_posPoteau select 0), (_posPoteau select 1), (_posPoteau select 2)]), _posPoteau]]; 
		(_markerP select _i) setMarkerType "hd_dot";
		(_markerP select _i) setMarkerColor "ColorGreen";

	} else {
		if (_state == 4) then {}
		else {
			[_posPoteau, _state, _rPetitL, _speedL] spawn WolvLights_fnc_lamps; //change le statut des lampe a proximité
		};
	};
	
	private _petitPoteau = nearestObjects [_posPoteau, [], _rPetitP, True]; // recupère tout les obj
	{
		_objType = (getModelInfo _x) select 0;
		_isPetitPoteaux = WolvLights_var_petitPoteauType find _objType;
		
		if(_isPetitPoteaux != -1) then {
			
			_posPoteauNV = (position _x);
			if (_state == 4) then {
				if (_count <= 5) then {
					_map ctrlAddEventHandler ["Draw",
						format["(_this select 0) drawLine [%1,%2,[0,0.8,0,1]];", str(_posPoteau), str(_posPoteauNV)]
					];
					_count = _count + 1;
				}
			};
			
			private _gen = nearestObjects [_posPoteau, WolvLights_var_genType, _rGenP / 2, True];
			if ((count _gen) == 0) then {		//si pas de générateur a proximité
				[_posPoteauNV, _petitPoteauPool, _forEachindex, _rPetitL, _rPetitP, _rGenP, _state, _speedL, _speedP] spawn WolvLights_fnc_petitPoteaux;
			};
		};
	} forEach _petitPoteau;
	
};
