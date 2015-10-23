private ["_cansee", "_eyes", "_angle", "_hyp", "_adj", "_opp", "_infront", "_obstruction", "_cansee"];
params ["_unit", "_focus"];
_cansee = false;

if (isnil("_focus")) then {
    _eyes = eyepos _unit;
    _angle = (getdir _unit);

    _hyp = 5;
    _adj = _hyp * (cos _angle);
    _opp = sqrt ((_hyp*_hyp) - (_adj * _adj));


    _infront = if ((_angle) >=  180) then {
        [(_eyes select 0) - _opp,(_eyes select 1) + _adj,(_eyes select 2)]
    } else {
        [(_eyes select 0) + _opp,(_eyes select 1) + _adj,(_eyes select 2)]
    };

    _obstruction = (lineintersectswith [_eyes,_infront,_unit]) select 0;

    _cansee = if (isnil("_obstruction")) then {true} else {false};
};

_cansee
