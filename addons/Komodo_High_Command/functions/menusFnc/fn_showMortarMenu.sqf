/*
Original name: pl_show_mortar_menu
New name:      KMD_fnc_showMortarMenu
Original url: "Plmod\pl_menus_fnc.sqf"
*/
call compile format ["
	pl_mortar_menu = [
    ['Platoon Mortar',true],
    ['Call Strike', [2], '', -5, [['expression', 'pl_arty_delay = 1; [] spawn KMD_fnc_fireMortar']], '1', '1'],
    ['', [], '', -5, [['expression', '']], '1', '0'],
    ['Rounds:           %1', [3], '#USER:pl_mortar_round_menu', -5, [['expression', '']], '1', '1']
	];", 
	pl_mortar_rounds
];

showCommandingMenu "#USER:pl_mortar_menu";