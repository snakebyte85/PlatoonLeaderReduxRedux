/*
Original name: pl_bleedout
New name:      KMD_fnc_bleedOut
Original url: "Plmod\pl_heal_fnc.sqf"
*/
    params ["_unit"];
    sleep 5;
    if (alive _unit and !(_unit getVariable "pl_bleedout_set")) then {
        _unit setVariable ["pl_bleedout_set", true];
        _time = _unit getVariable ["pl_bleedout_time", 300];
        _deathTime = time + _time;
        waitUntil {sleep 1; time > _deathTime};
        if (_unit getVariable "pl_wia") then {
            _unit setDamage 1;
        };
        if (alive _unit) then {
            _unit setVariable ["pl_bleedout_time", 300];
        };
    };
