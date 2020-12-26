setViewDistance 500;
setObjectViewDistance 500;
enableSaving [false, false];
if (isServer) then {
    JK_allSpawns = getArray (missionConfigFile >> "BadSanta" >> "spawns");
    JK_allTagets = getArray (missionConfigFile >> "BadSanta" >> "targets");
    JK_allWeapon = getArray (missionConfigFile >> "BadSata" >> "weapons");
    JK_count = getNumber (missionConfigFile >> "BadSata" >> "startGroupCount");
    JK_maxCount = getNumber (missionConfigFile >> "BadSata" >> "maxCount");

    JK_count = 2;
    JK_maxCount = 155;
    JK_playMusic = true;
    JK_killed = 0;

    publicVariable "JK_allSpawns";
    publicVariable "JK_allWeapon";
    publicVariable "JK_allTagets";
    publicVariable "JK_count";
    publicVariable "JK_playMusic";
    publicVariable "JK_maxCount";
    publicVariable "JK_killed";

};


JK_fnc_playMusic = {
    if !(JK_playMusic) exitWith {};
    "XMas_PlayMusic" call CLib_fnc_globalEvent;
};

soundPoint addAction ["Play Music", {
    if (JK_playMusic) then {
        [JK_fnc_playMusic] call CLib_fnc_mutex;
    };
}];

["JK_EndMission", {
    if (JK_playMusic) then {
        [JK_fnc_playMusic] call CLib_fnc_mutex;
    };
    [{
        [{
            JK_playMusic = false;
            publicVariable "JK_playMusic";
            ["fail", false, true, true] call BIS_fnc_EndMission;
        }, {JK_playMusic}] call CLib_fnc_waitAndExecute;
    }, 140] call CLib_fnc_wait;
}] call CLib_fnc_addEventhandler;

if (hasInterface) then {
    ["XMas_PlayMusic", {
        if !(JK_playMusic) exitWith {};
        soundPoint say3D ["Intro", 5000];
    }] call CLib_fnc_addEventhandler;
};

if (isServer) then {
    ["XMas_PlayMusic", {
        JK_playMusic = false;
        publicVariable "JK_playMusic";
        [{
            JK_playMusic = true;
            publicVariable "JK_playMusic";
        }, 150] call CLib_fnc_wait;
    }] call CLib_fnc_addEventhandler;
};
