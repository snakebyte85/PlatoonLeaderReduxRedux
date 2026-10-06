/*
Original name: pl_reset
New name:      KMD_fnc_reset
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    params ["_group", ["_isNotWp", true]];

    // _group setVariable ['pl_hold_fire', false];
    
    {
        _unit = _x;
        if ((currentCommand _unit) isEqualTo "SUPPORT") then {
            [_unit] spawn KMD_fnc_hardReset;
        };
        _unit enableAI "AUTOCOMBAT";
        _unit enableAI "AUTOTARGET";
        _unit enableAI "TARGET";
        _unit enableAI "PATH";
        _unit enableAI "SUPPRESSION";
        _unit enableAI "COVER";
        _unit enableAI "ANIM";
        _unit enableAI "FSM";
        _unit setUnitPos "AUTO";
        // sleep 0.5;
        _unit limitSpeed 5000;
        _unit forceSpeed -1;
        _unit doWatch objNull;
        if (vehicle _unit == _unit) then {
            _unit doFollow (leader _group);
        };
    } forEach (units _group);
    
    _leader = leader _group;
    (units _group) joinSilent _group;
    _group selectLeader _leader;
    if (_group isEqualTo (group player)) then {
        _group selectLeader player;
        // {
        //     _x commandFollow player;
        // } forEach (units _group);
    };

    if (vehicle (leader _group) != leader _group) then {
        _vic = vehicle (leader _group);
        _vic forceSpeed -1;
        // _vic setVariable ["pl_on_transport", nil];
    };

    if !(!(_isNotWp) and (_group getVariable ["pl_formation_leader", false])) then {
        _group setVariable ["onTask", false];        
        if !((_group getVariable "specialIcon") isEqualTo pl_cargo_icon) then {
            _group setVariable ["setSpecial", false];
        };
    };
    _group setVariable ["pl_show_info", true];
    _group setVariable ["pl_draw_convoy", false];
    // _group setCombatMode "YELLOW";

    if (_isNotWp) then {
        _group setSpeedMode "NORMAL";
        _group setBehaviour "AWARE";
        [_group, (currentWaypoint _group)] setWaypointPosition [getPosASL (leader _group), -1];
        sleep 0.1;
        deleteWaypoint [_group, (currentWaypoint _group)];
        for "_i" from count waypoints _group - 1 to 0 step -1 do {
            deleteWaypoint [_group, _i];
        };
    };
