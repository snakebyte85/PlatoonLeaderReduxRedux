/*
Original name: pl_show_css_menu
New name:      KMD_fnc_showCssMenu
Original url: "Plmod\pl_menus_fnc.sqf"
*/
    call compile format ["
    HC_Missions_0 = [
        ['CSS',true],
        [parseText '%3', [2], '', -5, [['expression', '[] spawn KMD_fnc_spawnHealGroup']], '%1', 'HCNotEmpty'],
        [parseText '%4', [3], '', -5, [['expression', '[] spawn KMD_fnc_ccp']], '%1', 'HCNotEmpty'],
        [parseText '%5', [4], '', -5, [['expression', '[] spawn KMD_fnc_transferMedic']], '%1', 'HCNotEmpty'],
        ['', [], '', -1, [['expression', '']], '%1', '1'],
        [parseText '%6', [5], '', -5, [['expression', '[] spawn pl_spawn_rearm']], '1', 'HCNotEmpty'],
        ['', [], '', -1, [['expression', '']], '%2', '1'],
        [parseText '%7', [6], '', -5, [['expression', '[] spawn KMD_fnc_repair']], '%2', 'HCNotEmpty'],
        [parseText '%8', [7], '', -5, [['expression', '[] spawn KMD_fnc_maintenancePoint']], '%2', 'HCNotEmpty']
    ];", pl_show_medical, pl_show_vehicle_recovery, pl_str_heal, pl_str_ccp, pl_str_transfer, pl_str_resupply, pl_str_repair, pl_str_maintenance];
    // showCommandingMenu "#USER:pl_mortar_menu";