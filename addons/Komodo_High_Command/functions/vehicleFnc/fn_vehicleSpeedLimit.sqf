/*
Original name: pl_vehicle_speed_limit
New name:      KMD_fnc_vehicleSpeedLimit
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    Params ["_group", "_speed"];

    _leader = leader _group;
    if (vehicle _leader != _leader) then {
        _vic = vehicle _leader;
        _vic limitSpeed _speed;
    };
