setViewDistance 500;
setObjectViewDistance 500;
enableSaving [false, false];
if (isServer) then {
    JK_allSpawns = ["spawn_1", "spawn_2", "spawn_3", "spawn_4", "spawn_5", "spawn_6", "spawn_7", "spawn_8"];
    JK_allTagets = ["target_1", "target_2", "target_3", "target_4", "target_5"];
    JK_allWeapon = ["LMG_Zafir_F", "arifle_TRG21_F", "arifle_TRG20_F", "arifle_Mk20_F", "arifle_Mk20_plain_F", "arifle_Mk20C_F", "arifle_Mk20C_plain_F", "arifle_Katiba_F", "arifle_Katiba_C_F"];
    JK_count = 2;
    JK_playMusic = true;
    JK_maxCount = 250;

    publicVariable "JK_allSpawns";
    publicVariable "JK_allWeapon";
    publicVariable "JK_allTagets";
    publicVariable "JK_count";
    publicVariable "JK_playMusic";
    publicVariable "JK_maxCount";
};


JK_fnc_playMusic = {
    if !(JK_playMusic) exitWith {};
    "XMas_PlayMusic" call CLib_fnc_globalEvent;
    JK_playMusic = true;
    publicVariable "JK_playMusic";

};

soundPoint addAction ["Play Music", {
    if (JK_playMusic) then {
        [JK_fnc_playMusic] call CLib_fnc_mutex;
    };
}];

if (hasInterface) then {
    ["XMas_PlayMusic", {
        soundPoint say3D "Intro";
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