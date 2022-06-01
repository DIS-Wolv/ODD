/*	Document : scripts\lights\init.sqf
 *	Fonction : initialise le scripts de lumière
 *	Auteur : Wolv (discord : Wolv#2393)
 *	Appellé : "[] execVM "scripts\lights\init.sqf";"
 *	Argument : 0/
 *	Appellé par : initPlayerLocal.sqf
 *	Apelle : scripts\lights\generators.sqf
 */


_genType = ["Land_spp_Transformer_F", "Land_dp_transformer_F","Land_TBox_F",
	//compat CUP
		"Land_Trafostanica_mala","Land_Trafostanica_velka", "Land_Substation_01_F"	
	];		//liste des générateur

//marker Générateur
private _posMarkerG = 0;
//Radius Gen
private  _rGenP = 800; 	//raduis de désactivation des poteaux
private _rGenL = 500;	//raduis de désactivation des lamps

private _gen = nearestObjects [[15000, 15000, 0], _genType, 30000]; //recupère les générateur de la carte dans un rayon de 15 km autour du centre de la carte

{
    _posMarkerG = (position _x);	//recupère la position
	
	// ajoute les actions
	_x addAction ["Turn ON",{
		params ["_target","_caller","_actionId","_posMarkerG"]; [_target, _caller, _actionId, _posMarkerG, 1] execVM "scripts\lights\generators.sqf";
	},_posMarkerG,1.5,true,true,"","true",5]; // turn ON
	
	_x addAction ["Turn OFF",{
		params ["_target","_caller","_actionId","_posMarkerG"]; [_target, _caller, _actionId, _posMarkerG, 0] execVM "scripts\lights\generators.sqf";
	},_posMarkerG,1.5,true,true,"","true",5]; // turn OFF
	
}forEach _gen; //pour chaque générateur

sleep 5;
systemchat "Script de lumière par [DIS]Wolv initialisé";
