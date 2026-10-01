/*
Original name: pl_bounding_squad
New name:      KMD_fnc_boundingSquad
Original url: "Plmod\pl_attack_fnc.sqf"
*/
private ["_cords", "_group", "_moveDir", "_movePos", "_tactic", "_offSet", "_groupLen", "_units", "_team1", "_team2", "_moveRange"];

    if !(visibleMap) exitWith {hint "Open Map for bounding OW"};

    _group = hcSelected player select 0;
    if (vehicle (leader _group) != leader _group) exitWith {hint "Infantry ONLY Task!"};
    // hint "Select location on MAP (LMB = MOVE, SHIFT + LMB = ATTACK)";
    _message = "Select location <br /><br />
    <t size='0.8' align='left'> -> LMB</t><t size='0.8' align='right'>MOVE</t> <br />
    <t size='0.8' align='left'> -> ALT + LMB</t><t size='0.8' align='right'>ATTACK</t> <br />
    <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t> <br />";
    hint parseText _message;
    onMapSingleClick {
        pl_bounding_cords = _pos;
        pl_mapClicked = true;
        pl_bounding_mode = "move";
        if (_alt) then {pl_bounding_mode = "attack"};
        if (_shift) then {pl_cancel_strike = true};
        hintSilent "";
        onMapSingleClick "";
    };
    while {!pl_mapClicked} do {sleep 0.2;};
    pl_mapClicked = false;

    if (pl_cancel_strike) exitWith {pl_cancel_strike = false};
        
    _cords = pl_bounding_cords;
    _moveDir = (leader _group) getDir _cords;

    [_group] call KMD_fnc_reset;
    sleep 0.2;

    playsound "beep";
    
    _group setVariable ["onTask", true];
    _group setVariable ["setSpecial", true];
    _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\help_ca.paa"];

    pl_bounding_draw_array pushBack [_group, _cords];

    _groupLen = (count (units _group)) - 1;

    _units = (units _group);
    _team1 = [];
    _team2 = [];

    _tactic = pl_bounding_mode;

    _group setSpeedMode "FULL";

    for "_i" from 0 to _groupLen do {
        (_units#_i) setVariable ["pl_bounding_set", false];
        if (_i % 2 == 0) then {
            if !(_units#_i getVariable ["pl_wia", false]) then {
                _units#_i setVariable ["pl_bounding_set", false];
                _team1 pushBack _units#_i;
            };
        }
        else
        {
            if !(_units#_i getVariable ["pl_wia", false]) then {
                _units#_i setVariable ["pl_bounding_set", false];
                _team2 pushBack _units#_i;
            };
        }
    };
    _units = _team1 + _team2;
    _leaderPos = getPos (leader _group);
    _offSet = 10;

    _arrive_pos_fn = {
        params ["_unit", "_movePos", "_moveDir"];
        _unit doMove _movePos;
        _unit disableAI "AUTOCOMBAT";
        // _unit disableAI "TARGET";
        // _unit disableAI "AUTOTARGET";
        // _unit disableAI "SUPPRESSION";
        // _unit disableAI "COVER";
        sleep 1;
        waitUntil {(unitReady _unit) or ((_unit distance2D _movePos) < 1.5) or (!alive _unit) or ( _unit getVariable["pl_wia", false]) or !((group _unit) getVariable ["onTask", true])};
        _unit enableAI "AUTOCOMBAT";
        if ((group _unit) getVariable ["onTask", true]) then {
            [_unit, _movePos, _moveDir, 3, false] spawn KMD_fnc_findCover;
            sleep 1;
            _unit setVariable ["pl_bounding_set", true];
        };
    };

    {
        _movePos = [_offSet*(sin (_moveDir - 90)), _offSet*(cos (_moveDir - 90)), 0] vectorAdd _leaderPos;
        _offSet = _offSet + 6;
        [_x, _movePos, _moveDir] spawn _arrive_pos_fn;
    } forEach _team1;
    _offSet = 10;
    {
        _movePos = [_offSet*(sin (_moveDir + 90)), _offSet*(cos (_moveDir + 90)), 0] vectorAdd _leaderPos;
        _offSet = _offSet + 6;
        [_x, _movePos, _moveDir] spawn _arrive_pos_fn;
    } forEach _team2;

    waitUntil {sleep 0.1; (({_x getVariable ["pl_bounding_set", false]} count _units) == (count _units)) or !(_group getVariable ["onTask", true])};

    sleep 1.5;

    _get_move_range_fn = {
        params ["_team", "_cords"];
        _return = {
            if ((_x distance2D _cords) < 70) exitWith {30};
            60
        } forEach _team;
        // player sideChat str _return;
        _return
    };

    _moveRange = 30;
    while {_group getVariable ["onTask", true]} do {
        _movePos = [_moveRange*(sin _moveDir), _moveRange*(cos _moveDir), 0] vectorAdd (getPos (_team1#0));
        _offSet = 0;
        (_team1#0) groupRadio "SentConfirmMove";
        {
            if (_x getVariable ["pl_wia", false] or !alive _x) then {_team1 = _team1 - [_x]};
            _x setUnitPos "UP";
            _x enableAI "PATH";
            _pos = [_offSet*(sin (_moveDir - 90)), _offSet*(cos (_moveDir - 90)), 0] vectorAdd _movePos;
            _offSet = _offSet + 6;
            [_x, _pos, _cords, _moveDir] spawn KMD_fnc_boundingMove;
        } forEach _team1;
        waitUntil {sleep 0.1; !(_group getVariable ["onTask", true]) or (({!(_x getVariable ["pl_bounding_set", false])} count _team1) < 1)};

        if !(_group getVariable ["onTask", true]) exitWith {};
        (_team1#0) groupRadio "sentCovering";
        sleep 2;
        _moveRange = [(_team1 + _team2), _cords] call _get_move_range_fn;
        _movePos = [_moveRange*(sin _moveDir), _moveRange*(cos _moveDir), 0] vectorAdd (getPos (_team2#0));
        _offSet = 0;
        (_team2#0) groupRadio "SentConfirmMove";
        {
            if (_x getVariable ["pl_wia", false] or !alive _x) then {_team2 = _team2 - [_x]};
            _x setUnitPos "UP";
            _x enableAI "PATH";
            _pos = [_offSet*(sin (_moveDir + 90)), _offSet*(cos (_moveDir + 90)), 0] vectorAdd _movePos;
            _offSet = _offSet + 6;
            [_x, _pos, _cords, _moveDir] spawn KMD_fnc_boundingMove;
        } forEach _team2;
        waitUntil {sleep 0.1; !(_group getVariable ["onTask", true]) or (({!(_x getVariable ["pl_bounding_set", false])} count _team2) < 1)};

        if (!(_group getVariable ["onTask", true]) or _moveRange == 30) exitWith {};
        (_team2#0) groupRadio "sentCovering";
        sleep 2;
    };

    pl_bounding_draw_array = pl_bounding_draw_array - [[_group, _cords]];

    // [_group] call KMD_fnc_reset;
    {
        _x setVariable ["pl_bounding_set", nil];
    } forEach _units;

    if !(_group getVariable ["onTask", true]) exitWith {};

    if (_tactic isEqualTo "attack") then { 
        [_group, _cords] spawn KMD_fnc_attack
    }
    else
    {
        [_group] spawn pl_take_cover; 
    };
