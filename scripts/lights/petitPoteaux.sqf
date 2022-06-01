/*	Document : scripts\lights\petitPoteaux.sqf
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

_genType = ["Land_spp_Transformer_F", "Land_dp_transformer_F","Land_TBox_F",
	//compat CUP
		"Land_Trafostanica_mala","Land_Trafostanica_velka", "Land_Substation_01_F"	
	];		//liste des générateur
	
_petitPoteauType = ["powerpolewooden_f.p3d","powerpolewooden_small_f.p3d","powerpolewooden_l_off_f.p3d","powerpolewooden_l_f.p3d","lampshabby_off_f.p3d","lampshabby_f.p3d",
		"powerline_02_pole_small_f.p3d","powerline_02_pole_small_a_f.p3d",
	// compatibilité JBAD (Lythium)
		"jbad_powlines_conc1.p3d","jbad_powlines_conc2l.p3d","powerpoleconcrete_f.p3d", 
	//CUP
		"powlines_conc1.p3d", "powlines_conc3.p3d", "misc_amplion_conc.p3d","powlines_concl.p3d","powlines_conca.p3d",
		"powlines_wood1.p3d", "powlines_wood2.p3d","powlines_wooda.p3d","powlines_woodl.p3d","misc_amplion_wood.p3d", "sloupyeli.p3d","sloupyele.p3d", 
	//compat DLC contact
		"powerline_03_pole_junction_f.p3d", "powerline_03_pole_f.p3d","powerline_02_pole_small_a_f.p3d", "powerline_02_pole_small_hook_f.p3d",
		"powerline_02_pole_small_hook_junction_f.p3d", "power_pole_wood1.p3d", "powerline_02_pole_junction_a_f.p3d", "powerline_02_pole_small_end_a_f.p3d",
		"powerline_03_pole_end_f.p3d"
	];	//liste des petit poteau (le ".p3d" est essentiel car il s'agit de model 3D des objet, voir note en bas de page de generators.sqf)

private _posPoteau = 0;
private _marker = [0];
private _markerP = [0];

//liste des grand poteaux et des générateur a proximité
private _gen = [];

private _map = (findDisplay 12 displayCtrl 51);  // récupères le control de ta map.
private _count = 0;

//récupération des parametre 
_posPoteau = param[0];
_petitPoteauPool = param[1];
_i = param[2];
_rPetitL = param[3];
_rPetitP = param[4];
_rGenP = param[5];
_state = param[6];
_speedL = param[7];
_speedP = param[8];


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
			[_posPoteau, _state, _rPetitL, _speedL] execVM "scripts\lights\lamps.sqf";//change le statut des lampe a proximité
		};
	};
	
	private _petitPoteau = nearestObjects [_posPoteau, [], _rPetitP, true]; // recupère tout les obj
	{
		_objType = (getModelInfo _x) select 0;
		_isPetitPoteaux = _petitPoteauType find _objType;
		
		if(_isPetitPoteaux != -1) then {
			
			_posPoteauNV = (position _x);
			if (_state == 4) then {
				if (_count <= 3) then {
					_map ctrlAddEventHandler ["Draw",
						format["(_this select 0) drawLine [%1,%2,[0,0.8,0,1]];", str(_posPoteau), str(_posPoteauNV)]
					];
					_count = _count + 1;
				}
			};
			
			private _gen = nearestObjects [_posPoteau, _genType, _rGenP / 2, true];
			if ((count _gen) == 0) then {		//si pas de générateur a proximité
				[_posPoteauNV, _petitPoteauPool, _forEachindex, _rPetitL, _rPetitP, _rGenP, _state, _speedL, _speedP] execVM "scripts\lights\petitPoteaux.sqf";
			};
		};
	} forEach _petitPoteau;
	
};
