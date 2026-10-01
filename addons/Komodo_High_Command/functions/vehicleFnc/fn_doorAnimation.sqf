/*
Original name: pl_door_animation
New name:      KMD_fnc_doorAnimation
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    params ["_vic", "_mode"];
    _vic animateDoor ["Door_rear_source", _mode];
    _vic animateDoor ["Door_1_source", _mode];
    _vic animateDoor ["Door_L", _mode];
    _vic animateDoor ["Door_R", _mode];