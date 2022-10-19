/*
* Auteur: Wolv
* Script ajoutant des locations custom
*/

// factory au sud est de Alikampos
_factory1 = createLocation ["NameLocal", [11473,14246,0], 200, 200];
_factory1 setText "factory";

_GhostHotel = createLocation ["NameLocal", [21830,21019,0], 200, 200];
_GhostHotel setText "Ghost Hotel";

_MilitaryLabBravo = createLocation ["NameLocal", [20888,19326,0], 250, 250];
_MilitaryLabBravo setText "Military lab bravo";

_PyrgosBase = createLocation ["NameLocal", [17416,13184,0], 200, 200];
_PyrgosBase setText "Pyrgos military base";

_SagonisiBase = createLocation ["NameLocal", [14200,13000,0], 200, 200];
_SagonisiBase setText "Sagonisi military base";

_feresAirfield = createLocation ["NameLocal", [20800,7200,0], 200, 200];
_feresAirfield setText "Feres airfield";

_selakanoBase = createLocation ["NameLocal", [20050,6700,0], 200, 200];
_selakanoBase setText "Selakano military base";

// _loc = _selakanoBase;
// _pos = getPos _loc;
// _markerG = createMarker [(format ["Gen Z x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
// _markerG setMarkerShape "RECTANGLE";
// _markerG setMarkerSize [(size _loc select 1),(size _loc select 1)];
// _markerG setMarkerBrush "SolidBorder";
// _markerG setMarkerAlpha 0.5; 
// _markerG setMarkerColor "ColorBlue";	// rayon d'action des générateur affiché sur carte