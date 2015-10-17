params ["_crates", "_content"];
{
    _currentCrate = _x;
    clearWeaponCargoGlobal _currentCrate;
    clearMagazineCargoGlobal _currentCrate;
    clearItemCargoGlobal _currentCrate;
    clearBackpackCargoGlobal _currentCrate;
    {
        if (isClass(configFile >> "CfgMagazines" >> (_x select 0))) then {
            _currentCrate addMagazineCargoGlobal _x;
        };
        if (isClass(configFile >> "CfgWeapons" >> (_x select 0))) then {
            _currentCrate addWeaponCargoGlobal _x;
        };
        if ((_x select 0) isKindOf "ItemCore") then {
            _currentCrate addItemCargoGlobal _x;
        };
        if ((_x select 0) isKindOf "Bag_Base") then {
            _currentCrate addBackpackCargoGlobal _x;
        };
        nil
    } count _content;
    nil
} count _crates;
