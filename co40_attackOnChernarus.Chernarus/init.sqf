enableSaving [false, false];

// define Groups
// Inf Attacks
missionNameSpace setVariable ["JK_groupUS1", ["rhsusf_army_ucp_explosives", "rhsusf_army_ucp_grenadier", "rhsusf_army_ucp_squadleader", "rhsusf_army_ucp_riflemanat", "rhsusf_army_ucp_machinegunner", "rhsusf_army_ucp_medic"]];
missionNameSpace setVariable ["JK_groupUS2", []];
missionNameSpace setVariable ["JK_groupUS3", []];
missionNameSpace setVariable ["JK_groupDE1", []];

// Vehicle Attacks
missionNameSpace setVariable ["JK_CARUS1", [["rhsusf_army_ucp_teamleader","rhsusf_army_ucp_medic","rhsusf_army_ucp_rifleman"], "rhsusf_m1025_w_s_m2"]];
missionNameSpace setVariable ["JK_CARUS2", [["rhsusf_army_ucp_teamleader","rhsusf_army_ucp_medic","rhsusf_army_ucp_rifleman"],"rhsusf_m1025_w_s_Mk19"]];
missionNameSpace setVariable ["JK_CARDE1", [["TTT_Grau1_Bw_Flecktarn","TTT_Grau3_Bw_Flecktarn","TTT_Grau4_Bw_Flecktarn"], "TTT_Truppfahrzeug_Mg_Bw_Flecktarn"]];
missionNameSpace setVariable ["JK_CARDE2", [["TTT_Grau1_Bw_Flecktarn","TTT_Grau3_Bw_Flecktarn","TTT_Grau4_Bw_Flecktarn"], "TTT_Truppfahrzeug_Gl_Bw_Flecktarn"]];
missionNameSpace setVariable ["JK_SPZ", [["rhsusf_army_ucp_driver","rhsusf_army_ucp_driver","rhsusf_army_ucp_driver"], "RHS_M2A3_BUSKIII_wd"]];
missionNameSpace setVariable ["JK_KPZ", [["rhsusf_army_ucp_driver","rhsusf_army_ucp_driver","rhsusf_army_ucp_driver"], "rhsusf_m1a2sep1tuskiiwd_usarmy"]];

// Own Reinforcement
missionNameSpace setVariable ["JK_groupRU1", [["rhs_msv_emr_sergeant", "rhs_msv_emr_junior_sergeant", "rhs_msv_emr_grenadier", "rhs_msv_emr_rifleman", "rhs_msv_emr_machinegunner", "rhs_msv_emr_at", "rhs_msv_emr_strelok_rpg_assist", "rhs_msv_emr_medic"], "rhs_gaz66_msv"]];

// create all Mission Events
call compile preprocessFileLineNumbers "missionEvents.sqf";
call compile preprocessFileLineNumbers "fixXEH.sqf";
