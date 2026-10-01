/*
Original name: (Called directly in the file)
New name:      KMD_fnc_repKilledEh
Original url: "Plmod\pl_repair_fnc.sqf"
*/
if !(pl_enable_vehicle_recovery) exitWith {};

addMissionEventHandler ["EntityKilled",{
    params ["_killed", "_killer", "_instigator", "_useEffects"];
    if (_killed isKindOf "Man" or _killed isKindOf "Air") exitWith {};
    if ((side (group (driver _killed))) isEqualTo playerSide) then {
        if (_killed getVariable ["pl_repair_lifes", 0] > 0) then {

            _groupId = groupId group driver _killed;
            playSound "beep";
            driver _killed sideChat format ["%1 has been disabled!", _groupId];

            _crew = crew _killed;

            _crewClassName = getText (configFile >> "CfgVehicles" >> typeOf _killed >> "crew");
            {
                if (typeOf _x isEqualTo _crewClassName) then {
                    deleteVehicle _x;
                }
                else
                {
                    [_x, _killed] call KMD_fnc_crewEject;
                };
            } forEach _crew;

            _pos = getPosATLVisual _killed;
            _dir = getDir _killed;
            _type = typeOf _killed;
            _appereance = _killed getVariable "pl_appereance";
            _loadout = _killed getVariable "pl_vic_inv";
            _lives = _killed getVariable "pl_repair_lifes";

            deleteVehicle _killed;

            [_type, _pos, _dir, _appereance, _loadout, _groupId, _lives] spawn KMD_fnc_createNewVic;
            
        }
        else
        {
            _groupId = groupId group driver _killed;
            playSound "beep";
            player sideChat format ["%1 has been destroyed", _groupId];
        };
    };
}];
