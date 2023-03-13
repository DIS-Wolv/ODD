
class ODD_Common {
    tag = "ODDcommon";
    class Initialize {
        file = "odd_functions\common";

		class log {};
        class CtrlVlLock {};
        class PlaceTable {};
		class CountOnBase {};
		class SelectZO {};
    };
};

class ODD_Data {
	tag = "ODDdata";
	class Initialize {
		file = "odd_functions\data";

		class Table {};
	};

};
class ODD_advanced {
	tag = "ODDadvanced"
	class wolv_ODD {
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
		class createOutpost {};
		class civil {};
		class createGarnison {};
		class createGarnisonV2 {};
		class infoOdd {};
		class createPatrol {};
		class createVehicule {};
		class roadBlock {};
		class roadBlockZO {};
		class createRenfort {};
		class intel {};
		class pressureIED {};
		class patrolZoM {};
		class surrender {};
		class var {};
		class varEne {};
		class varEneArd {};
		class varEneBlp {};
		class varEneChDKZ {};
		class varEneFia {};
		class varEneSaf{};
		class varEneTla {};
		class varRoadBlock {};
		class particules {};
		class civiesCover {};
		class haltCivilian {};
		class varOutpost {};
		class areaControl {};

		// fonctions "Propres"
		class TrigCreateExtract {};
		class TrigCreateRtb {};
		class TrigWaitRtb {};
		class TrigOkExtract {};
		class TrigOkRtb {};
		class CompleteObj {};
	}
}