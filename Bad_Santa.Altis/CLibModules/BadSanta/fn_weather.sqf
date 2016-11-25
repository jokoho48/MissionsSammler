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

[{
    100 setFog [0.08, 0.02, 120];
    100 setrain 0;
    100 setovercast 0.6;
    if (hasInterface) then {
        JK_hndl ppEffectEnable true;
        JK_hndl ppEffectAdjust [0.5, 0.7, 0.002, [0.1, .2, 2, 0.01], [.88, .88, 1, .45], [1.1 , 1.1, 1.1, 0.03]];
        JK_hndl ppEffectCommit 10;
    };
}, 10] call CLib_fnc_addPerFrameHandler;

//--- Wind & Dust
setwind [0.201112, 0.204166, true];
[{
    private _obj = vehicle player;
    if (_obj isEqualTo player) then {
        playSound format ["wind%1", ceil random 5];
    };
    private _pos = position _obj;

    //--- Dust
    private _velocity = [random 10, random 10, -1];
    private _color = [1.0, 0.9, 0.8];
    private _alpha = 0.02 + random 0.02;
    private _ps = "#particlesource" createVehicleLocal _pos;
    _ps setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8], "", "Billboard", 1, 3, [0, 0, -6], _velocity, 1, 1.275, 1, 0, [9], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _obj];
    _ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
    _ps setParticleCircle [0.1, [0, 0, 0]];
    _ps setDropInterval 0.002;

    [{deletevehicle _this;}, random 2 + 0.5, _ps] call CLib_fnc_wait;

}, 25] call CLib_fnc_addPerFrameHandler;

//Snow script
private _obj = player;

private _pos = position (vehicle _obj);
_pos set [2, 0];
#define __D 15
#define __H0 30
#define __H1 8
#define __H2 4
#define DENSITY 20000

JK_Weather_fog1 = "#particlesource" createVehicleLocal _pos;
JK_Weather_fog1 setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal" , 16, 12, 13, 0], "", "Billboard", 1, 10,
    [0, 0, -6], [0, 0, 0], 1, 1.275, 1, 0,
    [7,6], [[1, 1, 1, 0], [1, 1, 1, 0.04], [1, 1, 1, 0]], [1000], 1, 0, "", "", _obj
];
JK_Weather_fog1 setParticleRandom [3, [55, 55, 0.2], [0, 0, -0.1], 2, 0.45, [0, 0, 0, 0.1], 0, 0];
JK_Weather_fog1 setParticleCircle [0.001, [0, 0, -0.12]];
JK_Weather_fog1 setDropInterval 0.002;

JK_Weather_fog2 = "#particlesource" createVehicleLocal _pos;
JK_Weather_fog2 setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal" , 16, 12, 13, 0], "", "Billboard", 1, 10,
    [0, 0, -6], [0, 0, 0], 1, 1.275, 1, 0,
    [7,6], [[1, 1, 1, 0], [1, 1, 1, 0.04], [1, 1, 1, 0]], [1000], 1, 0, "", "", _obj
];
JK_Weather_fog2 setParticleRandom [3, [55, 55, 0.2], [0, 0, -0.1], 2, 0.45, [0, 0, 0, 0.1], 0, 0];
JK_Weather_fog2 setParticleCircle [0.001, [0, 0, -0.12]];
JK_Weather_fog2 setDropInterval 0.002;

JK_Weather_fog3 = "#particlesource" createVehicleLocal _pos;
JK_Weather_fog3 setParticleParams [
    ["\A3\data_f\ParticleEffects\Universal\Universal" , 16, 12, 13, 0], "", "Billboard", 1, 10,
    [0, 0, -6], [0, 0, 0], 1, 1.275, 1, 0,
    [7,6], [[1, 1, 1, 0], [1, 1, 1, 0.04], [1, 1, 1, 0]], [1000], 1, 0, "", "", _obj
];
JK_Weather_fog3 setParticleRandom [3, [55, 55, 0.2], [0, 0, -0.1], 2, 0.45, [0, 0, 0, 0.1], 0, 0];
JK_Weather_fog3 setParticleCircle [0.001, [0, 0, -0.12]];
JK_Weather_fog3 setDropInterval 0.002;
0 spawn {
    while {true} do {
        private _pos = getPos player;
        _pos set [2, 0];
        JK_Weather_fog1 setpos _pos;
        JK_Weather_fog2 setpos _pos;
        JK_Weather_fog3 setpos _pos;
        for "_i" from 0 to DENSITY do {
            private _pos = getPosATL player;
            _pos params ["_posX", "_posY", "_posZ"];
            private _playerVelocity = (velocity (vehicle player)) select 0;
            {
                private _dpos = [(_posX + (__D - (random (2*__D))) + (_playerVelocity * 1)),(_posY + (__D - (random (2*__D))) + (_playerVelocity * 1)),(_posZ + _x)];
                drop ["\a3\data_f\cl_water", "", "Billboard", 1, 7, _dpos, [0,0,-1], 1, 0.0000001, 0.000, 0.7, [0.07], [[1,1,1,0], [1,1,1,0.7], [1,1,1,0.7], [1,1,1,0.7]], [0,0], 0.2, 1.2, "", "", ""];
                nil
            } count [__H0, __H1, __H2];
        };
        sleep 1;
    };
};
