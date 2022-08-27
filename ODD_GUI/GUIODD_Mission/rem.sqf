/*
* Author: Wolv
* Script permetant de retiré des élément dans les listes
* 
* Argument :
* idc de la Liste  
* 
* Return Value:
* nil
*
*/
params [["_list", -1]];

if ((_list == ODDGUI_var_IdcListObjSel) or (_list == ODDGUI_var_IdcListPosSel)) then {
	_index = lbCurSel _list;

	if (_index != -1) then {
		if (_list == ODDGUI_var_IdcListObjSel) then {
			_tg = ODDGUI_var_SelTarg select _index;
			if ((_tg in ODDGUI_var_SelTarg)) then {
				ODDGUI_var_SelTarg  = ODDGUI_var_SelTarg - [_tg];
				lbDelete [ODDGUI_var_IdcListObjSel, _index];
			};
		};
		if (_list == ODDGUI_var_IdcListPosSel) then {
			_tg = ODDGUI_var_SelPos select _index;
			if ((_tg in ODDGUI_var_SelPos)) then {
				ODDGUI_var_SelPos  = ODDGUI_var_SelPos - [_tg];
				lbDelete [ODDGUI_var_IdcListPosSel, _index];
			};
		};
	};
};
