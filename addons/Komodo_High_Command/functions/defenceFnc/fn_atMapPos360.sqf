/*
Original name: pl_360_at_mappos
New name:      KMD_fnc_atMapPos360
Original url: "Plmod/pl_defence_fnc.sqf"
*/
    params ["_group", "_radius"];

    if (vehicle (leader _group) != leader _group) exitWith {hint "Infantry ONLY Task!"};

    [_group] call KMD_fnc_reset;

    sleep 0.2;

    playSound "beep";
    
    _group setVariable ["setSpecial", true];
    _group setVariable ["onTask", true];
    _group setVariable ["specialIcon", "\A3\ui_f\data\map\markers\military\circle_CA.paa"];
    [_group, getPos (leader _group), _radius] spawn KMD_fnc_pl360;
    waitUntil {sleep 0.1; (count (waypoints _group) > 0) or !(_group getVariable ["onTask", true])};
    sleep 1;
    {
        _x enableAI "PATH";
        _x doFollow (leader _group);
        _x commandFollow (leader _group);
        _x enableAI "AUTOCOMBAT";
    } forEach (units _group);
    _group setVariable ["setSpecial", false];
    _group setVariable ["onTask", false];
