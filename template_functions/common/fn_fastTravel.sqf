params ["_posFT"];

// Get the player object and the selected location
_player = player;
_location = _this select 0;

// Teleport the player to the selected location
_player setPos _location;
