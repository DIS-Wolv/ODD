/*
* Auteur: Wolv
* Script ajoutant des locations custom
*/

// factory au sud est de Alikampos
_factory1 = createLocation ["NameLocal", [11473,14246,0], 200, 200];
_factory1 setText "factory";

_GH = createLocation ["NameLocal", [21830,21019,0], 200, 200];
_GH setText "Ghost Hotel";

// _loc = _GH;
// _pos = getPos _loc;
// _markerG = createMarker [(format ["Gen Z x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
// _markerG setMarkerShape "RECTANGLE";
// _markerG setMarkerSize [(size _loc select 1),(size _loc select 1)];
// _markerG setMarkerBrush "SolidBorder";
// _markerG setMarkerAlpha 0.5; 
// _markerG setMarkerColor "ColorBlue";	// rayon d'action des générateur affiché sur carte