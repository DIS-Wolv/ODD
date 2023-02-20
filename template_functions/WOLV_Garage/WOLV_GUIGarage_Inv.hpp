class GUIgarage_Inv 
{
	idd = 0310222;
	name = "GUIgarage_Inv";
	author = "Wolv";
	
	class controlsBackground
	{
		class GUI_Garage_Background: RscText_WolvGUIgarage
		{
			idc = 1000;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.12 * safezoneH + safezoneY;
			w = 0.6 * safezoneW;
			h = 0.68 * safezoneH;
			colorBackground[] = {0.16,0.196,0.098,0.9};
		};
		class GUI_Garage_Title: RscStructuredText_WolvGUIgarage
		{
			idc = 1100;
			text = "<t size='3' align='center'>Garage DIS<t/>"; //--- ToDo: Localize;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.14 * safezoneH + safezoneY;
			w = 0.5 * safezoneW;
			h = 0.06 * safezoneH;
		};
	};

	class controls 
	{
		class GUI_Garage_ButtonNavGarage: RscButton_WolvGUIgarage
		{
			idc = 1600;
			text = "Garage"; //--- ToDo: Localize;
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[1] spawn WolvGarage_fnc_switchDisplay;";
		};
		class GUI_Garage_ButtonNavInv: RscButton_WolvGUIgarage
		{
			idc = 1601;
			text = "Inventaire"; //--- ToDo: Localize;
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.04 * safezoneH;
			//action = "[2] spawn WolvGarage_fnc_switchDisplay;";
			colorBackground[] = {0,0,0,1};
		};
		class GUI_Garage_ButtonNavInvAce: RscButton_WolvGUIgarage
		{
			idc = 1602;
			text = "Inventaire Ace"; //--- ToDo: Localize;
			x = 0.5875 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[3] spawn WolvGarage_fnc_switchDisplay;";
		};

		class GUI_Garage_ComboChoixVl: RscCombo_WolvGUIgarage
		{
			idc = 2100;
			x = 0.4125 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.04 * safezoneH;
		};

		class GUI_Garage_ListBoxInv: RscListbox_WolvGUIgarage
		{
			idc = 1500;
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.1625 * safezoneW;
			h = 0.4 * safezoneH;
		};
		class GUI_Garage_ListBoxItems: RscListbox_WolvGUIgarage
		{
			idc = 1501;
			x = 0.6 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.1625 * safezoneW;
			h = 0.4 * safezoneH;
		};

		class GUI_Garage_ButtonPlus1: RscButton_WolvGUIgarage
		{
			idc = 1603;
			text = "+ 1"; //--- ToDo: Localize;
			x = 0.525 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[1] spawn WolvGarage_fnc_invAddItem;";
		};
		class GUI_Garage_ButtonPlus5: RscButton_WolvGUIgarage
		{
			idc = 1604;
			text = "+ 5"; //--- ToDo: Localize;
			x = 0.525 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[5] spawn WolvGarage_fnc_invAddItem;";
		};
		class GUI_Garage_ButtonPlus10: RscButton_WolvGUIgarage
		{
			idc = 1605;
			text = "+ 10"; //--- ToDo: Localize;
			x = 0.525 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[10] spawn WolvGarage_fnc_invAddItem;";
		};
		
		class GUI_Garage_ButtonMoins1: RscButton_WolvGUIgarage
		{
			idc = 1606;
			text = "- 1"; //--- ToDo: Localize;
			x = 0.425 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[1] spawn WolvGarage_fnc_invRemoveItem;";
		};
		class GUI_Garage_ButtonMoins5: RscButton_WolvGUIgarage
		{
			idc = 1607;
			text = "- 5"; //--- ToDo: Localize;
			x = 0.425 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH;
			action = "[5] spawn WolvGarage_fnc_invRemoveItem;";
		};
		class GUI_Garage_ButtonMoins10: RscButton_WolvGUIgarage
		{
			idc = 1608;
			text = "- 10"; //--- ToDo: Localize;
			x = 0.425 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.04 * safezoneH
			action = "[10] spawn WolvGarage_fnc_invRemoveItem;";
		};

		class GUI_Garage_ProgressBarInv: RscProgressBar_WolvGUIgarage
		{
			idc = 1900;
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.74 * safezoneH + safezoneY;
			w = 0.525 * safezoneW;
			h = 0.04 * safezoneH;
		};
	};
};








