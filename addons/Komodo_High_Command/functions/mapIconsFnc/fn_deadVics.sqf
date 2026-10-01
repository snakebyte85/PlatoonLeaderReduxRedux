/*
Original name: pl_dead_vics
New name:      KMD_fnc_deadVics
Original url: "Plmod\pl_map_icons.sqf"
*/
    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","
        _display = _this#0;
        if (hcShownBar and pl_show_dead_vehicles) then {
            {
                _vic = _x #1;
                _icon = getText (configfile >> 'CfgVehicles' >> typeof _vic >> 'icon');
                _size = 30;
                _display drawIcon [
                    _icon,
                    [0.7,0,0,1],
                    getPosVisual _vic,
                    _size,
                    _size,
                    getDirVisual _vic
                ]
            } forEach pl_destroyed_vics_data;
        };
    "];