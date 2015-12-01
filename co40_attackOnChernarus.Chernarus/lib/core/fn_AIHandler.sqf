#define ISSTRING(VAR) (typeName (VAR) == "STRING")
#define ISFLOAT(VAR) (typeName (VAR) == "SCALAR")
/* AI Spawn Script ArmA3 Version
 * by joko // Jonas
 *
 * CBA Version
 * How To  CBA : [Spawn Postion(as Object or Marker(as String)), Target Postion as Object or Marker(as String)), Kind of Units as String or Array of Units, Side as Object, "CBA_X" X = Kind of Function, Radius Integer, Deficulty as String or as Array, move AI to HC, Name Of HeadlessClient as String] call JK_AI_fnc_Handler;
 * example CBA : [gameLogik1, gameLogik2, "OPF_F", east, "CBA_ATTACK", 20, "Normal"] call JK_AI_fnc_Handler;
 * CBA: CBA_ATTACK, CBA_DEFEND, CBA_PATROL
 *
 * UpsMon Version
 * How to  UpsMon: [Spawn Postion(as Object or Marker(String)), Target Postion Marker(as String)), Kind of Units as String or Array of Units, Side as Object, "UPSMON", [UPSMON Settings form Upsom Page in Array], Deficulty as String or as Array, move AI to HC, Name Of HeadlessClient as String] call JK_AI_fnc_Handler;
 * example UpsMon: [gameLogik1, "area1", "OPF_F", east, "UPSMON" , ["Random"], "Normal"] call JK_AI_fnc_AIHandler;
 * UpsMon: http://dev.withsix.com/projects/upsmon/wiki/UPSMONsqf
 *
 */
params [
    ["_spawnP", player],
    ["_target", player],
    ["_unitsA", ["B_Soldier_SL_F","B_Soldier_05_f","B_Soldier_03_f","B_Soldier_GL_F","B_soldier_M_F","B_medic_F"]],
    ["_side", west],
    ["_handler", "CBA_ATTACK"],
    ["_Settings", []],
    ["_spawnSkill", "NORMAL"]
];

if (ISSTRING(_spawnSkill)) then {
    _spawnSkill = switch (toUpper _skill) do {
        case ("EASY"): {[0.2,0.4,0.3]};
        case ("NORMAL"): {[0.4,0.6,0.5]};
        case ("HARD"): {[0.7,1,0.8]};
        default {[0.4,0.6,0.5]};
    };
};

if (ISSTRING(_spawnP)) then {
    _spawnP = getMarkerPos _pos;
} else {
    _spawnP = getPos _pos;
};
_spawnP set [2, 0];

if (ISSTRING(_target)) then {
    _target = getMarkerPos _area;
} else {
    _target = getPos _area;
};
_target set [2, 0];

if (ISSTRING(_unitsA)) then {
    _unitsA = missionNamespace getVariable _unitsA;
};

if (isNil "_unitsA") exitWith { diag_log format ["AIHandler: unaccepted Input Units in array!"]; };

_grp1 = [_spawnP, _side, _units, [], [], _spawnSkill] call BIS_fnc_spawnGroup;

switch (toUpper _handler) do {
    case ("CBA_ATTACK"): {
        if !(ISFLOAT(_Settings)) then { _Settings = 10; hint "CBA Need A Number as Setting!";};
        [_grp1, _targetPos, _Settings] call CBA_fnc_taskAttack;
    };
    case ("CBA_DEFEND"): {
        if !(ISFLOAT(_Settings)) then { _Settings = 60; hint "CBA Need A Number as Setting!";};
        [_grp1, _targetPos, _Settings] call CBA_fnc_taskDefend;
    };
    case ("CBA_PATROL"): {
        if !(ISFLOAT(_Settings)) then { _Settings = 120; hint "CBA Need A Number as Setting!";};
        [_grp1, _targetPos, _Settings] call CBA_fnc_taskPatrol;
    };
    case ("UPSMON"): {
        _settingsCall = [(leader _grp1), _area];
        _settingsCall append _Settings;
        _settingsCall spawn compile preprocessFileLineNumbers "scripts\upsmon.sqf";
    };
};