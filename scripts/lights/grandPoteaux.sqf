/*	Document : scripts\lights\grandPoteaux.sqf
 *	Fonction : execute les action sur les grands Poteaux
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Argument : 
		- _posPoteau		:	Position du poteau
		- _grandPoteauPool	:	Liste des grand Poteaux déja changé d'etat
		- _forEachindex		:	numéro du poteau (sert au debug)
		- _rGrandL			:	raduis de désactivation des lamps
		- _rGrandP			:	raduis de désactivation des poteaux
		- _rGenP			:	raduis de désactivation des poteaux sur les générateur
		- _state			:	état voulue (0 = eteint, 1 = allumé, 3 = affiché sur carte, 4 = ligne sur carte)
		- _speedL			:	delay entre l'extinction (m/s) des lamps
		- _speedP 			:	delay entre l'extinction (m/s) des poteaux
 
 *	Appellé par : scripts\lights\generators.sqf, scripts\lights\grandPoteaux.sqf
 *	Apelle : scripts\lights\grandPoteaux.sqf, scripts\lights\lamps.sqf
 */

_genType = ["Land_spp_Transformer_F", "Land_dp_transformer_F","Land_TBox_F",
	//compat CUP
		"Land_Trafostanica_mala","Land_Trafostanica_velka", "Land_Substation_01_F"	
	];		//liste des générateur
_grandPoteauType = ["highvoltagetower_largecorner_f.p3d","highvoltagetower_large_f.p3d","highvoltageend_f.p3d",
	"sloup_vn.p3d"	//compat CUP
	];	//liste des grand Poteaux

private _posPoteau = 0;
private _marker = [0];
private _markerP = [0];

//liste des grand poteaux et des générateur a proximité
private _grandPoteau = [];
private _gen = [];

private _map = (findDisplay 12 displayCtrl 51);  // récupères le control de ta map.
private _count = 0;

//récupération des parametre 
_posPoteau = param[0];
_grandPoteauPool = param[1];
_i = param[2];
_rGrandL = param[3];
_rGrandP = param[4];
_rGenP = param[5];
_state = param[6];
_speedL = param[7];
_speedP = param[8];

private _isInPool = _grandPoteauPool find _posPoteau;		//test si le poteau est deja dans la liste 

if (_isInPool == -1) then {		//si le poteaux n'est pas dans la liste 
	
	_grandPoteauPool set [(count _grandPoteauPool),_posPoteau];		// ajoute le poteaux dans la liste
	
	if (_state == 3) then {// si state = 3 alors on veux affiché des marker sur la carte et ne pas changé l'état des poteaux
		//place les 2 marker 
		/*_marker set [_i, createMarker [(format ["Grand Poteaux Z x %1, y %2, z %3", (_posPoteau select 0), (_posPoteau select 1), (_posPoteau select 2)]), _posPoteau]]; 
		(_marker select _i) setMarkerShape "ELLIPSE";
		(_marker select _i) setMarkerSize [_rGrandL,_rGrandL];
		(_marker select _i) setMarkerBrush "SolidBorder";
		(_marker select _i) setMarkerAlpha 0.2; 
		(_marker select _i) setMarkerColor "ColorOrange";//*/
		
		_markerP set [_i, createMarker [(format ["Grand Poteaux P x %1, y %2, z %3", (_posPoteau select 0), (_posPoteau select 1), (_posPoteau select 2)]), _posPoteau]]; 
		(_markerP select _i) setMarkerType "hd_dot";
		(_markerP select _i) setMarkerColor "ColorOrange"; 
	}
	else { //sinon on change l'état des poteaux
		if (_state == 4) then {}
		else {
			[_posPoteau, _state, _rGrandL, _speedL] execVM "scripts\lights\lamps.sqf";	//change le statut des lampe a proximité
		};
	};
	
	private _grandPoteau =  nearestObjects [_posPoteau, [], _rGrandP, true]; // recupère tout les grands poteaux a proximité
	{
		_objType = (getModelInfo _x) select 0;
		_isGrandPoteaux = _grandPoteauType find _objType;
		
		if(_isGrandPoteaux != -1) then {
		
			_posPoteauNV = (position _x);		//définie la nouvelle position et appele le script suivant
			if (_state == 4) then {
				
				if (_count <= 3) then {
					_map ctrlAddEventHandler ["Draw",
						format["(_this select 0) drawLine [%1,%2,[0.85,0.4,0,1]];", str(_posPoteau), str(_posPoteauNV)]
					];
					_count = _count + 1;
				}
			};
			
			private _gen = nearestObjects [_posPoteau, _genType, _rGenP / 2, true];		//vérifie qu'il n'y a pas de générateur a proximité
			if ((count _gen) == 0) then {		//si pas de générateur a proximité
				[_posPoteauNV, _grandPoteauPool, _forEachindex, _rGrandL, _rGrandP, _rGenP, _state, _speedL, _speedP] execVM "scripts\lights\grandPoteaux.sqf";
			};
		};
	}forEach _grandPoteau;	//pour chaque grand Poteaux
	//recurance : voir note 2 en bas de la page "generators.sqf"
};
