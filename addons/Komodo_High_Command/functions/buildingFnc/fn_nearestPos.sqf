/*
Original name: pl_nearest_pos
New name:      KMD_fnc_nearestPos
Original url: "Plmod\pl_building_fnc.sqf"
*/
    params ["_targets", "_buildPos"];
    private ["_returnPos", "_d", "_r"];

    _returnPos = [];
    {
        _d = 1000;
        _t = _x;
        {
            _p = _x;
            _b = (_t distance2D _p);
            if (_b < _d) then {
                _r = _p;
                _d = _b;
            };
        } forEach _buildPos;
        _returnPos pushBack _r;
        // player sideChat str _r;
    } forEach _targets;
    _returnPos = [_returnPos, [], {_x#2}, "ASCEND"] call BIS_fnc_sortBy;
    _returnPos