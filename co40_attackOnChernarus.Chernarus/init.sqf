enableSaving [false, false];

// define Groups
// Inf Attacks
missionNameSpace setVariable ["JK_groupUS1", []];
missionNameSpace setVariable ["JK_groupUS2", []];
missionNameSpace setVariable ["JK_groupUS3", []];
missionNameSpace setVariable ["JK_groupUS4", []];
missionNameSpace setVariable ["JK_groupUS5", []];
missionNameSpace setVariable ["JK_groupDE1", []];
missionNameSpace setVariable ["JK_groupDE2", []];

// Vehicle Attacks
missionNameSpace setVariable ["JK_CARUS", [[],""]];
missionNameSpace setVariable ["JK_CARDE", [[],""]];
missionNameSpace setVariable ["JK_SPZ", [[],""]];
missionNameSpace setVariable ["JK_KPZ", [[],""]];

// Own Reinforcement
missionNameSpace setVariable ["JK_groupRU1", []];
missionNameSpace setVariable ["JK_groupRU2", []];

// create all Mission Events
call compile preprocessFileLineNumbers "missionEvents.sqf";
