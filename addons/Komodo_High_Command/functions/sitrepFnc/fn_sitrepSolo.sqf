/*
Original name: pl_sitrep_solo
New name:      KMD_fnc_sitrepSolo
Original url: "Plmod\pl_sitrep_fnc.sqf"
*/
params ["_group"];

_clockTime = [daytime, "HH:MM"] call BIS_fnc_timeToString;
_gridPos = mapGridPosition (leader _group);
_ammoState = [_group] call KMD_fnc_getAmmoGroupState;
_healthState = [_group] call KMD_fnc_groupHealthHex;
_taskIcon = "";
_onTask = _group getVariable "onTask";
if (_onTask) then {
    _taskIcon = _group getVariable 'specialIcon';
};

_message = format ["
    <t color='#004c99' size='1.3' align='center' underline='1'>SITREP</t>
    <br /><br />
    <t color='#ffffff' size='1' align='left'>Callsign:</t><t color='#ffffff' size='0.9' align='right'>%1</t>
    <br /><br />
    <t color='#ffffff' size='1' align='left'>Status:</t><t color='#ffffff' size='0.9' align='right'>%2</t>
    <br />
    <t color='#ffffff' size='1' align='left'>Formation:</t><t color='#ffffff' size='0.9' align='right'>%3</t>
    <br />
    <t color='#ffffff' size='1' align='left'>Time:</t><t color='#ffffff' size='0.9' align='right'>%4</t>
    <br />
    <t color='#ffffff' size='1' align='left'>Grid:</t><t color='#ffffff' size='0.9' align='right'>%5</t>
    <br />
    <t color='#ffffff' size='1' align='left'>Strength:</t><t color='#ffffff' size='0.9' align='right'>%6x</t>
    <br />
    <t color='#ffffff' size='1' align='left'>Task:</t><img color='#e5e500' align='right' image='%7'/>
    <br /><br />
    <t color='#ffffff' size='0.9' align='left'>Health/MOS:</t><t color='#ffffff' size='0.9' align='right'>Ammo:</t>
    <br />
    <t color='%8' size='0.8' align='left'>%9</t><t color='%10' size='0.8' align='right'>%11</t>
    <br />
", (groupId _group), (behaviour (leader _group)), (formation _group), _clockTime, _gridPos, (count (units _group)), _taskIcon,
_healthState select 1, _healthState select 0, _ammoState select 1, _ammoState select 0];

{
    _mags = magazines _x;
    _mag = " ";
    _missile = " ";
    _magCount = 0;
    _missileCount = 0;

    if ((primaryWeapon _x) != "") then {
        _mag = (getArray (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "magazines")) select 0;
    };
    if ((secondaryWeapon _x) != "") then {
        _missile = (getArray (configFile >> "CfgWeapons" >> (secondaryWeapon _x) >> "magazines")) select 0;
    };

    {
        if ((_mag isEqualto _x)) then {
            _magCount = _magCount + 1;
        };
        if ((_missile isEqualto _x)) then {
            _missileCount = _missileCount + 1;
        };
    }forEach _mags;

    _unitMos = getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
    _unitDamage = damage _x;
    _unitDamage = 100 - (round (_unitDamage * 100));
    _unitDamageStr = format ["%1%2", _unitDamage, "%"];
    if (_x getVariable "pl_wia") then {
        _unitDamageStr = "W.I.A";
    };
    if (_unitDamage <= 0) then {
        _unitDamageStr = "M.I.A";
    };
    _message = _message + format ["<br /><t color='#cccccc' size='0.8' align='left'>- %1 / %2</t><t color='#cccccc' size='0.8' align='right'>%3x</t>",_unitDamageStr, _unitMos, _magCount];
    if (_missileCount > 0) then{
        _message = _message + format ["<t color='#cccccc' size='0.8' align='right'>/%1x</t>", _missileCount];
    };

}forEach (units _group);
if (vehicle (leader _group) != (leader _group)) then{
    _vic = vehicle (leader _group);
    _vicName = getText (configFile >> "CfgVehicles" >> typeOf _vic >> "displayName");
    _unitDamage = damage _vic;
    _unitDamage = 100 - (round (_unitDamage * 100));
    _message = _message + format ["
        <br /><br /><t color='#cccccc' size='1' align='left'>Vehicle:</t>
        <br /><t color='#cccccc' size='1' align='left'>- %1 </t><t color='#cccccc' size='1' align='center'>%2 %3</t>", _vicName, _unitDamage, "%"];
};


_targets = [];
_targets = [(leader _group)] call KMD_fnc_getTargets;

if ((count _targets) > 0) then {

    _manSpotted = "Man" countType _targets;
    _tankSpotted = "Tank" countType _targets;
    _carSpotted = "Car" countType _targets;
    _airSpotted = "Air" countType _targets;

    _message = _message + format ["
    <br /><br />
    <t color='#7f0000' size='1.3' align='center' underline='1'>CONTACTS</t>
    <br /><br />"];
    
    if( _manSpotted > 0 ) then {
        _message = _message + format["<img align='left' image='\A3\ui_f\data\map\markers\nato\o_inf.paa'/><t size='0.9' align='center'>INF</t><t size='0.9' align='right'>%1x</t>
    <br />", _manSpotted];
    };
    
    if( _tankSpotted > 0 ) then {
        _message = _message + format["<img align='left' image='\A3\ui_f\data\map\markers\nato\o_armor.paa'/><t size='0.9' align='center'>ARM</t><t color='#ffffff' size='0.9' align='right'>%1x</t><br />", _tankSpotted];
    };
    
    if( _carSpotted > 0 ) then {
        _message = _message + format["<img align='left' image='\A3\ui_f\data\map\markers\nato\o_motor_inf.paa'/><t size='0.9' align='center'>MOT</t><t color='#ffffff' size='0.9' align='right'>%1x</t><br />", _carSpotted];
    };
    
    if( _airSpotted > 0 ) then {
        _message = _message + format["<img align='left' image='\A3\ui_f\data\map\markers\nato\o_air.paa'/><t size='0.9' align='center'>AIR</t><t color='#ffffff' size='0.9' align='right'>%1x</t>",_airSpotted];
    };

}
else
{
    _message = _message + "
    <br /><br />
    <t color='#7f0000' size='1.3' align='center' underline='1'>CONTACTS</t>
    <br /><br />
    <t color='#7f0000' size='1' align='center'>No Enemy Contacts</t>
    ";
};
hint parseText _message;
