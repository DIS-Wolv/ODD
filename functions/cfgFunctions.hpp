
class DIS_Common {
    tag = "DISCommon";
    class Initialize {
        file = "functions\common";

        class CutBushes {};
        class PosFob {};
        class customLocation {};
    };
};

class DIS_Load {
    tag = "DISLoad";
    class Initialize {
        file = "functions\Loads";

        class Helo {};
        class Pilot {};
        class StandartScope {};
        class Equip {};
    };
};

class DIS_LoadCE {
    tag = "DISLoadCe";
    class Initialize {
        file = "functions\Loads\ce";

        class cdb {};
        class cdbr {};
        class cde {};
        class cdg {};
        class cds {};
        class eod {};
        class equipier {};
        class gv {};
        class medecin {};
        class minimi5 {};
        class minimi7 {};
        class spotter {};
        class te {};
        class tp {};
        class tpInf {};
        class zeus {};
    };
};

class DIS_LoadDa {
    tag = "DISLoadDa";
    class Initialize {
        file = "functions\Loads\da";

        class cdb {};
        class cdbr {};
        class cde {};
        class cdg {};
        class cds {};
        class eod {};
        class equipier {};
        class gv {};
        class medecin {};
        class minimi5 {};
        class minimi6 {};
        class spotter {};
        class te {};
        class tp {};
        class tpInf {};
        class zeus {};
    };
};

class DIS_LoadCrate {
    tag = "DISLoadCrate";
    class Initialize {
        file = "functions\Loads\crate";

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

class DIS_LoadDivers {
    tag = "DISLoadDivers";
    class Initialize {
        file = "functions\Loads\divers";

        class cde {};
        class cdg {};
        class gv {};
        class medecin {};
        class minimi {};
    };
};
