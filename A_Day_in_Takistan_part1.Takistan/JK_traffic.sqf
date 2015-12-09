waitUntil {!isNil "JK_MissionStarted"};
params ["_maxCarDensity", "_carSpawnDistance", "_maxCarDistance"];
JK_maxCarDensity = _maxCarDensity; //number of cars around 1 player at the same time
JK_carSpawnDistance = _carSpawnDistance; //how far cars spawn away from player
JK_maxCarDistance = _maxCarDistance;    //max distance until cars despawn

JK_carsArray = [];

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

JK_civCarList = [
    "LOP_TAK_Civ_UAZ",
    "LOP_TAK_Civ_UAZ_Open",
    "LOP_TAK_Civ_Landrover"
];

JK_comCarList = [
    "LOP_TAK_Civ_Ural_open",
    "LOP_TAK_Civ_Ural"
];

JK_getDrivingRoads = {
    private "_roads";
    _roads = _this nearRoads JK_maxCarDistance;
    _roads
};

JK_getSpawnRoads = {
    private ["_roads", "_farRoads", "_pos"];
    _roads = _this nearRoads JK_maxCarDistance;
    _farRoads = [];
    {
        if (_this distance position _x > JK_carSpawnDistance) then {
            _farRoads pushBack _x;
        };
        nil
    } count _roads;

    _farRoads
};

if (!isDedicated and isMultiplayer) then {
    [] spawn {
        while {true} do {
            private ["_roads", "_var"];
            _roads = (position player) call JK_getSpawnRoads;
            _var = player getVariable ["JK_roadsNear", false];

            if (count _roads > 0) then {
                if (!_var) then {
                    player setVariable ["JK_roadsNear", true, true];
                };
            } else {
                if (_var) then {
                    player setVariable ["JK_roadsNear", false, true];
                };
            };
            sleep 10;
        };
    };
};

JK_spawnCar = {
    private ["_roads", "_carlist", "_roadseg", "_spawnpos","_spawndir", "_car", "_sqname", "_spawncar", "_civtype", "_driver"];
    params ["_position", "_count"];

    _roads = _position call JK_getSpawnRoads;

    if (count _roads > 0) then {
        _carlist = JK_civCarList;

        if (daytime > 5 or daytime < 20) then {
            _carlist = JK_civCarList + JK_civCarList + JK_comCarList;
        };

        _roadseg = _roads call BIS_fnc_selectRandom;
        _spawnpos = getposasl _roadseg;
        _spawndir = getdir _roadseg;
        _car = _carlist call BIS_fnc_selectRandom;
        _sqname = creategroup civilian;
        _spawncar = _car createVehicle _spawnpos;
        _spawncar setdir _spawndir;
        _spawncar setfuel 0.5 + (random 0.5);

        JK_carsArray pushBack _spawncar;

        //Driver
        _civtype = JK_civlist call BIS_fnc_selectRandom;
        _driver = _sqname createUnit [_civtype,_spawnpos, [], 0, "FORM"];
        _driver moveindriver _spawncar;
        _driver setbehaviour "SAFE";
        _spawncar setvariable ["JK_car_driver", _driver];

        [leader _sqname] call JK_carWaypoint;
    };
};

JK_carWaypoint = {
    private ["_grp", "_locations", "_randomLocation", "_locationPos", "_roads", "_road", "_wp", "_waypoint"];
    params ["_driver"];
    _grp = group _driver;
    _locations = nearestLocations [getPos _driver, ["NameVillage","NameCity","NameCityCapital","NameLocal","CityCenter"], 30000];
    _randomLocation = _locations call BIS_fnc_selectRandom;
    _locationPos = locationPosition _randomLocation;

    if ([_locationPos, "21"] call CBA_fnc_inArea) then {
        while {!([_locationPos, "21"] call CBA_fnc_inArea)} do {
            _randomLocation = _locations call BIS_fnc_selectRandom;
            _locationPos = locationPosition _randomLocation;
        };
    };
    _roads = _locationPos call JK_getDrivingRoads;

    _road = _roads call BIS_fnc_selectRandom;
    _wp = getposasl _road;
    _waypoint = _grp addWaypoint [_wp, 0];
    [_grp,0] setWaypointCompletionRadius 30;
    _waypoint setWaypointStatements ["true", "[this] call JK_carWaypoint"]
};

JK_deleteCars = {
    private ["_players"];

    _players = allPlayers;

    {
        private ["_car", "_c", "_driver", "_group"];
        _car = _x;

        _c = 0;
        {
            if (_car distance _x > JK_maxCarDistance and ((lineintersects [eyepos _x,getposasl _car,_x,_car]) || (terrainintersectasl [eyepos _x,getposasl _car]))) then {
                _c = _c + 1;
            };
        } count _players;

        if (_c == (count _players)) then {
            _driver = (_car getvariable ["JK_car_driver", objNull]);

            if (!isNull _driver) then {
                _group = group _driver;
                moveout _driver;
                deleteVehicle _driver;
                deleteGroup _group;
            };

            JK_carsArray = JK_carsArray - [_car];
            deleteVehicle _car;
        };
    } count JK_carsArray;
};

if (isServer) then {
    if (isMultiplayer) then {
        while {true} do {
            call JK_deleteCars;

            {
                private ["_player", "_count", "_var"];
                _player = _x;
                _count = 0;
                _var = _player getVariable ["JK_roadsNear", false];

                if (_var) then {
                    {
                        if (_x distance _player < JK_maxCarDistance) then {
                            _count = _count + 1;
                        };
                    } count JK_carsArray;

                    if (_count < JK_maxCarDensity) then {
                        [(position _player), _count] call JK_spawnCar;
                    };
                };
            } count allPlayers;

            sleep 10;
        };
    } else {
        while {true} do {

            private ["_count", "_var"];
            call JK_deleteCars;

            _count = 0;
            _var = player getVariable ["JK_roadsNear", false];

            if (_var) then {
                {
                    if (_x distance player < JK_maxCarDistance) then {
                        _count = _count + 1;
                    };
                } count JK_carsArray;

                if (_count < JK_maxCarDensity) then {
                    if ([player, "21"] call CBA_fnc_inArea) then {
                        [(position player), _count] call JK_spawnCar;
                    };
                };
            };

            sleep 10;
        };
    };
};
