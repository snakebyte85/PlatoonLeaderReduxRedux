/*
Original name: pl_follow_other
New name:      KMD_fnc_followOther
Original url: "Plmod\pl_misc_fnc.sqf"
*/
   params ["_group"];
    private ["_leadGroup", "_formDir", "_posOffset", "_pGroup", "_pSpeed", "_pBehaviour"];

    if !(visibleMap) exitWith {hint "Opne Map"};
    if (_group getVariable ["pl_formation_leader", false]) exitWith {hint format ["%1 is already leading a Formation", groupId _group]};

    _message = "Select Group to follow <br /><br />
    <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t> <br />";
    hint parseText _message;

    pl_follow_array_other_setup = pl_follow_array_other_setup + [_group];

    missionNamespace setVariable ["pl_select_formation_leader", true];
    waitUntil {!(missionNamespace getVariable ["pl_select_formation_leader", true])};

    pl_follow_array_other_setup = pl_follow_array_other_setup - [_group];

    hintSilent "";
    _leadGroup =  missionNamespace getVariable "pl_formation_leader";
    if (_leadGroup isEqualTo (group player)) exitWith {hint "Select 'Form on Commander' instead"};
    if (_leadGroup getVariable ["pl_following_formation", false]) exitWith {hint format ["%1 is already following a Formation", groupId _leadGroup]};
    if (missionNamespace getVariable ["pl_formation_cancel", false]) exitWith {};
    if (_group isEqualTo _leadGroup) exitWith {};


    [_group] call KMD_fnc_reset;

    sleep 0.2;

    _formDir = getDir (leader _leadGroup);
    _group setVariable ["onTask", true];
    _group setVariable ["setSpecial", true];
    _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa"];
    _group setVariable ["pl_following_formation", true];
    playSound "beep";

    _pos1 = getPos (leader _group);
    _pos2 = getPos (leader _leadGroup);
    _relPos = [(_pos1 select 0) - (_pos2 select 0), (_pos1 select 1) - (_pos2 select 1)];
    _group setVariable ["pl_rel_pos", _relPos];
    {
        _x disableAI "AUTOCOMBAT";
    } forEach (units _group);
     _group setFormDir _formDir;
    
    if !(_leadGroup getVariable ["pl_formation_leader", false]) then {
        [_leadGroup] call KMD_fnc_reset;

        sleep 0.2;

        _leadGroup setVariable ["onTask", true];
        _leadGroup setVariable ["setSpecial", true];
        _leadGroup setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa"];
        _leadGroup setVariable ["pl_formation_leader", true];
    };

    {
        _x disableAI "AUTOCOMBAT";
    } forEach (units _leadGroup);

    pl_follow_array_other = pl_follow_array_other + [[_leadGroup, _group]];

    while {(_leadGroup getVariable ["onTask", true]) and (_group getVariable ["onTask", true])} do {
        _pos1 = getPos (leader _leadGroup);
        sleep 2;
        _pos2 = getPos (leader _leadGroup);
        _posOffset = [(_pos2 select 0) - (_pos1 select 0), (_pos2 select 1) - (_pos1 select 1)];

        _pBehaviour = behaviour (leader _leadGroup);
        _group setBehaviour _pBehaviour;

        _pSpeed = speedMode _leadGroup;
        _group setSpeedMode _pSpeed;

        private _leader = leader _group;
        _relPos = _group getVariable "pl_rel_pos";
        if (vehicle _leader != _leader) then {
            (vehicle _leader) limitSpeed 18;
            if ((speed (vehicle _leader)) < 1) then {
                _newPos = [((getPos _leader) select 0) + ((_posOffset select 0) * 15), ((getPos _leader) select 1) + ((_posOffset select 1) * 15)];
                driver (vehicle _leader) doMove _newPos;
            };
            if ((speed (leader _leadGroup)) < 1) then {
                _newPos = [((getPos (leader _leadGroup)) select 0) + (_relPos select 0), ((getPos (leader _leadGroup)) select 1) + (_relPos select 1)];
                driver (vehicle _leader) doMove _newPos;
            };
        }
        else
        {
            _newPos = [((getPos (leader _leadGroup)) select 0) + (_relPos select 0), ((getPos (leader _leadGroup)) select 1) + (_relPos select 1)];
            _leader limitSpeed 15;
            _leader doMove _newPos;
            {
                if (_x != _leader) then {
                    _x doFollow _leader;
                };
            } forEach (units _group);
        };
    };
    pl_follow_array_other = pl_follow_array_other - [[_leadGroup, _group]];
    _group setVariable ["pl_following_formation", false];
    [_group] call KMD_fnc_reset;
    sleep 0.2;
    if !(_leadGroup getVariable ["onTask", true]) then {
        _leadGroup setVariable ["pl_formation_leader", false];
    };