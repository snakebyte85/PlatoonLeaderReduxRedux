/*
Original name: pl_add_to_hc_execute
New name:      KMD_fnc_addToHcExecute
Original url: "Plmod\pl_group_fnc.sqf"
*/
    params ["_group"];

    _group setVariable ["onTask", false];
    sleep 0.25;

    player hcSetGroup [_group];
    [_group] spawn KMD_fnc_setupAi;
    pl_add_group_to_hc = false;