if(!isServer ) exitWith {};

while {!MCC_GAIA_CACHE} do {
	{
		//Seems like allgroups opens up with all sorts of empty groups, better check it
		if ((count(units _x)>0) && (alive (leader _x)) && ((_x) getVariable ["MCC_GAIA_CACHE", false])) then {MCC_GAIA_CACHE=true;};

		//stop
		if (MCC_GAIA_CACHE) exitwith {true;};
	}  forEach allgroups;
	//if not found go sleep
	if !(MCC_GAIA_CACHE) then {sleep 20;};

	//player globalchat "we wachten";
} ;


while {MCC_GAIA_CACHE} do {
	{
		//Seems like allgroups opens up with all sorts of empty groups, better check it
		if (!(units _x isEqualTo []) && (alive (leader _x))) then {
			//player globalchat "time to check caches";
			//Cache stage 1
			call {
				//We are not cached, closest player is out of range 1, not in combat, exclude artillery and mortars
				if (!(_x getVariable  ["GAIA_CACHED_STAGE_1",false]) && !([getPosATL(leader _x),GAIA_CACHE_STAGE_1] call gaia_fn_nearPlayer) &&
				  (behaviour(leader _x)!="COMBAT") && {((!("DoMortar" in (_x getVariable  ["GAIA_Portfolio",[]]))
				  && !("DoArtillery" in (_x getVariable  ["GAIA_Portfolio",[]]))) && {count (_x getVariable  ["GAIA_zone_intend",[]])>1}||
				  {count (_x getVariable  ["GAIA_zone_intend",[]])==0})}) exitWith  { _x spawn gaia_fn_cache;};
				//We are cached, player is in range 1
				if ((_x getVariable  ["GAIA_CACHED_STAGE_1",false]) && ([getPosATL(leader _x),GAIA_CACHE_STAGE_1] call gaia_fn_nearPlayer)) exitWith {_x spawn gaia_fn_uncache;};
				//We are in combat, decache him at all times, no matter the range
				if ((_x getVariable  ["GAIA_CACHED_STAGE_1",false]) && (behaviour(leader _x)=="COMBAT"))exitWith {_x spawn gaia_fn_uncache;};
 				_x spawn gaia_fn_sync;
			};

			//Cache stage 2
			if (!([getPosATL(leader _x),GAIA_CACHE_STAGE_2] call gaia_fn_nearPlayer)) then {[_x] call gaia_fn_cache_stage_2;};
		};
		//chill out, no rush
		sleep 0.1;
		nil
	} count ([ALLGROUPS, {_x getVariable ["mcc_gaia_cache", false]}] call BIS_fnc_conditionalSelect);

	{
		if ([_x,GAIA_CACHE_STAGE_2] call gaia_fn_nearPlayer) then {
			[(missionNamespace getVariable [ "GAIA_CACHE_" + str(_x),[0,0,0]])] call gaia_fn_uncache_stage_2;
			MCC_GAIA_CACHE_STAGE2 set [_forEachIndex, "delete_me"];
		};
	} forEach MCC_GAIA_CACHE_STAGE2;

	 // Delete respawned dudes
	 MCC_GAIA_CACHE_STAGE2 = MCC_GAIA_CACHE_STAGE2 - ["delete_me"];
	 //We checked allgroups so we need a break
	 sleep GAIA_CACHE_SLEEP;
};
