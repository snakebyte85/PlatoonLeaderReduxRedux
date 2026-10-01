/*
Original name: pl_spawn_getOut_vehicle
New name:      KMD_fnc_spawnGetOutVehicle
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    params [["_moveInConvoy", false]];
    playSound "beep";
    private _convoyArray = [];
    private _oneVicIsAirKind = false;
    {
        if (vehicle (leader _x) != leader _x) then {
            _vic = vehicle (leader _x);
            _group = group (driver _vic);
            _convoyArray pushBack _group;
            if(_vic isKindOf "Air") then {
                _oneVicIsAirKind = true;
            };
        };
    } forEach hcSelected player;

    _convoyArray = _convoyArray arrayIntersect _convoyArray;
    if (_moveInConvoy and ((count _convoyArray) < 2)) exitWith {
        playSound "beep";
        (leader (hcSelected player select 0)) sidechat "Not enough vehicles to form a Convoy";
    };
    
    if (_moveInConvoy and _oneVicIsAirKind) exitWith {
        playSound "beep";
        hint "Can't use air vehicles in a convoy";
    };
    
    if ((count _convoyArray) > 1 && _oneVicIsAirKind) exitWith {
        playSound "beep";
        hint "Can't unload multiple air vehicles at the same time.";
    };
    
    _convoyId = str (random 2);
    c_test_id = _convoyId;
    missionNamespace setVariable [_convoyId, _convoyArray];
    missionNamespace setVariable [_convoyId + "pos", 0];
    missionNamespace setVariable [_convoyId + "time", 0];
    {
        [_x, _convoyId, _moveInConvoy] spawn KMD_fnc_getOutVehicle;
        // sleep 0.1;
    } forEach hcSelected player;  
