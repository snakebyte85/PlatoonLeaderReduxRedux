/*
Original name: pl_show_fire_support_menu
New name:      KMD_fnc_showFireSupportMenu
Original url: "Plmod\pl_menus_fnc.sqf"
*/
    call compile format ["
     HC_Custom_0 = [
        ['Fire Support',true],
        [parseText '%2', [4], '', -5, [['expression', '[] spawn KMD_fnc_showMortarMenu']], '1', '%1']
    ];",  [] call KMD_fnc_onMapMortar, pl_str_mortar];
    // showCommandingMenu "#USER:pl_mortar_menu";