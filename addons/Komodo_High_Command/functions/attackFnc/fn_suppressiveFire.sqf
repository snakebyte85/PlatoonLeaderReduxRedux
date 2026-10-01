/*
Original name: pl_suppressive_fire
New name:      KMD_fnc_suppressiveFire
Original url: "Plmod\pl_attack_fnc.sqf"
*/

	params ["_units"];
    private ["_pos", "_time", "_target", "_leader", "_alt", "_aimPos"];

    _target = cursorTarget;
    _leader = leader (group (_units select 0));
    if (isNull _target) then {
        if (visibleMap) then {
            _pos = (findDisplay 12 displayCtrl 51) posScreenToWorld getMousePosition;
            _targetHouse = nearestTerrainObjects [_pos, ["BUILDING", "HOUSE", "BUNKER", "FORTRESS"], 10, true, true];
            if (count _targetHouse == 0) then {
                _pos = AGLToASL _pos;
                if (vehicle _leader != _leader) then {
                     _vic = vehicle _leader;
                     _leader = crew _vic select 1;
                     _aimPos = aimPos _leader
                }
                else
                {
                    _aimPos = getPosASL _leader;
                };
                _cansee = [objNull, "FIRE"] checkVisibility [getPosASL _leader, _pos];
                _alt = 0;
                while {_cansee < 0.8} do {
                    _pos = [_pos select 0, _pos select 1, (_pos select 2) + 2];
                    _cansee = [objNull, "FIRE"] checkVisibility [_aimPos, _pos];
                    _alt = _alt + 1;
                    if (_alt > 10) exitWith{};
                };
                _target = _pos;  
            }
            else
            {
                _target = _targetHouse select 0;
            };
        }
        else
        {
            _pos = screenToWorld [0.5,0.5];
            _pos = AGLToASL _pos;
            if (vehicle _leader != _leader) then {
                 _vic = vehicle _leader;
                 _leader = crew _vic select 1;
                 _aimPos = aimPos _leader
            }
            else
            {
                _aimPos = getPosASL _leader;
            };
            _cansee = [objNull, "FIRE"] checkVisibility [getPosASL _leader, _pos];
            _alt = 0;
            while {_cansee < 0.8} do {
                _pos = [_pos select 0, _pos select 1, (_pos select 2) + 2];
                _cansee = [objNull, "FIRE"] checkVisibility [_aimPos, _pos];
                _alt = _alt + 1;
                if (_alt > 10) exitWith{};
            };
            _target = _pos;
        };
        {
            if (vehicle _x != _x) exitWith {
                _vic = vehicle _x;
                _gunner = {
                    if (((assignedVehicleRole _x) select 0) isEqualTo "Turret") exitWith {_x};
                    objNull
                } forEach (crew _vic);
                _gunner doSuppressiveFire _target;
                sleep 3;
                // for "_i" from 0 to 6 do {
                //     [_vic, "HE"] call BIS_fnc_fire;
                //     sleep 0.2;
                // };
            };
            _x doSuppressiveFire _target;
        } forEach _units;
    }
    else
    {
        {
            if (vehicle _x != _x) exitWith {
                _vic = vehicle _x;
                _gunner = {
                    if (((assignedVehicleRole _x) select 0) isEqualTo "Turret") exitWith {_x};
                    objNull
                } forEach (crew _vic);
                _gunner doSuppressiveFire _target;
                sleep 3;
                // for "_i" from 0 to 6 do {
                //     [_vic, "HE"] call BIS_fnc_fire;
                //     sleep 0.2;
                // };
            };
            _x doSuppressiveFire _target;
        } forEach _units;
    };