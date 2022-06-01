/*	Document : scripts\lights\generators.sqf
 *	Fonction : execute les action sur les générateur
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Argument : 
		- "_target"		:	Ou est le Addaction (le générateur ciblé) (parrametre de base du addaction)
		- "_caller"		:	Qui effectue l'action (le player) (parrametre de base du addaction)
		- "_actionId"	:	L'id de l'action (int) (parrametre de base du addaction)
		- "_posPoteauG"	:	Position du générateur
		- "_state"		:	état souhaité 
 
 *	Appellé par : scripts\lights\init.sqf
 *	Apelle : scripts\lights\lamps.sqf, scripts\lights\petitPoteaux.sqf, scripts\lights\moyenPoteaux.sqf, scripts\lights\grandPoteaux.sqf
 */

params ["_target","_caller","_actionId","_posPoteauG","_state"]; 	//définition des parrametre
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
	];	//liste des petit poteau
	
_moyenPoteauType = ["highvoltagecolumn_f.p3d",	//Altis
	"powerline_01_pole_junction_f.p3d","powerline_01_pole_small_f.p3d","powerline_01_pole_tall_f.p3d", "powerline_01_pole_transformer_f.p3d", //Malden
	"powerline_01_pole_end_v1_f.p3d","powerline_01_pole_end_v2_f.p3d","powerline_01_pole_lamp_f.p3d", //Tanoa
	"jbad_powlineb.p3d" // compatibilité JBAD
	];	//liste des moyen Poteaux
	
_grandPoteauType = ["highvoltagetower_largecorner_f.p3d","highvoltagetower_large_f.p3d","highvoltageend_f.p3d",
	"sloup_vn.p3d"	//compat CUP
	];	//liste des grand Poteaux

//position poteau
private _posPoteau = 0;

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

//delay entre l'extinction (m/s)
private _speedL = 0; 	// des poteaus
private _speedP = 2000; 	// des lampes

//groupe de poteaux deja changé d'etat
private _petitPoteauPool = [0]; //Petit
private _moyenPoteauPool = [0];	//moyen
private _grandPoteauPool = [0];	//grand

private _poteau =  nearestObjects [_posPoteauG, [], _rGenP, true]; // recupère tout les obj
private _gen = nearestObjects [_posPoteauG, _genType, _rGenP, true]; // les grand poteaux

playSound3D [getMissionPath "scripts\lights\Toggle.wav", _posPoteauG , false, _posPoteauG, 2];


{		//pour chaque petit poteau
	_objType = (getModelInfo _x) select 0; //récupère l'élément 0 des info de l'objet voir note en bas de page
	
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
	
} forEach _poteau; 

{
	[position(_x), _state, _rGenL, _speedL] execVM "scripts\lights\lamps.sqf"; //change le statut des lampe a proximité du générateur 
}forEach _gen;


/* NOTE : 
on ne peux pas distingué les petits poteaux comme les grands en les cherchant par objet, 
je recupère donc tout les objets et je vérifie que le noms des model des objets correspond au noms des petits poteaux.
*/
/* Note 2 :
les scripts de poteaux se réappele de facon récurente, mais sont limité par le nombre de poteaux sur la carte, 
se qui empeche les potentiel probleme.
*/






