/*	Document : Wolv_Lights\fn_moyenPoteaux.sqf
 *	Fonction : execute les action sur les moyens Poteaux
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Argument : 
		- _posPoteau		:	Position du poteau
		- _moyenPoteauPool	:	Liste des grand Poteaux déja changé d'etat
		- _forEachindex		:	numéro du poteau (sert au debug)
		- _rMoyenL			:	raduis de désactivation des lamps
		- _rMoyenP			:	raduis de désactivation des poteaux
		- _rGenP			:	raduis de désactivation des poteaux sur les générateur
		- _state			:	état voulue (0 = eteint, 1 = allumé, 3 = affiché sur carte)
		- _speedL			:	delay entre l'extinction (m/s) des lamps
		- _speedP 			:	delay entre l'extinction (m/s) des poteaux
 
 *	Appellé par : scripts\lights\generators.sqf, scripts\lights\moyenPoteaux.sqf
 *	Apelle : scripts\lights\moyenPoteaux.sqf, scripts\lights\lamps.sqf
 */
//récupération des parametre 
params ["_posPoteau", "_moyenPoteauPool", "_i", "_rMoyenL", "_rMoyenP", "_rGenP", "_state", "_speedL", "_speedP"];

private _posPoteau = 0;
private _marker = [0];
private _markerP = [0];

//liste des grand poteaux et des générateur a proximité
private _moyenPoteau = [];
private _gen = [];

private _map = (findDisplay 12 displayCtrl 51);  // récupères le control de ta map.
private _count = 0;

private _isInPool = _moyenPoteauPool find _posPoteau;		//test si le poteau est deja dans la liste 

if (_isInPool == -1) then {		//si le poteaux n'est pas dans la liste 

	_moyenPoteauPool set [(count _moyenPoteauPool),_posPoteau];		// ajoute dans la liste
	
	if (_state == 3) then {		// si state = 3 alors on veux affiché des marker sur la carte et ne pas changé l'état des poteaux
		//place les 2 marker 
		/*_marker set [_i, createMarker [(format ["Moyen Poteaux Z x %1, y %2, z %3", (_posPoteau select 0), (_posPoteau select 1), (_posPoteau select 2)]), _posPoteau]]; 
		(_marker select _i) setMarkerShape "ELLIPSE";
		(_marker select _i) setMarkerSize [_rMoyenL,_rMoyenL];
		(_marker select _i) setMarkerBrush "SolidBorder";
		(_marker select _i) setMarkerAlpha 0.2; 
		(_marker select _i) setMarkerColor "ColorBlue";//*/
		
		_markerP set [_i, createMarker [(format ["Moyen Poteaux P x %1, y %2, z %3", (_posPoteau select 0), (_posPoteau select 1), (_posPoteau select 2)]), _posPoteau]]; 
		(_markerP select _i) setMarkerType "hd_dot";
		(_markerP select _i) setMarkerColor "ColorBlue";
	}
	else { //sinon on change l'état des poteaux
		if (_state == 4) then {}
		else {
			[_posPoteau, _state, _rMoyenL, _speedL] spawn WolvLights_fnc_lamps; //change le statut des lampe a proximité
		};
	};
	
	//test les objet a proximité
	private _moyenPoteau =  nearestObjects [_posPoteau, [], _rMoyenP, True]; // recupère tout les moyens poteau
	{
		_objType = (getModelInfo _x) select 0;
		_isMoyenPoteaux = WolvLights_var_moyenPoteauType find _objType;
		if (_isMoyenPoteaux != -1) then {
		
			_posPoteauNV = (position _x);
			if (_state == 4) then {
				if (_count <= 3) then {
					_map ctrlAddEventHandler ["Draw",
						format["(_this select 0) drawLine [%1,%2,[0,0,1,1]];", str(_posPoteau), str(_posPoteauNV)]
					];
					_count = _count + 1;
				}
			};
			
			private _gen = nearestObjects [_posPoteau, WolvLights_var_genType, _rGenP / 2, True];
			if ((count _gen) == 0) then {		//si pas de générateur a proximité
				[_posPoteauNV, _moyenPoteauPool, _forEachindex, _rMoyenL, _rMoyenP, _rGenP, _state, _speedL, _speedP] spawn WolvLights_fnc_moyenPoteaux;
			};
		};
	}forEach _moyenPoteau;	
	
};
