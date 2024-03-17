
class ODD_Common {
	tag = "ODDcommon";
	class Initialize {
		file = "odd_functions\common";

		class log {};
		class CtrlVlLock {};
		class createAndLockVl {};
		class PlaceTable {};
		class CountOnBase {};
		class SelectZO {};
		class limitPatrols {};
		class defineZo {};
		class ZoType {};

		class initCustomBuildings {};
		class initCivils {};
		class initPatrol {};
		class initGarison {};
		class initIED {};
		class initOutpost {};
		class initVls {};

		class controlCiv {};
		class controlPatrols {};
		class controlGarisons {};
		class controlRoadBlockAo {};
		class controlIED {};
		class controlOutpost {};
		class controlVls {};

		class civPatrol {};
		class civGarnison {};
		class civVehicle {};
		class civVehicleStatic {};

		class eniPatrol {};
		class eniGarison {};

		class roadBlockAo {};
		class ied {};
	};
};

class ODD_Data {
	tag = "ODDdata";
	class Initialize {
		file = "odd_functions\data";

		class Table {};

		class var {};
		class varEne {};
		class varEneArd {};
		class varEneBlp {};
		class varEneChDKZ {};
		class varEneFia {};
		class varEneSaf{};
		class varEneTla {};
		class varRoadBlock {};
		class varOutpost {};
		class varIntel {};
	};

};

class ODD_advanced {
	tag = "ODDadvanced"
	class Initialize {
		file = "odd_functions\advanced";
		class missions {/*recompile = 1;*/};
		class countIA {};
		class garbageCollector {};
		class sortieGarnison {};
		class testRenfort {};
		class createZO {};
		class clearZO {};
		class createTarget {};
		class createTargetSec {};
		class civil {};
		class createGarnison {};
		class createGarnisonV2 {};
		class infoOdd {};
		class initMissionArea {};
		class createPatrol {};
		class createVehicule {};
		class roadBlock {};
		class roadBlockZO {};
		class createRenfort {};
		class pressureIED {};
		class patrolZoM {};
		class surrender {};
		class particules {};
		class civiesCover {};
		class haltCivilian {};
		class areaControl {};
		class createVehiculeAtPos {};

		// outpost
		class createOutpostAtPos {};
		class createOutpostsAroundZo {};

		// fonctions "Propres"
		class TrigCreateExtract {};
		class TrigCreateRtb {};
		class TrigWaitRtb {};
		class TrigOkExtract {};
		class TrigOkRtb {};
		class CompleteObj {};
	}
};

class ODD_Intels {
	tag = "ODDintels"
	class Initialize {
		file = "odd_functions\intels";
		class addInteraction {};
		class addInteractionLocal {};
		class formatDistAngle {};
		class formatGrid {};
		class formatPos {};
		class getClosestOjbInArr {};
		class giveIntel {};
		class maybeGiveIntel {};
		class nameCaisse {};
		class nameVl {};
	}
};
