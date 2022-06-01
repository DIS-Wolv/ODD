Readme_EN
Be careful, read the entire file before asking for help

Thanks for downloading my script

Summary:
I. Use
II. Installation
III. Contact

I. use:
At the launch of the mission, to check the initialization of the script the following message appears: "Script de lumière par [DIS]Wolv initialisé" ("Light script by [DIS] Wolv initialized" in French)
If not, restart the installation, restart your mission, then and if it still not working : ask me for help.
If the script is correctly executed, when you approach an electrical transformer, you will have the following options in the jog wheel:
	- "Turn ON": activates the transformer, the lights nearby, as well as all the lights near the nearby electric poles up to the next transformer,
	- "Turn OFF": deactivates the transformer, the lights nearby, as well as all the lights near the nearby electric poles until the next transformer.

If you wish, you can have the following information displayed on the map as desired by interacting with a predefined object (see installation):
	- either Electric transformers, (advisor)
	- either the transformers and their radius of action on the lamps,
	- either the transformers as well as all the connected poles (not recommended because it causes drops in FPS)


II. Installation:
In order to properly install the script, please follow the following protocol:
	1. Create a mission in 3den and save it, with if you want an object with a variable name to display the information (see Use)
	2. Open the mission folder (in C:\User\<YourUserName>\Documents\Arma 3 - Other Profiles\<YourProfile>\mpmissions\<MissionName>)
	3. Create a folder named "scripts"
	4. Put the "lights" folder in it
	5. Setting up the script launch
		5.a) Next to the script folder create the file "initPlayerLocal.sqf"
		5.b) In it put the following command line: "[] execVM"scripts\lights\init.sqf";"
		5.c) If you want to have information available on a panel, add: "<MyVar> addAction ["Hide generators", {[0] execVM"scripts\lights\mapGen.sqf";}, [], 1.5 , true, true, "", "true", 5]; "
			As well as ONE of the following lines to choose from:
			- To have ONLY the transformers on the map:
				"<MyVar> addAction ["Show generators", {[1] execVM"scripts\lights\mapGen.sqf";}, [], 1.5, true, true,"","true", 5];"
			- To have the transformers and their radius of action on the lamps on the map:
				"<MyVar> addAction ["Show generators", {[2] execVM"scripts\lights\mapGen.sqf";}, [], 1.5, true, true,"","true", 5];"
			- For transformers as well as all the poles connected on the board:
				"<MyVar> addAction ["Show generators", {[3] execVM"scripts\lights\mapGen.sqf";}, [], 1.5, true, true,"","true", 5];"
			Replace <MyVar> with the name of the object on which you want actions to display or hide information.
	6. Start the mission and check if the initialization message is displayed.
	7. Enjoy

III. Contact :
If you want any help with setting up or troubleshooting the script, I invite you to text me on discord: Wolv#2393

Thanks for downloading my script