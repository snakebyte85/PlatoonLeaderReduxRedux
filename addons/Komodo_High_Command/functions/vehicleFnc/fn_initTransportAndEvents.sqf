{
    _leader = leader _x;
    private _hcs = allMissionObjects "HighCommandSubordinate" select 0;
    if (isNil{_hcs}) exitWith {};
    if ((_hcs in (synchronizedObjects _leader)) and (vehicle _leader != _leader)) then {
        if (((assignedVehicleRole _leader) select 0) isEqualTo "cargo") then {
            [_x] call KMD_fnc_infTransportSetup;
            //[_x, true] spawn KMD_fnc_contactReport;
        };
        if !(isNull (isVehicleCargo (vehicle _leader))) then {
            [_x] call KMD_fnc_vicTransportSetup;
            //[_x, true] spawn KMD_fnc_contactReport;

        };

    };
} forEach (allGroups select {side _x isEqualTo playerSide});


player addEventHandler ["GetInMan", {
    params ["_vehicle", "_role", "_unit", "_turret"];
    private ["_group"];
    _group = group player;
    _vicGroup = group (driver (vehicle player));
    _vicGroup setVariable ["setSpecial", true];
    _vicGroup setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa"];
    player setVariable ["pl_player_vicGroup", _vicGroup];
    if (_vicGroup != (group player)) then {
        _group setVariable ["pl_show_info", false];
        player hcRemoveGroup _group;
    };
}];

player addEventHandler ["GetOutMan", {
    params ["_vehicle", "_role", "_unit", "_turret"];
    private ["_group"];
    _group = group player;
    _vicGroup = player getVariable ["pl_player_vicGroup", (group player)];
    _group setVariable ["setSpecial", false];
    _group setVariable ["onTask", false];
    _group setVariable ["pl_show_info", true];
    player hcSetGroup [_group];

    _cargo = fullCrew [(vehicle ((units _vicGroup)#0)), "cargo", false];
    if ((count _cargo == 0)) exitWith {
        _vicGroup setVariable ["setSpecial", false];
    };
    if (({(group (_x#0)) isEqualTo _group} count _cargo) > 0) then {
        [_vicGroup, _cargo, _group] spawn {
            params ["_vicGroup", "_cargo", "_group"];
            waitUntil {sleep 1; (({(group (_x#0)) isEqualTo _group} count (fullCrew [(vehicle ((units _vicGroup)#0)), "cargo", false])) == 0)};
            _vicGroup setVariable ["setSpecial", false];
        };
    };
}];