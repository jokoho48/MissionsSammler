JK_BuildAnimation = "Acts_carFixingWheel";
JK_BuildTime = 12;
JK_Medical_Vehicles = [MedUAZ1, MedUAZ2];
waitUntil {!isNil "JK_varHandle"};
JK_varHandle setVariable ["JK_tent", []];
JK_fnc_canBuildTent = {
    params ["_JKvehicle","_JKplayer"];
    !(_JKvehicle getVariable ["JK_buildTent", false]) && (_JKplayer getVariable ["ace_medical_medicClass", 0]) == 2 && _JKplayer == vehicle _JKplayer
};

JK_fnc_destructTent = {
    (_this select 0) params ["_JKtent","_JKplayer"];
    local _JKvehicle = _JKtent getVariable ["JK_tentVehicle", objNull];
    _JKtent setVariable ["JK_tentVehicle", objNull];
    _JKvehicle setVariable ["JK_buildTent", false];
    _array = JK_varHandle getVariable ["JK_tent", []];
    _array deleteAt (_array find _JKtent);
    deleteVehicle _JKtent;
    JK_varHandle setVariable ["JK_tent", _array];

};

JK_fnc_destructTentProgressBar = {
    player playMove JK_BuildAnimation;
    [JK_BuildTime, _this, JK_fnc_destructTent, {(_this select 0) select 1 switchMove ""}, "Zelt Abbauen"] call ace_common_fnc_progressBar;
};

JK_fnc_buildTent = {
    (_this select 0) params ["_JKvehicle","_JKplayer"];
    local _position = (getPos _JKvehicle) findEmptyPosition [5, 20, "MASH"];
    if (_position isEqualTo []) exitWith {hint "Kein Platz zum Aufbauen eines Medizinieschen Notfallzeltes."};
    local _JKtent = "MASH" createVehicle _position;
    _JKtent setdir (getDir _JKvehicle);
    local _action = ["JK_BuildTent", "Zelt Abbauen", "", JK_fnc_destructTentProgressBar, JK_fnc_canBuildTent] call ace_interact_menu_fnc_createAction;
    [_JKtent, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    _JKtent setVariable ["ace_medical_isMedicalFacility", true, true];
    _JKvehicle setVariable ["JK_buildTent", true];
    _JKtent setVariable ["JK_tentVehicle", _JKvehicle];
    _array = JK_varHandle getVariable ["JK_tent", []];
    _array pushBack _JKtent;
    JK_varHandle setVariable ["JK_tent", _array];
};

JK_buildTentProgressBar = {
    player playMove JK_BuildAnimation;
    [JK_BuildTime, _this, JK_fnc_buildTent, {(_this select 0) select 1 switchMove ""}, "Baue Mediziniesches Zelt auf"] call ace_common_fnc_progressBar;
};

local _action = ["JK_BuildTent", "Baue Mediziniesches Zelt auf", "", JK_buildTentProgressBar, JK_fnc_canBuildTent] call ace_interact_menu_fnc_createAction;

{
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    nil
} count JK_Medical_Vehicles;

call compile preprocessFileLineNumbers "fixXEH.sqf";

TelePortFlag addAction ["Teleport Tent 1", {(_this select 1) setPos (getPos ((JK_varHandle getVariable ["JK_tent", [player, player]]) select 0))}, [], 99, false, false, "", "(count (JK_varHandle getVariable ['JK_tent', [player, player]])) >= 1"];
TelePortFlag addAction ["Teleport Tent 2", {(_this select 1) setPos (getPos ((JK_varHandle getVariable ["JK_tent", [player, player]]) select 1))}, [], 98, false, false, "", "(count (JK_varHandle getVariable ['JK_tent', [player, player]])) == 2"];
