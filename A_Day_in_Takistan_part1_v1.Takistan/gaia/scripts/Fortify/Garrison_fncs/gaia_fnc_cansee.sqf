params ["_unit", "_focus"];
local _cansee = false;

if (isnil("_focus")) then {
    local _eyes = eyepos _unit;
    local _angle = (getdir _unit);

    local _hyp = 5;
    local _adj = _hyp * (cos _angle);
    local _opp = sqrt ((_hyp*_hyp) - (_adj * _adj));


    local _infront = if ((_angle) >=  180) then {
        [(_eyes select 0) - _opp,(_eyes select 1) + _adj,(_eyes select 2)]
    } else {
        [(_eyes select 0) + _opp,(_eyes select 1) + _adj,(_eyes select 2)]
    };

    local _obstruction = (lineintersectswith [_eyes,_infront,_unit]) select 0;

    _cansee = if (isnil("_obstruction")) then {true} else {false};
};

_cansee
