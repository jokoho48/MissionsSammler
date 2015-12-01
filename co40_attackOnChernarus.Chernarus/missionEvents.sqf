["moerser1", {
    {
        playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", _x, false, getPosASL _x, 1, 1, 300]
    } count [Sound1, Sound2, Sound3];
    sleep 5;
    for "_x" from 1 to 6 do {
        private ["_pos", "_veh"];
        _pos = getMarkerPos format ["moerser_%1",_x];
        call {
            _pos = [(_pos select 0) + (random 10), (_pos select 1) + (random 10), (_pos select 2) + (random 10)];
            _veh = "HeliHEmpty" createVehicle _pos;
            _veh setVariable ["type", "ModuleOrdnanceHowitzer_F_Ammo", true];
            [_veh,[],true] spawn bis_fnc_moduleprojectile;
        };
        sleep 0.5;
        call {
            _pos = [(_pos select 0) + (random 10), (_pos select 1) + (random 10), (_pos select 2) + (random 10)];
            _veh = "HeliHEmpty" createVehicle _pos;
            _veh setVariable ["type", "ModuleOrdnanceHowitzer_F_Ammo", true];
            [_veh,[],true] spawn bis_fnc_moduleprojectile;
        };
        sleep 0.5;
        call {
            _pos = [(_pos select 0) + (random 10), (_pos select 1) + (random 10), (_pos select 2) + (random 10)];
            _veh = "HeliHEmpty" createVehicle _pos;
            _veh setVariable ["type", "ModuleOrdnanceHowitzer_F_Ammo", true];
            [_veh,[],true] spawn bis_fnc_moduleprojectile;
        };
        sleep 5 + (random 5);
    };
}, 1] call JK_Core_fnc_addMissionEvent;
