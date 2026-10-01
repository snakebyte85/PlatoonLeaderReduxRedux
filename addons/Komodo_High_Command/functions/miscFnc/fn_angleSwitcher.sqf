/*
Original name: pl_angle_switcher
New name:      KMD_fnc_angleSwitcher
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    params ["_a"];
    if (_a > 360) then {
        _a = _a - 360;
    }
    else
    {
        _a = _a + 360;
    };
    _a