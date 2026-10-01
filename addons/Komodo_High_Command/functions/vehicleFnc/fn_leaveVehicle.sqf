/*
Original name: pl_leave_vehicle
New name:      KMD_fnc_leaveVehicle
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    params ["_group"];
    private ["_vic"];

    if ((leader _group) != vehicle (leader _group)) then {
        _vic = vehicle (leader _group);
        if ((driver _vic) in (units _group)) then {
            pl_left_vehicles pushBack [_vic, _group];
            _group setVariable ["pl_group_left_vehicle", _vic];
        };
        _group leaveVehicle _vic;
        _group setVariable ["setSpecial", false];
        _group setVariable ["onTask", false];
    };