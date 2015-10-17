params ["_maxCivDensity", "_maxCivDistance", "_maxCivWaypoints"];
JK_maxCivDensity = _maxCivDensity; //number of civs around 1 player at the same time
JK_maxCivDistance = _maxCivDistance;    //max distance until civs despawn
JK_maxCivWaypoints = _maxCivWaypoints; //number of civ waypoints

JK_CivsArray = [];

_centerC = createCenter civilian;

JK_civlist = [
    "LOP_Tak_Civ_Man_01",
    "LOP_Tak_Civ_Man_04",
    "LOP_Tak_Civ_Man_02"
];

JK_civClothes = [
    "LOP_U_TAK_Civ_Fatigue_01",
    "LOP_U_TAK_Civ_Fatigue_04",
    "LOP_U_TAK_Civ_Fatigue_02"
];

JK_housesList = [
"Land_Ind_Shed_02_EP1",
"Land_Lampa_Ind_EP1",
"Land_Vez",
"Land_Ind_Shed_01_EP1",
"Land_Mil_hangar_EP1",
"Land_Mil_Barracks_EP1",
"Land_Mil_Barracks_i_EP1",
"Land_runway_edgelight",
"Land_Mil_Barracks_L_EP1",
"Land_Mil_ControlTower_EP1",
"Land_Mil_Guardhouse_EP1",
"Land_Shed_M01_EP1",
"Land_Mil_House_EP1",
"Land_Shed_W02_EP1",
"Land_PowLine_wire_BB_EP1",
"Land_PowLine_wire_A_right_EP1",
"Land_NavigLight",
"Land_Mil_Repair_center_EP1",
"Land_House_L_3_EP1",
"Land_PowLine_wire_A_left_EP1",
"Land_Wall_L_2m5_gate_EP1",
"Land_Lamp_Small_EP1",
"Land_House_L_6_EP1",
"Land_House_L_7_EP1",
"Land_House_L_1_EP1",
"Land_House_L_4_EP1",
"Land_PowLine_wire_AB_EP1",
"Land_Ind_Garage01_EP1",
"Land_Ind_FuelStation_Build_EP1",
"Land_House_K_1_EP1",
"Land_House_K_3_EP1",
"Land_Terrace_K_1_EP1",
"Land_House_K_8_EP1",
"Land_House_K_5_EP1",
"Land_Wall_L1_gate_EP1",
"Land_Wall_L3_5m_EP1",
"Land_Misc_Well_L_EP1",
"Land_A_Mosque_small_1_EP1",
"Land_A_Mosque_small_2_EP1",
"Land_House_C_12_EP1",
"Land_House_L_8_EP1",
"Land_A_Minaret_EP1",
"Land_House_C_1_v2_EP1",
"Land_House_K_7_EP1",
"Land_House_C_10_EP1",
"Land_House_C_11_EP1",
"Land_House_C_2_EP1",
"Land_House_C_3_EP1",
"Land_House_C_5_EP1",
"Land_House_C_1_EP1",
"Land_House_K_6_EP1",
"Land_House_C_5_V2_EP1",
"Land_Ind_Oil_Pump_EP1",
"Land_IndPipe2_big_ground1_EP1",
"Land_Shed_Ind02",
"Land_IndPipe2_bigL_R_EP1",
"Land_Ind_TankBig",
"Land_Ind_PowerStation_EP1",
"Land_IndPipe2_big_ground2_EP1",
"Land_Misc_Cargo1C_EP1",
"Land_Misc_Cargo2B_EP1",
"Land_Misc_Cargo1A_EP1",
"Land_Shed_W03_EP1",
"Land_Ind_Oil_Tower_EP1",
"Land_House_L_9_EP1",
"Land_House_C_5_V3_EP1",
"Land_Lamp_Street1_EP1",
"Land_House_C_5_V1_EP1",
"Land_Misc_Well_C_EP1",
"Land_House_C_9_EP1",
"Land_House_C_4_EP1",
"Land_PowLines_Conc2L_EP1",
"Land_Wall_L_Mosque_1_EP1",
"Land_Wall_L_Mosque_2_EP1",
"Land_Misc_Cargo1D_EP1",
"Land_Misc_Cargo1B_EP1",
"Land_Misc_Cargo1Bo_EP1",
"Land_Misc_Cargo2C_EP1",
"Land_Barrack2",
"Land_Wall_L3_pillar_EP1",
"Land_Wall_L3_gate_EP1",
"Land_Market_stalls_02_EP1",
"Land_A_Minaret_Porto_EP1",
"Land_Market_stalls_01_EP1",
"Land_Misc_Cargo1Ao_EP1",
"Land_Ind_Coltan_Hopper_EP1",
"Land_Ind_Coltan_Main_EP1",
"Land_Misc_Coltan_Heap_EP1",
"Land_Ind_Coltan_Conv2_EP1",
"Land_Ind_Coltan_Conv1_end_EP1",
"Land_Ind_Coltan_Conv1_10_EP1",
"Land_Ind_Coltan_Conv1_Main_EP1",
"Land_fortified_nest_small_EP1",
"Land_Fort_Watchtower_EP1",
"Land_fortified_nest_big_EP1",
"Land_A_Mosque_big_wall_corner_EP1",
"Land_A_Mosque_big_wall_EP1",
"Land_A_Mosque_big_minaret_1_EP1",
"Land_A_Mosque_big_addon_EP1",
"Land_A_Mosque_big_wall_gate_EP1",
"Land_A_Mosque_big_hq_EP1",
"Land_A_Mosque_big_minaret_2_EP1",
"Land_Ind_FuelStation_Shed_EP1",
"Land_IndPipe1_stair_EP1",
"Land_Misc_Cargo2A_EP1",
"Land_IndPipe2_bigL_L_EP1"
];

JK_getHouses = {
    private ["_allhouses", "_temphouses"];
    _allhouses = nearestObjects [_this,["House"],JK_maxCivDistance];
    _temphouses = [];

    {
        if (_x getvariable ["JK_isHouse",false]) then {
            _temphouses pushBack _x;
        } else {
            private ["_housestring", "_ishouse"];
            _housestring = str (typeof _x);
            _ishouse = ["_i_house", _housestring] call BIS_fnc_inString;

            if (_ishouse) then {
                _temphouses pushBack _x;
                _x setvariable ["JK_isHouse",true];
            };
        };
    } count _allhouses;

    _temphouses
};

JK_spawnciv = {
    params ["_position", "_count"];
    local _count = JK_maxCivDensity - _count;

    local _temphouses = _position call JK_getHouses;

    if (count _temphouses > 0) then {
        for "_b" from 1 to _count do {
            if (count JK_CivsArray > 100) exitWith {};
            private ["_spawnpos", "_class", "_sqname", "_civ"];
            _spawnpos = getposasl (_temphouses call BIS_fnc_selectRandom);
            _class = (JK_civlist call BIS_fnc_selectRandom);

            _sqname = creategroup civilian;
            _class createUnit [_spawnpos, _sqname];

            _civ = leader _sqname;

            JK_CivsArray pushBack _civ;

            removeUniform _civ;
            _civ addUniform (JK_civClothes call BIS_fnc_selectRandom);

            _civ setvariable ["JK_civ_owner", "server"];

            _civ setspeedmode "LIMITED";
            _civ setBehaviour "SAFE";

            for "_i" from 0 to JK_maxCivWaypoints do {
                private ["_house", "_waypoint"];
                _house = _temphouses call BIS_fnc_selectRandom;
                if ([_player, "21"] call CBA_fnc_inArea) then {
                    _waypoint = _sqname addWaypoint [getposasl _house,_i];
                    _waypoint setWaypointType "Move";
                };
            };
            _waypoint = _sqname addWaypoint [_spawnpos,(count waypoints _sqname)];
            _waypoint setWaypointType "Cycle";
        };
    };
};

if (!isDedicated and isMultiplayer) then {
    [] spawn {
        while {true} do {
            private ["_houses", "_var"];
            _houses = (position player) call JK_getHouses;
            _var = player getVariable ["JK_housesNear", false];

            if (count _houses > 0) then {
                if (!_var) then {
                    player setVariable ["JK_housesNear", true, true];
                };
            } else {
                if (_var) then {
                    player setVariable ["JK_housesNear", false, true];
                };
            };
            sleep 120;
        };
    };
};

JK_deleteCivs = {
    private ["_civ", "_players"];

    {
        if (!alive _x or isNull _x) then {
            JK_CivsArray set [_forEachIndex, objNull];
        };
    } forEach JK_CivsArray;

    JK_CivsArray = JK_CivsArray - [objNull];

    _players = allPlayers;

    {
        _civ = _x;

        _c = 0;
        {
            if (_civ distance _x > JK_maxCivDistance and ((lineintersects [eyepos _x,getposasl _civ,_x,_civ]) || (terrainintersectasl [eyepos _x,getposasl _civ]))) then {
                _c = _c + 1;
            };
        } count _players;

        if (_c == (count _players)) then {
            if (_civ in JK_CivsArray) then {
                JK_CivsArray = JK_CivsArray - [_civ];
            };

            _group = group _civ;
            deleteVehicle _civ;
            deleteGroup _group;

        };
    } count JK_CivsArray;
};

if (isServer) then {
    if (isMultiplayer) then {
        while {true} do {
            call JK_deleteCivs;

            {
                _player = _x;
                _count = 0;
                _var = _player getVariable ["JK_housesNear", false];

                if (_var) then {
                    {
                        if (_x distance _player < JK_maxCivDistance) then {
                            _count = _count + 1;
                        };
                    } count JK_CivsArray;

                    if (_count < JK_maxCivDensity) then {
                        if ([_player, "21"] call CBA_fnc_inArea) then {
                            [(position _player), _count] call JK_spawnciv;
                        };
                    };
                };
                nil
            } count allPlayers;

            sleep 10;
        };
    } else {
        while {true} do {
            call JK_deleteCivs;

            _count = 0;
            {
                if (_x distance player < JK_maxCivDistance) then {
                    _count = _count + 1;
                };
            } count JK_CivsArray;

            if (_count < JK_maxCivDensity) then {
                [(position player), _count] call JK_spawnciv;
            };

            sleep 10;
        };
    };
};
