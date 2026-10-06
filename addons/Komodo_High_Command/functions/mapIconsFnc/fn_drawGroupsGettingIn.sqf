/*
Original name: pl_draw_left_vehicles
New name:      KMD_fnc_drawLeftVehicles
Original url: "Plmod\pl_map_icons.sqf"
*/
    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","
        _display = _this#0;
        if (hcShownBar) then {
            {
                _group = groupFromNetId _x;
                _vic = _y;
                _empty_vic = (count crew _vic == 0);
                _pos1 = getPos leader _group;
                _pos2 = getPos _vic;
                _color = [0.9,0.9,0,1];
                if ( !_empty_vic ) then {
                    _color = [side _group] call KMD_fnc_sideToColor;
                };
                _display drawLine [
                    _pos1,
                    _pos2,
                    _color
                    ];                
                _icon = getText (configfile >> 'CfgVehicles' >> typeof _vic >> 'icon');
                _size = 25;
                _display drawIcon [
                    _icon,
                    _color,
                    getPosVisual _vic,
                    _size,
                    _size,
                    getDirVisual _vic
                ]
            } forEach pl_groups_getting_in;
        };
    "]; 
