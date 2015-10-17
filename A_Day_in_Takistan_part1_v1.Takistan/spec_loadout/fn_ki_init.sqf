if(isServer) then {
	{
		if(side _x == west) then {
			comment "test for KI only";
			if (!isPlayer _x) then {
				[_x] call Spec_fnc_loadout;
				_x addEventHandler ["respawn","_this call Spec_fnc_loadout;"];
			};
		} else {
			//_x removeMagazines "1Rnd_HE_Grenade_shell";
		};
	} foreach  allunits;
};
