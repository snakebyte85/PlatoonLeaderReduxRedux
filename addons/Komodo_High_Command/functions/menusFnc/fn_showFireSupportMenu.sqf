/*
Original name: pl_show_fire_support_menu
New name:      KMD_fnc_showFireSupportMenu
Original url: "Plmod\pl_menus_fnc.sqf"
*/
    call compile format ["
     HC_Custom_0 = [
        ['Fire Support',true],
        [parseText '%4', [2], '', -5, [['expression', '[] spawn KMD_fnc_showCasMenu']], '1', '%1'],
        [parseText '%5', [3], '', -5, [['expression', '[] spawn KMD_fnc_showArtyMenu']], '1', '%2'],
        ['', [], '', -1, [['expression', '']], '1', '1'],
        [parseText '%6', [4], '', -5, [['expression', '[] spawn KMD_fnc_showMortarMenu']], '1', '%3'],
        ['', [], '', -1, [['expression', '']], '1', '1'],
        [parseText '%7', [5], '', -5, [['expression', '[] spawn KMD_fnc_supportStatus']], '1', '1']
    ];", pl_cas_enabled, pl_arty_enabled, [] call KMD_fnc_onMapMortar, pl_str_cas, pl_str_arty, pl_str_mortar, pl_str_status];
    // showCommandingMenu "#USER:pl_mortar_menu";