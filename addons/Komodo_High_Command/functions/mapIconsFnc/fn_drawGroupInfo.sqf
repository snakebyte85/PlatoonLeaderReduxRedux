/*
Original name: pl_draw_group_info
New name:      KMD_fnc_drawGroupInfo
Original url: "Plmod\pl_map_icons.sqf"
*/
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw","
        _display = _this#0;
        {
            if (hcShownBar and (_x getVariable 'pl_show_info')) then {
                if ((getText (configFile >> 'CfgVehicles' >> typeOf (units _x select 0)>> 'displayName')) isEqualTo 'Game Logic') exitWith {};
                {
                    _unit = _x;
                    _icon = getText (configfile >> 'CfgVehicles' >> typeof _unit >> 'icon');
                    _size = 15;
                    _unitColor = [0,0.3,0.6,0.65];
                    if (_unit getVariable 'pl_is_ccp_medic' and (alive _unit)) then {
                        _unitColor = [0.4,1,0.2,0.65];
                    };
                    if (_unit getVariable 'pl_wia') then {
                        _unitColor = [0.7,0,0,0.65];
                    };
                    if (vehicle _unit == _unit and (alive _unit)) then {
                        _display drawIcon [
                            _icon,
                            _unitColor,
                            getPosVisual _unit,
                            _size,
                            _size,
                            getDirVisual _unit
                        ];
                    };
                } forEach (units _x);


                _worldSizeX = round (worldSize * 0.03);
                _worldSizeY = round (worldSize * 0.02);
                _mapScale = ctrlMapScale (_this select 0);
                _mapscaleX = _mapScale * _worldSizeX;
                _mapScaleY = _mapScale * _worldSizeY;
                _pos = getPosVisual (leader _x);


                _callsignText = format ['  %1', groupId _x];
                if (count (units _x) == 1 and _x != (group player)) then {
                    _unitMos = getText (configFile >> 'CfgVehicles' >> typeOf (units _x select 0)>> 'displayName');
                    if ((vehicle (units _x select 0)) != (units _x select 0)) then {
                        _unitMos = getText (configFile >> 'CfgVehicles' >> typeOf (vehicle (units _x select 0))>> 'displayName');
                        if ((vehicle (units _x select 0)) isKindOf 'Air') then {
                            _unitMos = groupId _x;
                        };
                    };
                    _callsignText = format ['  %1', _unitMos];
                };
                _display drawIcon [
                    '#(rgb,4,1,1)color(1,1,1,0)',
                    [0,0.3,0.6,1],
                    _pos,
                    25,
                    25,
                    0,
                    _callsignText,
                    0,
                    0.03,
                    'TahomaB',
                    'right'
                    ];

                _strength = count (units _x);
                _healthColor = [_x] call KMD_fnc_getGroupHealth;
                _strengthText = format ['%1  ', _strength];
                _display drawIcon [
                    '#(rgb,4,1,1)color(1,1,1,0)',
                    _healthColor,
                    _pos,
                    25,
                    25,
                    0,
                    _strengthText,
                    1,
                    0.03,
                    'TahomaB',
                    'left'
                ];


                _contactIcon = '\A3\ui_f\data\igui\cfg\simpleTasks\types\target_ca.paa';
                _contactPos = [(_pos select 0) - _mapscaleX, (_pos select 1) - _mapScaleY];
                _contactColor = [0.4,1,0.2,1];
                _x setVariable ['inContact', false];
                _time = (_x getVariable 'PlContactTime') - 30;
                if (_x getVariable ['pl_hold_fire', false]) then {
                    _contactColor = [0.1,0.1,0.6,1];
                };
                if (_time > time) then {
                    _contactColor = [0.7,0,0,1];
                    _x setVariable ['inContact', true];
                };
                _display drawIcon [
                    _contactIcon,
                    _contactColor,
                    _contactPos,
                    15,
                    15,
                    0,
                    '',
                    2
                ];


                _behaviourPos = [(_pos select 0) + _mapscaleX, (_pos select 1) - _mapScaleY];
                _behaviour = behaviour (leader _x);
                _setSpecial = _x getVariable 'setSpecial';
                _specialIcon = _x getVariable 'specialIcon';
                _color = [0.4,1,0.2,1];
                _icon = '\A3\ui_f\data\igui\cfg\simpleTasks\types\listen_ca.paa';
                if (_behaviour isEqualTo 'COMBAT') then {
                    _color = [0.7,0,0,1];
                    _icon = '\A3\ui_f\data\igui\cfg\simpleTasks\types\danger_ca.paa';
                };
                if (_behaviour isEqualTo 'STEALTH') then {
                    _color = [0.1,0.1,0.6,1];
                    _icon = '\A3\ui_f\data\igui\cfg\simpleTasks\types\scout_ca.paa';
                };
                if (_behaviour isEqualTo 'SAFE') then {
                    _color = [0.9,0.9,0.9,1];
                    _icon = '\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa';
                };
                _display drawIcon [
                    _icon,
                    _color,
                    _behaviourPos,
                    15,
                    15,
                    0,
                    '',
                    2
                ];


                if (_setSpecial) then {
                    _posOffset = _mapscaleX + (_mapscaleX * 0.85);
                    _specialPos = [(_pos select 0) + _posOffset, (_pos select 1) - _mapScaleY];
                    _color = [0.9,0.9,0,1];
                    _display drawIcon [
                        _specialIcon,
                        _color,
                        _specialpos,
                        15,
                        15,
                        0,
                        '',
                        2
                    ];
                };

                
            };
        } forEach (allGroups select {side _x isEqualTo playerSide});
    "];