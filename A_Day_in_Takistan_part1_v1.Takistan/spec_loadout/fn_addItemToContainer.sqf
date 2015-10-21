_parameterCorrect = params [["_x",objNull],["_item",objNull],["_container",3,[0]]];
_returnValue = 1;

if (_parameterCorrect) then {
    switch (_container) do {
        case 0 : {
            if (_x canAddItemToUniform _item) then {
                _x addItemToUniform _item;
                _returnValue = 0;
            } else {
                hint format ["Could not add %1 to Uniform\nUnit Type = %2\nUnit Name = %3", _item, typeOf _x, str _x];
            };
        };
        case 1 : {
            if (_x canAddItemToVest _item) then {
                _x addItemToVest _item;
                _returnValue = 0;
            } else {
                hint format ["Could not add %1 to Vest\nUnit Type = %2\nUnit Name = %3", _item, typeOf _x, str _x];
            };
        };
        case 2 : {
            if (_x canAddItemToBackpack _item) then {
                _x addItemToBackpack _item;
                _returnValue = 0;
            } else {
                hint format ["Could not add %1 to Backpack\nUnit Type = %2\nUnit Name = %3", _item, typeOf _x, str _x];
            };
        };
        default {
            if (_x canAddItemToUniform _item) exitWith {
                _x addItemToUniform _item;
                _returnValue = 0;
            };
            if (_x canAddItemToVest _item) exitWith {
                _x addItemToVest _item;
                _returnValue = 0;
            };
            if (_x canAddItemToBackpack _item) exitWith {
                _x addItemToBackpack _item;
                _returnValue = 0;
            };
            hint format ["Could not add %1 to any Container\nUnit Type = %2\nUnit Name = %3", _item, typeOf _x, str _x];
        };
    };
};
_returnValue
