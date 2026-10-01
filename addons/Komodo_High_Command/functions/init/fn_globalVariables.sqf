pl_global_spotrep_cd     = 0;
pl_At_fire_report_cd     = 0;
pl_sitrep_multi_cd       = 0;
pl_bounding_cords        = [0,0,0];
pl_bounding_mode         = "full";
pl_bounding_draw_array   = [];
pl_attack_mode           = "normal";
pl_sweep_cords           = [0,0,0];
pl_sweep_area_size       = 35;
pl_marker_targets        = [];
pl_draw_building_array   = [];
pl_building_search_cords = [0,0,0];
pl_garrison_area_size    = 25; 
pl_mapClicked            = false;
pl_show_vehicles         = false;
pl_show_vehicles_pos     = [0,0,0];
pl_vics                  = [];
pl_mapClicked            = false;
pl_getOut_cd             = 0;
pl_lz_cords              = [0,0,0];
pl_lz_marker_cords       = [0,0,0];
pl_convoy_pos            = 0;
pl_convoy_array          = [];
pl_draw_convoy_array     = [];
pl_convoy_path_marker    = [];
pl_left_vehicles         = [];

pl_covers                = [];
pl_defence_cords         = [0,0,0];
pl_mapClicked            = false;
pl_denfence_draw_array   = [];
pl_deploy_static = false;
pl_add_group_to_hc = false;
pl_ccp_set          = false;
pl_ccp_heal_range   = 50;
pl_ccp_revive_range = 200;
pl_follow_active = false;
pl_follow_array  = [];

pl_follow_array_other = [];
pl_follow_array_other_setup = [];

pl_arty_cords = [0,0,0];
pl_mapClicked = false;
pl_cancel_strike = false;
pl_mortar_rounds = 4;
pl_arty_cords = [0,0,0];
pl_show_dead_vehicles = false;
pl_destroyed_vics_data = [];
pl_maintenance_area = 45;
pl_3dIcon_select_cd = 0;
pl_vehicle_destroyed_report_cd = 0;

if (pl_enabled_medical) then {pl_show_medical = 1} else {pl_show_medical = 0};
if (pl_enable_vehicle_recovery) then {pl_show_vehicle_recovery = 1} else {pl_show_vehicle_recovery = 0};

pl_mortars = [];

call KMD_fnc_classVars;
call KMD_fnc_strImgVars;
call KMD_fnc_menuArrayVariables;