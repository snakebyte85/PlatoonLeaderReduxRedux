/*
Original name: pl_vehicle_group_check
New name:      KMD_fnc_vehicleGroupCheck
Original url: "Plmod\init.sqf"
*/
    private ["_vicArray"];
    {       
        _vicArray = [];
        {
            if (vehicle _x != _x) then {
                0 = _vicArray pushBackUnique (vehicle _x);
            };
        } forEach (units _x);

        if ((count _vicArray) > 1) exitWith {hint "There are Groups with more then ONE vehicle! Grouped up Vehicles are not recomended to use with High Command as it will lead to uncontrollable and unintended AI behaviour."};

    } forEach (allGroups select {side _x isEqualto playerSide}); 