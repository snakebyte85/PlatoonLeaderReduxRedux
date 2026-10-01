/*
Original name: pl_support_status
New name:      KMD_fnc_supportStatus
Original url: "Plmod\pl_support_fnc.sqf"
*/
    _gunCd = "ON STATION";
    _gunColor = "#66ff33";
    _gunRocketCd = "ON STATION";
    _gunRocketColor = "#66ff33";
    _clusterCd = "ON STATION";
    _clusterColor = "#66ff33";
    _jdamCd = "ON STATION";
    _jdamColor = "#66ff33";
    _sadPlaneCd = "ON STATION";
    _sadPlaneColor = "#66ff33";
    _sadHeloCd = "ON STATION";
    _sadHeloColor = "#66ff33";
    _sadUavCd = "ON STATION";
    _sadUavColor = "#66ff33";
    _sadMedevacCd = "ON STATION";
    _sadMedevacColor = "#66ff33";
    _time = time + 8;
    while {time < _time} do {
        if (time < pl_cas_gun_cd) then {
            _gunCd = format ["%1s", round (pl_cas_gun_cd - time)];
            _gunColor = '#b20000';
        };
        if (time < pl_cas_gun_rocket_cd) then {
            _gunRocketCd = format ["%1s", round (pl_cas_gun_rocket_cd - time)];
            _gunRocketColor = '#b20000';
        };
        if (time < pl_cas_cluster_cd) then {
            _clusterCd = format ["%1s", round (pl_cas_cluster_cd - time)];
            _clusterColor = '#b20000';
        };
        if (time < pl_cas_jdam_cd) then {
            _jdamCd = format ["%1s", round (pl_cas_jdam_cd - time)];
            _jdamColor = '#b20000';
        };
        if (time < pl_plane_sad_cd) then {
            _sadPlaneCd = format ["%1s", round (pl_plane_sad_cd - time)];
            _sadPlaneColor = '#b20000';
        };
        if (time < pl_helo_sad_cd) then {
            _sadHeloCd = format ["%1s", round (pl_helo_sad_cd - time)];
            _sadHeloColor = '#b20000';
        };
        if (time < pl_uav_sad_cd) then {
            _sadUavCd = format ["%1s", round (pl_uav_sad_cd - time)];
            _sadUavColor = '#b20000';
        };
        if (time < pl_medevac_sad_cd) then {
            _sadMedevacCd = format ["%1s", round (pl_medevac_sad_cd - time)];
            _sadMedevacColor = '#b20000';
        };
         _message = format ["
            <t color='#004c99' size='1.3' align='center' underline='1'>CAS</t>
            <br /><br />
            <t color='#ffffff' size='0.8' align='left'>Sorties:</t><t color='%1' size='0.8' align='right'>%10</t>
            <br /><br />
            <t color='#ffffff' size='0.8' align='left'>Viper 1 (Gun Run)</t><t color='%1' size='0.8' align='right'>%2</t>
            <br /><br />
            <t color='#ffffff' size='0.8' align='left'>Viper 4 (Attack Run)</t><t color='%3' size='0.8' align='right'>%4</t>
            <br /><br />
            <t color='#ffffff' size='0.8' align='left'>Black Knight 1-2 (Cluster)</t><t color='%5' size='0.8' align='right'>%6</t>
            <br /><br />
            <t color='#ffffff' size='0.8' align='left'>Stroke 3 (JDAM)</t><t color='%7' size='0.8' align='right'>%8</t>
            <br /><br />
            <t color='#ffffff' size='0.8' align='left'>Reaper 1 (SAD Plane)</t><t color='%11' size='0.8' align='right'>%12</t>
            <br /><br />
            <t color='#ffffff' size='0.8' align='left'>Black Jack 4 (SAD HELO)</t><t color='%13' size='0.8' align='right'>%14</t>
            <br /><br />
            <t color='#ffffff' size='0.8' align='left'>Sentry 3 (UAV Recon)</t><t color='%15' size='0.8' align='right'>%16</t>
            <br /><br />
            <t color='#ffffff' size='0.8' align='left'>Angel 6 (MEDEVAC)</t><t color='%17' size='0.8' align='right'>%18</t>
            <br /><br />
            <t color='#004c99' size='1.3' align='center' underline='1'>Artillery</t>
            <br /><br />
            <t color='#ffffff' size='0.8' align='left'>155m Battery</t><t color='#ffffff' size='0.8' align='right'>%9x</t>
        ", _gunColor, _gunCd, _gunRocketColor, _gunRocketCd, _clusterColor, _clusterCd, _jdamColor, _jdamCd,  pl_arty_ammo, pl_sorties, _sadPlaneColor, _sadPlaneCd, _sadHeloColor, _sadHeloCd, _sadUavColor, _sadUavCd, _sadMedevacColor, _sadMedevacCd];

        hintSilent parseText _message;
        sleep 1;
    };
    hintSilent "";