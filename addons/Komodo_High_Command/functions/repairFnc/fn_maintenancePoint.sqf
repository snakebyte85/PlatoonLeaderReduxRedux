/*
Original name: pl_maintenance_point
New name:      KMD_fnc_maintenancePoint
Original url: "Plmod\pl_repair_fnc.sqf"
*/
    private ["_group", "_markerName", "_areaMarkerName", "_cords", "_engineer", "_vics", "_groupId"];

    _group = hcSelected player select 0;
    _cords = getPos (leader _group);
    _engineer = {
        if (getNumber ( configFile >> "CfgVehicles" >> typeOf _x >> "engineer" ) isEqualTo 1) exitWith {_x};
        objNull
    } forEach (units _group);

    if (isNull _engineer) exitWith {hint format ["%1 has no Engineer!", groupId _group]};
    if (vehicle (leader _group) != leader _group) exitWith {hint format ["%1 needs to dismount first!", groupId _group]};

    // _markerName = createMarker ["maintenance_point_center", (getPos (leader _group))];
    // _markerName setMarkerType "b_maint";
    // _markerName setMarkerText "Maintenance Point";

    // _group addGroupIcon ["b_maint"];
    // _group removeGroupIcon 1;
    _groupId = groupId _group;
    _group setGroupId [format ["%1 (Maintenance Point)", _groupId]];
    _group setVariable ["MARTA_customIcon", ["b_maint"]];
    
    _areaMarkerName = createMarker ["maintenance_point_area", getPos (leader _group)];
    _areaMarkerName setMarkerShape "ELLIPSE";
    _areaMarkerName setMarkerBrush "DiagGrid";
    _areaMarkerName setMarkerColor "colorBLUFOR";
    _areaMarkerName setMarkerAlpha 0.4;
    _areaMarkerName setMarkerSize [pl_maintenance_area, pl_maintenance_area];

    [_group] call KMD_fnc_reset;
    
    sleep 0.2;

    _group setVariable ["onTask", true];
    _group setVariable ["setSpecial", true];
    _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa"];
    _engineer setVariable ["pl_is_ccp_medic", true];

    private _fn_repair_action = {
        params ["_vic", "_engineer", "_group"];
        private ["_pos", "_offsetX", "_offsetZ"];
        (driver _vic) disableAI "PATH";

        (group (driver _vic)) setVariable ["setSpecial", true];
        (group (driver _vic)) setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa"];

        _offsetZ = ((getPosASL _vic)#2) - ((getPosWorldVisual _vic)#2);
        _offsetX = (((boundingBoxReal _vic) select 0) select 0) / 2 - 1;
        _pos = getPosASL _vic;
        _pos = [(_pos#0) + _offsetX, _pos#1, (_pos#2) + _offsetZ];

        _engineer doMove _pos;
        _engineer moveTo _pos;
        private _eLoadout = getUnitLoadout _engineer ;

        waitUntil {unitReady _engineer or !(_group getVariable ["onTask", true]) or (!alive _engineer)};
        if ((_group getVariable ["onTask", true]) and (alive _engineer)) then {
            doStop _engineer;
            _engineer disableAI "PATH";
            _engineer attachTo [_vic, [_offsetX ,0, _offsetZ]];
            [_engineer, "REPAIR_VEH_STAND", "ASIS", objNull, true, true] call BIS_fnc_ambientAnim;
            _engineer setDir 90;

            _time = time + 30;
            waitUntil {!(_group getVariable ["onTask", true]) or (!alive _engineer) or time > _time};
            _engineer call BIS_fnc_ambientAnim__terminate;
            _engineer enableAI "PATH";
            _engineer setUnitLoadout _eLoadout ;
            if ((_group getVariable ["onTask", true]) and (alive _engineer)) then {
                (group (driver _vic)) setVariable ["setSpecial", false];
                _vic setDamage 0;
                private _vicGroup = group (driver _vic);
                {
                    _vicGroup = group _x;
                    _x setDamage 0;
                } forEach (crew _vic);
                _g = createVehicleCrew _vic;
                [units _g] joinSilent _vicGroup; 
                sleep 5;
                // (driver _vic) enableAI "PATH";
                _engineer doMove (getPos (leader _group));
                _engineer moveTo (getPos (leader _group));
            };
        };
        (driver _vic) enableAI "PATH";
    };

    sleep 1;

    _engineer disableAI "AUTOCOMBAT";
    {
        _x disableAI "AUTOCOMBAT";
        [_x, (getPos _engineer), 0, 10, false] spawn KMD_fnc_findCover;
    } forEach (units _group) - [_engineer];

    while {(_group getVariable ["onTask", true] and (alive _engineer))} do {
        _vics = nearestObjects [_cords, ["Car", "Tank", "Truck"], pl_maintenance_area];
        {
            if ((damage _x) > 0.1) then {
                _s1 = [_x, _engineer, _group] spawn _fn_repair_action;
                waitUntil {scriptDone _s1};
            };
        } forEach (_vics select {side _x isEqualTo playerSide});
        sleep 2;
    };

    _engineer setVariable ["pl_is_ccp_medic", false];
    deleteMarker _areaMarkerName;
    _group setVariable ["MARTA_customIcon", nil];
    _group setGroupId [_groupId];
    // deleteMarker _markerName;
