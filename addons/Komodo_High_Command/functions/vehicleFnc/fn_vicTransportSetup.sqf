/*
Original name: pl_viv_trans_set_up
New name:      KMD_fnc_vicTransportSetup
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/

    params ["_group"];
    _vic = vehicle (leader _group);
    _targetVic = isVehicleCargo _vic;
    _group setVariable ["pl_show_info", false];
    (group (driver _targetVic)) setVariable ["setSpecial", true];
    (group (driver _targetVic)) setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa"];
    {
        player hcRemoveGroup (group (_x select 0));
    } forEach fullCrew[_vic, "cargo", false];