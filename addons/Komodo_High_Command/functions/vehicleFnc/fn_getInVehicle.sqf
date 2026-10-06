/*
Original name: pl_getIn_vehicle
New name:      KMD_fnc_getInVehicle
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    private ["_vics", "_targetVic", "_groupLen", "_group"];

    _group = hcSelected player select 0;
    _groupLen = count (units _group);
    
    pl_vics = [];

    if (visibleMap) then {
        pl_show_vehicles_pos = getPos (leader _group);
        pl_show_vehicles = true;
        hint "Select TRANSPORT on Map";
        onMapSingleClick {
            pl_mapClicked = true;
            _cords = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
            pl_vics = nearestObjects [_cords, ["Car", "Truck", "Tank", "Air"], 20, true];
            hintSilent "";
            onMapSingleClick "";
        };
        while {!pl_mapClicked} do {sleep 0.1};
        pl_show_vehicles = false;
        pl_mapClicked = false;
    }
    else
    {
        if(!isNull cursorTarget) then {
            pl_vics = [cursorTarget];
        };
    };
    
    if( count pl_vics > 0) then {
        _targetVic = pl_vics select 0;
    };
    
    if !(isNil "_targetVic") then {
    
        if( count fullCrew[_targetVic, "driver", false] == 0) then {
            hint "There is no crew in the selected vehicle";
       } else {
    
            if( _groupLen > _targetVic emptyPositions "Cargo" ) then {
                hint "Not enough avaiable seats!";
            } else {

                // Request Airlift
                if ((_targetVic distance2D (leader _group)) > 200 and _targetVic isKindOf "Air") then {
                    {
                        _x disableAI "AUTOCOMBAT";
                        _x disableAI "TARGET";
                        _x disableAI "AUTOTARGET";
                    } forEach (units (group (driver _targetVic)));
                    group (driver _targetVic) addWaypoint [getPos (leader _group), 0];
                    (group (driver _targetVic)) setVariable ["setSpecial", true];
                    (group (driver _targetVic)) setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\takeoff_ca.paa"];
                    playSound "beep";
                    driver _targetVic sideChat "Moving to the rendez-vous location";
                    sleep 20;
                    waitUntil {sleep 0.1; unitReady _targetVic or !alive _targetVic};
                    playSound "beep";
                    driver _targetVic sideChat "Beginning landing";
                    _targetVic land "GET IN";
                    sleep 10;
                    waitUntil {sleep 0.1; (isTouchingGround _targetVic) or !alive _targetVic};
                    sleep 1;
                };

                [_group] call KMD_fnc_reset;
                sleep 0.2;

                // Vehicle Transport
                if ((vehicle (leader _group)) != leader _group) then {
                    _vic = vehicle (leader _group);
                    if ((_targetVic canVehicleCargo _vic) select 0) then {
                        _vicName = getText (configFile >> "CfgVehicles" >> typeOf _targetVic >> "displayName");
                        playSound "beep";
                        leader _group sideChat format ["Getting in %1", _vicName];
                        _group setVariable ["pl_show_info", false];
                        (group (driver _targetVic)) setVariable ["setSpecial", true];
                        (group (driver _targetVic)) setVariable ["specialIcon", pl_cargo_icon];
                        
                        _wp = _group addWaypoint [getPosASL _targetVic, 0];
                        _wp setWaypointType "VEHICLEINVEHICLEGETIN";
                        // player hcRemoveGroup _group;
                        //{
                        //    player hcRemoveGroup (group (_x select 0));
                        //} forEach fullCrew[_vic, "cargo", false];
                        // player hcSetGroup [(group (driver _targetVic))];
                    }
                    else
                    {
                        playSound "beep";
                        hint "No avaiable Transport";
                    };
                }
                // Infantry Tranport
                else
                {
                    _targetVic setUnloadInCombat [false, false];

                    for "_i" from count waypoints _group - 1 to 0 step -1 do {
                        deleteWaypoint [_group, _i];
                    };
                    _vicName = getText (configFile >> "CfgVehicles" >> typeOf _targetVic >> "displayName");
                    leader _group sideChat format ["Getting in %1", _vicName];
                    (group (driver _targetVic)) setVariable ["setSpecial", true];
                    (group (driver _targetVic)) setVariable ["specialIcon", pl_cargo_icon];
                    _group setVariable ["setSpecial", true];
                    _group setVariable ["specialIcon", pl_cargo_icon];
                    pl_groups_getting_in set [netid _group, _targetVic];
                    {
                        if !(_x in (crew _targetVic)) then {
                            _x assignAsCargo _targetVic;
                            [_x] allowGetIn true;
                            [_x] orderGetIn true;
                        }
                        else
                        {
                            [_x] allowGetIn true;
                            [_x] orderGetIn true;
                        }; 
                    } forEach (units _group);
                    _group setVariable ["onTask", true];
                    waitUntil {sleep 0.1; ({_x in _targetVic} count (units _group) > 0) or !(_group getVariable ["onTask", true])};
                    if !(_group getVariable "onTask") then {
                        {
                            unassignVehicle _x;
                        } forEach (units _group);
                        (group (driver _targetVic)) setVariable ["setSpecial", false];
                    }
                    else
                    {
                        _group setVariable ["onTask", false];
                        _group setVariable ["setSpecial", false];
                        _group setVariable ["pl_show_info", false];
                        player hcRemoveGroup _group;
                        
                    };
                    pl_groups_getting_in deleteAt (netid _group);
                };
            };
        };
    }
    else
    {
        playSound "beep";
        hint "No available Transport";
    };
