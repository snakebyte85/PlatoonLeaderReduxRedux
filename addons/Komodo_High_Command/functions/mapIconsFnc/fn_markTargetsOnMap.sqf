/*
Original name: pl_mark_targets_on_map
New name:      KMD_fnc_markTargetsOnMap
Original url: "Plmod\pl_map_icons.sqf"
*/
    params ["_targets"];
    _markers = [];
    _markerTargets = [];
    _time = time + 60;
    {
        if !(_x in pl_marker_targets) then {
            if (alive _x and (side _x) != civilian) then {
                if (_x isKindOf "Man" or _x isKindOf "Tank" or _x isKindOf "Car" or _x isKindOf "Truck") then {
                    _pos = getPos _x;
                    _markerName = str _x;
                    _markerSize = 0.3;
                    _marker = createMarker [_markerName, _pos];
                    _markerName setMarkerType "o_unknown";
                    if (_x isKindOf "Tank") then {
                        _markerName setMarkerType "o_armor";
                        _markerSize = 0.8;
                    };
                    if (_x isKindOf "Car") then {
                        _markerName setMarkerType "o_motor_inf";
                        _markerSize = 0.5;
                    };
                    _markerName setMarkerColor "ColorRed";
                    _markerName setMarkerSize [_markerSize, _markerSize];
                    // _markerName setMarkerText str (parseText _markerText);
                    _markers pushBack _markerName;
                    _markerTargets pushBack _x;
                    pl_marker_targets pushBack _x;
                };
            };
        };
    } forEach _targets;

    waitUntil {time >= _time};
    {
        deleteMarker _x;
    } forEach _markers;
    pl_marker_targets = pl_marker_targets - _markerTargets; 
