/*
Original name: pl_draw_bounding_line
New name:      KMD_fnc_drawBoundingLine
Original url: "Plmod\pl_map_icons.sqf"
*/
	findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","
        _display = _this#0;
        if (hcShownBar) then {
            {
                _pos1 = getPos (leader (_x select 0));
                _pos2 =_x select 1;
                _display drawArrow [
                    _pos1,
                    _pos2,
                    [0.9,0.9,0,1]
                    ];
            } forEach pl_bounding_draw_array;
        };
    "];