////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Hhaine, v1.063, #Vawoma)
////////////////////////////////////////////////////////

class ODDGUI_Control
{
	idd = 31082024;
	name = "ODDGUIControl";
	author = "WOLV";
	
	class controlsBackground
	{
		class ODDGUIMissions_Text_Bckgrnd: RscText_ODDGUI
		{
			idc = 1800;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.1625 * safezoneH + safezoneY;
			w = 0.6 * safezoneW;
			h = 0.675 * safezoneH;
			colorBackground[] = {0.00,0.05,0.10,0.75}; // "Onyx"
			// colorBackground[] = {0.05,0.74,0.26,0.75};
		};
		class ODDGUIMissions_SText_Title: RscStructuredText_ODDGUI
		{
			idc = 1100;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.275 * safezoneW;
			h = 0.05 * safezoneH;
			colorBackground[] = {0.00,0.15,0.30,0.85}; // "Oxford blue"
			text = "<t size='2.25' align='center'>Générateur  D'ODD<t/>";
		};
		class ODDGUIMissions_SText_Summary: RscStructuredText_ODDGUI
		{
			idc = 1101;
			x = 0.3875 * safezoneW + safezoneX;
			y = 0.19 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.46 * safezoneH;
			colorBackground[] = {0.00,0.05,0.10,0.75};
			text = "<t size='3' align='center' valign='middle'>GUI en préparation ...<t/>";
		};
		class ODDGUIMissions_SText_Time: RscStructuredText_ODDGUI
		{
			idc = 1102;
			x = 0.55 * safezoneW + safezoneX;
			y = 0.725 * safezoneH + safezoneY;
			w = 0.075 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {0.00,0.05,0.10,0.75};
			text = "<t size='1' align='center'>45h72<t/>";
		};	
		class ODDGUIMissions_SText_Area: RscStructuredText_ODDGUI
		{
			idc = 1103;
			x = 0.225 * safezoneW + safezoneX;
			y = 0.19 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.04 * safezoneH;
			colorBackground[] = {0.00,0.05,0.10,0.75};
			text = "<t size='1' align='center'>Zone de mission<t/>";
		};
		class ODDGUIMissions_SText_TailleZO: RscStructuredText_ODDGUI
		{
			idc = 1104;
			x = 0.225 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {0.00,0.05,0.10,1};
			text = "<t size='1' align='center'>Taille de la zone<t/>";
		};
		class ODDGUIMissions_SText_Location: RscStructuredText_ODDGUI
		{
			idc = 1105;
			x = 0.225 * safezoneW + safezoneX;
			y = 0.37 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {0.00,0.05,0.10,0.75};
			text = "<t size='1' align='center'>Localité<t/>";
		};
		class ODDGUIMissions_SText_Objectif: RscStructuredText_ODDGUI
		{
			idc = 1106;
			x = 0.225 * safezoneW + safezoneX;
			y = 0.46 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {0.00,0.05,0.10,0.75};
			text = "<t size='1' align='center'>Objectif<t/>";
		};
		class ODDGUIMissions_SText_Weather: RscStructuredText_ODDGUI
		{
			idc = 1107;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.675 * safezoneH + safezoneY;
			w = 0.275 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {0.00,0.05,0.10,0.75};
			text = "<t size='1' align='center'>Modifications de l'heure et de la météo (indépendant de la mission)<t/>";
		};
	}
	class controls 
	{
		class ODDGUIMissions_Combo_Area: RscCombo_ODDGUI
		{
			idc = 2100;
			x = 0.225 * safezoneW + safezoneX;
			y = 0.2125 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class ODDGUIMissions_Combo_TailleZO: RscCombo_ODDGUI
		{
			idc = 2101;
			x = 0.225 * safezoneW + safezoneX;
			y = 0.3050 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class ODDGUIMissions_Combo_Location: RscCombo_ODDGUI
		{
			idc = 2102;
			x = 0.225 * safezoneW + safezoneX;
			y = 0.3950 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class ODDGUIMissions_Combo_Objectif: RscCombo_ODDGUI
		{
			idc = 2103;
			x = 0.225 * safezoneW + safezoneX;
			y = 0.4850 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class ODDGUIMissions_Combo_Weather: RscCombo_ODDGUI
		{
			idc = 2105;
			x = 0.65 * safezoneW + safezoneX;
			y = 0.725 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class ODDGUIMissions_Combo_Fog: RscCombo_ODDGUI
		{
			idc = 2106;
			x = 0.65 * safezoneW + safezoneX;
			y = 0.775 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class ODDGUIMissions_Slider_Time: RscSlider_ODDGUI
		{
			idc = 1900;
			x = 0.225 * safezoneW + safezoneX;
			y = 0.725 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class ODDGUIMissions_Button_Generate: RscButton_ODDGUI
		{
			idc = 1600;
			text = "Générer la mission"; //--- ToDo: Localize;
			x = 0.225 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.125 * safezoneW;
			h = 0.05 * safezoneH;
			colorBackground[] = {0.00,1.00,0.00,0.8}; // "Electric green"
			action = "[] call OddGuiMissions_fnc_createMission; (findDisplay ODDGUIMissions_IddDisplay) closeDisplay 1;";
		};
		class ODDGUIMissions_Button_Time: RscButton_ODDGUI
		{
			idc = 1603;
			text = "Changer l'heure / Modifier la météo"; //--- ToDo: Localize;
			x = 0.425 * safezoneW + safezoneX;
			y = 0.775 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.05 * safezoneH;
			colorBackground[] = {0.00,0.60,0.60,0.8}; // "Persian green"

			action = "[] call OddGuiMissions_fnc_setTimeWeather";
		};
	}
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
