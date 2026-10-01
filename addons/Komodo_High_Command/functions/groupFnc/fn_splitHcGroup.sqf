/*
Original name: pl_split_hc_group
New name:      KMD_fnc_splitHcGroup
Original url: "Plmod\pl_group_fnc.sqf"
*/
    params ["_group"];
    {
        if (_x != (leader _group)) then {
            _newGroup = createGroup [west, true];
            [_x] joinSilent _newGroup;
            player hcSetGroup [_newGroup]
        };
    } forEach (units _group);