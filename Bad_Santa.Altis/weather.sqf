/*
 * Author: joko // Jonas
 * Add a Color Correction and add Ground Fog and Snow Particles
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call compile preprocessFileLineNumbers "weather.sqf";
 *
 * Public: Yes
 */
0 spawn {
    waitUntil {!isNull (findDisplay 46)};

    "filmGrain" ppEffectEnable true;
    "filmGrain" ppEffectAdjust [0.02, 1, 1, 0.1, 1, false];
    "filmGrain" ppEffectCommit 5;

    setviewdistance 1000;

    setObjectViewDistance [1000, 1000];

    0 setovercast 0.6;
    0 setrain 0;

    if (hasInterface) then {
        JK_hndl = ppEffectCreate ["colorCorrections", 1501];
        JK_hndl ppEffectEnable true;
        JK_hndl ppEffectAdjust [0.5, 0.7, 0.002, [0.1, .2, 2, 0.01], [.88, .88, 1, .45], [1.1 , 1.1, 1.1, 0.03]];
        JK_hndl ppEffectCommit 0;
    };

    [] spawn {
        while {true} do {
            100 setFog [0.08, 0.02, 120];
            100 setrain 0;
            100 setovercast 0.6;
            if (hasInterface) then {
                JK_hndl ppEffectEnable true;
                JK_hndl ppEffectAdjust [0.5, 0.7, 0.002, [0.1, .2, 2, 0.01], [.88, .88, 1, .45], [1.1 , 1.1, 1.1, 0.03]];
                JK_hndl ppEffectCommit 10;
            };
            sleep 10;
        };
    };

    //--- Wind & Dust
    [] spawn {
        waituntil {isplayer player};
        setwind [0.201112,0.204166,true];
        while {true} do {
            private _ran = ceil random 5;
            playsound format ["wind%1",_ran];
            private _obj = vehicle player;
            private _pos = position _obj;

            //--- Dust
            private _velocity = [random 10,random 10,-1];
            private _color = [1.0, 0.9, 0.8];
            private _alpha = 0.02 + random 0.02;
            private _ps = "#particlesource" createVehicleLocal _pos;
            _ps setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8], "", "Billboard", 1, 3, [0, 0, -6], _velocity, 1, 1.275, 1, 0, [9], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _obj];
            _ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
            _ps setParticleCircle [0.1, [0, 0, 0]];
            _ps setDropInterval 0.002;

            sleep (random 1);
            deletevehicle _ps;
            sleep 10 + random 20;
        };
    };

    //Snow script

    private _obj = player;

    private _pos = position (vehicle _obj);
    _pos set [2, 0];
    private _d = 15;
    private _h = 30;
    private _h1 = 8;
    private _h2 = 4;
    private _density = 20000;

    private _fog1 = "#particlesource" createVehicleLocal _pos;
    _fog1 setParticleParams [
        ["\A3\data_f\ParticleEffects\Universal\Universal" , 16, 12, 13, 0], "", "Billboard", 1, 10,
        [0, 0, -6], [0, 0, 0], 1, 1.275, 1, 0,
        [7,6], [[1, 1, 1, 0], [1, 1, 1, 0.04], [1, 1, 1, 0]], [1000], 1, 0, "", "", _obj
    ];
    _fog1 setParticleRandom [3, [55, 55, 0.2], [0, 0, -0.1], 2, 0.45, [0, 0, 0, 0.1], 0, 0];
    _fog1 setParticleCircle [0.001, [0, 0, -0.12]];
    _fog1 setDropInterval 0.002;

    private _fog2 = "#particlesource" createVehicleLocal _pos;
    _fog2 setParticleParams [
        ["\A3\data_f\ParticleEffects\Universal\Universal" , 16, 12, 13, 0], "", "Billboard", 1, 10,
        [0, 0, -6], [0, 0, 0], 1, 1.275, 1, 0,
        [7,6], [[1, 1, 1, 0], [1, 1, 1, 0.04], [1, 1, 1, 0]], [1000], 1, 0, "", "", _obj
    ];
    _fog2 setParticleRandom [3, [55, 55, 0.2], [0, 0, -0.1], 2, 0.45, [0, 0, 0, 0.1], 0, 0];
    _fog2 setParticleCircle [0.001, [0, 0, -0.12]];
    _fog2 setDropInterval 0.002;

    private _fog3 = "#particlesource" createVehicleLocal _pos;
        _fog3 setParticleParams [
        ["\A3\data_f\ParticleEffects\Universal\Universal" , 16, 12, 13, 0], "", "Billboard", 1, 10,
        [0, 0, -6], [0, 0, 0], 1, 1.275, 1, 0,
        [7,6], [[1, 1, 1, 0], [1, 1, 1, 0.04], [1, 1, 1, 0]], [1000], 1, 0, "", "", _obj
    ];
    _fog3 setParticleRandom [3, [55, 55, 0.2], [0, 0, -0.1], 2, 0.45, [0, 0, 0, 0.1], 0, 0];
    _fog3 setParticleCircle [0.001, [0, 0, -0.12]];
    _fog3 setDropInterval 0.002;


    while {true} do {
        private _a = 0;
        private _pos = getPos player;
        _pos set [2, 0];
        _fog1 setpos _pos;
        _fog2 setpos _pos;
        _fog3 setpos _pos;
        for "_i" from 0 to _density step 1 do {
            private _pos = getPosATL player;
            0 setRain 0;
            _pos params ["_posX", "_posY", "_posZ"];
            private _playerVelocity = (velocity (vehicle player)) select 0;
            private _dpos = [(_posX + (_d - (random(2 * _d))) + (_playerVelocity * 1)), (_posY + (_d - (random (2*_d))) + (_playerVelocity*1)),(_posZ + _h)];
            drop ["\a3\data_f\cl_water", "", "Billboard", 1, 7, _dpos, [0,0,-1], 1, 0.0000001, 0.000, 0.7, [0.07], [[1,1,1,0], [1,1,1,0.7], [1,1,1,0.7], [1,1,1,0.7]], [0,0], 0.2, 1.2, "", "", ""];

            _dpos = [(_posX + (_d - (random (2*_d))) + (_playerVelocity * 1)),(_posY + (_d - (random (2*_d))) + (_playerVelocity * 1)),(_posZ + _h1)];
            drop ["\a3\data_f\cl_water", "", "Billboard", 1, 7, _dpos, [0,0,-1], 1, 0.0000001, 0.000, 0.7, [0.07], [[1,1,1,0], [1,1,1,0.7], [1,1,1,0.7], [1,1,1,0.7]], [0,0], 0.2, 1.2, "", "", ""];

            _dpos = [(_posX + (_d - (random (2*_d))) + (_playerVelocity * 1)),(_posY + (_d - (random (2*_d))) + (_playerVelocity * 1)),(_posZ + _h2)];
            drop ["\a3\data_f\cl_water", "", "Billboard", 1, 7, _dpos, [0,0,-1], 1, 0.0000001, 0.000, 0.7, [0.07], [[1,1,1,0], [1,1,1,0.7], [1,1,1,0.7], [1,1,1,0.7]], [0,0], 0.2, 1.2, "", "", ""];
            _a = _a + 1;
        };
        sleep 1;
    };
};
