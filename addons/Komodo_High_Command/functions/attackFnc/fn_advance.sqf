/*
Original name: pl_advance
New name:      KMD_fnc_advance
Original url: "Plmod\pl_attack_fnc.sqf"
*/

    params ["_group"];
    private ["_cords", "_awp"];

    if (visibleMap) then {
        _cords = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
    }
    else
    {
        _cords = screenToWorld [0.5,0.5];
    };

    if (vehicle (leader _group) != leader _group) exitWith {hint "Infantry ONLY Task!"};

    [_group] call KMD_fnc_reset;

    sleep 0.2;
    playsound "beep";

    (leader _group) limitSpeed 15;

    {
        _x disableAI "AUTOCOMBAT";
    } forEach (units _group);

    _awp = _group addWaypoint [_cords, 0];
    _group setBehaviour "AWARE";

    _group setVariable ["onTask", true];
    _group setVariable ["setSpecial", true];
    _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\walk_ca.paa"];

    waitUntil {if (_group isEqualTo grpNull) exitWith {true}; (((leader _group) distance2D (waypointPosition _awp)) < 10) or !(_group getVariable ["onTask", true])};

    // sleep 1;

    deleteWaypoint [_group, _awp#1];

    (leader _group) limitSpeed 5000;
    {
        _x enableAI "AUTOCOMBAT";
    } forEach (units _group);
    _group setVariable ["setSpecial", false];
    _group setVariable ["onTask", false];

    // leader _group sideChat "We Advanced to assigned Position, Over";
