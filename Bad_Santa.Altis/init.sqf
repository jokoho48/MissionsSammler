setviewdistance 1000;
enableSaving [false,false];
[] spawn compile preprocessFileLineNumbers "weather.sqf";
JK_allSpawns = ["spawn_1", "spawn_2", "spawn_3", "spawn_4", "spawn_5", "spawn_6", "spawn_7", "spawn_8"];
JK_allTagets = ["target_1", "target_2", "target_3", "target_4", "target_5"];
JK_allWeapon = ["LMG_Zafir_F", "arifle_TRG21_F", "arifle_TRG20_F", "arifle_Mk20_F", "arifle_Mk20_plain_F", "arifle_Mk20C_F", "arifle_Mk20C_plain_F", "arifle_Katiba_F", "arifle_Katiba_C_F"];
JK_count = 5;
JK_maxCount = 200000;
JK_isInLoop = false;
JK_fnc_unitInit = {
    params ["_unit"];
    _unit removeMagazines "xmas_explosive_present";
    private _weapon = JK_allWeapon call BIS_fnc_selectRandom;
    [_unit, _weapon, 8] call BIS_fnc_addWeapon;
    _unit addMagazine ["xmas_explosive_present", 1];
};

JK_fnc_spawnUnits = {
    params ["_group", "_className", "_position"];
    _className createUnit [_position, _group, "this call JK_fnc_unitInit", 0.9];
};

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
            [_grp, _posWP, 100] call CBA_fnc_taskAttack;
        };
        if !(count (allUnits - allPlayers) >= JK_maxCount) then {
            JK_count = JK_count + (floor (((random 3) min 1) max 2));
        };
        {
            _x addCuratorEditableObjects [allUnits, true];
            true
        } count allCurators;
        {
            _x addCuratorEditableObjects [vehicles, true];
            true
        } count allCurators;
        {
            _x addCuratorEditableObjects [allDead, true];
            true
        } count allCurators;
        JK_isInLoop = false;
    };
};

if (isServer) then {
    [JK_fnc_loop, 300, []]call CBA_fnc_addPerFrameHandler;
};


finishMissionInit;

waitUntil {!isNil "AME_Core_fnc_loadModules"};
["Core", "LoadOut", "Crates", "Environment", "Grenades", "TFAR", "GarbageCollect", "Zeus"] call AME_Core_fnc_loadModules;

if (hasInterface) then {
    soundPoint say3D "Intro";
};
