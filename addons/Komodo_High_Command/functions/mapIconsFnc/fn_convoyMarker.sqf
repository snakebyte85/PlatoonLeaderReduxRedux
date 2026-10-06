/*
Original name: pl_convoy_marker
New name:      KMD_fnc_convoyMarker
Original url: "Plmod\pl_map_icons.sqf"
*/
    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","
        _display = _this#0;
        if (hcShownBar) then {
            {
                _convoy = _x;
                {
                    if (_x != (_convoy select 0) and _x getVariable 'pl_draw_convoy') then {
                        _convoyPos = _convoy find _x;
                        _pos1 = getPos (leader _x);
                        _pos2 = getPos (leader (_convoy select (_convoyPos -1)));
                        _display drawLine [
                            _pos1,
                            _pos2,
                            [0.9,0.9,0,1]
                        ];
                    };
                } forEach _convoy;
            } forEach pl_draw_convoy_array;
        };
    "];
