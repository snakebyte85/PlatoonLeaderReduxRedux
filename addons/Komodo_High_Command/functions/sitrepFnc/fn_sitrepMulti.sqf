/*
Original name: pl_sitrep_multi
New name:      KMD_fnc_sitrepMulti
Original url: "Plmod\pl_sitrep_fnc.sqf"
*/

	params ["_groups"];
    private ["_strengthAll", "_groupInfo", "_targetsAll", "_message"];

    _strengthAll = 0;
    _targetsAll = [];
    _targets =  [];
    _groupInfo = [];
    _message = "<t color='#004c99' size='1.5' align='center' underline='1'>SITREP</t>";
    {
        _group = _x;
        _callsign = groupId _group;
        _strength = count (units _group);
        _strengthAll = _strengthAll + _strength;
        _healthState = ([_group] call KMD_fnc_groupHealthHex) select 1;
        _ammoState = [_group] call KMD_fnc_getAmmoGroupState;

        _taskIcon = "";
        _onTask = _group getVariable "onTask";
        if (_onTask) then {
            _taskIcon = _group getVariable 'specialIcon';
        };

        _contactIconColor = "#66ff33";
        _inContact = _group getVariable 'inContact';
        if (_inContact) then {
            _contactIconColor = "#b20000";
        };

        _statusColor = "#66ff33";
        _statusIcon = '\A3\ui_f\data\igui\cfg\simpleTasks\types\listen_ca.paa';
        _behaviour = behaviour (leader _group);
        if (_behaviour isEqualTo 'COMBAT') then {
            _statusColor = "#b20000";
            _statusIcon = '\A3\ui_f\data\igui\cfg\simpleTasks\types\danger_ca.paa';
        };
        if (_behaviour isEqualTo 'STEALTH') then {
            _statusColor = '#004c99';
            _statusIcon = '\A3\ui_f\data\igui\cfg\simpleTasks\types\scout_ca.paa';
        };
        if (_behaviour isEqualTo 'SAFE') then {
            _statusColor = "#cccccc";
            _statusIcon = '\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa';
        };

        _groupStatus = [_statusColor, _statusIcon];

        _groupInfo pushBack [_callsign, _strength, _healthState, _ammoState, _taskIcon, _contactIconColor, _groupStatus];

        _targets = [(leader _group)] call pl_get_targets;
        _targetsAll append _targets;
    } forEach _groups;

    _targetsAll = _targetsAll arrayIntersect _targetsAll;

    if (pl_sitrep_multi_cd < time) then {
        [_targetsAll] spawn KMD_fnc_markTargetsOnMap;
        [_targetsAll, player] call KMD_fnc_revealTargets;
        pl_sitrep_multi_cd = time + 30;
    };
    _targetsAmount = count _targetsAll;

    _message = _message + format ["
    <br /><br />
    <t color='#ffffff' size='1' align='left'>Strength:</t><t color='#ffffff' size='1' align='right'>%1x</t>
    <br /><br />
    <t color='#ffffff' size='1' align='left'>Contacts:</t><t color='#ffffff' size='1' align='right'>%2x</t>
    <br /><br />
    <t color='#ffffff' size='1.1' align='center' underline='1'>Units:</t>", _strengthAll, _targetsAmount];
    {
        _callsign = _x select 0;
        _strength = _x select 1;
        _healthState = _x select 2;
        _ammoState = _x select 3;
        _taskIcon = _x select 4;
        _contactColor = _x select 5;
        _groupStatus = _x select 6;

        _message = _message + format ["
        <br />
        <t color='#004c99' size='1' align='left'>%1</t>
        <img color='#e5e500' align='right' image='%2'/>
        <img color='%3' align='right' image='\A3\ui_f\data\igui\cfg\simpleTasks\types\target_ca.paa'/>
        <img color='%4' align='right' image='%5'/>
        <br />
    <t color='#cccccc' size='0.9' align='left'>Strength: </t><t color='%6' size='0.9' align='left'>%7</t>
    <t color='#cccccc' size='0.9' align='right'>Ammo: </t><t color='%8' size='0.9' align='right'>%9</t>",
    _callsign, _taskIcon, _contactColor, _groupStatus select 0, _groupStatus select 1, _healthState,
    _strength, _ammoState select 1, _ammoState select 0];

} forEach _groupInfo;

hint parseText _message;