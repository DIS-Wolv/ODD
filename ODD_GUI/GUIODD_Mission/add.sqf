/*
* Auteur : Wolv
* Script pour ajouter des éléments dans les listes
* 
* Argument :
* 0: ID du controlleur (idc)
* 
* Valeur renvoyée :
* nil
*
*/

params [["_list", -1]];

if ((_list == ODDGUI_var_IdcListObjAll) or (_list == ODDGUI_var_IdcListPosAll)) then {
	_index = lbCurSel _list;

	if (_index != -1) then {
		if (_list == ODDGUI_var_IdcListObjAll) then {
			_tg = ODD_var_MissionType select _index;
			if (!(_tg in ODDGUI_var_SelTarg)) then {
				lbAdd [ODDGUI_var_IdcListObjSel, _tg];
				ODDGUI_var_SelTarg pushBack _tg;
			};
		};
		if (_list == ODDGUI_var_IdcListPosAll) then {
			_tg = ODDGUI_var_Secteur select _index;
			if (!(_tg in ODDGUI_var_SelPos)) then {
				lbAdd [ODDGUI_var_IdcListPosSel, _tg];
				ODDGUI_var_SelPos pushBack _tg;
			};
		};
	};
};
