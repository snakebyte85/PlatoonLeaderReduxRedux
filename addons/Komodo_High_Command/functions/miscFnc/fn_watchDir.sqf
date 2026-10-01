/*
Original name: pl_watch_dir
New name:      KMD_fnc_watchDir
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    params ["_group"];
    private ["_watchPos"];

    _cords = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
    _groupPos = getPos (leader _group);
    _watchDir = [_cords, _groupPos] call BIS_fnc_dirTo;
    _group setFormDir _watchDir;
    _watchDir = [(_watchDir - 180)] call KMD_fnc_angleSwitcher;
    _watchPos = [1000*(sin _watchDir), 1000*(cos _watchDir), 0] vectorAdd _groupPos;
    {
        _x doWatch _watchPos;
    } forEach (units _group);

    playSound "beep";