["deleteLog", {
    {
        private _vehicle = _x;
        private _crew = crew _x;
        {
            _vehicle deleteVehicleCrew _x;
            nil
        } count _crew;
        deleteVehicle _vehicle;
        nil
    } count [Log1, Log2, Log3];
}] call CBA_fnc_addEventHandler;

["Attack1", {




}] call CBA_fnc_addEventHandler;

["moerser1", {
    {
        playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", _x, false, getPosASL _x, 1, 1, 300]
    } count [Sound1, Sound2, Sound3, Sound4];
    sleep 5;
    for "_x" from 1 to 6 do {
        private _pos = getMarkerPos format ["moerser_%1",_x];
        for "_i" from 0 to 3 do {
            private _pos = [(_pos select 0) + (random 10), (_pos select 1) + (random 10), (_pos select 2) + (random 10)];
            private _veh = "HeliHEmpty" createVehicle _pos;
            _veh setVariable ["type", "ModuleOrdnanceHowitzer_F_Ammo", true];
            [_veh,[],true] spawn bis_fnc_moduleprojectile;
            sleep 0.5;
        };
        sleep 5 + (random 5);
    };
}] call CBA_fnc_addEventHandler;
