/*	Document : Wolv_Lights\fn_init.sqf
 *	Fonction : initialise le scripts de lumière
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Appellé : "[] spawn WolvLights_fnc_init;"
 *	Argument : 0/
 *	Appellé par : initPlayerLocal.sqf
 *	Apelle : WolvLights_fnc_generators
 */

WolvLights_var_genType = ["Land_spp_Transformer_F", "Land_dp_transformer_F","Land_TBox_F",
	//compat CUP
		"Land_Trafostanica_mala","Land_Trafostanica_velka", "Land_Substation_01_F",
	//compat SOG Prairie Fire
		"Land_vn_mobileradar_01_generator_f","Land_vn_misc_waterstation", "Land_vn_waterstation_01_f"
	];		//liste des générateur

WolvLights_var_petitPoteauType = ["powerpolewooden_f.p3d","powerpolewooden_small_f.p3d","powerpolewooden_l_off_f.p3d","powerpolewooden_l_f.p3d","lampshabby_off_f.p3d",
		"lampshabby_f.p3d","powerline_02_pole_small_f.p3d","powerline_02_pole_small_a_f.p3d",
	// compatibilité JBAD (Lythium)
		"jbad_powlines_conc1.p3d","jbad_powlines_conc2l.p3d","powerpoleconcrete_f.p3d", 
	//CUP
		"powlines_conc1.p3d", "powlines_conc3.p3d", "misc_amplion_conc.p3d","powlines_concl.p3d","powlines_conca.p3d",
		"powlines_wood1.p3d", "powlines_wood2.p3d","powlines_wooda.p3d","powlines_woodl.p3d","misc_amplion_wood.p3d", "sloupyeli.p3d","sloupyele.p3d", 
	//compat DLC contact
		"powerline_03_pole_junction_f.p3d", "powerline_03_pole_f.p3d","powerline_02_pole_small_a_f.p3d", "powerline_02_pole_small_hook_f.p3d",
		"powerline_02_pole_small_hook_junction_f.p3d", "power_pole_wood1.p3d", "powerline_02_pole_junction_a_f.p3d", "powerline_02_pole_small_end_a_f.p3d",
		"powerline_03_pole_end_f.p3d",
	//compat SOG Prairie Fire
		"vn_powerpolewooden_small_f.p3d","vn_powerpolewooden_l_f.p3d","vn_powerpolewooden_l_off_f.p3d","vn_lampshabby_f.p3d","vn_powerpolewooden_f.p3d",
		"vn_powlineb_ep1.p3d"
	];	//liste des petit poteau (le ".p3d" est essentiel car il s'agit de model 3D des objet, voir note en bas de page de generators.sqf)

WolvLights_var_moyenPoteauType = ["highvoltagecolumn_f.p3d",	//Altis
	"powerline_01_pole_junction_f.p3d","powerline_01_pole_small_f.p3d","powerline_01_pole_tall_f.p3d", "powerline_01_pole_transformer_f.p3d", //Malden
	"powerline_01_pole_end_v1_f.p3d","powerline_01_pole_end_v2_f.p3d","powerline_01_pole_lamp_f.p3d", //Tanoa
	"jbad_powlineb.p3d" // compatibilité JBAD
	];	//liste des moyen Poteaux

WolvLights_var_grandPoteauType = ["highvoltagetower_largecorner_f.p3d","highvoltagetower_large_f.p3d","highvoltageend_f.p3d",
	"sloup_vn.p3d"	//compat CUP
	];	//liste des grand Poteaux

WolvLights_var_lampsType = [
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
		"Land_PowerLine_02_pole_small_lamp_F",
	//DLC SOG Prairie Fire
		"Land_vn_lampshabby_off_f",
		"Land_vn_lampshabby_f",
		"Land_vn_lampazel",
		"Land_vn_powerpolewooden_l_off_f",
		"Land_vn_powerpolewooden_l_f"
]; //liste des lamps

WolvLights_var_lightHouseType = ["Land_LightHouse_F"];

//marker Générateur
private _posMarkerG = 0;
//Radius Gen
private  _rGenP = 800; 	//raduis de désactivation des poteaux
private _rGenL = 500;	//raduis de désactivation des lamps

private _gen = nearestObjects [[15000, 15000, 0], WolvLights_var_genType, 30000]; //recupère les générateur de la carte dans un rayon de 15 km autour du centre de la carte
{
	_posMarkerG = (position _x);	//recupère la position
	
	// ajoute les actions
	_x addAction ["Turn ON",{
		params ["_target","_caller","_actionId","_posMarkerG"]; [_target, _caller, _actionId, _posMarkerG, 1] spawn WolvLights_fnc_generators;
	},_posMarkerG,1.5,true,true,"","true",5]; // turn ON
	
	_x addAction ["Turn OFF",{
		params ["_target","_caller","_actionId","_posMarkerG"]; [_target, _caller, _actionId, _posMarkerG, 0] spawn WolvLights_fnc_generators;
	},_posMarkerG,1.5,true,true,"","true",5]; // turn OFF
	
}forEach _gen; //pour chaque générateur

private _LightHouse = nearestObjects [[15000, 15000, 0], WolvLights_var_lightHouseType, 30000]; //recupère les générateur de la carte dans un rayon de 15 km autour du centre de la carte

{

	_x addAction ["Turn ON",{
		params ["_target"]; 
		[_target, True] remoteExecCall["BIS_fnc_switchLamp"]; 
		playSound3D [getMissionPath "WOLV_Lights\Toggle.wav", (position _target) , false, (position _target), 2];
	},nil,1.5,true,true,"","(_this distance2D _target) <= 2",50]; // turn ON
	
	_x addAction ["Turn OFF",{
		params ["_target"]; 
		[_target, False] remoteExecCall["BIS_fnc_switchLamp"]; 
		playSound3D [getMissionPath "WOLV_Lights\Toggle.wav", (position _target) , false, (position _target), 2];
	},nil,1.5,true,true,"","(_this distance2D _target) <= 2",50]; // turn OFF
} forEach _LightHouse;

sleep 5;
systemchat "Script de lumière par [DIS]Wolv initialisé";
