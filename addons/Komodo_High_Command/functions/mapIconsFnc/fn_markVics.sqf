/*
Original name: pl_mark_vics
New name:      KMD_fnc_markVics
Original url: "Plmod\pl_map_icons.sqf"
*/
	findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","
        _display = _this#0;
        if (hcShownBar and pl_show_vehicles) then {
            {                  
                _vic = _x;
                if ((_vic isKindOf 'Car') || (_vic isKindOf 'Tank') || (_vic isKindOf 'Air') || (_vic isKindOf 'Ship')) then {
                    _empty_vic = (count crew _vic == 0);
                    if( (_empty_vic && _vic distance2D pl_show_vehicles_pos < 500) || 
                        (!_empty_vic && (side _vic) isEqualTo playerSide) ) then {                        
                            _icon = getText (configfile >> 'CfgVehicles' >> typeof _vic >> 'icon');
                            _size = 30;
                            _color = [0.9,0.9,0,1];
                            if ( !_empty_vic ) then {
                                _color = [side _x] call KMD_fnc_sideToColor;
                            };
                            
                            _display drawIcon [
                                _icon,
                                _color,
                                getPosVisual _vic,
                                _size,
                                _size,
                                getDirVisual _vic
                            ];
                            
                            _displayNameText = format ['  %1', getText (configFile >> 'CfgVehicles' >> typeOf _vic >> 'displayName')];
                            _display drawIcon [
                                '#(rgb,4,1,1)color(1,1,1,0)',
                                _color,
                                getPosVisual _vic,
                                25,
                                25,
                                0,
                                _displayNameText,
                                0,
                                0.03,
                                'TahomaB',
                                'right'
                                ];
                    };
                };
            } forEach vehicles;
        };
    "];
