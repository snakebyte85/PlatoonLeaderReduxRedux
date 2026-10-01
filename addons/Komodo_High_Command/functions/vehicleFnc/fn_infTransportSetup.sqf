/*
Original name: pl_inf_trans_set_up
New name:      KMD_fnc_infTransportSetup
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/

    params ["_group"];
    private["_targetVic", "_icon"];
    _targetVic = vehicle (leader _group);
    (group (driver _targetVic)) setVariable ["setSpecial", true];
    (group (driver _targetVic)) setVariable ["specialIcon", pl_cargo_icon];
    _group setVariable ["onTask", false];
    _group setVariable ["setSpecial", false];
    _group setVariable ["pl_show_info", false];
