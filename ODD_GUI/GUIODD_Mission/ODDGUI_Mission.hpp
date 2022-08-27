class ODDGUI_Mission
{
	idd = 270822;
	name = "ODDGUI_Mission";
	author = "Wolv";
	
	class controlsBackground
	{
		class GUIODD_Mission_BackGround: RscText_ODDGUI
		{
			idc = 1000;
			x = 0.05 * safezoneW + safezoneX;
			y = 0.08 * safezoneH + safezoneY;
			w = 0.9 * safezoneW;
			h = 0.84 * safezoneH;
			colorBackground[] = {0.06,0.15,0.69,0.9};
		};

		class GUIODD_Mission_Title: RscStructuredText_ODDGUI
		{
			idc = 1100;
			text = "<t size='4' align='center'>Générateur de missions ODD<t/>";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.12 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.08 * safezoneH;
		};
		class GUIODD_Mission_TitleObj: RscStructuredText_ODDGUI
		{
			idc = 1101;
			text = "<t size='2' align='center'>Objectif<t/>";
			x = 0.075 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class GUIODD_Mission_TitlePos: RscStructuredText_ODDGUI
		{
			idc = 1102;
			text = "<t size='2' align='center'>Position<t/>";
			x = 0.375 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class GUIODD_Mission_TitleJoueur: RscStructuredText_ODDGUI
		{
			idc = 1103;
			text = "<t size='2' align='center'>Nombre de joueur<t/>";
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class GUIODD_Mission_TitleFaction: RscStructuredText_ODDGUI
		{
			idc = 1104;
			text = "<t size='2' align='center'>Faction<t/>";
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class GUIODD_Mission_TitleHeure: RscStructuredText_ODDGUI
		{
			idc = 1105;
			text = "<t size='2' align='center'>Heure<t/>";
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.54 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class GUIODD_Mission_TitleMeteo: RscStructuredText_ODDGUI
		{
			idc = 1106;
			text = "<t size='2' align='center'>Meteo<t/>";
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
		};
	}

	class controls 
	{
		class GUIODD_Mission_ListObjAll: RscListbox_ODDGUI
		{
			idc = 1500;
			x = 0.075 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class GUIODD_Mission_ListObjSel: RscListbox_ODDGUI
		{
			idc = 1501;
			x = 0.225 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class GUIODD_Mission_ListPosAll: RscListbox_ODDGUI
		{
			idc = 1502;
			x = 0.375 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class GUIODD_Mission_ListPosSel: RscListbox_ODDGUI
		{
			idc = 1503;
			x = 0.525 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.44 * safezoneH;
		};

		class GUIODD_Mission_ComboJoueur: RscCombo_ODDGUI
		{
			idc = 2100;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class GUIODD_Mission_ComboFaction: RscCombo_ODDGUI
		{
			idc = 2101;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class GUIODD_Mission_ComboHeure: RscCombo_ODDGUI
		{
			idc = 2102;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class GUIODD_Mission_ComboMeteo: RscCombo_ODDGUI
		{
			idc = 2103;
			x = 0.7125 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
		};

		class GUIODD_Mission_ButtonObjAdd: RscButton_ODDGUI
		{
			idc = 1600;
			text = "Ajouter"; //--- ToDo: Localize;
			x = 0.1 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[ODDGUI_var_IdcListObjAll] execVM 'ODD_GUI\GUIODD_Mission\add.sqf'";
		};
		class GUIODD_Mission_ButtonObjRem: RscButton_ODDGUI
		{
			idc = 1601;
			text = "Enlever"; //--- ToDo: Localize;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[ODDGUI_var_IdcListObjSel] execVM 'ODD_GUI\GUIODD_Mission\rem.sqf'";
		};
		class GUIODD_Mission_ButtonPosAdd: RscButton_ODDGUI
		{
			idc = 1602;
			text = "Ajouter"; //--- ToDo: Localize;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[ODDGUI_var_IdcListPosAll] execVM 'ODD_GUI\GUIODD_Mission\add.sqf'";
		};
		class GUIODD_Mission_ButtonPosRem: RscButton_ODDGUI
		{
			idc = 1603;
			text = "Enlever"; //--- ToDo: Localize;
			x = 0.55 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[ODDGUI_var_IdcListPosSel] execVM 'ODD_GUI\GUIODD_Mission\rem.sqf'";
		};
		class GUIODD_Mission_ButtonGen: RscButton_ODDGUI
		{
			idc = 1604;
			text = "Générer la mission"; //--- ToDo: Localize;
			x = 0.425 * safezoneW + safezoneX;
			y = 0.84 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[] execVM 'ODD_GUI\GUIODD_Mission\start.sqf'";
		};
	}
};


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Wolv, v1.063, #Xuxada)
////////////////////////////////////////////////////////

		
		
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
