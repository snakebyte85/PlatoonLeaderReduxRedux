/*
Original name: pl_crew_vehicle
New name:      KMD_fnc_crewVehicle
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    private ["_group", "_vics", "_targetVic", "_crew", "_crewCap", "_groupLen"];
    _group = hcSelected player select 0;
    _groupLen = count (units _group);


    if (visibleMap) then {
        pl_show_vehicles_pos = getPos (leader _group);
        pl_show_vehicles = true;
        onMapSingleClick {
            pl_mapClicked = true;
            _cords = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
            pl_vics = nearestObjects [_cords, ["Car", "Truck", "Tank", "Air"], 10, true];
            onMapSingleClick "";
        };
        while {!pl_mapClicked} do {sleep 0.1};
        pl_show_vehicles = false;
        pl_mapClicked = false;
    }
    else
    {
        pl_vics = [cursorTarget];
    };
    {
        _crewCap = [typeOf _x, true] call BIS_fnc_crewCount;
        if (_crewCap >= _groupLen) then {
            _targetVic = _x;
        };
        if (vehicle (leader _group) == _x) then {
            _targetVic = _x;
        };
    } forEach pl_vics;
    if !(isNil "_targetVic") then {

        _targetVic setUnloadInCombat [false, false];

        _crew = [];
        if (_targetVic emptyPositions "Driver" > 0) then {
            _vicName = getText (configFile >> "CfgVehicles" >> typeOf _targetVic >> "displayName");
            playSound "beep";
            leader _group sideChat format ["%1: Getting in %2", (groupId _group), _vicName];

            pl_left_vehicles = pl_left_vehicles - [[_group getVariable ["pl_group_left_vehicle", objNull], _group]];

            [_group] call KMD_fnc_reset;
            sleep 0.2;

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
        }
        else
        {
            {
                if (_x in (crew _targetVic)) then {
                    _crew pushBack _x;
                };
            } forEach (units _group);
            _groupLen = _groupLen - count _crew;
            _cargoCap = _crewCap - (count (crew _targetVic));  
            if (_cargoCap >= _groupLen) then {
                {
                    if !(_x in (crew _targetVic)) then {
                        _x assignAsCargo _targetVic;
                        [_x] allowGetIn true;
                        [_x] orderGetIn true;
                    };
                    // else
                    // {
                    //     [_x] allowGetIn true;
                    //     [_x] orderGetIn true;
                    // }; 
                } forEach (units _group);
            }
            else
            {
                // playSound "beep";
                hint "Not enough avaiable seats!";
            };
        };
    }
    else
    {
        // playSound "beep";
        hint "No avaiable Transport!";
    };