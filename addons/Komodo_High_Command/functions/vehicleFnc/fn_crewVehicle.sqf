/*
Original name: pl_crew_vehicle
New name:      KMD_fnc_crewVehicle
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    private ["_group", "_vics", "_targetVic", "_crew", "_crewCap", "_groupLen"];
    _group = hcSelected player select 0;
    _groupLen = count (units _group);

    pl_vics = [];

    if (visibleMap) then {
        pl_show_vehicles_pos = getPos (leader _group);
        pl_show_vehicles = true;
        hint "Select VEHICLE on Map";
        onMapSingleClick {
            pl_mapClicked = true;
            _cords = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
            pl_vics = nearestObjects [_cords, ["Car", "Truck", "Tank", "Air"], 20, true];
            onMapSingleClick "";
            hintSilent "";
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
        
        if (_targetVic emptyPositions "Driver" > 0) then {
        
            if( _groupLen > _targetVic emptyPositions "" ) then {
                hint "Not enough avaiable seats!";
            } else {
        
                _targetVic setUnloadInCombat [false, false];

                _crew = [];
                _vicName = getText (configFile >> "CfgVehicles" >> typeOf _targetVic >> "displayName");
                playSound "beep";
                leader _group sideChat format ["Getting in %1", _vicName];
                pl_groups_getting_in set [netid _group, _targetVic];

                [_group] call KMD_fnc_reset;
                sleep 0.2;
                
                _group addVehicle _targetVic;

                if ((_targetVic emptyPositions "Gunner" > 0) and (_targetVic emptyPositions "Commander" == 0)) then {
                    if (_group != (group player)) then {
                        (leader _group) assignAsDriver _targetVic;
                        _crew pushBack (leader _group);
                    }
                    else
                    {
                        _unit = (units _group) select {_x != player} select 0;
                        _unit assignAsDriver _targetVic;
                        _crew pushBack _unit;
                    };
                    {
                        if !(_x in _crew) exitWith {
                            _x assignAsGunner _targetVic;
                            _crew pushBack _x;
                        };
                    } forEach ((units _group) select {_x != player});
                };

                if (_targetVic emptyPositions "Commander" > 0) then {
                    (leader _group) assignAsCommander _targetVic;
                    _crew pushBack (leader _group);
                    {
                        if !(_x in _crew) exitWith {
                            _x assignAsGunner _targetVic;
                            _crew pushBack _x;
                        };
                    } forEach (units _group);
                    {
                        if !(_x in _crew) exitWith {
                            _x assignAsDriver _targetVic;
                            _crew pushBack _x;
                        };
                    } forEach (units _group);
                }
                else
                { 
                    (leader _group) assignAsDriver _targetVic;
                    _crew pushBack (leader _group);
                };
                {
                    if !(_x in _crew) then {
                        _x assignAsCargo _targetVic;
                    };
                    [_x] allowGetIn true;
                    [_x] orderGetIn true;
                } forEach (units _group);
                
                _group setVariable ["onTask", true];
                waitUntil {sleep 0.1; ({_x in _targetVic} count (units _group) > 0) or !(_group getVariable ["onTask", true])};
                _group setVariable ["onTask", false];
                pl_groups_getting_in deleteAt (netid _group);
            };
        }
        else
        {
            hint "The selected vehicle has already a crew!";            
        };
    }
    else
    {
        playSound "beep";
        hint "No available Vehicle!";
    };
