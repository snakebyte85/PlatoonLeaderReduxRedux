/*
Original name: pl_transfer_medic
New name:      KMD_fnc_transferMedic
Original url: "Plmod\pl_heal_fnc.sqf"
*/
    private ["_destMedic", "_srcMedic", "_srcGroup", "_destGroup"];

    _srcGroup = hcSelected player select 0;

    _srcMedic = {
        if (getNumber ( configFile >> "CfgVehicles" >> typeOf _x >> "attendant" ) isEqualTo 1) exitWith {_x};
        objNull
    } forEach (units _srcGroup);

    if (_srcMedic isEqualTo objNull) exitWith {hint format ["%1 doens't has a Medic to transfer!", groupId _srcGroup]};
        
    missionNamespace setVariable ["pl_transfer_medic_enabled", true];

    hint "Select Group to transfer to";
    waitUntil {!(missionNamespace getVariable ["pl_transfer_medic_enabled", true])};
    hintSilent "";

    _destGroup = missionNamespace getVariable ["pl_transfer_medic_group", false];

    _destMedic = {
        if (getNumber ( configFile >> "CfgVehicles" >> typeOf _x >> "attendant" ) isEqualTo 1) exitWith {_x};
        objNull
    } forEach (units _destGroup);

    if (!(_destMedic isEqualTo objNull) and !(_destMedic getVariable "pl_wia")) exitWith {hint "Group already has a Medic"};


    playSound "beep";
    [_srcMedic] joinSilent _destGroup;   