params ["_posFT", ["_player", player]];

// Teleport the player to the selected location
private _pos = _posFT getPos [random 1 + 0.5, random 360];
_pos set [2, (_posFT select 2)];
_player setPosASL _pos;
