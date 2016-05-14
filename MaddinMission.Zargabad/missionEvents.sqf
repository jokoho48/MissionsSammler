["CreateTask1", {
    // @TODO translat to germanz!!!
    [west, ["task1"], ["Find the Crashside and retrieve the Crew.","Find the Crashside","search"], getPos heliCrashed vectorAdd [(random 100) - 200, (random 100) - 200, 0], 1,3,true] call BIS_fnc_taskCreate;
    ["task1", "ASSIGNED", false] spawn BIS_fnc_taskSetState;
}] call CBA_fnc_addEventHandler;

["CreateTask2", {
    ["task1", "SUCCEEDED", false] spawn BIS_fnc_taskSetState;
    // @TODO translat to germanz!!!
    [west, ["task2"], ["The Crew Member you Searching for is not under the found Troops. you need to Search and find the Pilot. The Operation Center Send Information that in the NorthEast of your Current Position are heavy Enemy Positions.","Find the Crew Members","search"], getMarkerPos "Attack" vectorAdd [(random 100) - 200, (random 100) - 200, 0], 1,3,true] call BIS_fnc_taskCreate;
    ["task2", "ASSIGNED", true] spawn BIS_fnc_taskSetState;
}] call CBA_fnc_addEventHandler;

["spawnCityUnits", {
    [] spawn {
        for "_c" from 0 to 7 do {
            private _name = format ["spawnMarker_%1", _c];
            for "_i" from 0 to floor(random 6) do {
                [_name, _name, ["CUP1","CUP2","CUP3"] select ((_i+_c) mod 3), resistance, ["CBA_PATROL", "CBA_DEFEND"] select ((_i+_c) mod 2), 300, "HARD"] call JK_AI_fnc_AIHandler;
                //sleep 1;
            };
        };
    };
}] call CBA_fnc_addEventHandler;


["spawnHouseUnits", {
    [] spawn {
        for "_c" from 0 to 3 do {
            private _name = format ["spawnMarkerHouse_%1", _c];
            for "_i" from 0 to floor(random 3) do {
                [_name, "Attack", ["CUP1","CUP2","CUP3"] select ((_i+_c) mod 3), resistance, ["CBA_PATROL", "CBA_DEFEND"] select ((_i+_c) mod 2), 150, "HARD"] call JK_AI_fnc_AIHandler;
                //sleep 1;
            };
        };
    };
}] call CBA_fnc_addEventHandler;

["collectAttack", {
    [] spawn {
        private _pos = getPos MoveCenter;
        private _enemys = nearestObjects [getPos CityCenter, ["CAManBase"], 700];

        {
            if !(side _x isEqualTo west) then {
                _x doMove _pos;
            };
            nil
        } count _enemys;
    };
}] call CBA_fnc_addEventHandler;

if (isServer) then {
    ["CreateTask1"] call CBA_fnc_localEvent;
};

// ["CreateTask2"] call CBA_fnc_localEvent;
// ["spawnCityUnits"] call CBA_fnc_localEvent;
// ["spawnHouseUnits"] call CBA_fnc_localEvent;
