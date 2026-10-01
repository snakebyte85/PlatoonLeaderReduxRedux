/*
Original name: pl_attack
New name:      KMD_fnc_attack
Original url: "Plmod\pl_attack_fnc.sqf"
*/

	params ["_group", ["_cords", [0,0,0]]];
    private ["_atkwp", "_posArray", "_fastAtk"];

    if (vehicle (leader _group) != leader _group) exitWith {hint "Infantry ONLY Task!"};

    if (_cords isEqualTo [0,0,0]) then {
        if (visibleMap) then {
            // hint "Select location on MAP (LMB = Tactical, SHIFT + LMB = SLOW, ALT + LMB = FAST)";
            _message = "Select Assault Location <br /><br />
            <t size='0.8' align='left'> -> LMB</t><t size='0.8' align='right'>TACTICAL</t> <br />
            <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>SLOW</t> <br />
            <t size='0.8' align='left'> -> ALT + LMB</t><t size='0.8' align='right'>FAST</t>";
            hint parseText _message;

            onMapSingleClick {
                pl_bounding_cords = _pos;
                pl_mapClicked = true;
                pl_attack_mode = "normal";
                if (_shift) then {pl_attack_mode = "slow"};
                if (_alt) then {pl_attack_mode = "fast"};
                hintSilent "";
                onMapSingleClick "";
            };
            while {!pl_mapClicked} do {sleep 0.2;};
            pl_mapClicked = false;
            _cords = pl_bounding_cords;
            _moveDir = (leader _group) getDir _cords;
        }
        else
        {
            _cords = screenToWorld [0.5,0.5];
            pl_attack_mode = "normal";
        };
    };

    [_group] call KMD_fnc_reset;
    sleep 0.2;

    _groupStrength = count (units _group);
    playsound "beep";
    // leader _group sideChat "Roger beginning Assault, Over";

    {
        _x disableAI "AUTOCOMBAT";
    } forEach (units _group);
    _group setBehaviour "AWARE";

    _fastAtk = false;
    switch (pl_attack_mode) do { 
        case "normal" : {leader _group limitSpeed 12;}; 
        case "slow" : {_group setSpeedMode "LIMITED"}; 
        case "fast" : {_fastAtk = true; _group setSpeedMode "FULL";};
        default {leader _group limitSpeed 12;}; 
    };
    

    _atkwp =_group addWaypoint [_cords, 0];
    _atkwp setWaypointType "SAD";

    _group setVariable ["setSpecial", true];
    _group setVariable ["onTask", true];
    _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\attack_ca.paa"];

    if (_fastAtk) then {
        _atkDir = (leader _group) getDir _cords;
        {
            _pos = [[[_cords, 25]],[]] call BIS_fnc_randomPos;
            _x setUnitPos "UP";
            [_x, _pos, _cords, _atkDir, 45] spawn KMD_fnc_boundingMove;
        } forEach (units _group);
    };
    waitUntil {if (_group isEqualTo grpNull) exitWith {true}; (((leader _group) distance2D (waypointPosition _atkwp)) < 30) or ((count (units _group)) <= (_groupStrength - 4)) or !(_group getVariable ["onTask", true])};

    sleep 1;

    _group setVariable ["pl_combat_mode", true];
    _group setCombatMode "RED";
    _group enableAttack true;

    {
        _x enableAI "AUTOCOMBAT";
    } forEach (units _group);
    leader _group limitSpeed 5000;

    waitUntil {!(_atkwp in (waypoints _group)) or !(_group getVariable ["onTask", true])};

    _group setVariable ["pl_combat_mode", false];
    _group setCombatMode "YELLOW";
    _group enableAttack false;

    {
        _targets = _x targetsQuery [objNull, sideUnknown, "", [], 0];
        _count = count _targets;
            
        for [{private _i = 0}, {_i < _count}, {_i = _i + 1}] do {
            private _y = _targets select _i;
            _x forgetTarget (_y select 1);
        };
    } forEach (units _group);

    _group setVariable ["setSpecial", false];
    _group setVariable ["onTask", false];