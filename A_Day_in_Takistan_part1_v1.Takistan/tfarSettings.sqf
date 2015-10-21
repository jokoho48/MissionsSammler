call compile preprocessFileLineNumbers "\task_force_radio\functions\common.sqf";

tf_radio_channel_name = "LaufendeMission";
tf_radio_channel_password = "130";

tf_no_auto_long_range_radio = true;
tf_give_personal_radio_to_regular_soldier = false;
TF_give_microdagr_to_soldier = false;
tf_same_sw_frequencies_for_side = true;
tf_same_lr_frequencies_for_side = true;
tf_terrain_interception_coefficient = 7.0;

/*
not Required for This Mission
//radios
BLU_F_personal_tf_faction_radio = "tf_anprc152";
BLU_G_F_personal_tf_faction_radio = "tf_anprc148jem";
BLU_F_rifleman_tf_faction_radio = "tf_rf7800str";
BLU_G_F_rifleman_tf_faction_radio = "tf_anprc154";

IND_F_personal_tf_faction_radio = "tf_anprc148jem";
IND_F_rifleman_tf_faction_radio = "tf_anprc154";

OPF_F_personal_tf_faction_radio = "tf_fadak";
OPF_F_rifleman_tf_faction_radio = "tf_pnr1000a";
*/

//frequencies
//blufor
local _normalFrequenz = "110";
_secoundaryFrequenz = "130";
_LR = "30";
_LRA = "31";
if ((str player) in ["OPL"]) then {
    _normalFrequenz = "110";
    _secoundaryFrequenz = "130";
};

if ((str player) in ["SQL1", "Ersthelfen1"]) then {
    _normalFrequenz = "111";
    _secoundaryFrequenz = "122";
};

if ((str player) in ["TL1", "Gren1", "MGAss1", "MG1"]) then {
    _normalFrequenz = "113";
    _secoundaryFrequenz = "122";
};

if ((str player) in ["TL2", "Gren2", "ATAss1", "AT1"]) then {
    _normalFrequenz = "114";
    _secoundaryFrequenz = "122";
};

if ((str player) in ["SQL2", "Ersthelfen2"]) then {
    _normalFrequenz = "114";
    _secoundaryFrequenz = "123";
};

if ((str player) in ["TL3", "Gren3", "MGAss2", "MG2"]) then {
    _normalFrequenz = "115";
    _secoundaryFrequenz = "123";
};

if ((str player) in ["TL4", "Gren4", "ATAss2", "AT2"]) then {
    _normalFrequenz = "116";
    _secoundaryFrequenz = "123";
};

if ((str player) in ["TL5", "NAH", "San1", "San2"]) then {
    _normalFrequenz = "117";
    _secoundaryFrequenz = "130";
    _LR = "31";
    _LRA = "30";
};

if ((str player) in ["OPL","SQL1","SQL2", "TL5"]) then {
    [(call TFAR_fnc_activeLrRadio), 1, _LR] call TFAR_fnc_SetChannelFrequency;
    [(call TFAR_fnc_activeLrRadio), 1, _LR] call TFAR_fnc_SetChannelFrequency;
    [(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, 1] call TFAR_fnc_setAdditionalLrChannel;

};
[(call TFAR_fnc_activeSwRadio), 1, _normalFrequenz] call TFAR_fnc_SetChannelFrequency;
[(call TFAR_fnc_activeSwRadio), 2, _secoundaryFrequenz] call TFAR_fnc_SetChannelFrequency;
[(call TFAR_fnc_activeSwRadio), 1] call TFAR_fnc_setAdditionalSwChannel;