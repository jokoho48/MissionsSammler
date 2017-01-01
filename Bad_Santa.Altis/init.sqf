enableEnvironment false;
enableSentences false;


if (isServer) then {
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

    tf_freq_guer = [0,7,["100","110","120","130","140","150","134.5","135","135.5","136","136.5","137","137.5"],0,"_event",-1,0];
    tf_freq_guer_lr = [0,7,["52","52.5","53","53.5","54","54.5","55","55.5","56","56.5","57","57.5","58"],0,"_event",-1,0];
    tf_freq_name append [["100","Alpha"],["110","Bravo"],["120","Charlie"],["130","Delta"],["140","Echo"],["150","Foxtrot"],["134.5","Golf"],["135","Hotel"],["135.5","India"],["136","Juliett"],["136.5","Kilo"],["137","Lima"],["137.5","Mike"]];

    publicVariable "tf_radio_channel_name";
    publicVariable "tf_radio_channel_password";
    publicVariable "tf_west_radio_code";
    publicVariable "tf_east_radio_code";
    publicVariable "tf_guer_radio_code";
    publicVariable "tf_no_auto_long_range_radio";
    publicVariable "tf_give_personal_radio_to_regular_soldier";
    publicVariable "tf_give_microdagr_to_soldier";
    publicVariable "tf_same_sw_frequencies_for_side";
    publicVariable "tf_same_lr_frequencies_for_side";
    publicVariable "tf_freq_west";
    publicVariable "tf_freq_west_lr";
    publicVariable "tf_freq_name";
    publicVariable "tf_freq_east";
    publicVariable "tf_freq_east_lr";
    publicVariable "tf_freq_name";
    publicVariable "tf_freq_guer";
    publicVariable "tf_freq_guer_lr";
    publicVariable "tf_freq_name";
};

call CLib_fnc_loadModules;