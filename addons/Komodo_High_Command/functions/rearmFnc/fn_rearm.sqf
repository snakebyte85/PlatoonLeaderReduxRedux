/*
Original name: pl_rearm
New name:      KMD_fnc_rearm
Original url: "Plmod\pl_rearm_fnc.sqf"
*/
params ["_unit", "_target"];

    if !(isNull _target) then {
        if (_unit getVariable "pl_wia") exitWith {};
        createMarker ["sup_zone_marker", (getPos _target)];
        "sup_zone_marker" setMarkerType "b_support";
        "sup_zone_marker" setMarkerText "Supply Point";

        _unit disableAI "AUTOCOMBAT";
        _unit doMove (position _target);
        _unit moveTo (position _target);

        waitUntil {sleep 0.1; ((_unit distance2D  _target) < 8) or !((group _unit) getVariable ["onTask", true])};
        _unit action ["rearm",_target];
        0 = [_unit, "Rearming..."] remoteExecCall ["groupChat",[0,-2] select isDedicated,false];
        sleep 1;
        if ((secondaryWeapon _unit) != "") then {
            sleep 3;
            _unit action ["rearm",_target];
            0 = [_unit, "Rearming..."] remoteExecCall ["groupChat",[0,-2] select isDedicated,false];
        };

        _unit enableAI "AUTOCOMBAT";

        _time = time + 20;
        waitUntil {sleep 0.1; (time > _time) or !((group _unit) getVariable ["onTask", true])};
        deleteMarker "sup_zone_marker";
        (group _unit) setVariable ["setSpecial", false];
        (group _unit) setVariable ["onTask", true];
    };