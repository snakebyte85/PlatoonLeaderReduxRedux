/*
Original name: pl_leave_vehicle
New name:      KMD_fnc_leaveVehicle
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    params ["_group"];
    private ["_vics"];

    _vics = assignedVehicles _group;
    
    if( count _vics > 0) then {         
        {
            _vic = _x;
            _is_crew = false;
            {
                _role = "";
                if( !isNil{(assignedVehicleRole _x) param[0]}) then {
                    _role = (assignedVehicleRole _x) select 0;
                };
                if( _role == "driver" || _role == "commander") then {
                    _is_crew = true;
                };
            
            } forEach units _group;
            
            _group leaveVehicle _vic;
            
            // if crew leave the vehicle, make sure the cargo of that vic disembark
            if( _is_crew) then {
                {
                    (_x select 0) leaveVehicle _vic;
                } forEach fullCrew [_vic, "cargo", false];
            }
            
        } forEach _vics;
        
        _group setVariable ["setSpecial", false];
        _group setVariable ["onTask", false];
    };
