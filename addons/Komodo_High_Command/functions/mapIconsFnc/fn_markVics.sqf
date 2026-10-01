/*
Original name: pl_mark_vics
New name:      KMD_fnc_markVics
Original url: "Plmod\pl_map_icons.sqf"
*/
	findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","
        _display = _this#0;
        if (hcShownBar and pl_show_vehicles) then {
            {
                if ((_x distance2D pl_show_vehicles_pos < 150) or (_x isKindOf 'Air')) then {
                    if (((side _x) isEqualTo playerSide) or ((side _x) isEqualTo civilian)) then {
                        if ((_x isKindOf 'Tank') or (_x isKindOf 'Car') or (_x isKindOf 'Air') or (_x isKindOf 'Truck')) then {
                            _vic = _x;
                            _icon = getText (configfile >> 'CfgVehicles' >> typeof _vic >> 'icon');
                            _size = 30;
                            _display drawIcon [
                                _icon,
                                [0.9,0.9,0,1],
                                getPosVisual _vic,
                                _size,
                                _size,
                                getDirVisual _vic
                            ]
                        };
                    };
                };
            } forEach vehicles;
        };
    "];