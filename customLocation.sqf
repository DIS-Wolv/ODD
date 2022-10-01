/*
* Auteur: Wolv
* Script ajoutant des locations custom
*/

// factory au sud est de Alikampos
_factory1 = createLocation ["NameLocal", [11473,14246,0], 200, 200];
_factory1 setText "factory";

_GhostHotel = createLocation ["NameLocal", [21830,21019,0], 200, 200];
_GhostHotel setText "Ghost Hotel";

_MillitaryLabBravo = createLocation ["NameLocal", [20888,19326,0], 250, 250];
_MillitaryLabBravo setText "Millitary Lab Bravo";

_PyrgosBase = createLocation ["NameLocal", [17416,13184,0], 200, 200];
_PyrgosBase setText "Pyrgos Base";

// _loc = _PyrgosBase;
// _pos = getPos _PyrgosBase;
// _markerG = createMarker [(format ["Gen Z x %1, y %2, z %3", (_pos select 0), (_pos select 1), (_pos select 2)]), _pos]; 
// _markerG setMarkerShape "RECTANGLE";
// _markerG setMarkerSize [(size _loc select 1),(size _loc select 1)];
// _markerG setMarkerBrush "SolidBorder";
// _markerG setMarkerAlpha 0.5; 
// _markerG setMarkerColor "ColorBlue";	// rayon d'action des générateur affiché sur carte