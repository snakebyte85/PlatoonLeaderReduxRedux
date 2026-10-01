/*
Original name: pl_airassualt_security
New name:      KMD_fnc_airAssualtSecurity
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    params ["_group", "_vic"];
    _moveDir = [((getDir _vic) - 180)] call KMD_fnc_angleSwitcher;
    _coverPos =  [65*(sin _moveDir), 65*(cos _moveDir), 0] vectorAdd (getPos (_vic));
    _group addWaypoint [_coverPos, 7];
    waitUntil {sleep 0.1; {_x in _vic} count (units _group) ==  0};
    sleep 1;
    [_group, 20] spawn KMD_fnc_atMapPos360;