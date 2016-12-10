call JK_BadSanta_fnc_common;

BadSanta_Reveal_Statemachine = call CLib_fnc_addStatemachineState;

[BadSanta_Reveal_Statemachine, "init", {
    BadSanta_RevealUnitsData = +allPlayers;
    "updateReveal"
}] call CLib_fnc_addStatemachineState;

[BadSanta_Reveal_Statemachine, "updateReveal", {
    private _unit = BadSanta_RevealUnitsData deleteAt 0;
    player reveal _unit;
    ["updateReveal", "init"] select (BadSanta_RevealUnitsData isEqualTo []);
}] call CLib_fnc_addStatemachineState;

[BadSanta_Reveal_Statemachine] call CLib_fnc_addStatemachineState;