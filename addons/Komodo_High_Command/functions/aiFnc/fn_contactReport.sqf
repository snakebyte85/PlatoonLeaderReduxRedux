/*
Original name: pl_contact_report
New name:      KMD_fnc_contactReport
Original url: "Plmod\pl_ai_fnc.sqf"
*/
params ["_group", "_inTransport"];

_leader = leader _group;
_leader setVariable ["PlContactRepEnabled", true];
_group setVariable ["PlContactTime", 0];
if !(_inTransport) then {
    if (vehicle _leader != _leader) then {
        _leader = vehicle _leader;
    };
};

if (_leader != player) then {
    _leader addEventHandler ["FiredNear", {
        params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];

        if ((group _firer) isEqualTo (group _unit)) then {
        	if (((group _unit) getVariable "PlContactTime") < time) then {
                    _callsign = groupId (group _unit);
                        if ((vehicle _unit) isKindOf "Air") then {
                            playSound "beep";
                            _unit sideChat format ["%1: Engaging Ground Targets", _callsign];
                        }
                        else
                        {
                            playSound "beep";
                            _unit sideChat format ["%1: Engaging Enemies", _callsign];
                        };
                        [_unit] spawn KMD_fnc_contactInfoShare;
                        (group _unit) setVariable ['inContact', true];
                };
                (group _unit) setVariable ["PlContactTime", (time + 60)];
                if ("launch" in (_weapon splitString "_")) then {
                    if (pl_At_fire_report_cd < time) then {
                        pl_At_fire_report_cd = time + 5;
                        _callsign = groupId (group _unit);
                        _unit sideChat format ["%1: Engaging Vehicles with AT", _callsign];
                    };
                };
            };
            if !(alive _unit) then {
                _unit setVariable ["PlContactRepEnabled", false];
            };
        }];
};