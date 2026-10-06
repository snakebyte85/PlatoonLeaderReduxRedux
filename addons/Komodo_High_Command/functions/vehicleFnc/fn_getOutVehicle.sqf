/*
Original name: pl_getOut_vehicle
New name:      KMD_fnc_getOutVehicle
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    params ["_group", "_convoyId", "_moveInConvoy"];
    private ["_vic", "_commander", "_markerName", "_cargo", "_cargoGroups", "_vicTransport", "_transportedVic", "_inLandConvoy", "_convoyLeader", "_convoyArray", "_convoyPosition", "_watchPos"];

    _leader = leader _group;

    if (vehicle _leader != _leader) then {
        _vic = vehicle _leader;
        _vicTransport = false;
        if !(isNull (isVehicleCargo _vic)) then {
            _transportedVic = _vic;
            _vic = isVehicleCargo _vic;
            _vicTransport = true;
        };

        if !(isNil {_vic getVariable "pl_on_transport"}) exitWith {
            if ((count (missionNamespace getVariable _convoyId)) > 1) then {
                player hcRemoveGroup _group;
            };
            if ((missionNamespace getVariable (_convoyId + "time")) > time) then {
                playSound "beep";
                hint format ["%1 is already on a mission!", groupId (group (driver _vic))];
            };
        };

        _vic setVariable ["pl_on_transport", true];
        _cargo = fullCrew _vic;
        _commander = driver _vic;
        {
            if (_x select 1 isEqualTo "commander") then {
                _commander = (_x select 0);
            };
        } forEach _cargo;

        for "_i" from count waypoints (group _commander) - 1 to 0 step -1 do{
            deleteWaypoint [(group _commander), _i];
        };
        _cargo = fullCrew [_vic, "cargo", false];

        if (visibleMap) then {
            // Unload at selected Map Position
            // For Land Vehicles and Air Transport

            ///// Transport Set up /////

            hintSilent "Select DESTINATION on MAP";
            onMapSingleClick {
                pl_mapClicked = true;
                pl_lz_cords = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
                pl_lz_marker_cords = pl_lz_cords;
                // if (_shift) then {pl_cancel_strike = true};
                hintSilent "";
                onMapSingleClick "";
            };
            waitUntil {pl_mapClicked};

            // if (pl_cancel_strike) exitWith {pl_cancel_strike = false};

            sleep 0.1;
            pl_mapClicked = false;
            _cords = pl_lz_cords;

            _convoyArray = [];
            _inLandConvoy = false;

            // More then One Tranport == Convoy
            if ((count (missionNamespace getVariable _convoyId)) > 1) then {
                if (_group isEqualTo ((missionNamespace getVariable _convoyId) select 0)) then {
                    _c = [(missionNamespace getVariable _convoyId), [], {(leader _x) distance2D _cords}, "ASCEND"] call BIS_fnc_sortBy;
                    missionNamespace setVariable [_convoyId, _c];

                    private _blacklistr1 = [];
                    private _r2 = [_cords, 100,[]] call BIS_fnc_nearestRoad;
                    {
                        private _r1 = [(getPos (leader _x)), 100] call BIS_fnc_nearestRoad;
                        if (_r1 in _blacklistr1) then {
                            private _roads = getPos (leader _x) nearRoads 100;
                            _roads = [_roads, [], {(getPos _x) distance2D _cords}, "ASCEND"] call BIS_fnc_sortBy;  
                            _r1 = {
                                if !(_x in _blacklistr1) exitWith {_x};
                            } forEach _roads;
                        };
                        _blacklistr1 pushback _r1;
                        // player sideChat (str _r1);
                        _pathCost = [_r1, _r2] call KMD_fnc_convoyPathFind;
                        _x setVariable ["pl_path_cost", _pathCost];
                        _x setVariable ["r1", _r1];
                    } forEach (missionNamespace getVariable _convoyId);
                    hint "Setting up Convoy...";
                    playSound "beep";
                };
                sleep 5;
                hintSilent "";
                pl_set_up_convoy = true;

                _c = [(missionNamespace getVariable _convoyId), [], {_x getVariable ["pl_path_cost", 2000]}, "ASCEND"] call BIS_fnc_sortBy;  
                 missionNamespace setVariable [_convoyId, _c];
                pl_draw_convoy_array pushBack (missionNamespace getVariable _convoyId);
                pl_draw_convoy_array = pl_draw_convoy_array arrayIntersect pl_draw_convoy_array;
                _convoyLeader = (missionNamespace getVariable _convoyId) select 0;
                _convoyArray = (missionNamespace getVariable _convoyId);
                _convoyLeader setVariable ["onTask", true];
                _convoyLeader setVariable ["setSpecial", true];
                _convoyLeader setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\navigate_ca.paa"];
                group (_commander) setVariable ["pl_draw_convoy", true];

                if (_group != _convoyLeader and _group != (group player)) then {
                    player hcRemoveGroup _group;
                };

                // Air Convoy
                if (_vic isKindOf "Air") then {
                    hint "This should not happens. Report it as a bug.";
                }
                else
                // Land Convoy
                {
                    player hcSetGroup [_convoyLeader];
                    {
                        _x disableAI "AUTOCOMBAT";
                    } forEach units (group _commander);
                    _vic limitSpeed 50;
                    // _vic forceFollowRoad true;
                    // _vic setConvoySeparation 20;
                    group _commander setBehaviour "SAFE"; // SAFE
                    _inLandConvoy = true;
                    waitUntil {(time >= (missionNamespace getVariable (_convoyId + "time")) and (group _commander) == ((missionNamespace getVariable _convoyId) select (missionNamespace getVariable (_convoyId + "pos")))) or !(_convoyLeader getVariable ["onTask", true])};

                    // private _points = pl_convoy_path_marker apply {getMarkerPos _x};
                    // _vic setDriveOnPath _points;

                    _convoyPosition = (missionNamespace getVariable (_convoyId + "pos"));
                    _t = time + 4;
                    missionNamespace setVariable [_convoyId + "time", _t];
                    _p  = (missionNamespace getVariable (_convoyId + "pos"));
                    _p = _p + 1;
                    missionNamespace setVariable [_convoyId + "pos", _p];
                };
            }
            else
            {
                _inLandConvoy = false;
            };

            _wp = (group _commander) addWaypoint [_cords, 0];
            _wp setWaypointType "TR UNLOAD";
            // Create Destination Marker
            if ((group driver (_vic)) == (group player)) then {
                (driver _vic) commandMove _cords;
            };
            _markerName = format ["lzmarker%1", (groupId _group)];
            createMarker [_markerName, pl_lz_marker_cords];            
            _markerName setMarkerType "mil_marker";
            if (_vic isKindOf "Air") then {
                _markerName setMarkerType "hd_end";
                _markerName setMarkerText "LZ";
            };
             _markerName setMarkerColor ([side _vic] call KMD_fnc_sideToMarkerColor);
            // Setup the cargo of Transport Vehicle
            _cargo = fullCrew [_vic, "cargo", false];
            _cargoGroups = [];
            {
                _groupCargo = group (_x select 0);
                if( _group != _groupCargo ) then { // just another check so we don't make the crew group disembark
                    _cargoGroups pushBack _groupCargo;
                };
            } forEach _cargo;
            _cargoGroups = _cargoGroups arrayIntersect _cargoGroups;
            format ["Cargo groups %1 will get out from vehicle group %2", _cargoGroups, _group] call KMD_fnc_debug;

            /// Transport Execution ///

            // If Infantry is Transported
            if !(_vicTransport) then {
                if (_vic isKindOf "Air") then {
                
                     _wp setWaypointType "MOVE";
                
                    {
                        _x disableAI "AUTOCOMBAT";
                        _x disableAI "TARGET";
                        _x disableAI "AUTOTARGET";
                    } forEach (units (group _commander));
                    (group _commander) setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\land_ca.paa"];
                    sleep 40;
                    waitUntil {sleep 0.1; unitReady _vic or !alive _vic};
                    playSound "beep";
                    driver _vic sideChat "Beginning landing";
                    _vic land "GET OUT";
                    sleep 10;
                    waitUntil {sleep 0.1; (isTouchingGround _vic) or !alive _vic};
                    sleep 1;
                    {
                        _x leaveVehicle _vic;                        
                        _x setVariable ["pl_show_info", true];
                        player hcSetGroup [_x];
                        
                    } forEach _cargoGroups;
                }
                else
                {
                    sleep 0.2;
                    // Land Convoy Loop
                    if (_inLandConvoy) then {
                        if (_moveInConvoy) then {
                            _wp setWaypointType "MOVE";
                        };
                        while {
                        (alive (vehicle (leader _convoyLeader))) and
                        // !(unitReady (driver (vehicle (leader _convoyLeader)))) and
                        ((leader _convoyLeader) distance2D waypointPosition[_convoyLeader, currentWaypoint _convoyLeader] > 60) and
                        (_convoyLeader getVariable ["onTask", true])
                        } do {
                            if ((group _commander) != _convoyLeader) then {
                                if ((speed (vehicle (leader (_convoyArray select _convoyPosition - 1)))) < 4) then {
                                    _vic forceSpeed 0;
                                };
                                _distance = _vic distance2d vehicle (leader (_convoyArray select _convoyPosition - 1));
                                if (_distance > 60) then {
                                    _vic forceSpeed -1;
                                    _vic limitSpeed 55;
                                };
                                if (_distance < 60) then {
                                    _vic forceSpeed -1;
                                    _vic limitSpeed 30;
                                };
                                if (_distance < 30) then {
                                    _vic forceSpeed -1;
                                    _vic limitSpeed 20;
                                };
                                if (_distance < 20) then {
                                    _vic forceSpeed 0;
                                };
                            }
                            else
                            {
                                _distance = _vic distance2d vehicle (leader (_convoyArray select 1));
                                if (_distance < 70) then {
                                    _vic forceSpeed -1;
                                    _vic limitSpeed 50;
                                };
                                if (_distance > 70) then {
                                    _vic forceSpeed -1;
                                    _vic limitSpeed 25;
                                };
                                if (_distance > 90) then {
                                    _vic forceSpeed 0;
                                };
                            };
                            sleep 1;
                        };
                        _vic forceSpeed -1;
                        _vic limitSpeed 50;
                        // Land Convoy Arriving
                        // if moveInConvoy do not unload Cargo
                        {
                            deleteMarker _x;
                        } forEach pl_convoy_path_marker;
                        if !(_moveInConvoy) then {
                            {
                                {
                                    if ((assignedVehicleRole _x) select 0 isEqualTo "Cargo") then {
                                        unassignVehicle _x;
                                        doGetOut _x;
                                    };
                                } forEach (units _x);
                                if (_x == (group player)) then {
                                    doStop driver (vehicle (player));
                                    sleep 0.1;
                                    driver (vehicle (player)) doFollow player;
                                };
                                player hcSetGroup [_x];
                            } forEach _cargoGroups;
                        };
                        {
                            player hcSetGroup [_x];
                        } forEach _convoyArray;
                        _wp setWaypointPosition [getPos _vic, 0];
                        // if !(_convoyLeader getVariable "onTask" and _convoyLeader == (group _commander)) then {
                        //     _wp = (group _commander) addWaypoint [getPos _vic, 0];
                        //     _wp setWaypointType "TR UNLOAD";
                        // };
                        _convoyLeader setVariable ["onTask", false];
                        _convoyLeader setVariable ["setSpecial", false];
                        _cVic = vehicle (leader _convoyLeader);
                        // if (_cVic getVariable ["pl_on_transport", false]) then {
                        //     _convoyLeader setVariable ["setSpecial", true];
                        //     _convoyLeader setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa"]
                        // };
                        group (_commander) setVariable ["pl_draw_convoy", false];
                        group (_commander) setBehaviour "AWARE";
                        {
                            _x enableAI "AUTOCOMBAT";
                        } forEach units (group _commander);
                        pl_draw_convoy_array = pl_draw_convoy_array - [_convoyArray];
                    }
                    // Single Vehicle
                    else
                    {
                        waitUntil {sleep 0.1; ((leader _group) distance2D waypointPosition[(group _commander), currentWaypoint (group _commander)] < 30) or (!alive _vic)};
                        {
                            _unit = _x select 0;
                            _unit enableAI "AUTOCOMBAT";
                            if (_x select 1 isEqualTo "cargo") then {
                                unassignVehicle _unit;
                                doGetOut _unit;
                            };
                        } forEach _cargo;
                    };
                    if !(_moveInConvoy) then {
                        {
                            _x setVariable ["pl_show_info", true];
                            player hcSetGroup [_x];
                            // _x addWaypoint [getPos _vic, 10];                            
                        } forEach _cargoGroups;
                    };
                    // Single Land Tarnsport ariving
                };
            }
            // If Vehicle is Transported
            else
            {
                {
                    _x disableAI "AUTOCOMBAT";
                    _x disableAI "TARGET";
                    _x disableAI "AUTOTARGET";
                } forEach (units (group _commander));
                (group _commander) setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\land_ca.paa"];
                sleep 40;

                // Air Vehicle in Vehicle Tranport Ariving
                waitUntil {sleep 0.1; (isTouchingGround _vic) or !alive _vic};
                // player hcSetGroup [_group];
                {
                    player hcsetGroup [(group (_x select 0))];
                } forEach fullCrew[vehicle (leader (_group)), "cargo", false];
                sleep 5;
                for "_i" from count waypoints _group - 1 to 0 step -1 do {
                    deleteWaypoint [_group, _i];
                };
                _wp = (group _commander) addWaypoint [getPos _vic, 0];
                _wp setWaypointType  "VEHICLEINVEHICLEUNLOAD";
                // player hcRemoveGroup (group _commander);
                sleep 2;
                waitUntil {sleep 0.1; isNull (isVehicleCargo _transportedVic) or (!alive _vic)};
                _group setVariable ["pl_show_info", true];
            };

            if !(_moveInConvoy) then {
                waitUntil {sleep 0.1; ((count (fullCrew [_vic, "cargo", false])) == 0) or (!alive _vic)};
                // playSound "beep";
                // _commander sideChat format ["%1 finished unloading, over", groupId _group];                
                sleep 2;
                (group _commander) setVariable ["setSpecial", false];
            };
            _vic setVariable ["pl_on_transport", nil];
            deleteMarker _markerName;
            sleep 10;

        }
        else
        {
            // Unload at Current Position when map closed
            _cargoGroups = [];
            doStop _vic;
            for "_i" from count waypoints (group _commander) - 1 to 0 step -1 do{
                deleteWaypoint [(group _commander), _i];
            };
            {
                _unit = _x select 0;
                unassignVehicle _unit;
                doGetOut _unit;
                _cargoGroups pushBack (group (_x select 0));
            } forEach _cargo;
            _cargoGroups = _cargoGroups arrayIntersect _cargoGroups;
            {
                // _x leaveVehicle _vic;
                _x setVariable ["pl_show_info", true];
                player hcSetGroup [_x];
                // _x addWaypoint [getPos _vic, 10];
            } forEach _cargoGroups;

            playSound "beep";
            // _commander sideChat format ["Roger, %1 beginning unloading, over", groupId _group];
            waitUntil {sleep 0.1; ((count (fullCrew [_vic, "cargo", false])) == 0) or (!alive _vic)};
            playSound "beep";
            // _commander sideChat format ["%1 finished unloading, over", groupId _group];
            _vic setVariable ["pl_on_transport", nil];
            (group _commander) setVariable ["setSpecial", false];
            _vic doFollow _vic;
        };
    };
