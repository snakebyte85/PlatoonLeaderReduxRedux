/*
Original name: pl_draw_defence_line
New name:      KMD_fnc_drawDefenceLine
Original url: "Plmod\pl_map_icons.sqf"
*/
    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","
        _display = _this#0;
        if (hcShownBar) then {
            {
                _pos1 = getMarkerPos (_x select 0);
                _pos2 = getPos (_x select 1);
                _display drawLine [
                    _pos1,
                    _pos2,
                    [0.9,0.9,0,1]
                    ];
            } forEach pl_denfence_draw_array;
        };
    "]; 
