/*
Original name: pl_spawn_heal_group
New name:      KMD_fnc_spawnHealGroup
Original url: "Plmod\pl_heal_fnc.sqf"
*/

    if( count (hcSelected player) > 1) exitWith { hint "Select only one group!" };
   

   _srcGroup = hcSelected player select 0;

    _srcMedic = {
        if (getNumber ( configFile >> "CfgVehicles" >> typeOf _x >> "attendant" ) isEqualTo 1 && !(_x getVariable["pl_wia",false])) exitWith {_x};
        objNull
    } forEach (units _srcGroup);

    if (_srcMedic isEqualTo objNull) exitWith {hint format ["%1 doesn't have a Medic!", groupId _srcGroup]};
        
    missionNamespace setVariable ["pl_transfer_medic_enabled", true];

    hint "Select Group to heal (or the same group)";
    waitUntil {!(missionNamespace getVariable ["pl_transfer_medic_enabled", true])};
    hintSilent "";

    _destGroup = missionNamespace getVariable ["pl_transfer_medic_group", false];
    
    if((leader _destGroup) distance2D (leader _srcGroup) > 500) exitWith { hint "The group is too distant"};

    [_srcGroup, _destGroup] spawn KMD_fnc_healGroup;
