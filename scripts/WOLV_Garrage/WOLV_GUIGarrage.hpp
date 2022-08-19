class GUIGarrage 
{
	idd = 110822;
	name = "GUIGarrage";
	author = "Wolv";
	
	class controlsBackground
	{
		class GUIGarrage_BackGround: RscText_WolvGUIGarrage
		{
			idc = 1000;
			x = 0.1375 * safezoneW + safezoneX;
			y = 0.0599998 * safezoneH + safezoneY;
			w = 0.725 * safezoneW;
			h = 0.84 * safezoneH;
			colorBackground[] = {0.16,0.196,0.098,0.9};
		};
		class GUIGarrage_Title: RscStructuredText_WolvGUIGarrage
		{
			idc = 1100;
			text = "<t size='4' align='center'>Garrage de la DIS par [DIS]Wolv<t/>"; //--- ToDo: Localize;
			x = 0.15 * safezoneW + safezoneX;
			y = 0.08 * safezoneH + safezoneY;
			w = 0.7 * safezoneW;
			h = 0.08 * safezoneH;
			// font = TahomaB;
		};

		class GUIGarrage_TitleListSpawn: RscStructuredText_WolvGUIGarrage
		{
			idc = 1101;
			text = "<t size='2' align='center'>VL à Spawn<t/>";
			x = 0.15 * safezoneW + safezoneX;
			y = 0.2 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class GUIGarrage_TitleListVL: RscStructuredText_WolvGUIGarrage
		{
			idc = 1102;
			text = "<t size='2' align='center'>VL à proximité<t/>";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.2 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class GUIGarrage_TitleListInv: RscStructuredText_WolvGUIGarrage
		{
			idc = 1103;
			text = "<t size='2' align='center'>Inventaire<t/>";
			x = 0.475 * safezoneW + safezoneX;
			y = 0.2 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class GUIGarrage_TitleListArs: RscStructuredText_WolvGUIGarrage
		{
			idc = 1104;
			text = "<t size='2' align='center'>Arsenal<t/>";
			x = 0.675 * safezoneW + safezoneX;
			y = 0.2 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.04 * safezoneH;
		};
	};

	class controls 
	{
		class GUIGarrage_ListSpawn: RscListBox_WolvGUIGarrage
		{
			idc = 1500;
			x = 0.15 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.46 * safezoneH;
			font = PuristaSemibold;
		};
		class GUIGarrage_ListVL: RscListBox_WolvGUIGarrage
		{
			idc = 1501;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.46 * safezoneH;
			font = PuristaSemibold;
		};
		class GUIGarrage_ListArs: RscListBox_WolvGUIGarrage
		{
			idc = 1502;
			x = 0.675 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.46 * safezoneH;
			font = PuristaSemibold;
		};
		class GUIGarrage_ListInv: RscListBox_WolvGUIGarrage
		{
			idc = 1503;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.46 * safezoneH;
			font = PuristaSemibold;
		};
		
		class GUIGarrage_ButtonSpawn: RscButton_WolvGUIGarrage
		{
			idc = 1600;
			text = "Spawn"; //--- ToDo: Localize;
			x = 0.15 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.1 * safezoneH;
			// sizeEx = 1.8 * GUI_GRID_H;
			action = "execVM 'scripts\WOLV_Garrage\spawnVL.sqf'";
			font = PuristaBold;
		};
		class GUIGarrage_ButtonParradrop: RscButton_WolvGUIGarrage
		{
			idc = 1601;
			text = "Parradrop"; //--- ToDo: Localize;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.04 * safezoneH;
			// sizeEx = 1 * GUI_GRID_H;
			action = "execVM 'scripts\WOLV_Garrage\parradropVL.sqf'";
			font = PuristaSemibold;
		};
		class GUIGarrage_ButtonDelete: RscButton_WolvGUIGarrage
		{
			idc = 1602;
			text = "Delete"; //--- ToDo: Localize;
			x = 0.3 * safezoneW + safezoneX;
			y = 0.82 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.04 * safezoneH;
			// sizeEx = 1 * GUI_GRID_H;
			action = "execVM 'scripts\WOLV_Garrage\deleteVL.sqf'";
			font = PuristaSemibold;
		};

		class GUIGarrage_ButtonMoins10: RscButton_WolvGUIGarrage
		{
			idc = 1603;
			text = "- 10"; //--- ToDo: Localize;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[10] execVM 'scripts\WOLV_Garrage\RemoveItem.sqf'";
			font = PuristaSemibold;
		};
		class GUIGarrage_ButtonMoins5: RscButton_WolvGUIGarrage
		{
			idc = 1604;
			text = "- 5"; //--- ToDo: Localize;
			x = 0.5375 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[5] execVM 'scripts\WOLV_Garrage\RemoveItem.sqf'";
			font = PuristaSemibold;
		};
		class GUIGarrage_ButtonMoins1: RscButton_WolvGUIGarrage
		{
			idc = 1605;
			text = "- 1"; //--- ToDo: Localize;
			x = 0.6 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[1] execVM 'scripts\WOLV_Garrage\RemoveItem.sqf'";
			font = PuristaSemibold;
		};
		class GUIGarrage_ButtonPlus1: RscButton_WolvGUIGarrage
		{
			idc = 1606;
			text = "+ 1"; //--- ToDo: Localize;
			x = 0.675 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[1] execVM 'scripts\WOLV_Garrage\AddItem.sqf'";
			font = PuristaSemibold;
		};
		class GUIGarrage_ButtonPlus5: RscButton_WolvGUIGarrage
		{
			idc = 1607;
			text = "+ 5"; //--- ToDo: Localize;
			x = 0.7375 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[5] execVM 'scripts\WOLV_Garrage\AddItem.sqf'";
			font = PuristaSemibold;
		};
		class GUIGarrage_ButtonPlus10: RscButton_WolvGUIGarrage
		{
			idc = 1608;
			text = "+ 10"; //--- ToDo: Localize;
			x = 0.8 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[10] execVM 'scripts\WOLV_Garrage\AddItem.sqf'";
			font = PuristaSemibold;
		};

		class GUIGarrage_BarreInv: RscProgressBar_WolvGUIGarrage
		{
			idc = 1900;
			x = 0.475 * safezoneW + safezoneX;
			y = 0.82 * safezoneH + safezoneY;
			w = 0.375 * safezoneW;
			h = 0.04 * safezoneH;
		};
	};
};
