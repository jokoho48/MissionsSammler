private ["_opl", "_sql", "_medic", "_tf", "_gl", "_mg", "_mgAssi", "_at", "_atAssi", "_medevac", "_type"];
waitUntil {!isNull player || isServer};
_parameterCorrect = params [["_x",objNull,[objNull]]];

comment "Officer";
_opl = "B_officer_F";

comment "Squad Leader";
_sql = "B_Soldier_SL_F";
comment "Combat Life Saver";
_medic = "B_medic_F";

comment "Team Leader";
_tf = "B_Soldier_TL_F";
comment "Grenadier";
_gl = "B_Soldier_GL_F";
comment "Autorifleman";
_mg = "B_soldier_AR_F";
comment "Ammo Bearer";
_mgAssi = "B_Soldier_A_F";
comment "Rifleman (AT)";
_at = "B_soldier_LAT_F";
comment "Missile Specialist (AT)";
_atAssi = "B_soldier_AT_F";

comment "Rifleman (Light)";
_medevac = "B_Soldier_lite_F";

if(_parameterCorrect) then {
   if(side _x == west) then {
        _type = typeOf _x;

        removeAllWeapons _x;
        removeAllItems _x;
        removeAllAssignedItems _x;
        removeUniform _x;
        removeVest _x;
        removeBackpack _x;
        removeHeadgear _x;
        removeGoggles _x;

        comment "Edit Vest, Uniform, Backpack, Headgear (, Googgles)";

        [_x, "rhs_uniform_mflora_patchless"] call Spec_fnc_addContainer;
        if(_type == _opl) then {
            [_x, "rhs_vest_commander", 1] call Spec_fnc_addContainer;
            _x addHeadgear "rhs_gssh18";
        } else {
            _x addHeadgear "rhs_fieldcap_ml";
            if(_type == _medic || _type == _medevac) then {
                [_x, "rhs_6sh46", 1] call Spec_fnc_addContainer;
            } else {
                if(_type == _tf || _type == _sql) then {
                    [_x, "rhs_vydra_3m", 1] call Spec_fnc_addContainer;
                } else {
                    [_x, "rhs_vydra_3m", 1] call Spec_fnc_addContainer;
                };
            };
        };

        if(_type == _opl || _type == _sql) then {
            [_x, "tf_bussole"] call Spec_fnc_addContainer;
        } else {
            if(_type == _at) then {
                [_x, "rhs_rpg_empty"] call Spec_fnc_addContainer;
            } else {
                [_x, "rhs_sidor"] call Spec_fnc_addContainer;
            };
        };

        comment "Loadout based on TTT-Mod (edit weapons near end of file)";
        _x addWeapon "Binocular";

        _x linkItem "ItemMap";
        _x linkItem "ItemCompass";
        _x linkItem "ItemWatch";

        if(_type == _opl || _type == _tf || _type == _sql) then {
            for "_i" from 1 to 2 do {[_x,"ACE_CableTie",1] call Spec_fnc_addItemToContainer;};
            [_x, "ACE_Flashlight_KSF1",0] call Spec_fnc_addItemToContainer;
            _x linkItem "tf_anprc152";
        };

        comment "standard equipment (ear plugs, grenades)";
        [_x,"ACE_EarPlugs",0] call Spec_fnc_addItemToContainer;
        [_x,"ACE_MapTools",0] call Spec_fnc_addItemToContainer;

        for "_i" from 1 to 3 do {[_x,"Chemlight_red",0] call Spec_fnc_addItemToContainer;};
        for "_i" from 1 to 2 do {[_x,"rhs_mag_nspn_red",1] call Spec_fnc_addItemToContainer;};

        [_x,"rhs_mag_rgd5",0] call Spec_fnc_addItemToContainer;
        [_x,"rhs_mag_rgd5",0] call Spec_fnc_addItemToContainer;



        comment "medic equipment";
        switch _type do {
            case _medic : {
                for "_i" from 1 to 10 do {[_x,"ACE_fieldDressing",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 15 do {[_x,"ACE_elasticBandage",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 10 do {[_x,"ACE_quikclot",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 10 do {[_x,"ACE_packingBandage",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 3 do {[_x,"ACE_tourniquet",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 4 do {[_x,"ACE_salineIV_500",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 5 do {[_x,"ACE_atropine",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 8 do {[_x,"ACE_epinephrine",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 8 do {[_x,"ACE_morphine",2] call Spec_fnc_addItemToContainer;};
                _x setVariable ["ace_medical_medicClass", 1];
            };
            case _medevac : {
                for "_i" from 1 to 10 do {[_x,"ACE_fieldDressing",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 15 do {[_x,"ACE_elasticBandage",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 10 do {[_x,"ACE_quikclot",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 10 do {[_x,"ACE_packingBandage",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 2 do {[_x,"ACE_tourniquet",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 6 do {[_x,"ACE_salineIV",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 8 do {[_x,"ACE_atropine",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 12 do {[_x,"ACE_epinephrine",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 12 do {[_x,"ACE_morphine",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 1 do {[_x,"ACE_surgicalKit",2] call Spec_fnc_addItemToContainer;};
                [_x,"ACE_personalAidKit",1] call Spec_fnc_addItemToContainer;
                _x setVariable ["ace_medical_medicClass", 2];
            };
            default {
                for "_i" from 1 to 7 do {[_x,"ACE_fieldDressing",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 2 do {[_x,"ACE_tourniquet",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 1 do {[_x,"ACE_morphine",2] call Spec_fnc_addItemToContainer;};
                _x setVariable ["ace_medical_medicClass", 0];
            };
        };

        comment "role specific special equipment";
        switch _type do {
            case _tf : {
                for "_i" from 1 to 6 do {[_x,"rhs_VG40OP_white",2] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 6 do {[_x,"rhs_VG40OP_red",2] call Spec_fnc_addItemToContainer;};
            };
            case _gl : {
                for "_i" from 1 to 12 do {[_x,"rhs_VOG25",2] call Spec_fnc_addItemToContainer;};
            };
            case _mg : {
                [_x,"ACE_SpareBarrel",1] call Spec_fnc_addItemToContainer;
            };
            case _mgAssi : {
                for "_i" from 1 to 2 do {[_x,"rhs_100Rnd_762x54mmR_green",2] call Spec_fnc_addItemToContainer;};
            };
            case _atAssi : {
                for "_i" from 1 to 2 do {[_x, "rhs_rpg7_PG7VL_mag", 2] call Spec_fnc_addItemToContainer;};
            };
        };

        comment "===========================================";
        comment "==============  Weapons  ==================";
        comment "===========================================";

        comment "MG (change 'case _mgAssi :' ammunition for mmg above)";
        if(_type == _mg) then {
            for "_i" from 1 to 3 do {[_x,"rhs_100Rnd_762x54mmR_green",3] call Spec_fnc_addItemToContainer;};
            _x addWeapon "rhs_weap_pkm";
        } else {
            if(_type == _opl || _type == _sql) then {
                for "_i" from 1 to 1 do {[_x,"rhs_30Rnd_762x39mm",3] call Spec_fnc_addItemToContainer;};
                for "_i" from 1 to 2 do {[_x,"rhs_30Rnd_762x39mm",3] call Spec_fnc_addItemToContainer;};
                if (_type == _sql) then {
                    _x addWeapon "rhs_weap_akms_gp25";
                } else {
                    _x addWeapon "rhs_weap_akm";
                };
                [_x,"rhs_30Rnd_762x39mm",3] call Spec_fnc_addItemToContainer;
            } else {
                if(_type == _gl) then {
                    for "_i" from 1 to 6 do {[_x,"rhs_30Rnd_762x39mm",3] call Spec_fnc_addItemToContainer;};
                    _x addWeapon "rhs_weap_akm_gp25";
                } else {
                    comment "AT launcher";
                    if(_type == _at) then {
                        for "_i" from 1 to 2 do {[_x, "rhs_rpg7_PG7VL_mag", 3] call Spec_fnc_addItemToContainer;};
                        _x addWeapon "rhs_weap_rpg7";
                   };
                    comment "standard weapon";
                    for "_i" from 1 to 6 do {[_x,"rhs_30Rnd_762x39mm",3] call Spec_fnc_addItemToContainer;};
                    if(_type == _tf) then {
                        _x addWeapon "rhs_weap_akms_gp25";
                    } else {
                        _x addWeapon "rhs_weap_akm";
                    };
                };
            };
        };
        [_x,"rhs_mag_9x18_12_57N181S",3] call Spec_fnc_addItemToContainer;
        _x addWeapon "rhs_weap_makarov_pmm";
        [_x,"rhs_mag_9x18_12_57N181S",3] call Spec_fnc_addItemToContainer;
    };
};

reload _x;
