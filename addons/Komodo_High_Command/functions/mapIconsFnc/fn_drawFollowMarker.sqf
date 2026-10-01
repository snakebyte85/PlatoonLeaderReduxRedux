/*
Original name: pl_draw_follow_marker
New name:      KMD_fnc_drawFollowMarker
Original url: "Plmod\pl_map_icons.sqf"
*/
    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","
        _display = _this#0;
        if (hcShownBar and pl_follow_active) then {
            {
                _group = _x;
                _pos1 = getPos (leader _group);
                _pos2 = getPos player;
                _display drawLine [
                    _pos1,
                    _pos2,
                    [0.9,0.9,0,1]
                    ];
            } forEach pl_follow_array;
        };
    "];