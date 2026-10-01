/*
Original name: (Called directly in the file)
New name:      KMD_fnc_disableHcElements
Original url: "Plmod\pl_disable_hc_elements.sqf"
*/

_time = time + 5;

waitUntil {time > _time};

// disable Pointless Tolltip
onGroupIconOverEnter {scriptname "HC: onGroupIconOverEnter";
    if !(hcshownbar) exitwith {};

    _is3D = _this select 0;
    _group = _this select 1;
    _wpID = _this select 2;
    _posx = _this select 3;
    _posy = _this select 4;
    _logic = player getvariable "BIS_HC_scope";

    if (_wpID < 0) then {
        _logic setvariable ["groupover",_group];
        _logic setvariable ["wpover",[grpnull]];
    } else {
        if (_group in hcallgroups player && !(_logic getvariable "LMB_hold")) then {
            _logic setvariable ["groupover",grpnull];
            _logic setvariable ["wpover",[_group,_wpID]];
        };
    };

};