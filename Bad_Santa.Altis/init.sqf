setviewdistance 1000;
enableSaving [false,false];
JK_allSpawns = ["spawn_1", "spawn_2", "spawn_3", "spawn_4", "spawn_5", "spawn_6", "spawn_7", "spawn_8"];
JK_allTagets = ["target_1", "target_2", "target_3", "target_4", "target_5"];
JK_allWeapon = ["LMG_Zafir_F", "arifle_TRG21_F", "arifle_TRG20_F", "arifle_Mk20_F", "arifle_Mk20_plain_F", "arifle_Mk20C_F", "arifle_Mk20C_plain_F", "arifle_Katiba_F", "arifle_Katiba_C_F"];
JK_count = 2;
JK_playMusic = false;
JK_maxCount = 250;
JK_isInLoop = false;


/*
 * Author: joko // Jonas
 * Fill Units Gear
 *
 * Arguments:
 * 0: Unit that become the Weapons
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call JK_fnc_unitInit
 */
JK_fnc_unitInit = {
    params ["_unit"];
    _unit removeMagazines "xmas_explosive_present";
    private _weapon = JK_allWeapon call BIS_fnc_selectRandom;
    [_unit, _weapon, 8] call BIS_fnc_addWeapon;
    _unit addMagazine ["xmas_explosive_present", 1];
};

/*
 * Author: joko // Jonas
 * Create a Unit with the Loadout
 *
 * Arguments:
 * 0: Group in the the Unit Spawn <Group>
 * 1: Classname of the Unit <String>
 * 2: Position of where the Unit spawn <Array>
 *
 * Return Value:
 * spawned Unit <Object>
 *
 * Example:
 * [grpNull, "CABaseMan", getPos testObj] call JK_fnc_spawnUnits
 */
JK_fnc_spawnUnits = {
    params ["_group", "_className", "_position"];
    _className createUnit [_position, _group, "this call JK_fnc_unitInit", 0.9];
};

/*
 * Author: joko // Jonas
 * called in the Loop to Create the Groups
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call JK_fnc_loop
 */
JK_fnc_loop = {
    if (JK_isInLoop) exitWith {};
    if (count (allUnits - allPlayers) >= JK_maxCount) exitWith {};
    0 spawn {
        JK_isInLoop = true;
        private _allreadyUsedPos = [];
        for "_j" from 0 to JK_count step 1 do {
        if (count (allUnits - allPlayers) >= JK_maxCount) exitWith {};
            private _grp = createGroup EAST;
            private _pos = JK_allSpawns call BIS_fnc_selectRandom;
            _allreadyUsedPos pushBack _pos;
            _pos = getMarkerPos _pos;
            for "_i" from 0 to 5 step 1 do {
                [_grp, "xmas_santa_opfor", _pos] call JK_fnc_spawnUnits;
            };
            private _posWP = JK_allTagets call BIS_fnc_selectRandom;
            _posWP = getMarkerPos _posWP;
            [_grp, _posWP, 50, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [3,6,9]] call CBA_fnc_addWaypoint;
        };
        if (isServer) then {
            {
                _x addCuratorEditableObjects [entities "", true];
                true
            } count allCurators;
        } else {
            [{
                {
                    _x addCuratorEditableObjects [entities "", true];
                    true
                } count allCurators;
            }, "BIS_fnc_call", false, false, true] call BIS_fnc_MP;
        };
        JK_isInLoop = false;
        if !(count (allUnits - allPlayers) >= JK_maxCount) then {
            JK_count = JK_count + 1;
            publicVariable "JK_count";
        };
    };
};

if (!isServer && !hasInterface) then {
    if ((paramsArray select 0) isEqualTo 1) then {
        [JK_fnc_loop, 600, []] call CBA_fnc_addPerFrameHandler;
    };
};

finishMissionInit;

waitUntil {!isNil "AME_Core_fnc_loadModules"};
["Core", "LoadOut", "Crates", "Environment", /*"Grenades", */"TFAR", "GarbageCollect", "Zeus"] call AME_Core_fnc_loadModules;

[] spawn compile preprocessFileLineNumbers "weather.sqf";

if (hasInterface) then {
    [] spawn {
        waitUntil {!isNull (findDisplay 46)};
        while {true} do {
            if (JK_playMusic) then {
                soundPoint say3D "Intro";
                JK_playMusic = false;
                publicVariable "JK_playMusic";
                sleep 400;
            };
        };
    };
};
