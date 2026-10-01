/*
Original name: pl_merge_hc_groups
New name:      KMD_fnc_mergeHcGroup
Original url: "Plmod\pl_group_fnc.sqf"
*/
    private ["_groupLen", "_largestGroup", "_groups"];
    _groupLen = 0;
    _largestGroup = 0;
    _groups = [];
    {
        _x setVariable ["onTask", false];
        _groups pushBack _x;
        _len = count (units _x);
        if (_len > _groupLen) then {
            _largestGroup = _x;   
        };
    } forEach hcSelected player;
    sleep 0.25;
    {
        if !(_x getVariable ["pl_not_addalbe", false]) then {
            (units _x) joinSilent _largestGroup;
        };
    } forEach _groups;
    sleep 0.1;
    [_largestGroup] call KMD_fnc_reset;
