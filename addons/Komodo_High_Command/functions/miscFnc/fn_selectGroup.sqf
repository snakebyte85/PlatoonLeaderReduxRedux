/*
Original name: pl_select_group
New name:      KMD_fnc_selectGroup
Original url: "Plmod\pl_misc_fnc.sqf"
*/

    _target = cursorTarget;
    _group = group _target;
    player hcSelectGroup [_group];
    sleep 2;
