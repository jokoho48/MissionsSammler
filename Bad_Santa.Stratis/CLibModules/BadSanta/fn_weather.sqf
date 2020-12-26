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

JK_OverCast = overcast;

0 setOvercast JK_OverCast;
0 setRain 0;

if (hasInterface) then {
    JK_hndl = ppEffectCreate ["colorCorrections", 1501];
    JK_hndl ppEffectEnable true;
    JK_hndl ppEffectAdjust [0.5, 0.7, 0.002, [0.1, .2, 2, 0.01], [.88, .88, 1, .45], [1.1 , 1.1, 1.1, 0.03]];
    JK_hndl ppEffectCommit 0;
};

JK_FogParams = fogparams;
JK_BadSanta_fnc_UpdateWeatherAndPP = {
    10 setFog JK_FogParams;
    10 setRain 0;
    10 setOvercast JK_OverCast;
    if (hasInterface) then {
        JK_hndl ppEffectEnable true;
        JK_hndl ppEffectAdjust [0.5, 0.7, 0.002, [0.1, .2, 2, 0.01], [.88, .88, 1, .45], [1.1 , 1.1, 1.1, 0.03]];
        JK_hndl ppEffectCommit 10;
        if (isNull objectParent player) then {
            playSound format ["wind%1", ceil random 5];
        };
    };
    [{call JK_BadSanta_fnc_UpdateWeatherAndPP}, 10] call CLib_fnc_wait;
};
call JK_BadSanta_fnc_UpdateWeatherAndPP;
//--- Wind & Dust
setWind [0.201112, 0.204166, true];
if !(hasInterface) exitWith {};
if (isNull objectParent player) then {
    playSound format ["wind%1", ceil random 5];
};

//--- Dust
private _velocity = [random 10, random 10, -1];
private _color = [1.0, 0.9, 0.8];
private _alpha = 0.02 + random 0.02;
private _ps = "#particlesource" createVehicleLocal _pos;
_ps setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8], "", "Billboard", 1, 3, [0, 0, -6], _velocity, 1, 1.275, 1, 0, [9], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _obj];
_ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
_ps setParticleCircle [0.1, [0, 0, 0]];
_ps setDropInterval 0.002;

JK_BadSanta_fnc_UpdateFogParticles = {
    params ["_ps"];
    _ps setPos (getPos player);
    [{_this call JK_BadSanta_fnc_UpdateFogParticles}, _ps] call CLib_fnc_wait;
};

_ps call JK_BadSanta_fnc_UpdateFogParticles;

//Snow script
private _obj = player;

private _pos = getPos (vehicle _obj);
_pos set [2, 0];

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

JK_Distance = 15;
JK_Height = 5;
JK_Density = 6000;

[{
    private _pos = getPosATL player;
    _pos params ["_posX", "_posY", "_posZ"];
    private _playerVelocity = (velocity (vehicle player));
    for "_i" from 0 to JK_Density/diag_fps do {
        private _dpos = [
            (_posX + (JK_Distance - (random (2 * JK_Distance))) + (_playerVelocity select 0)),
            (_posY + (JK_Distance - (random (2 * JK_Distance))) + (_playerVelocity select 1)),
            (_posZ + JK_Height)
        ];
        drop [
            "\a3\data_f\cl_water",
            "",
            "Billboard",
            1, 15,
            _dpos,
            [0,0,-1],
            1, 0.0000001,
            0.000, 0.7,
            [0.07],
            [
                [1,1,1,0],
                [1,1,1,0.7],
                [1,1,1,0.7],
                [1,1,1,0.7]
            ],
            [0,0],
            0.2, 1.2,
            "", "", ""
        ];
    };
    JK_Weather_fog1 setPos _pos;
    JK_Weather_fog2 setPos _pos;
    JK_Weather_fog3 setPos _pos;
}, 0] call CLib_fnc_addPerframeHandler;
