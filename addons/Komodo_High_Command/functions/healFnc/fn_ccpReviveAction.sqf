/*
Original name: pl_ccp_revive_action
New name:      KMD_fnc_ccpReviveAction
Original url: "Plmod\pl_heal_fnc.sqf"
*/
   params ["_group", "_medic", "_escort", "_healTarget", "_ccpPos", "_reviveTime"];
    // player sideChat str (alive _healTarget);
    _healTarget setVariable ["pl_beeing_treatet", true];
    _medic disableAI "AUTOCOMBAT";
    _medic disableAI "AUTOTARGET";
    _medic disableAI "TARGET";
    // _medic disableAI "FSM";
    _medic enableAI "PATH";
    doStop _medic;
    _medic doMove (getPos _healTarget);
    _medic moveTo (getPos _healTarget);
    if !(isNil "_escort") then {
        _escort disableAI "AUTOCOMBAT";
        _escort enableAI "PATH";
        _escort doMove ((getPos _healTarget) findEmptyPosition [3, 40]);
        _escort moveTo ((getPos _healTarget) findEmptyPosition [3, 40]);

    };
    waitUntil {(unitReady _medic) or ((_medic distance2D _healTarget) < 2) or !(_group getVariable ["onTask", true]) or (!alive _healTarget) or (!alive _medic) or (_medic getVariable ["pl_wia", false])};
    // Animation
    if (_group getVariable ["onTask", true] and (alive _healTarget) and (alive _medic) and !(_medic getVariable ["pl_wia", false])) then {
        // _medic setUnitPos "MIDDLE";
        sleep 0.1;
        _reviveTime = time + _reviveTime;
        _medic attachTo [_healTarget, [0.6,0.2,0]];
        _medic setDir -90;
        _medic playAction "medicStart";
        _medic disableAI "ANIM";
        sleep 2;
        _medic switchMove "AinvPknlMstpSnonWrflDnon_medic3";
        waitUntil {
            sleep 5;
            _medic switchMove selectRandom ["AinvPknlMstpSnonWrflDnon_medic3", "AinvPknlMstpSnonWrflDnon_medic2", "AinvPknlMstpSnonWrflDnon_medic1", "AinvPknlMstpSnonWrflDnon_medic4"];
            (time > _reviveTime) or !(_group getVariable ["onTask", true]);
         };
        detach _medic;
        _medic playAction "medicStop";
        sleep 2;
        _medic enableAI "ANIM";
        if !(_group getVariable ["onTask", true]) then {
            _healTarget setVariable ["pl_beeing_treatet", false];
        }
    }
    else
    {
        _healTarget setVariable ["pl_beeing_treatet", false];
    };
    _medic setUnitPos "AUTO";
    if (_group getVariable "onTask" and (alive _medic) and !(_medic getVariable "pl_wia")) then {
        _healTarget setUnconscious false;
        _healTarget setDamage 0;
        _healTarget setUnitPos "AUTO";
        _healTarget enableAI "PATH";
        _healTarget setVariable ["pl_wia", false];
        _healtarget setVariable ["pl_injured", false];
        _healTarget setVariable ["pl_wia_calledout", false];
        _healTarget setVariable ["pl_beeing_treatet", false];
        _healTarget setVariable ["pl_bleedout_set", false];
        _medic doMove _ccpPos;
        _medic moveTo _ccpPos;
        if !(isNil "_escort") then {
            _escort enableAI "AUTOCOMBAT";
            _escort doMove _ccpPos;
            _escort moveTo _ccpPos;
        };
    }
    else
    {
        _healTarget setVariable ["pl_beeing_treatet", false];
    };
