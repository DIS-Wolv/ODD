
class DIS_Common {
	tag = "DISCommon";
	class Initialize {
		file = "template_functions\common";

		class CutBushes {};
		class PosFob {};
		class customLocations {};
		class markers {};
		class fastTravel {};
		class haloJump {};
		class createBoat {};
		class deleteBoats {};
		class resetRadio {};
		class arsenal{};
	};
};

class DIS_Load {
	tag = "DISLoad";
	class Initialize {
		file = "template_functions\loads";
		class StandartScope {};
		class Equip {};
		class VarLoads {};
		class SetLoad {};
	};
};

class DIS_LoadCrate {
	tag = "DISLoadCrate";
	class Initialize {
		file = "template_functions\loads\crate";

		class armes {};
		class dump {};
		class items {};
		class itemsCe {};
		class itemsDa {};
		class lanceurs {};
		class medical {};
		class para {};
	};
};
