/*	Document : scripts\lights\mapGen.sqf
 *	Fonction : permet d'indiqué sur carte les générateur
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Argument : 
		- _power		:	état souhaité 
 *	Appellé par : addAction
 *		- this addAction ["Cacher les lights",{[0] execVM "scripts\lights\lightsMap.sqf";},[],1.5,true,true,"","true",5];
 *	Apelle : 0/
 */
 
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
	];

_moyenPoteauType = ["highvoltagecolumn_f.p3d",	//Altis
	"powerline_01_pole_junction_f.p3d","powerline_01_pole_small_f.p3d","powerline_01_pole_tall_f.p3d", "powerline_01_pole_transformer_f.p3d", //Malden
	"powerline_01_pole_end_v1_f.p3d","powerline_01_pole_end_v2_f.p3d","powerline_01_pole_lamp_f.p3d", //Tanoa
	"jbad_powlineb.p3d" // compatibilité JBAD
	];	//liste des moyen Poteaux

_grandPoteauType = ["highvoltagetower_largecorner_f.p3d","highvoltagetower_large_f.p3d","highvoltageend_f.p3d",
	"sloup_vn.p3d"	//compat CUP
	];	//liste des grand Poteaux

private _markerGP = [0];

private _power = param[0];

if (_power == 1) then {

	private _Poteau = nearestObjects [[15000, 15000, 0], [], 30000]; // recupère tout les obj
	{
		_objType = (getModelInfo _x) select 0;
		
		_isGrandPoteaux = _grandPoteauType find _objType;
		
		if(_isGrandPoteaux != -1) then {
			_posG = position _x;
			
			_markerGP set [_forEachindex, 
				createMarker [(format ["Poteaux Moyen P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]
			];
			(_markerGP select _forEachindex) setMarkerType "hd_dot";
			(_markerGP select _forEachindex) setMarkerColor "ColorOrange";
				
		};
		
		_isMoyenPoteaux = _moyenPoteauType find _objType;
		
		if(_isMoyenPoteaux != -1) then {
			_posG = position _x;
			
			_markerGP set [_forEachindex, 
				createMarker [(format ["Poteaux Moyen P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]
			];
			(_markerGP select _forEachindex) setMarkerType "hd_dot";
			(_markerGP select _forEachindex) setMarkerColor "ColorBlue";
				
		};
		
		_isPetitPoteaux = _petitPoteauType find _objType;
		
		if(_isPetitPoteaux != -1) then {
			_posG = position _x;
			
			_markerGP set [_forEachindex, 
				createMarker [(format ["Poteaux Petit P x %1, y %2, z %3", (_posG select 0), (_posG select 1), (_posG select 2)]), _posG]
			];
			(_markerGP select _forEachindex) setMarkerType "hd_dot";
			(_markerGP select _forEachindex) setMarkerColor "ColorGreen";
				
		}
		
	}forEach _Poteau;
	
};

if (_power == 0) then {
	{
		_markerN = _x splitString " ";
		if (("Poteaux" in _markerN) or ("" in _markerN)) then {
			deleteMarker(_x);
		};
		sleep 0.1;
		systemChat(str(_forEachIndex));
	}forEach allMapMarkers;
};
systemChat("Map mise à jour !")