/*
Original name: pl_spawn_rearm
New name:      KMD_fnc_spawnRearm
Original url: "Plmod\pl_rearm_fnc.sqf"
*/
private ["_box", "_magAmount"];
    {
        if (vehicle (leader _x) != leader _x) exitWith {hint "Infantry ONLY Task!"};
        if (visibleMap) then {
            _cords = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
            _supplies = _cords nearSupplies 100;
            _magAmount = 0;

            if (count _supplies > 0) then {
                {
                    if !(_x isKindOf "Man") then {
                        _cargo = magazineCargo _x;
                        if (count _cargo > _magAmount) then {
                            _magAmount = count _cargo;
                            _box = _x;
                        };
                    };
                } forEach _supplies;

                [_x] call KMD_fnc_reset;
                sleep 0.2;

                playSound "beep";

                _x setVariable ["setSpecial", true];
                _x setVariable ["onTask", true];
                _x setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa"];    
            
                _boxName = getText (configFile >> "CfgVehicles" >> typeOf _box >> "displayName");
                playSound "beep";
                (leader _x) sideChat format ["%1: Resupplying at %2", (groupId _x), _boxName];

                {
                    [_x, _box] spawn pl_rearm; 
                } forEach units _x;
            }
            else
            {
                playSound "beep";
                leader _x sideChat "Negativ, There are no avaiable Supplies, Over";
            };
        }
        else
        {
            _supplies = cursorTarget nearSupplies 10;
            if (count _supplies > 0) then {
                _box = cursorTarget;
                if !(_box isKindOf "Man") then {

                    [_x] call KMD_fnc_reset;
                    sleep 0.2;

                    _x setVariable ["setSpecial", true];
                    _x setVariable ["onTask", true];
                    _x setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa"];
                    _boxName = getText (configFile >> "CfgVehicles" >> typeOf _box >> "displayName");
                    playSound "beep";
                    (leader _x) sideChat format ["%1: Resupplying at %2", (groupId _x), _boxName];
                    {
                        [_x, _box] spawn pl_rearm; 
                    } forEach units _x;
                }
                else
                {
                    // playSound "beep";
                    hint "No avaiable Supplies!";
                };
            }
            else
            {
                // playSound "beep";
                hint "No avaiable Supplies!";
            };
        };

    } forEach hcSelected player;