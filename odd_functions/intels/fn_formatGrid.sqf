params[["_loc", [0,0,0]]];


private _pxtxt = str floor((_loc select 0) / 100);
private _pytxt = str floor((_loc select 1) / 100);

// en 123 45 on veut 123045 et pas 12345
if (count _pxtxt < 3) then {_pxtxt = "0" + _pxtxt};
if (count _pytxt < 3) then {_pytxt = "0" + _pytxt};

private _msg = "en " + _pxtxt + _pytxt;
