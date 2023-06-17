/*
* Auteur : QuentinN42
* Fonction d'initialisation des variables des camps.
* https://community.bistudio.com/wiki/Arma_3:_CfgVehicles_Structures
*
* Arguments :
* 
*
* Valeur renvoyée :
* nil
*
* Exemple :
* [] call ODDadvanced_fnc_varOutpost
*
* Variable publique :
*/

// Orientation des batiments par rapport a leur model
// Les HQ et maison regardent vers l'interieur
// Les tours regardent vers l'exterieur
private _HQ_orientation = 270;
private _House_orientation = 0;
private _Patrol_orientation = 180;
private _Tower_orientation = -1;

private _bat_types = ["centre", "cercle", "fortification"];
ODD_var_outpost_bat_types = createHashMap;
{ODD_var_outpost_bat_types set [_x, _forEachIndex]} forEach _bat_types;

private _flavor = ["default", "Medevac", "Research", "Green", "Rusty", "Brown", "Jungle"];
ODD_var_outpost_flavor = createHashMap;
{ODD_var_outpost_flavor set [_x, _forEachIndex]} forEach _flavor;


ODD_var_outpost_batiments = createHashMapFromArray [
	[
		"Land_Medevac_HQ_V1_F",
		["type", "orientation", "flavor"] createHashMapFromArray [
			ODD_var_outpost_bat_types get "centre",
			_HQ_orientation,
			createHashMapFromArray [
				[(ODD_var_outpost_flavor get "default"), 0.5],
				[(ODD_var_outpost_flavor get "Medevac"), 100]
			]
		]
	],
	[
		"Land_Research_HQ_F",
		["type", "orientation", "flavor"] createHashMapFromArray [
			ODD_var_outpost_bat_types get "centre",
			_HQ_orientation,
			createHashMapFromArray [
				[(ODD_var_outpost_flavor get "default"), 0.5],
				[(ODD_var_outpost_flavor get "Research"), 100]
			]
		]
	],
	[
		"Land_Medevac_house_V1_F",
		["type", "orientation", "flavor"] createHashMapFromArray [
			ODD_var_outpost_bat_types get "cercle",
			_House_orientation,
			createHashMapFromArray [
				[(ODD_var_outpost_flavor get "default"), 0.5],
				[(ODD_var_outpost_flavor get "Research"), 2]
			]
		]
	],
	[
		"Land_Research_house_V1_F",
		["type", "orientation", "flavor"] createHashMapFromArray [
			ODD_var_outpost_bat_types get "cercle",
			_House_orientation,
			createHashMapFromArray [
				[(ODD_var_outpost_flavor get "default"), 0.5],
				[(ODD_var_outpost_flavor get "Research"), 2]
			]
		]
	]
];
// ajout des 7 types de tours
for "_i" from 1 to 7 do {
	ODD_var_outpost_batiments set [
		format ["Land_Cargo_Tower_V1_No%1_F", _i],
		["type", "orientation", "flavor"] createHashMapFromArray [
			ODD_var_outpost_bat_types get "centre",
			_Tower_orientation,
			createHashMapFromArray [
				[(ODD_var_outpost_flavor get "default"), 1],
				[(ODD_var_outpost_flavor get "Green"), 2],
				[(ODD_var_outpost_flavor get "Rusty"), 0],
				[(ODD_var_outpost_flavor get "Brown"), 0],
				[(ODD_var_outpost_flavor get "Jungle"), 0.5]
			]
		]
	];
};
// ajout des blocks par flavor
{
	ODD_var_outpost_batiments set [
		format ["Land_Cargo_Tower_V%1_F", _forEachIndex + 1],
		["type", "orientation", "flavor"] createHashMapFromArray [
			ODD_var_outpost_bat_types get "centre",
			_Tower_orientation,
			createHashMapFromArray [
				[(ODD_var_outpost_flavor get "default"), 0.5],
				[(ODD_var_outpost_flavor get "Green"), 0],
				[(ODD_var_outpost_flavor get "Rusty"), 0.5],
				[(ODD_var_outpost_flavor get "Brown"), 0],
				[(ODD_var_outpost_flavor get "Jungle"), 0],
				[(ODD_var_outpost_flavor get _x), 8]
			]
		]
	];
	ODD_var_outpost_batiments set [
		format ["Land_Cargo_HQ_V%1_F", _forEachIndex + 1],
		["type", "orientation", "flavor"] createHashMapFromArray [
			ODD_var_outpost_bat_types get "centre",
			_HQ_orientation,
			createHashMapFromArray [
				[(ODD_var_outpost_flavor get "default"), 0.5],
				[(ODD_var_outpost_flavor get "Green"), 0],
				[(ODD_var_outpost_flavor get "Rusty"), 0.5],
				[(ODD_var_outpost_flavor get "Brown"), 0],
				[(ODD_var_outpost_flavor get "Jungle"), 0],
				[(ODD_var_outpost_flavor get _x), 8]
			]
		]
	];
	ODD_var_outpost_batiments set [
		format ["Land_Cargo_House_V%1_F", _forEachIndex + 1],
		["type", "orientation", "flavor"] createHashMapFromArray [
			ODD_var_outpost_bat_types get "cercle",
			_House_orientation,
			createHashMapFromArray [
				[(ODD_var_outpost_flavor get "default"), 0.5],
				[(ODD_var_outpost_flavor get "Green"), 0],
				[(ODD_var_outpost_flavor get "Rusty"), 0.5],
				[(ODD_var_outpost_flavor get "Brown"), 0],
				[(ODD_var_outpost_flavor get "Jungle"), 0],
				[(ODD_var_outpost_flavor get _x), 5]
			]
		]
	];
	ODD_var_outpost_batiments set [
		format ["Land_Cargo_Patrol_V%1_F", _forEachIndex + 1],
		["type", "orientation", "flavor"] createHashMapFromArray [
			ODD_var_outpost_bat_types get "cercle",
			_Patrol_orientation,
			createHashMapFromArray [
				[(ODD_var_outpost_flavor get "default"), 0.5],
				[(ODD_var_outpost_flavor get "Green"), 0],
				[(ODD_var_outpost_flavor get "Rusty"), 0.5],
				[(ODD_var_outpost_flavor get "Brown"), 0],
				[(ODD_var_outpost_flavor get "Jungle"), 0],
				[(ODD_var_outpost_flavor get _x), 5]
			]
		]
	];
} forEach ["Green", "Rusty", "Brown", "Jungle"];
// Ajout des fillets de cammouflage
{
	private _type = _x;
	{
		private _side = _x;
		ODD_var_outpost_batiments set [
			format ["CamoNet_%1%2_F", _side, _type],
			["type", "orientation", "flavor"] createHashMapFromArray [
				ODD_var_outpost_bat_types get "cercle",
				-1,
				createHashMapFromArray [
					[(ODD_var_outpost_flavor get "Green"),  if (_x in ["BLUFOR",          "INDP"        ]) then { 1 } else { 0 }],
					[(ODD_var_outpost_flavor get "Jungle"), if (_x in ["BLUFOR",          "INDP", "ghex"]) then { 1 } else { 0 }],
					[(ODD_var_outpost_flavor get "Rusty"),  if (_x in [          "OPFOR", "INDP", "ghex"]) then { 0.75 } else { 0 }],
					[(ODD_var_outpost_flavor get "Brown"),  if (_x in [          "OPFOR",         "ghex"]) then { 1 } else { 0 }],
					[(ODD_var_outpost_flavor get "default"), 0.5]
				]
			]
		];
	} forEach ["BLUFOR", "OPFOR", "INDP", "ghex"];
} forEach ["", "_open", "_big"];

// Fortifications
//   Frequent
{
	ODD_var_outpost_batiments set [
		_x,
		["type", "orientation", "flavor"] createHashMapFromArray [
			ODD_var_outpost_bat_types get "fortification",
			0,
			createHashMapFromArray [
				[(ODD_var_outpost_flavor get "default"), 1]
			]
		]
	];
} forEach [
	"Land_HBarrier_3_F",
	"Land_HBarrier_5_F",
	"Land_HBarrier_Big_F",
	"Land_HBarrierWall4_F",
	"Land_HBarrierWall6_F",
	"Land_BagFence_Long_F",
	"Land_Rampart_F"
];
//    less frequent
{
	ODD_var_outpost_batiments set [
		_x,
		["type", "orientation", "flavor"] createHashMapFromArray [
			ODD_var_outpost_bat_types get "fortification",
			0,
			createHashMapFromArray [
				[(ODD_var_outpost_flavor get "default"), 0.25]
			]
		]
	];
} forEach [
	"Land_DragonsTeeth_01_4x2_new_F",
	"Land_DragonsTeeth_01_4x2_old_F",
	"Land_DragonsTeeth_01_4x2_new_redwhite_F ",
	"Land_DragonsTeeth_01_4x2_old_redwhite_F",
	"Land_CzechHedgehog_01_new_F",
	"Land_ConcreteHedgehog_01_F"
];
