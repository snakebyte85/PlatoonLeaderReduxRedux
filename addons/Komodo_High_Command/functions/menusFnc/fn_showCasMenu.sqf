/*
Original name: pl_show_cas_menu
New name:      KMD_fnc_showCasMenu
Original url: "Plmod\pl_menus_fnc.sqf"
*/
    call compile format ["
    pl_cas_menu = [
        ['CAS',true],
        [parseText '%8', [2], '', -5, [['expression', '[1] spawn KMD_fnc_cas']], '1', '%1'],
        [parseText '%9', [3], '', -5, [['expression', '[2] spawn KMD_fnc_cas']], '1', '%2'],
        [parseText '%10', [4], '', -5, [['expression', '[3] spawn KMD_fnc_cas']], '1', '%3'],
        [parseText '%11', [5], '', -5, [['expression', '[4] spawn KMD_fnc_cas']], '1', '%4'],
        ['', [], '', -1, [['expression', '']], '1', '1'],
        [parseText '%12', [6], '', -5, [['expression', '[1] spawn pl_interdiction_cas']], '1', '%5'],
        [parseText '%13', [7], '', -5, [['expression', '[2] spawn pl_interdiction_cas']], '1', '%6'],
        ['', [], '', -1, [['expression', '']], '1', '1'],
        [parseText '%14', [8], '', -5, [['expression', '[3] spawn pl_interdiction_cas']], '1', '%7'],
        ['', [], '', -1, [['expression', '']], '1', '1'],
        [parseText '%15', [9], '', -5, [['expression', '[4] spawn pl_interdiction_cas']], '1', '%16']

    ];", pl_gun_enabled, pl_gun_rocket_enabled, pl_cluster_enabled, pl_jdam_enabled, pl_plane_sad_enabled, pl_helo_sad_enabled, pl_uav_sad_enabled, pl_str_gun, pl_str_attack_run, pl_str_cluster, pl_str_jdam, pl_str_plane_sad, pl_str_helo_sad, pl_str_uav, pl_str_medevac, pl_medevac_sad_enabled];
    showCommandingMenu "#USER:pl_cas_menu";