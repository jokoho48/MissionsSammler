[player ,typeOf player] call CLib_fnc_applyLoadout;
call JK_BadSanta_fnc_weather;

["Respawn",{
    (_this select 0) params ["_oldUnit", "_newUnit"];
    deleteVehicle _oldUnit;
    [_newUnit, typeOf _newUnit] call CLib_fnc_applyLoadout;
}] call CLib_fnc_addEventHandler;