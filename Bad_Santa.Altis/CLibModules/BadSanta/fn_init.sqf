setViewDistance 500;
enableSaving [false, false];
JK_allSpawns = ["spawn_1", "spawn_2", "spawn_3", "spawn_4", "spawn_5", "spawn_6", "spawn_7", "spawn_8"];
JK_allTagets = ["target_1", "target_2", "target_3", "target_4", "target_5"];
JK_allWeapon = ["LMG_Zafir_F", "arifle_TRG21_F", "arifle_TRG20_F", "arifle_Mk20_F", "arifle_Mk20_plain_F", "arifle_Mk20C_F", "arifle_Mk20C_plain_F", "arifle_Katiba_F", "arifle_Katiba_C_F"];
JK_count = 2;
JK_playMusic = false;
JK_maxCount = 250;
JK_isInLoop = false;
soundPoint addAction ["Play Music", {
    [{
        if (JK_playMusic) exitWith {};
        "" call CLib_fnc_globalEvent;
    }] call CLib_fnc_mutex;
}];
call JK_BadSanta_fnc_common;
