enableSaving [false, false];
missionNamespace setVariable ["CUP1", ["CUP_I_TK_GUE_Soldier_TL","CUP_I_TK_GUE_Soldier_MG","CUP_I_TK_GUE_Soldier_GL","CUP_I_TK_GUE_Soldier_AT"]];
missionNamespace setVariable ["CUP2", ["CUP_I_TK_GUE_Soldier","CUP_I_TK_GUE_Soldier_M16A2","CUP_I_TK_GUE_Soldier_AK_47S"]];
missionNamespace setVariable ["CUP3", ["CUP_I_TK_GUE_Mechanic","CUP_I_TK_GUE_Demo"]];

// create all Mission Events
call compile preprocessFileLineNumbers "missionEvents.sqf";
