JK_BuildAnimation = "Acts_carFixingWheel";
JK_BuildTime = 12;
JK_Medical_Vehicles = [MedUAZ1, MedUAZ2];

JK_fnc_canBuildTent = {
    params ["_JKvehicle","_JKplayer"];
    !(_JKvehicle getVariable ["JK_buildTent", false]) && (_JKplayer getVariable ["ace_medical_medicClass", 0]) == 2 && _JKplayer == vehicle _JKplayer
};

JK_fnc_destructTent = {
    (_this select 0) params ["_JKtent","_JKplayer"];
    local _JKvehicle = _JKtent getVariable ["JK_tentVehicle", objNull];
    _JKtent setVariable ["JK_tentVehicle", objNull];
    _JKvehicle setVariable ["JK_buildTent", false];
    deleteVehicle _JKtent;
};

JK_fnc_destructTentProgressBar = {
    player playMove JK_BuildAnimation;
    [JK_BuildTime, _this, JK_fnc_destructTent, {(_this select 0) select 1 switchMove ""}, "tear down tent"] call ace_common_fnc_progressBar;
};

JK_fnc_buildTent = {
    (_this select 0) params ["_JKvehicle","_JKplayer"];
    local _position = (getPos _JKvehicle) findEmptyPosition [5, 20, "MASH"];
    if (_position isEqualTo []) exitWith {hint "No Space to create the medical tent."};
    local _JKtent = "MASH" createVehicle _position;
    _JKtent setdir (getDir _JKvehicle);
    local _action = ["JK_BuildTent", "tear down Tent", "", JK_fnc_destructTentProgressBar, JK_fnc_canBuildTent] call ace_interact_menu_fnc_createAction;
    [_JKtent, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    _JKtent setVariable ["ace_medical_isMedicalFacility", true, true];
    _JKvehicle setVariable ["JK_buildTent", true];
    _JKtent setVariable ["JK_tentVehicle", _JKvehicle];
};

JK_buildTentProgressBar = {
    player playMove JK_BuildAnimation;
    [JK_BuildTime, _this, JK_fnc_buildTent, {(_this select 0) select 1 switchMove ""}, "build medical tent"] call ace_common_fnc_progressBar;
};

local _action = ["JK_BuildTent", "build medical tent", "", JK_buildTentProgressBar, JK_fnc_canBuildTent] call ace_interact_menu_fnc_createAction;

{
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach JK_Medical_Vehicles;
call compile preprocessFileLineNumbers "fixXEH.sqf";
