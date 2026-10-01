/*
Original name: pl_draw_building_search_marker
New name:      KMD_fnc_drawBuildingSearchMarker
Original url: "Plmod\pl_map_icons.sqf"
*/

findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","
        _display = _this#0;
        if (hcShownBar) then {
            {
                _group = _x select 0;
                _building = _x select 1;
                _pos1 = getPos (leader _group);
                _pos2 = getPos _building;
                _display drawLine [
                    _pos1,
                    _pos2,
                    [0.9,0.9,0,1]
                    ];
            } forEach pl_draw_building_array;
        };
    "];