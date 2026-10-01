/*
Original name: pl_create_hc_group
New name:      KMD_fnc_createHcGroup
Original url: "Plmod\pl_group_fnc.sqf"
*/
    private ["_group"];

    _group = createGroup [playerSide, true];
    {
        [_x] join _group;
    } forEach (groupSelectedUnits player);
    player hcSetGroup [_group];
    [_group] spawn pl_set_up_ai;