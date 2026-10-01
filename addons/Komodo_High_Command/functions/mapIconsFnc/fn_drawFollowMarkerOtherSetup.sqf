/*
Original name: pl_draw_follow_marker_other_setup
New name:      KMD_fnc_drawFollowMarkerOtherSetup
Original url: "Plmod\pl_map_icons.sqf"
*/
    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","
        _display = _this#0;
        if (hcShownBar) then {
            {
                _pos1 = getPos (leader _x);
                _pos2 = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
                _display drawLine [
                    _pos1,
                    _pos2,
                    [0.9,0.9,0,1]
                    ];
            } forEach pl_follow_array_other_setup;
        };
    "]; 
