setViewDistance 500;
setObjectViewDistance 500;
enableSaving [false, false];
JK_allSpawns = ["spawn_1", "spawn_2", "spawn_3", "spawn_4", "spawn_5", "spawn_6", "spawn_7", "spawn_8"];
JK_allTagets = ["target_1", "target_2", "target_3", "target_4", "target_5"];
JK_allWeapon = ["LMG_Zafir_F", "arifle_TRG21_F", "arifle_TRG20_F", "arifle_Mk20_F", "arifle_Mk20_plain_F", "arifle_Mk20C_F", "arifle_Mk20C_plain_F", "arifle_Katiba_F", "arifle_Katiba_C_F"];
JK_count = 2;
JK_playMusic = true;
JK_maxCount = 250;

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

// teamspeak
tf_radio_channel_name = "Event";
tf_radio_channel_password = "SchlechterSanta";

// encryption
tf_west_radio_code = "_event";
tf_east_radio_code = "_event";
tf_guer_radio_code = "_event";

// loadout
tf_no_auto_long_range_radio = true;
tf_give_personal_radio_to_regular_soldier = false;
tf_give_microdagr_to_soldier = false;

// frequencies
tf_same_sw_frequencies_for_side = true;
tf_same_lr_frequencies_for_side = true;

tf_freq_west = [0,7,["100","110","120","130","140","150","134.5","135","135.5","136","136.5","137","137.5"],0,"_event",-1,0];
tf_freq_west_lr = [0,7,["42","42.5","43","43.5","44","44.5","45","45.5","46","46.5","47","47.5","48"],0,"_event",-1,0];
tf_freq_name = [["100","Alpha"],["110","Bravo"],["120","Charlie"],["130","Delta"],["140","Echo"],["150","Foxtrot"],["134.5","Golf"],["135","Hotel"],["135.5","India"],["136","Juliett"],["136.5","Kilo"],["137","Lima"],["137.5","Mike"]];

tf_freq_east = [0,7,["100","110","120","130","140","150","134.5","135","135.5","136","136.5","137","137.5"],0,"_event",-1,0];
tf_freq_east_lr = [0,7,["31","31.5","32","32.5","33","33.5","34","34.5","35","35.5","36","36.5","37"],0,"_event",-1,0];
tf_freq_name append [["100","Alpha"],["110","Bravo"],["120","Charlie"],["130","Delta"],["140","Echo"],["150","Foxtrot"],["134.5","Golf"],["135","Hotel"],["135.5","India"],["136","Juliett"],["136.5","Kilo"],["137","Lima"],["137.5","Mike"]];

tf_freq_guer = [0,7,["341.5","342","342.5","343","343.5","344","344.5","345","345.5","346","346.5","347","347.5"],0,"_event",-1,0];
tf_freq_guer_lr = [0,7,["52","52.5","53","53.5","54","54.5","55","55.5","56","56.5","57","57.5","58"],0,"_event",-1,0];
tf_freq_name append [["100","Alpha"],["110","Bravo"],["120","Charlie"],["130","Delta"],["140","Echo"],["150","Foxtrot"],["134.5","Golf"],["135","Hotel"],["135.5","India"],["136","Juliett"],["136.5","Kilo"],["137","Lima"],["137.5","Mike"]];
