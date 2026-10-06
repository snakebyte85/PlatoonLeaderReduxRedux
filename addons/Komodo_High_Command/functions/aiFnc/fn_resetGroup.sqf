/*
Original name: pl_reset_group
New name:      KMD_fnc_resetGroup
Original url: "Plmod\pl_ai_fnc.sqf"
*/
params ["_group"];

{
    if !(_x isEqualTo player) then{
        _x spawn KMD_fnc_hardReset;
    };
} forEach (units _group);

_groupId = groupId _group;

sleep 1.5;

_newGroup = createGroup playerside;
    
{ 
    [_x] joinSilent _newGroup;
} forEach (units _group);

[_newGroup] spawn KMD_fnc_setupAi;
deleteGroup _group;

_newGroup setGroupId [_groupId];

player hcSetGroup [_newGroup];
