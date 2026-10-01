/*
Original name: pl_march
New name:      KMD_fnc_march
Original url: "Plmod\pl_misc_fnc.sqf"
*/

    params ["_group"];
    private ["_cords", "_f", "_mwp"];

    if (visibleMap) then {
        _cords = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
    }
    else
    {
        _cords = screenToWorld [0.5,0.5];
    };


    if (isNil {_group getVariable "pl_on_march"}) then {
        [_group] call KMD_fnc_reset;
        sleep 0.2;

        playSound "beep";

        _group setVariable ["onTask", true];
        _group setVariable ["setSpecial", true];
        _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\navigate_ca.paa"];
        _group setVariable ["pl_on_march", true];

        {
            _x disableAI "AUTOCOMBAT";
        } forEach (units _group);
        (leader _group) limitSpeed 14;
        _f = formation _group;
        _group setFormation "STAG COLUMN";
        _group setBehaviour "AWARE";
        if ((vehicle (leader _group)) != (leader _group)) then {
            _group setBehaviour "SAFE";
            // if (((count (hcSelected player)) > 1) and (_group isEqualTo ((hcSelected player) select 0))) then {
            //     [true] call pl_spawn_getOut_vehicle;
            // };
        };

        _mwp = _group addWaypoint [_cords, 0];
        _group setVariable ["pl_mwp", _mwp];

        sleep 3;
        waitUntil {!(_group getVariable ["onTask", true]) or (((leader _group) distance2D (waypointPosition (_group getVariable ["pl_mwp", (currentWaypoint _group)]))) < 11)};
        _group setFormation _f;
        _group setVariable ["pl_on_march", nil];

        if (_group getVariable ["onTask", true]) then {[_group] call KMD_fnc_reset;};
        
    }
    else
    {
        _mwp = _group addWaypoint [_cords, 0];
        _group setVariable ["pl_mwp", _mwp];
    };
