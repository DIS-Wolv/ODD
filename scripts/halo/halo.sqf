private _coord2D = [0,0,0];
private _coordZ = [0,0,0];

{
  private _markerHalo = (markerText _x splitString " ");
  //hint str(_markerHalo); sleep 3; hintSilent "";
  //hint str(_markerHalo select 1); sleep 3; hintSilent "";
  //hint str(parseNumber str(_markerHalo select 1)); sleep 3; hintSilent "";
  if ("DZ" in _markerHalo)
  then {
    _coord2D = getMarkerPos _x;
    //hint str(_coord2D); sleep 3; hintSilent ""; 
    _coordZ = [0,0,parseNumber (_markerHalo select 1)];
    //hint str(_coordZ select 2); sleep 3; hintSilent "";
  };
}forEach allMapMarkers;

private _posHalo = _coord2D vectorAdd _coordZ;
//hint str(_posHalo); sleep 3; hintSilent "";

if (_posHalo isEqualTo [0,0,0])
then {
  hint "Pas de zone de saut, \n définissez une zone de saut";
  sleep 10;
  hintSilent "";
}
else {
player setPosASL _posHalo; sleep 3; hintSilent "";
};
