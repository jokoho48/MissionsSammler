{
    private "_myBall";
    _myBall = "Sign_Sphere25cm_F" createVehicle [0,0,0];
    [_x,_myBall] spawn {
        params ["_unit", "_ball"];

        while {sleep 0.2; alive _unit} do {
            private ["_pos", "_eyes", "_zDif", "_alert"];
            _pos = getPosAtl _unit;
            _eyes = eyePos _unit;
            _zDif = ((_eyes select 2) - ((getPosASL _unit) select 2));
            _pos set [2,(_pos select 2) + _zDif + 0.2];
            _ball setPos _pos;

            _alert = time - (_unit getVariable ["alerted",0]);
            if (_alert < 10) then {
                _ball setObjectTexture [0,"#(argb,8,8,3)color(1,0,0,1)"];
            } else {
                _ball setObjectTexture [0,"#(argb,8,8,3)color(0,0,1,1)"];
            };
        };
        deleteVehicle _ball;
    };
} count allUnits;
