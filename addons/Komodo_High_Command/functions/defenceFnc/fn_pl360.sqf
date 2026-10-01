/*
Original name: pl_360
New name:      KMD_fnc_pl360
Original url: "Plmod/pl_defence_fnc.sqf"
*/

    params ["_group", "_pos", "_radius"];
    // private ["_radius"];
    _count = count (units _group);
    // _radius = 10;
    _diff = 360/_count;
    _movePos = [];
    for "_i" from 0 to (_count - 1) do {
        _degree = 1 + _i*_diff;
        _newPos = [_radius*(sin _degree), _radius*(cos _degree), 0] vectorAdd _pos;
        _watchPos = [100*(sin _degree), 100*(cos _degree), 0] vectorAdd _pos;
        _movePos pushBack [_newPos, _watchPos];
    };

    for "_i" from 0 to (_count - 1) do {
        [(units _group) select _i, _movePos select _i] spawn KMD_fnc_moveTo360;
    };