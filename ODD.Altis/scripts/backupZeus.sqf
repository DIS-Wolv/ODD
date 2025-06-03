// rules addAction ["Bug Zeus","scripts\backupZeus.sqf",[],1.5,True,True,"","True",2];
{
	if (!isNil("god")) then {
		unassignCurator cur;
		sleep 2;
		god assignCurator cur;
	} else {
		if (!isNil ("god1")) then {
			unassignCurator cur1;
			sleep 2;
			god1 assignCurator cur1;
		};
	};
} forEach allPlayers;
