/*
Original name: pl_get_group_health
New name:      KMD_fnc_getGroupHealth
Original url: "Plmod\pl_map_icons.sqf"
*/

    params ["_group"];
    private ["_healthState"];
    _healthState = [0.4,1,0.2,1];
    {
        if ((damage _x) > 0.1) then {
            _healthState = [0.9,0.9,0,1];
        };
        if ((_x getVariable "pl_wia") and (alive _x)) then {
            _healthState = [0.7,0,0,1];
        };
    } forEach (units _group);
    _healthState;
