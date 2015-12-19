enableSaving[false,false];
JK_allSpawns = ["", "", "", "", "", "", "", "", ""];
JK_allTagets = ["", "", "", "", "", "", "", "", ""];

JK_unitInit = {
    params ["_unit"];
    _unit removeMagazines "xmas_explosive_present";
    [_unit, "", 8] call BIS_fnc_addWeapon;
    _unit addMagazine ["xmas_explosive_present", 3];
};

JK_fnc_spawnUnits = {
    params ["_group", "_className", "_position"];
    _className createUnit [_position, _group, "this call JK_unitInit", 0.9];
};

JK_count = 5;
[{
    private _grp = createGroup EAST;
    private _pos = JK_allSpawns call BIS_fnc_selectRandom;
    _pos = getMarkerPos _pos;
    for "_i" from 0 to JK_count step 1 {
        [_grp, "xmas_santa_opfor", _pos] call JK_fnc_spawnUnits;
    };
    private _posWP = JK_allTagets call BIS_fnc_selectRandom;
    _posWP = getMarkerPos _posWP;
    private _wp = _grp addWaypoint [_posWP, 5];
    _wp setWaypointBehaviour "COMBAT";
    _wp setWaypointSpeed "FULL";
    JK_count = JK_count + floor(random 3);
}, 300, []]call CBA_fnc_addPerFrameHandler;

finishMissionInit;
/*
waitUntil {!isNil "AME_Core_fnc_loadModules"};
["Core", "LoadOut", "Crates", "Environment", "Grenades", "TFAR", "GarbageCollect", "Zeus"] call AME_Core_fnc_loadModules;
*/