/*
Original name: pl_defend_position
New name:      KMD_fnc_defendPosition
Original url: "Plmod/pl_defence_fnc.sqf"
*/
    private ["_group", "_markerName", "_isStatic", "_staticMarkerName", "_cords", "_watchDir", "_watchPos", "_offSet", "_moveDir", "_medic", "_medicPos"];
    _group = hcSelected player select 0;
    if (vehicle (leader _group) != leader _group) exitWith {hint "Infantry ONLY Task!"};
    if (visibleMap) then {
        hintSilent "";

        _message = "Select DEFENCE position on MAP <br /><br />
        <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t> <br />";
        hint parseText _message;

        onMapSingleClick {
            pl_defence_cords = _pos;
            pl_mapClicked = true;
            if (_shift) then {pl_cancel_strike = true};
            if (_alt) then {pl_deploy_static = true};
            hintSilent "";
            onMapSingleClick "";
        };

        while {!pl_mapClicked} do {sleep 0.1;};
        pl_mapClicked = false;
        if (pl_cancel_strike) exitWith {pl_cancel_strike = false};
        _message = "Select Position FACING <br /><br />
        <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t> <br />
        <t size='0.8' align='left'> -> ALT + LMB</t><t size='0.8' align='right'>DEPLOY Static Weapon</t>";
        hint parseText _message;

        sleep 0.1;
        _cords = pl_defence_cords;
        _markerName = format ["defence%1", _group];
        createMarker [_markerName, _cords];
        _markerName setMarkerType "marker_sfp";
        _markerName setMarkerColor "colorBLUFOR";

        onMapSingleClick {
            pl_mortar_cords = _pos;
            pl_mapClicked = true;
            if (_shift) then {pl_cancel_strike = true};
            if (_alt) then {pl_deploy_static = true};
            hintSilent "";
            onMapSingleClick "";
        };

        while {!pl_mapClicked} do {
            _watchDir = [_cords, ((findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition)] call BIS_fnc_dirTo;
            _markerName setMarkerDir _watchDir;
            sleep 0.05;
        };
        pl_mapClicked = false;

        if (pl_cancel_strike) exitWith {pl_cancel_strike = false; deleteMarker _markerName};

        [_group] call KMD_fnc_reset;

        sleep 0.2;

        _group setVariable ["onTask", true];
        _group setVariable ["setSpecial", true];
        _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\defend_ca.paa"];

        _watchPos = [1000*(sin _watchDir), 1000*(cos _watchDir), 0] vectorAdd _cords;
        _leaderDir = _watchDir - 90;
        _leaderPos = [6*(sin _leaderDir), 6*(cos _leaderDir), 0] vectorAdd _cords;
        _medicDir = _watchDir - 180;
        _medicPos = [15*(sin _medicDir), 15*(cos _medicDir), 0] vectorAdd _cords;
        if (pl_deploy_static) then {
            _isStatic = [_group, _markerName, _watchPos, _leaderPos] call KMD_fnc_newBisUnpack;
            pl_deploy_static = false;
            if !(_isStatic#0) then {
                hint "No Static Weapon!";
            };
        }
        else
        {
            _isStatic = [false, []];
        };
        sleep 0.1;

        _medic = {
            if (getNumber ( configFile >> "CfgVehicles" >> typeOf _x >> "attendant" ) isEqualTo 1) exitWith {_x};
        } forEach (units _group);

        pl_denfence_draw_array pushBack [_markerName, (leader _group)];

        leader _group groupRadio "SentCmdHide";

        if (_isStatic#0) then {
            _staticMarkerName = format ["static%1", _group];
            createMarker [_staticMarkerName, _cords];
            _staticMarkerName setMarkerType "marker_afp";
            _staticMarkerName setMarkerColor "colorBLUFOR";
            _staticMarkerName setMarkerDir _watchDir;
            (leader _group) addWeapon "Binocular";
            playSound "beep";
            // leader _group sideChat format ["Roger, %1 will deploy static Weapon at designated coordinates, over",(groupId _group)];
            _offSet = 9;
        }
        else
        {
            playSound "beep";
            // leader _group sideChat format ["Roger, %1 will defend the Position, over",(groupId _group)];
            _offSet = 0;
        };
        for "_i" from 0 to ((count (units _group))- 1) do {
            if ((_i % 2) == 0) then {
                _offSet = _offSet + 9;
                _moveDir = _watchDir - 90;
            }
            else
            {
                _moveDir = _watchDir + 90;
            };
            _movePos = [_offSet*(sin _moveDir), _offSet*(cos _moveDir), 0] vectorAdd _cords;
            _unit = (units _group) select _i;
            if !(_unit in _isStatic#1) then {
                private _isLeader = false;
                if (_unit == (leader _group)) then {
                    _movePos = _cords;
                    _isLeader = true;
                };
                if (!(isNil "_medic") && pl_enable_revival) then {
                    if (_unit == _medic) then {
                        _movePos = _medicPos;
                    };
                };
                [_unit, _movePos, _watchDir, _isLeader, _markerName, _group] spawn {
                    params ["_unit", "_pos", "_watchDir", "_isLeader", "_markerName", "_group"];
                    _unit disableAI "AUTOCOMBAT";
                    _unit disableAI "AUTOTARGET";
                    _unit disableAI "TARGET";
                    // _unit disableAI "FSM";
                    _unit doMove _pos;
                    waitUntil {(!alive _unit) or (unitReady _unit) or !(_group getVariable ["onTask", true])};
                    _unit enableAI "AUTOCOMBAT";
                    _unit enableAI "AUTOTARGET";
                    _unit enableAI "TARGET";
                    // _unit enableAI "FSM";
                    if (_group getVariable ["onTask", true]) then {
                        [_unit, _pos, _watchDir, 7, true] spawn KMD_fnc_findCover;
                    };
                    if (_isLeader) then {
                        pl_denfence_draw_array = pl_denfence_draw_array - [[_markerName, _unit]];
                    };
                };
            };
        };
        // Cancel Task
        
        if (!(isNil "_medic") and pl_enable_revival) then {
            _medic setVariable ["pl_is_ccp_medic", true];
            while {(_group getVariable ["onTask", true])} do {
                {
                    if (_x getVariable ["pl_wia", false] and !(_x getVariable "pl_beeing_treatet")) then {
                        _medic setUnitPos "MIDDLE";
                        _h1 = [_group, _medic, nil, _x, _medicPos, 50] spawn KMD_fnc_ccpReviveAction;
                        waitUntil {sleep 0.1; scriptDone _h1 or !(_group getVariable ["onTask", true])};
                        [_x, getPos _x, _watchDir, 7, false] spawn KMD_fnc_findCover;
                        _medic setUnitPos "MIDDLE";
                    };
                } forEach (units _group);
                _time = time + 10;
                waitUntil {time > _time or !(_group getVariable ["onTask", true])};
            };
            _medic setVariable ["pl_is_ccp_medic", false];
        }
        else
        {
            waitUntil {!(_group getVariable ["onTask", true])};
        };
        if (_isStatic#0) then {
            _weapon = {
                if (vehicle _x != _x) exitWith {vehicle _x};
                objNull
            } forEach (units _group);
            if !(isNull _weapon) then {
                [_group, _weapon] call KMD_fnc_newBisPack;
            };
            deleteMarker _staticMarkerName;
            (leader _group) removeWeapon "Binocular";
        };
        deleteMarker _markerName;

    };
