/*
Original name: pl_viv_trans_set_up
New name:      KMD_fnc_vicTransportSetup
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/

    params ["_group"];
    private["_vic", "_targetVic", "_icon"];
    _vic = vehicle (leader _group);
    _targetVic = isVehicleCargo _vic;
    _group setVariable ["pl_show_info", false];
    (group (driver _targetVic)) setVariable ["setSpecial", true];
    (group (driver _targetVic)) setVariable ["specialIcon", pl_cargo_icon];
