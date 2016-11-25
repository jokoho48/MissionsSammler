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
    private _weapon = selectRandom JK_allWeapon;
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

    if (count (allUnits - allPlayers) >= JK_maxCount) exitWith {
                [{call JK_fnc_loop}, (400 + random 200)] call CLib_fnc_wait;
    };

    0 spawn {
        for "_j" from 0 to JK_count step 1 do {
        if (count (allUnits - allPlayers) >= JK_maxCount) exitWith {
                    [{call JK_fnc_loop}, (400 + random 200)] call CLib_fnc_wait;
        };
            private _grp = createGroup EAST;
            private _pos = selectRandom JK_allSpawns;
            _pos = getMarkerPos _pos;
            for "_i" from 0 to 5 step 1 do {
                [_grp, "xmas_santa_opfor", _pos] call JK_fnc_spawnUnits;
            };
            private _posWP = selectRandom JK_allTagets;
            _posWP = getMarkerPos _posWP;
            [_grp, _posWP, 50, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [3,6,9]] call CBA_fnc_addWaypoint;
        };

        {
            _x addCuratorEditableObjects [entities "", true];
            true
        } count allCurators;
        if !(count (allUnits - allPlayers) >= JK_maxCount) then {
            JK_count = JK_count + 1;
            publicVariable "JK_count";
        };
        [{call JK_fnc_loop}, (400 + random 200)] call CLib_fnc_wait;
    };
};

if (!isServer && !hasInterface) then {
    if ((paramsArray select 0) isEqualTo 1) then {
        call JK_fnc_loop;
    };
};
