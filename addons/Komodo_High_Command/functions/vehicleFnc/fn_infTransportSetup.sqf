/*
Original name: pl_inf_trans_set_up
New name:      KMD_fnc_infTransportSetup
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/

    params ["_group"];
    _targetVic = vehicle (leader _group);
    (group (driver _targetVic)) setVariable ["setSpecial", true];
    (group (driver _targetVic)) setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa"];
    _group setVariable ["onTask", false];
    _group setVariable ["setSpecial", false];
    _group setVariable ["pl_show_info", false];