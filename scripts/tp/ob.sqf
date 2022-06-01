_tele = _this select 0;
_caller = _this select 1;

_caller setPos (getpos OB);

if(!isNull pa)
then {
player setPosASL [ getPos player select 0, getPos player select 1, 23];
};
