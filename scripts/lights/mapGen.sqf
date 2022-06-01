/*	Document : scripts\lights\mapGen.sqf
 *	Fonction : permet d'indiqué sur carte les générateur
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Argument : 
		- _power		:	état souhaité 
 *	Appellé par : addAction
 *		- this addAction ["Cacher les générateur",{[Parrametre] execVM "scripts\lights\mapGen.sqf";},[],1.5,true,true,"","true",5];
 *	Apelle : 0/
 */
 
_genType = ["Land_spp_Transformer_F", "Land_dp_transformer_F","Land_TBox_F",
	//compat CUP
		"Land_Trafostanica_mala","Land_Trafostanica_velka", "Land_Substation_01_F"	
	];		//liste des générateur
	
_petitPoteauType = ["powerpolewooden_f.p3d","powerpolewooden_small_f.p3d","powerpolewooden_l_off_f.p3d","powerpolewooden_l_f.p3d","lampshabby_off_f.p3d","lampshabby_f.p3d",
	"jbad_powlines_conc1.p3d","jbad_powlines_conc2l.p3d","powerpoleconcrete_f.p3d", // compatibilité JBAD
	"powlines_conc1.p3d", "powlines_conc3.p3d", "misc_amplion_conc.p3d","powlines_concl.p3d","powlines_conca.p3d",	// Compat CUP
	"powlines_wood1.p3d", "powlines_wood2.p3d","powlines_wooda.p3d","powlines_woodl.p3d","misc_amplion_wood.p3d"	// compat CUP
	];
	//liste des petit Poteaux (le ".p3d" est essentiel car il s'agit de model 3D des objet, voir note en bas de page)
	
_moyenPoteauType = ["highvoltagecolumn_f.p3d",	//Altis
	"powerline_01_pole_junction_f.p3d","powerline_01_pole_small_f.p3d","powerline_01_pole_tall_f.p3d", "powerline_01_pole_transformer_f.p3d", //Malden
	"powerline_01_pole_end_v1_f.p3d","powerline_01_pole_end_v2_f.p3d","powerline_01_pole_lamp_f.p3d", //Tanoa
	"jbad_powlineb.p3d"]; // compatibilité JBAD
	//liste des moyen Poteaux
	
_grandPoteauType = ["highvoltagetower_largecorner_f.p3d","highvoltagetower_large_f.p3d","highvoltageend_f.p3d",
	"sloup_vn.p3d"	//compat CUP
	];	//liste des grand Poteaux
	
//Radius Gen
private  _rGenP = 800; 	//raduis de désactivation des poteaux
private _rGenL = 500;	//raduis de désactivation des lamps

//Radius Petit poteau
private _rPetitP = 130; //raduis de désactivation des poteaux
private _rPetitL = 150; //raduis de désactivation des lamps

//Radius Moyen poteau
private _rMoyenP = 150; //raduis de désactivation des poteaux
private _rMoyenL = 160; //raduis de désactivation des lamps

//Radius Moyen poteau
private _rGrandP = 250;	//raduis de désactivation des poteaux
private _rGrandL = 250;	//raduis de désactivation des lamps

private _markerG = [0];
private _markerGP = [0];
private _posG = [0,0,0];
private _gen = nearestObjects [[15000, 15000, 0], _genType, 30000]; //recupère les générateur de la carte

private _map = (findDisplay 12 displayCtrl 51);  // récupères le control de ta map.

private _state = 3; // ici on ne veux que l'affichage

//delay entre l'extinction (m/s)
private _speedL = 0; 	// des poteaus
private _speedP = 2000; 	// des lampes

private _power = param[0];

private _markerN = "";

//groupe de poteaux deja changé d'etat
private _petitPoteauPool = [0]; //Petit
private _moyenPoteauPool = [0];	//moyen
private _grandPoteauPool = [0];	//grand


{
    _posG = position _x;	//recupère la position

	if (_power == 3) then {	//a 3 affiche les générateur et leur rayon d'action et les poteaux

		/*_markerG set [_forEachindex, createMarker [(format ["Gen Z %1", _forEachindex]), _posG]]; 
		(_markerG select _forEachindex) setMarkerShape "ELLIPSE";
		(_markerG select _forEachindex) setMarkerSize [_rGenP,_rGenP];
		(_markerG select _forEachindex) setMarkerBrush "SolidBorder";
		(_markerG select _forEachindex) setMarkerAlpha 0.2; 
		(_markerG select _forEachindex) setMarkerColor "ColorYellow";	// rayon d'action des générateur affiché sur carte*/
		
		_markerGP set [_forEachindex, createMarker [(format ["Gen P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]]; 
		(_markerGP select _forEachindex) setMarkerType "loc_Power";
		(_markerGP select _forEachindex) setMarkerColor "ColorYellow";
		
		private _poteau = nearestObjects [_posG, [], _rGenP, true]; 	// recupère tout les obj
		
		
		{		//pour chaque petit poteau
			_objType = (getModelInfo _x) select 0; //récupère l'élément 0 des info de l'objet voir note en bas de page de generators.sqf
			
			_isPetitPoteaux = _petitPoteauType find _objType;		//verifie qu'il s'ajit d'un petit poteau
			if(_isPetitPoteaux != -1) then {  	//si c'est un petit poteaux
				_posPoteau = (position _x); 	//recupère ca position et appel le script
				[_posPoteau, _petitPoteauPool, _forEachindex, _rPetitL, _rPetitP, _rGenP, _state, _speedL, _speedP] execVM "scripts\lights\petitPoteaux.sqf";
			}; 
			
			_isGrandPoteaux = _grandPoteauType find _objType;		//verifie qu'il s'ajit d'un grand poteau
			if(_isGrandPoteaux != -1) then {  	//si c'est un grand poteaux
				_posPoteau = (position _x);	// recupère ca position et appel le script
				[_posPoteau, _grandPoteauPool, _forEachindex, _rGrandL, _rGrandP, _rGenP, _state, _speedL, _speedP] execVM "scripts\lights\grandPoteaux.sqf";
			};
			
			_isMoyenPoteaux = _moyenPoteauType find _objType;		//verifie qu'il s'ajit d'un moyen poteau
			if(_isMoyenPoteaux != -1) then {  	//si c'est un moyen poteaux
				_posPoteau = (position _x); 	// recupère ca position et appel le script
				[_posPoteau, _moyenPoteauPool, _forEachindex, _rMoyenL, _rMoyenP, _rGenP,_state, _speedL, _speedP] execVM "scripts\lights\moyenPoteaux.sqf";
			};
		} forEach _poteau; 
		
		sleep 0.1;
	}
	else {
		if (_power == 2) then {	//a 2 affiche les générateur et leur rayon d'action
			_markerG set [_forEachindex, createMarker [(format ["Gen Z x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]]; 
			(_markerG select _forEachindex) setMarkerShape "ELLIPSE";
			(_markerG select _forEachindex) setMarkerSize [_rGenL,_rGenL];
			(_markerG select _forEachindex) setMarkerBrush "SolidBorder";
			(_markerG select _forEachindex) setMarkerAlpha 0.2; 
			(_markerG select _forEachindex) setMarkerColor "ColorYellow";	// rayon d'action des générateur affiché sur carte
			
			_markerGP set [_forEachindex, createMarker [(format ["Gen P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]]; 
			(_markerGP select _forEachindex) setMarkerType "loc_Power";
			(_markerGP select _forEachindex) setMarkerColor "ColorYellow";
			
			sleep 0.25;
		}
		else {
			if (_power == 1) then {	//a 1 affiche que les points des générateur
				_markerGP set [_forEachindex, createMarker [(format ["Gen P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]]; 
				(_markerGP select _forEachindex) setMarkerType "loc_Power";
				(_markerGP select _forEachindex) setMarkerColor "ColorYellow";
				
				sleep 0.25;
			} 
			else {
				if (_power == 4) then {
					_markerGP set [_forEachindex, createMarker [(format ["Gen P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]]; 
					(_markerGP select _forEachindex) setMarkerType "loc_Power";
					(_markerGP select _forEachindex) setMarkerColor "ColorYellow";
					
					_state = 4;
					
					private _poteau = nearestObjects [_posG, [], _rGenP, true]; 	// recupère tout les obj
					{		//pour chaque petit poteau
						_objType = (getModelInfo _x) select 0; //récupère l'élément 0 des info de l'objet voir note en bas de page de generators.sqf
						
						_isPetitPoteaux = _petitPoteauType find _objType;		//verifie qu'il s'ajit d'un petit poteau
						if(_isPetitPoteaux != -1) then {  	//si c'est un petit poteaux
							_posPoteau = (position _x); 	//recupère ca position et appel le script
							[_posPoteau, _petitPoteauPool, _forEachindex, _rPetitL, _rPetitP, _rGenP, _state, _speedL, _speedP] execVM "scripts\lights\petitPoteaux.sqf";
						}; 
						
						_isMoyenPoteaux = _moyenPoteauType find _objType;
						if(_isMoyenPoteaux != -1) then {  	//si c'est un petit poteaux
							_posPoteau = (position _x); 	// recupère ca position et appel le script
							[_posPoteau, _moyenPoteauPool, _forEachindex, _rMoyenL, _rMoyenP, _rGenP, _state, _speedL, _speedP] execVM "scripts\lights\moyenPoteaux.sqf";
						}; 
						
						_isGrandPoteaux = _grandPoteauType find _objType;
						if(_isGrandPoteaux != -1) then {  	//si c'est un petit poteaux
							_posPoteau = (position _x); 	//recupère ca position et appel le script
							[_posPoteau, _grandPoteauPool, _forEachindex, _rGrandL, _rGrandP, _rGenP, _state, _speedL, _speedP] execVM "scripts\lights\grandPoteaux.sqf";
						}; 
						
						
					}forEach _poteau;					
					sleep 0.25;
				}
				else {
					if (_power == 0) then {
						{
							_markerN = _x splitString " ";
							// systemChat(("Gen" in _markerN));
							if (("Gen" in _markerN) or ("" in _markerN)) then {
								deleteMarker(_x);
							};
							if (("Poteaux" in _markerN) or ("" in _markerN)) then {
								deleteMarker(_x);
							};
							sleep 0.1;
						}forEach allMapMarkers;
						_map ctrlRemoveAllEventHandlers "Draw";
					};
				};
			};
		};
	};
	
} forEach _gen;

systemChat("Map mise a jour !");

//radio addAction ["Afficher les générateur",{[true] execVM "scripts\lights\mapGen.sqf";},[],1.5,true,true,"","true",5];// turn ON
//radio addAction ["Cacher les générateur",{[false] execVM "scripts\lights\mapGen.sqf";},[],1.5,true,true,"","true",5];// turn off

