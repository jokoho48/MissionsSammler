JK_BuildAnimation = "Acts_carFixingWheel";
JK_BuildTime = 12;
JK_Medical_Vehicles = [MedUAZ1, MedUAZ2];
waitUntil {!isNil "JK_varHandle"};
JK_varHandle setVariable ["JK_tent", [], true];
JK_fnc_canBuildTent = {
    params ["_JKvehicle","_JKplayer"];
    !(_JKvehicle getVariable ["JK_buildTent", false]) /*&& (_JKplayer getVariable ["ace_medical_medicClass", 0]) == 2*/ && _JKplayer == vehicle _JKplayer
};

JK_fnc_destructTent = {
    private ["_JKvehicle"];
    (_this select 0) params ["_JKtent","_JKplayer"];
    _JKvehicle = _JKtent getVariable ["JK_tentVehicle", objNull];
    _JKtent setVariable ["JK_tentVehicle", objNull, true];
    _JKvehicle setVariable ["JK_buildTent", false, true];
    _array = JK_varHandle getVariable ["JK_tent", []];
    _array deleteAt (_array find _JKtent);
    deleteVehicle _JKtent;
    JK_varHandle setVariable ["JK_tent", _array, true];
};

JK_fnc_destructTentProgressBar = {
    player playMove JK_BuildAnimation;
    [JK_BuildTime, _this, JK_fnc_destructTent, {(_this select 0) select 1 switchMove ""}, "Zelt Abbauen"] call ace_common_fnc_progressBar;
};

JK_fnc_buildTent = {
    private ["_position", "_JKtent", "_action"];
    (_this select 0) params ["_JKvehicle","_JKplayer"];
    _position = (getPos _JKvehicle) findEmptyPosition [5, 20, "MASH"];
    if (_position isEqualTo []) exitWith {hint "Kein Platz zum Aufbauen eines medizinisches Notfallzeltes."};
    _JKtent = "MASH" createVehicle _position;
    _JKtent setdir (getDir _JKvehicle);
    _action = ["JK_BuildTent", "Zelt Abbauen", "", JK_fnc_destructTentProgressBar, JK_fnc_canBuildTent] call ace_interact_menu_fnc_createAction;
    [[_JKtent, 0, ["ACE_MainActions"], _action], "ace_interact_menu_fnc_addActionToObject", true] call BIS_fnc_MP;
    _JKtent setVariable ["ace_medical_isMedicalFacility", true, true];
    _JKvehicle setVariable ["JK_buildTent", true, true];
    _JKtent setVariable ["JK_tentVehicle", _JKvehicle, true];
    _array = JK_varHandle getVariable ["JK_tent", []];
    _array pushBack _JKtent;
    JK_varHandle setVariable ["JK_tent", _array, true];
};

JK_fnc_buildTentProgressBar = {
    private "_position";
    params ["_JKvehicle"];
    _position = (getPos _JKvehicle) findEmptyPosition [5, 20, "MASH"];
    if (_position isEqualTo []) exitWith {hint "Kein Platz zum Aufbauen eines medizinisches Notfallzeltes."};
    player playMove JK_BuildAnimation;
    [JK_BuildTime, _this, JK_fnc_buildTent, {(_this select 0) select 1 switchMove ""}, "Baue medizinisches Zelt auf"] call ace_common_fnc_progressBar;
};

private "_action";
_action = ["JK_BuildTent", "Baue Mediziniesches Zelt auf", "", JK_fnc_buildTentProgressBar, JK_fnc_canBuildTent] call ace_interact_menu_fnc_createAction;

{
    [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    nil
} count JK_Medical_Vehicles;

call compile preprocessFileLineNumbers "fixXEH.sqf";

TelePortFlag addAction ["Teleport Tent 1", {(_this select 1) setPos (getPos ((JK_varHandle getVariable ["JK_tent", [player, player]]) select 0)); call JK_MedicalMarker_fnc_hide;}, [], 99, false, false, "", "(count (JK_varHandle getVariable ['JK_tent', []])) >= 1"];
TelePortFlag addAction ["Teleport Tent 2", {(_this select 1) setPos (getPos ((JK_varHandle getVariable ["JK_tent", [player, player]]) select 1)); call JK_MedicalMarker_fnc_hide;}, [], 98, false, false, "", "(count (JK_varHandle getVariable ['JK_tent', []])) == 2"];

JK_MedicalMarker = [];
JK_MedicalMarker_fnc_show = {
    {
        private ["_name", "_mrk"];
        _name = "Medical Rally Point " + str(_forEachindex + 1);
        _mrk = createMarkerLocal [_name, getPos _x];
        _mrk setMarkerShapeLocal "ICON";
        _mrk setMarkerTypeLocal "hd_start";
        _mrk setMarkerColorLocal "ColorEAST";
        _mrk setMarkerText _name;
        JK_MedicalMarker pushBack _mrk;
    } forEach (JK_varHandle getVariable ['JK_tent', []]);
};

JK_MedicalMarker_fnc_hide = {
    {
        deleteMarkerLocal _x;
    } count JK_MedicalMarker;
    JK_MedicalMarker = [];
};
