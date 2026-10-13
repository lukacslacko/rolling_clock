; HEADER_BLOCK_START
; BambuStudio 02.05.00.66
; Custom analytic path generator; version line above selects the Bambu preview dialect.
; model printing time: 0h 44m 43s; total estimated time: 0h 57m 17s
; total layer number: 20
; total filament length [mm] : 3710.96
; total filament volume [cm^3] : 8.926
; total filament weight [g] : 11.25
; filament_density: 1.26
; filament_diameter: 1.75
; max_z_height: 4.00
; filament: 1
; HEADER_BLOCK_END
; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0,1,1
; additional_cooling_fan_speed = 70,0,0
; apply_scarf_seam_on_circles = 1
; apply_top_surface_compensation = 0
; auxiliary_fan = 1
; avoid_crossing_wall_includes_support = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 0x0,18x0,18x28,0x28
; bed_temperature_formula = by_first_filament
; before_layer_change_gcode = 
; best_object_pos = 0.5,0.5
; bottom_color_penetration_layers = 3
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_density = 100%
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.1
; brim_type = no_brim
; brim_width = 0
; chamber_temperatures = 0,60,0
; change_filament_gcode = ;=P1S 20251031=\nM620 S[next_extruder]A\nM204 S9000\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{else}\nM620.11 S0\n{endif}\nM400\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F{flush_volumetric_speeds[previous_extruder]/2.4053*60} T{flush_temperatures[previous_extruder]}\nT[next_extruder]\nM620.1 E F{flush_volumetric_speeds[next_extruder]/2.4053*60} T{flush_temperatures[next_extruder]}\n\n{if next_extruder < 255}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\nG92 E0\n{if flush_length_1 > 1}\nM83\n; FLUSH_START\n; always use highest temperature to flush\nM400\n{if filament_type[next_extruder] == "PETG"}\nM109 S260\n{elsif filament_type[next_extruder] == "PVA"}\nM109 S210\n{else}\nM109 S{flush_temperatures[next_extruder]}\n{endif}\n{if flush_length_1 > 23.7}\nG1 E23.7 F{flush_volumetric_speeds[previous_extruder]/2.4053*60} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\n{else}\nG1 E{flush_length_1} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{flush_volumetric_speeds[next_extruder]/2.4053*60} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X105 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\n\nG1 X70 F10000\nG1 X80 F15000\nG1 X60\nG1 X80\nG1 X60\nG1 X80 ; shake to put down garbage\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A\n
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200,200,200
; close_fan_the_first_x_layers = 1,3,3
; complete_print_exhaust_fan_speed = 70,70,70
; cool_plate_temp = 35,0,0
; cool_plate_temp_initial_layer = 35,0,0
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10,10,10
; cooling_slowdown_logic = uniform_cooling,uniform_cooling,uniform_cooling
; counter_coef_1 = 0,0,0
; counter_coef_2 = 0.008,0.008,0.008
; counter_coef_3 = -0.041,-0.041,-0.041
; counter_limit_max = 0.033,0.033,0.033
; counter_limit_min = -0.035,-0.035,-0.035
; curr_bed_type = Textured PEI Plate
; default_acceleration = 10000
; default_filament_colour = ;;
; default_filament_profile = "Bambu PLA Basic @BBL P1S 0.4 nozzle"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL X1C
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50,50,50
; different_settings_to_system = resolution;;;;
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70,70,70
; elefant_foot_compensation = 0.15
; embedding_wall_into_infill = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_height_slowdown = 0
; enable_long_retraction_when_cut = 2
; enable_overhang_bridge_fan = 1,1,1
; enable_overhang_speed = 1
; enable_pre_heating = 0
; enable_pressure_advance = 0,0,0
; enable_prime_tower = 0
; enable_support = 0
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 0,100,90
; eng_plate_temp_initial_layer = 0,100,90
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 1#0|4#0;1#0|4#0
; extruder_clearance_dist_to_rod = 33
; extruder_clearance_height_to_lid = 90
; extruder_clearance_height_to_rod = 34
; extruder_clearance_max_radius = 68
; extruder_colour = #018001
; extruder_max_nozzle_count = 1
; extruder_nozzle_stats = Standard#1
; extruder_offset = 0x2
; extruder_printable_area = 
; extruder_type = Direct Drive
; extruder_variant_list = "Direct Drive Standard,Direct Drive High Flow"
; fan_cooling_layer_time = 100,35,30
; fan_direction = left
; fan_max_speed = 100,35,60
; fan_min_speed = 100,10,10
; filament_adaptive_volumetric_speed = 0,0,0
; filament_adhesiveness_category = 100,200,200
; filament_bridge_speed = 25,25,25
; filament_change_length = 5,10,10
; filament_change_length_nc = 10,10,10
; filament_colour = #FEC600;#E02928;#00AE42
; filament_colour_type = 0;0;0
; filament_cooling_before_tower = 0,0,0
; filament_cost = 24.99,31.99,24.99
; filament_density = 1.26,1.05,1.04
; filament_dev_ams_drying_ams_limitations = 1;0;1;1
; filament_dev_ams_drying_heat_distortion_temperature = 45,100,90
; filament_dev_ams_drying_temperature = 45,45,45,45,65,80,65,80,65,80,65,75
; filament_dev_ams_drying_time = 12,12,12,12,12,8,12,8,12,8,12,8
; filament_dev_chamber_drying_bed_temperature = 70,90,90
; filament_dev_chamber_drying_time = 12,12,12
; filament_dev_drying_cooling_temperature = 45,85,75
; filament_dev_drying_softening_temperature = 50,85,80
; filament_diameter = 1.75,1.75,1.75
; filament_enable_overhang_speed = 1,1,1
; filament_end_gcode = "; filament end gcode \n\n";"; filament end gcode \n\n";"; filament end gcode \n\n"
; filament_extruder_variant = "Direct Drive Standard";"Direct Drive Standard";"Direct Drive Standard"
; filament_flow_ratio = 0.98
; filament_flush_temp = 0,0,0
; filament_flush_volumetric_speed = 0,0,0
; filament_ids = GFA00;GFB01;GFB00
; filament_is_support = 0,0,0
; filament_long_retractions_when_cut = 1,1,1
; filament_map = 1,1,1
; filament_map_2 = 0,0,0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 21,18,16
; filament_minimal_purge_on_wipe_tower = 15,15,15
; filament_multi_colour = #FEC600;#E02928;#00AE42
; filament_notes = 
; filament_nozzle_map = 0,0,0
; filament_overhang_1_4_speed = 0,0,0
; filament_overhang_2_4_speed = 50,50,50
; filament_overhang_3_4_speed = 30,30,30
; filament_overhang_4_4_speed = 10,10,10
; filament_overhang_totally_speed = 10,10,10
; filament_pre_cooling_temperature = 0,0,0
; filament_pre_cooling_temperature_nc = 0,0,0
; filament_prime_volume = 30,45,45
; filament_prime_volume_nc = 60,60,60
; filament_printable = 3,3,3
; filament_ramming_travel_time = 0,0,0
; filament_ramming_travel_time_nc = 0,0,0
; filament_ramming_volumetric_speed = -1,-1,-1
; filament_ramming_volumetric_speed_nc = -1,-1,-1
; filament_retract_length_nc = 14,14,14
; filament_retraction_distances_when_cut = 18,18,18
; filament_retraction_length = nil,nil,0.4
; filament_scarf_gap = 0%,0%,0%
; filament_scarf_height = 10%,10%,10%
; filament_scarf_length = 10,10,10
; filament_scarf_seam_type = none,none,none
; filament_self_index = 1,1,2,2,3,3
; filament_settings_id = Bambu PLA Basic @BBL P1S 0.4 nozzle
; filament_shrink = 100%,100%,100%
; filament_soluble = 0,0,0
; filament_start_gcode = "; filament start gcode\n{if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200\n{elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150\n{elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50\n{endif}\nM142 P1 R35 S40\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; Filament gcode\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}";"; Filament gcode\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10,10,10
; filament_tower_interface_pre_extrusion_length = 0,0,0
; filament_tower_interface_print_temp = -1,-1,-1
; filament_tower_interface_purge_volume = 20,20,20
; filament_tower_ironing_area = 4,4,4
; filament_type = PLA
; filament_velocity_adaptation_factor = 1,1,1
; filament_vendor = "Bambu Lab";"Bambu Lab";"Bambu Lab"
; filament_volume_map = 0,0,0
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 0,0,0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_volumes_matrix = 0,246,258,458,0,382,523,252,0
; flush_volumes_vector = 140,140,140,140,140,140
; full_fan_speed_layer = 0,0,0
; fuzzy_skin = none
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 250
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 0
; group_algo_with_time = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; hole_coef_1 = 0,0,0
; hole_coef_2 = -0.008,-0.008,-0.008
; hole_coef_3 = 0.23415,0.23415,0.23415
; hole_limit_max = 0.22,0.22,0.22
; hole_limit_min = 0.088,0.088,0.088
; host_type = octoprint
; hot_plate_temp = 55,100,90
; hot_plate_temp_initial_layer = 55,100,90
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 13.8,4.9,7.4
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; initial_layer_travel_acceleration = 6000
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 300
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 250
; ironing_direction = 45
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.2
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 0
; long_retractions_when_ec = 0,0,0
; machine_end_gcode = ;===== date: 20230428 =====================\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X65 Y245 F12000 ; move to safe pos \nG1 Y265 F3000\n\nG1 X65 Y245 F12000\nG1 Y265 F3000\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\nG1 X100 F12000 ; wipe\n; pull back filament to AMS\nM620 S255\nG1 X20 Y50 F12000\nG1 Y-3\nT255\nG1 X65 F12000\nG1 Y265\nG1 X100 F12000 ; wipe\nM621 S255\nM104 S0 ; turn off hotend\n\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S3 ;wait for last picture to be taken\nM623; end of "timelapse_record_flag"\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 250}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z250 F600\n    G1 Z248\n{endif}\nM400 P100\nM17 R ; restore z current\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\nM17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\n
; machine_hotend_change_time = 0
; machine_load_filament_time = 29
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 500,500
; machine_max_jerk_e = 2.5,2.5
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,500
; machine_max_speed_y = 500,500
; machine_max_speed_z = 20,20
; machine_min_extruding_rate = 0
; machine_min_travel_rate = 0
; machine_pause_gcode = M400 U1
; machine_prepare_compensation_time = 260
; machine_start_gcode = ;===== machine: P1S-0.4 ========================\n;===== date: 20251031 =====================\n;===== turn on the HB fan & MC board fan =================\nM104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle\nM710 A1 S255 ;turn on MC fan by default(P1S)\n;===== reset machine status =================\nM290 X40 Y40 Z2.6666666\nG91\nM17 Z0.4 ; lower the z-motor current\nG380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed\nG380 S2 Z-25 F300 ;\nG1 Z5 F300;\nG90\nM17 X1.2 Y1.2 Z0.75 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 5\nM221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem\nG29.1 Z{+0.0} ; clear z-trim value first\nM204 S10000 ; init ACC set to 10m/s^2\n\n;===== heatbed preheat ====================\nM1002 gcode_claim_action:54\nM140 S[bed_temperature_initial_layer_single] ;set bed temp\nM190 S[bed_temperature_initial_layer_single] ;wait for bed temp\n\n\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_extruder]=="PLA"}\n    {if (bed_temperature[initial_extruder] >45)||(bed_temperature_initial_layer[initial_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n;===== prepare print temperature and material ==========\nM104 S[nozzle_temperature_initial_layer] ;set extruder temp\nG91\nG0 Z10 F1200\nG90\nG28 X\nM975 S1 ; turn on\nG1 X60 F12000\nG1 Y245\nG1 Y265 F3000\nM620 M\nM620 S[initial_extruder]A   ; switch material if AMS exist\n    M109 S[nozzle_temperature_initial_layer]\n    G1 X120 F12000\n\n    G1 X20 Y50 F12000\n    G1 Y-3\n    T[initial_extruder]\n    G1 X54 F12000\n    G1 Y265\n    M400\nM621 S[initial_extruder]A\nM620.1 E F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60} T{flush_temperatures[initial_no_support_extruder]}\n\n\nM412 S1 ; ===turn on filament runout detection===\n\nM109 S250 ;set nozzle to common flush temp\nM106 P1 S0\nG92 E0\nG1 E50 F200\nM400\nM104 S[nozzle_temperature_initial_layer]\nG92 E0\nG1 E50 F200\nM400\nM106 P1 S255\nG92 E0\nG1 E5 F300\nM109 S{nozzle_temperature_initial_layer[initial_extruder]-20} ; drop nozzle temp, make filament shink a bit\nG92 E0\nG1 E-0.5 F300\n\nG1 X70 F9000\nG1 X76 F15000\nG1 X65 F15000\nG1 X76 F15000\nG1 X65 F15000; shake to put down garbage\nG1 X80 F6000\nG1 X95 F15000\nG1 X80 F15000\nG1 X165 F15000; wipe and shake\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\nM106 S255\nG1 X65 Y230 F18000\nG1 Y264 F6000\nM109 S{nozzle_temperature_initial_layer[initial_extruder]-20}\nG1 X100 F18000 ; first wipe mouth\n\nG0 X135 Y253 F20000  ; move to exposed steel surface edge\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nG0 Z5 F20000\n\nG1 X60 Y265\nG92 E0\nG1 E-0.5 F300 ; retrack more\nG1 X100 F5000; second wipe mouth\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X90 F5000\nG0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle\nM104 S140 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\n\nM221 S; push soft endstop status\nM221 Z0 ;turn off Z axis endstop\nG0 Z0.5 F20000\nG0 X125 Y259.5 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 X128\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\n\nM109 S140 ; wait nozzle temp down to heatbed acceptable\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\n\nM221 R; pop softend status\nG1 Z10 F1200\nM400\nG1 Z10\nG1 F30000\nG1 X230 Y15\nG29.2 S1 ; turn on ABL\n;G28 ; home again after hard wipe mouth\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n\n;===== bed leveling ==================================\nM1002 judge_flag g29_before_print_flag\nM622 J1\n\n    M1002 gcode_claim_action : 1\n    G29 A X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\n\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28\n\nM623\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_extruder]=="PLA"}\n    {if (bed_temperature[initial_extruder] >45)||(bed_temperature_initial_layer[initial_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n\nM104 S{nozzle_temperature_initial_layer[initial_extruder]} ; set extrude temp earlier, to reduce wait time\n\n;===== mech mode fast check============================\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q1 A7 B30 C80  H15 K0\nM974 Q1 S2 P0\n\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q0 A7 B30 C90 Q0 H15 K0\nM974 Q0 S2 P0\n\nM975 S1\nG1 F30000\nG1 X230 Y15\nG28 X ; re-home XY\n;===== fmech mode fast check============================\n\n\n;===== nozzle load line ===============================\nM975 S1\nG90\nM83\nT1000\nG1 X18.0 Y1.0 Z0.8 F18000;Move to start position\nM109 S{nozzle_temperature_initial_layer[initial_extruder]}\nG1 Z0.2\nG0 E2 F300\nG0 X240 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 Y11 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\nG0 X239.5\nG0 E0.2\nG0 Y1.5 E0.700\nG0 X18 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM400\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type=="Textured PEI Plate"}\nG29.1 Z{-0.04} ; for Textured PEI Plate\n{endif}\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression\n
; machine_switch_extruder_time = 0
; machine_unload_filament_time = 28
; master_extruder_id = 1
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; no_slow_down_for_cooling_on_outwalls = 0,0,0
; nozzle_diameter = 0.4
; nozzle_flush_dataset = 0
; nozzle_height = 4.2
; nozzle_temperature = 220
; nozzle_temperature_initial_layer = 220,270,260
; nozzle_temperature_range_high = 240,280,280
; nozzle_temperature_range_low = 190,240,240
; nozzle_type = stainless_steel
; nozzle_volume = 107
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 500,500
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 40,40
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 100,80,80
; overhang_fan_threshold = 50%,25%,25%
; overhang_threshold_participating_cooling = 95%,95%,95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0,0,0
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 0,0,0
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02,0.02,0.02
; prime_tower_brim_width = 3
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 0
; prime_tower_infill_gap = 150%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 1
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 35
; prime_volume_mode = Default
; print_compatible_printers = "Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab P1S 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle"
; print_extruder_id = 1
; print_extruder_variant = "Direct Drive Standard"
; print_flow_ratio = 1
; print_sequence = by layer
; print_settings_id = 0.20mm Standard @BBL X1C
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 250
; printer_extruder_id = 1
; printer_extruder_variant = "Direct Drive Standard"
; printer_model = Bambu Lab P1S
; printer_notes = 
; printer_settings_id = Bambu Lab P1S 0.4 nozzle
; printer_structure = corexy
; printer_technology = FFF
; printer_variant = 0.4
; printhost_authorization_type = key
; printhost_ssl_ignore_revoke = 0
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = -1
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1,1,1
; reduce_infill_retraction = 1
; required_nozzle_HRC = 3,3,3
; resolution = 0.001
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 249
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0,0,0
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_placement_away_from_overhangs = 0
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_gap = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 10%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 15%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 15%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1,1,1
; slow_down_layer_time = 4,12,12
; slow_down_min_speed = 20,20,20
; slowdown_end_acc = 100000
; slowdown_end_height = 400
; slowdown_end_speed = 1000
; slowdown_start_acc = 100000
; slowdown_start_height = 0
; slowdown_start_speed = 1000
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 150
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 0
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 100%
; sparse_infill_filament = 0
; sparse_infill_lattice_angle_1 = -45
; sparse_infill_lattice_angle_2 = 45
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = zig-zag
; sparse_infill_speed = 270
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 45,0,0
; supertack_plate_temp_initial_layer = 45,0,0
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 0
; support_cooling_filter = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_ironing_direction = 0
; support_ironing_flow = 10%
; support_ironing_inset = 0
; support_ironing_pattern = zig-zag
; support_ironing_spacing = 0.15
; support_ironing_speed = 30
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_skip_flush = 0
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = tree(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 45,100,100
; template_custom_gcode = 
; textured_plate_temp = 55
; textured_plate_temp_initial_layer = 55,100,90
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;========Date 20250206========\n; SKIPPABLE_START\n; SKIPTYPE: timelapse\nM622.1 S1 ; for prev firmware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\nM971 S11 C10 O0\nM1004 S5 P1  ; external shutter\n{elsif timelapse_type == 1} ; timelapse with wipe tower\nG92 E0\nG1 X65 Y245 F20000 ; move to safe pos\nG17\nG2 Z{layer_z} I0.86 J0.86 P1 F20000\nG1 Y265 F3000\nM400\nM1004 S5 P1  ; external shutter\nM400 P300\nM971 S11 C11 O0\nG92 E0\nG1 X100 F5000\nG1 Y255 F20000\n{endif}\nM623\n; SKIPPABLE_END
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 5
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; top_z_overrides_xy_distance = 0
; travel_acceleration = 10000
; travel_jerk = 9
; travel_short_distance_acceleration = 250
; travel_speed = 500
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = -1
; upward_compatible_machine = "Bambu Lab P1S 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%
; volumetric_speed_coefficients = "0 0 0 0 0 0";"0 0 0 0 0 0";"0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = classic
; wall_loops = 5
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 165
; wipe_tower_y = 216.972
; wrapping_detection_gcode = 
; wrapping_detection_layers = 20
; wrapping_exclude_area = 
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END
; 248 mm OD, 2 mm radial ring, 4 mm axial thickness, six inward mounting pads; five concentric ring passes per layer.
; First layers: radial compensation 0.15 / 0.075 / 0 mm; full dense fill.
; Requires the same P1S 0.4 / PLA / textured PEI setup as the supplied job.
; Retains source T0 / AMS slot 0 selection. Inspect preview before printing.
M73 P0 R58
; EXECUTABLE_BLOCK_START
M201 X20000 Y20000 Z500 E5000
M203 X500 Y500 Z20 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;===== machine: P1S-0.4 ========================
;===== date: 20251031 =====================
;===== turn on the HB fan & MC board fan =================
M104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle
M710 A1 S255 ;turn on MC fan by default(P1S)
;===== reset machine status =================
M290 X40 Y40 Z2.6666666
G91
M17 Z0.4 ; lower the z-motor current
G380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed
G380 S2 Z-25 F300 ;
G1 Z5 F300;
G90
M17 X1.2 Y1.2 Z0.75 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 5
M221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem
G29.1 Z0 ; clear z-trim value first
M204 S10000 ; init ACC set to 10m/s^2

;===== heatbed preheat ====================
M1002 gcode_claim_action:54
M140 S55 ;set bed temp
M190 S55 ;wait for bed temp



;=============turn on fans to prevent PLA jamming=================

    
    M106 P3 S180
    ;Prevent PLA from jamming

M106 P2 S100 ; turn on big fan ,to cool down toolhead

;===== prepare print temperature and material ==========
M104 S220 ;set extruder temp
G91
G0 Z10 F1200
G90
G28 X
M975 S1 ; turn on
G1 X60 F12000
G1 Y245
G1 Y265 F3000
M620 M
M620 S0A   ; switch material if AMS exist
    M109 S220
    G1 X120 F12000

    G1 X20 Y50 F12000
    G1 Y-3
    T0
    G1 X54 F12000
    G1 Y265
    M400
M621 S0A
M620.1 E F523.843 T240


M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
G1 E50 F200
M400
M104 S220
G92 E0
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S200 ; drop nozzle temp, make filament shink a bit
G92 E0
G1 E-0.5 F300

G1 X70 F9000
G1 X76 F15000
G1 X65 F15000
G1 X76 F15000
G1 X65 F15000; shake to put down garbage
G1 X80 F6000
G1 X95 F15000
G1 X80 F15000
G1 X165 F15000; wipe and shake
M400
M106 P1 S0
;===== prepare print temperature and material end =====


;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1
M106 S255
G1 X65 Y230 F18000
G1 Y264 F6000
M109 S200
G1 X100 F18000 ; first wipe mouth

G0 X135 Y253 F20000  ; move to exposed steel surface edge
G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
G0 Z5 F20000

G1 X60 Y265
G92 E0
G1 E-0.5 F300 ; retrack more
G1 X100 F5000; second wipe mouth
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X90 F5000
G0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle
M104 S140 ; set temp down to heatbed acceptable
M106 S255 ; turn on fan (G28 has turn off fan)

M221 S; push soft endstop status
M221 Z0 ;turn off Z axis endstop
G0 Z0.5 F20000
G0 X125 Y259.5 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 X128
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300

M109 S140 ; wait nozzle temp down to heatbed acceptable
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000

M221 R; pop softend status
G1 Z10 F1200
M400
G1 Z10
G1 F30000
G1 X230 Y15
G29.2 S1 ; turn on ABL
;G28 ; home again after hard wipe mouth
M106 S0 ; turn off fan , too noisy
;===== wipe nozzle end ================================


;===== bed leveling ==================================
M1002 judge_flag g29_before_print_flag
M622 J1

    M1002 gcode_claim_action : 1
    G29 A X3.99999 Y3.99999 I248 J248
    M400
    M500 ; save cali data

M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28

M623
;===== home after wipe mouth end =======================

M975 S1 ; turn on vibration supression


;=============turn on fans to prevent PLA jamming=================

    
    M106 P3 S180
    ;Prevent PLA from jamming

M106 P2 S100 ; turn on big fan ,to cool down toolhead


M104 S220 ; set extrude temp earlier, to reduce wait time

;===== mech mode fast check============================
G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q1 A7 B30 C80  H15 K0
M974 Q1 S2 P0

G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q0 A7 B30 C90 Q0 H15 K0
M974 Q0 S2 P0

M975 S1
G1 F30000
G1 X230 Y15
G28 X ; re-home XY
;===== fmech mode fast check============================


;===== nozzle load line ===============================
M975 S1
G90
M83
T1000
G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
M109 S220
G1 Z0.2
G0 E2 F300
G0 X240 E15 F6033.27
G0 Y11 E0.700 F1508.32
G0 X239.5
G0 E0.2
G0 Y1.5 E0.700
G0 X18 E15 F6033.27
M400

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Textured PEI Plate

G29.1 Z-0.04 ; for Textured PEI Plate

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
; MACHINE_START_GCODE_END
; filament start gcode
M106 P3 S150

M142 P1 R35 S40
;VT0
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; HANDCRAFTED_TIRE_BODY_START
G90
G21
G17
M83
G92 E0
; CHANGE_LAYER
; Z_HEIGHT: 0.200
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 1/20
M73 L1
M991 S0 P0
M106 P1 S0
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.69688 Y183.60229 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.42000
M204 S1000
G1 F1500
G2 X227.32918 Y181.03001 I-1.96999 J-0.60229 E0.099428
G2 X224.75691 Y182.39771 I-0.60229 J1.96999 E0.099428
G2 X226.12461 Y184.96999 I1.96999 J0.60229 E0.099428
G2 X228.69688 Y183.60229 I0.60229 J-1.96999 E0.099428
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X236.86856 Y181.87534 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F1500
G1 X227.05853 Y176.87688 E0.338308
G3 X221.58994 Y186.34876 I-99.05853 J-50.87688 E0.336205
G1 X230.82374 Y192.34527 E0.338308
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X236.46751 Y181.87301 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F1800
G1 X236.53201 Y182.11373 E0.007657
G1 X236.27440 Y182.60923 E0.017160
G1 X236.01541 Y181.64265 E0.030748
G1 X235.56330 Y181.41230 E0.015591
G1 X236.01581 Y183.10108 E0.053722
G1 X235.75627 Y183.58938 E0.016992
G1 X235.11119 Y181.18194 E0.076584
G1 X234.65909 Y180.95158 E0.015591
G1 X235.49578 Y184.07415 E0.099333
G1 X235.23436 Y184.55546 E0.016830
G1 X234.20698 Y180.72122 E0.121972
G1 X233.75488 Y180.49086 E0.015591
G1 X234.97203 Y185.03333 E0.144501
G1 X234.70879 Y185.50785 E0.016674
G1 X233.30277 Y180.26050 E0.166924
G1 X232.85066 Y180.03014 E0.015591
G1 X234.44466 Y185.97902 E0.189241
G1 X234.17966 Y186.44693 E0.016523
G1 X232.39856 Y179.79978 E0.211454
G1 X231.94645 Y179.56942 E0.015591
G1 X233.91378 Y186.91158 E0.233563
G1 X233.64705 Y187.37305 E0.016378
G1 X231.49434 Y179.33906 E0.255570
G1 X231.04224 Y179.10870 E0.015591
G1 X233.37947 Y187.83137 E0.277478
G1 X233.11106 Y188.28655 E0.016237
G1 X230.59013 Y178.87834 E0.299286
G1 X230.13803 Y178.64798 E0.015591
G1 X232.84182 Y188.73868 E0.320997
G1 X232.57178 Y189.18778 E0.016102
G1 X229.68592 Y178.41762 E0.342611
G1 X229.23381 Y178.18726 E0.015591
G1 X232.30092 Y189.63386 E0.364129
G1 X232.02927 Y190.07698 E0.015971
G1 X228.78171 Y177.95690 E0.385554
G1 X228.32960 Y177.72654 E0.015591
G1 X231.75684 Y190.51718 E0.406885
G1 X231.48364 Y190.95451 E0.015844
G1 X227.87749 Y177.49618 E0.428125
G1 X227.42539 Y177.26582 E0.015591
G1 X228.65747 Y181.86400 E0.146273
G1 X228.96682 Y183.01852 E0.036727
G1 X231.20967 Y191.38895 E0.266273
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.09654 Y181.22753 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X227.04371 Y177.29829 E0.124994
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.79928 Y183.85018 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X230.93494 Y191.82057 E0.253547
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X227.63208 Y180.95105 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X226.78589 Y177.79303 E0.100460
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.53528 Y184.32185 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X230.58633 Y191.97647 E0.243502
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X227.20430 Y180.81147 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X226.52702 Y178.28382 E0.080408
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.23460 Y184.65662 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X230.11371 Y191.66954 E0.223089
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X226.80045 Y180.76121 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X226.26710 Y178.77071 E0.063320
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X227.90999 Y184.90207 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X229.64109 Y191.36262 E0.205517
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X226.41557 Y180.78174 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X226.00615 Y179.25378 E0.048606
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X227.56641 Y185.07673 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X229.16847 Y191.05569 E0.190198
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X226.04763 Y180.86549 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X225.74419 Y179.73306 E0.036024
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X227.20589 Y185.18818 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X228.69584 Y190.74877 E0.176889
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.69628 Y181.01118 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X225.48124 Y180.20864 E0.025530
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X226.82877 Y185.23767 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X228.22322 Y190.44185 E0.165551
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.36274 Y181.22330 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X225.21731 Y180.68056 E0.017265
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X226.43385 Y185.22075 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X227.75060 Y190.13492 E0.156326
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.05037 Y181.51446 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X224.95241 Y181.14887 E0.011630
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X226.01776 Y185.12478 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X227.27798 Y189.82800 E0.149615
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.76728 Y181.91487 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X224.68657 Y181.61364 E0.009583
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.57238 Y184.91955 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X226.80536 Y189.52107 E0.146380
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.53898 Y182.51977 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X224.41978 Y182.07491 E0.014152
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.07222 Y184.50984 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X226.33274 Y189.21415 E0.149649
G1 X225.86011 Y188.90723 E0.017316
G1 X224.15207 Y182.53273 E0.202780
G1 X223.88345 Y182.98714 E0.016220
G1 X225.38749 Y188.60030 E0.178561
G1 X224.91487 Y188.29338 E0.017316
G1 X223.61393 Y183.43819 E0.154449
G1 X223.34352 Y183.88594 E0.016072
G1 X224.44225 Y187.98645 E0.130442
G1 X223.96963 Y187.67953 E0.017316
G1 X223.07224 Y184.33044 E0.106538
G1 X222.80009 Y184.77169 E0.015930
G1 X223.49701 Y187.37260 E0.082738
G1 X223.02438 Y187.06568 E0.017316
G1 X222.52710 Y185.20977 E0.059039
G1 X222.25326 Y185.64473 E0.015793
G1 X222.55176 Y186.75876 E0.035438
G1 X222.07914 Y186.45183 E0.017316
G1 X221.97859 Y186.07657 E0.011938
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.96999 Y240.60229 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F1500
G2 X128.60229 Y238.03001 I-1.96999 J-0.60229 E0.099428
G2 X126.03001 Y239.39771 I-0.60229 J1.96999 E0.099428
G2 X127.39771 Y241.96999 I1.96999 J0.60229 E0.099428
G2 X129.96999 Y240.60229 I0.60229 J-1.96999 E0.099428
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X134.04482 Y248.22061 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F1500
G1 X133.46860 Y237.22564 E0.338308
G3 X122.53140 Y237.22564 I-5.46860 J-111.22564 E0.336205
G1 X121.95518 Y248.22061 E0.338308
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X133.84631 Y247.87213 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F1800
G1 X133.67009 Y248.04835 E0.007657
G1 X133.11217 Y248.07300 E0.017160
G1 X133.81975 Y247.36541 E0.030748
G1 X133.79319 Y246.85870 E0.015591
G1 X132.55692 Y248.09498 E0.053722
G1 X132.00427 Y248.11436 E0.016992
G1 X133.76664 Y246.35198 E0.076584
G1 X133.74008 Y245.84527 E0.015591
G1 X131.45420 Y248.13115 E0.099333
G1 X130.90667 Y248.14541 E0.016830
G1 X133.71353 Y245.33855 E0.121972
G1 X133.68697 Y244.83184 E0.015591
G1 X130.36165 Y248.15716 E0.144501
G1 X129.81909 Y248.16645 E0.016674
G1 X133.66042 Y244.32512 E0.166924
G1 X133.63386 Y243.81841 E0.015591
G1 X129.27898 Y248.17329 E0.189241
G1 X128.74125 Y248.17775 E0.016523
G1 X133.60730 Y243.31169 E0.211454
G1 X133.58075 Y242.80498 E0.015591
G1 X128.20591 Y248.17981 E0.233563
G1 X127.67290 Y248.17955 E0.016378
G1 X133.55419 Y242.29826 E0.255570
G1 X133.52764 Y241.79155 E0.015591
G1 X127.14220 Y248.17699 E0.277478
G1 X126.61379 Y248.17212 E0.016237
G1 X133.50108 Y241.28483 E0.299286
G1 X133.47453 Y240.77811 E0.015591
G1 X126.08762 Y248.16502 E0.320997
G1 X125.56366 Y248.15570 E0.016102
G1 X133.44797 Y240.27140 E0.342611
G1 X133.42141 Y239.76468 E0.015591
G1 X125.04192 Y248.14417 E0.364129
G1 X124.52234 Y248.13048 E0.015971
G1 X133.39486 Y239.25797 E0.385554
G1 X133.36830 Y238.75125 E0.015591
G1 X124.00490 Y248.11465 E0.406885
G1 X123.48957 Y248.09672 E0.015844
G1 X133.34175 Y238.24454 E0.428125
G1 X133.31519 Y237.73782 E0.015591
G1 X129.94909 Y241.10392 E0.146273
G1 X129.10392 Y241.94909 E0.036727
G1 X122.97634 Y248.07667 E0.266273
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.21983 Y240.29992 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.09623 Y237.42351 E0.124994
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X128.29992 Y242.21983 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.46519 Y248.05456 E0.253547
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.22703 Y239.75944 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X132.53886 Y237.44761 E0.100460
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X127.75944 Y242.22703 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.15587 Y247.83060 E0.243502
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.13402 Y239.31918 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X131.98439 Y237.46881 E0.080408
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X127.31918 Y242.13402 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.18536 Y247.26784 E0.223089
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.97563 Y238.94430 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X131.43277 Y237.48716 E0.063320
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X126.94430 Y241.97563 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.21486 Y246.70507 E0.205517
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.76540 Y238.62125 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X130.88395 Y237.50270 E0.048606
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X126.62125 Y241.76540 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.24435 Y246.14231 E0.190198
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.50891 Y238.34448 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X130.33790 Y237.51549 E0.036024
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X126.34448 Y241.50891 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.27384 Y245.57954 E0.176889
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.20706 Y238.11305 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X129.79456 Y237.52555 E0.025530
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X126.11305 Y241.20706 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.30334 Y245.01678 E0.165551
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X128.85659 Y237.93025 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X129.25390 Y237.53294 E0.017265
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.93025 Y240.85659 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.33283 Y244.45401 E0.156326
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X128.44826 Y237.80532 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X128.71588 Y237.53769 E0.011630
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.80532 Y240.44826 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.36232 Y243.89125 E0.149615
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X127.95994 Y237.76036 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X128.18046 Y237.53984 E0.009583
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.76036 Y239.95994 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.39182 Y243.32849 E0.146380
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X127.32193 Y237.86510 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X127.64760 Y237.53943 E0.014152
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.86510 Y239.32193 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.42131 Y242.76572 E0.149649
G1 X122.45080 Y242.20296 E0.017316
G1 X127.11725 Y237.53651 E0.202780
G1 X126.58942 Y237.53107 E0.016220
G1 X122.48030 Y241.64019 E0.178561
G1 X122.50979 Y241.07743 E0.017316
G1 X126.06403 Y237.52318 E0.154449
G1 X125.54106 Y237.51288 E0.016072
G1 X122.53928 Y240.51466 E0.130442
G1 X122.56878 Y239.95190 E0.017316
G1 X125.02048 Y237.50020 E0.106538
G1 X124.50227 Y237.48513 E0.015930
G1 X122.59827 Y239.38914 E0.082738
G1 X122.62776 Y238.82637 E0.017316
G1 X123.98638 Y237.46775 E0.059039
G1 X123.47278 Y237.44809 E0.015793
G1 X122.65725 Y238.26361 E0.035438
G1 X122.68675 Y237.70084 E0.017316
G1 X122.96146 Y237.42613 E0.011938
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.24309 Y183.60229 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F1500
G2 X29.87539 Y181.03001 I-1.96999 J-0.60229 E0.099428
G2 X27.30312 Y182.39771 I-0.60229 J1.96999 E0.099428
G2 X28.67082 Y184.96999 I1.96999 J0.60229 E0.099428
G2 X31.24309 Y183.60229 I0.60229 J-1.96999 E0.099428
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X25.17626 Y192.34527 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F1500
G1 X34.41006 Y186.34876 E0.338308
G3 X28.94147 Y176.87688 I93.58994 J-60.34876 E0.336205
G1 X19.13144 Y181.87534 E0.338308
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X25.37879 Y191.99911 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F1800
G1 X25.13808 Y191.93461 E0.007657
G1 X24.83777 Y191.46377 E0.017160
G1 X25.80434 Y191.72276 E0.030748
G1 X26.22989 Y191.44640 E0.015591
G1 X24.54111 Y190.99389 E0.053722
G1 X24.24800 Y190.52497 E0.016992
G1 X26.65544 Y191.17005 E0.076584
G1 X27.08100 Y190.89369 E0.015591
G1 X23.95842 Y190.05700 E0.099333
G1 X23.67231 Y189.58995 E0.016830
G1 X27.50655 Y190.61734 E0.121972
G1 X27.93210 Y190.34098 E0.015591
G1 X23.38962 Y189.12383 E0.144501
G1 X23.11029 Y188.65860 E0.016674
G1 X28.35765 Y190.06462 E0.166924
G1 X28.78320 Y189.78827 E0.015591
G1 X22.83431 Y188.19427 E0.189241
G1 X22.56159 Y187.73081 E0.016523
G1 X29.20875 Y189.51191 E0.211454
G1 X29.63430 Y189.23556 E0.015591
G1 X22.29213 Y187.26823 E0.233563
G1 X22.02586 Y186.80650 E0.016378
G1 X30.05985 Y188.95920 E0.255570
G1 X30.48540 Y188.68285 E0.015591
G1 X21.76272 Y186.34561 E0.277478
G1 X21.50273 Y185.88557 E0.016237
G1 X30.91095 Y188.40649 E0.299286
G1 X31.33650 Y188.13014 E0.015591
G1 X21.24580 Y185.42634 E0.320997
G1 X20.99189 Y184.96792 E0.016102
G1 X31.76205 Y187.85378 E0.342611
G1 X32.18760 Y187.57742 E0.015591
G1 X20.74100 Y184.51032 E0.364129
G1 X20.49307 Y184.05350 E0.015971
G1 X32.61315 Y187.30107 E0.385554
G1 X33.03870 Y187.02471 E0.015591
G1 X20.24806 Y183.59747 E0.406885
G1 X20.00593 Y183.14221 E0.015844
G1 X33.46425 Y186.74836 E0.428125
G1 X33.88980 Y186.47200 E0.015591
G1 X29.29162 Y185.23992 E0.146273
G1 X28.13710 Y184.93057 E0.036727
G1 X19.76668 Y182.68772 E0.266273
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.12328 Y185.07238 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X34.05253 Y186.12522 E0.124994
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.50063 Y184.36965 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X19.53025 Y182.23399 E0.253547
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.59496 Y184.80839 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X33.75297 Y185.65458 E0.100460
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.22415 Y183.90518 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X19.56954 Y181.85414 E0.243502
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.92972 Y184.50771 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X33.45738 Y185.18499 E0.080408
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.08458 Y183.47740 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X20.07165 Y181.59830 E0.223089
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.17518 Y184.18309 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X33.16567 Y184.71645 E0.063320
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.03431 Y183.07355 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X20.57377 Y181.34245 E0.205517
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.34983 Y183.83951 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X32.87780 Y184.24893 E0.048606
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.05485 Y182.68867 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X21.07588 Y181.08661 E0.190198
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.46128 Y183.47899 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X32.59370 Y183.78242 E0.036024
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.13859 Y182.32073 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X21.57800 Y180.83077 E0.176889
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.51078 Y183.10187 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X32.31332 Y183.31691 E0.025530
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.28428 Y181.96939 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X22.08011 Y180.57493 E0.165551
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.49385 Y182.70696 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X32.03659 Y182.85238 E0.017265
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.49640 Y181.63584 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X22.58223 Y180.31909 E0.156326
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.39789 Y182.29086 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X31.76347 Y182.38882 E0.011630
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.78756 Y181.32348 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X23.08434 Y180.06325 E0.149615
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.19266 Y181.84549 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X31.49389 Y181.92620 E0.009583
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X28.18798 Y181.04039 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X23.58646 Y179.80741 E0.146380
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.78295 Y181.34533 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X31.22781 Y181.46453 E0.014152
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X28.79288 Y180.81209 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X24.08857 Y179.55157 E0.149649
G1 X24.59069 Y179.29573 E0.017316
G1 X30.96518 Y181.00377 E0.202780
G1 X30.70597 Y180.54394 E0.016220
G1 X25.09280 Y179.03989 E0.178561
G1 X25.59492 Y178.78405 E0.017316
G1 X30.45011 Y180.08500 E0.154449
G1 X30.19754 Y179.62694 E0.016072
G1 X26.09703 Y178.52821 E0.130442
G1 X26.59915 Y178.27237 E0.017316
G1 X29.94824 Y179.16976 E0.106538
G1 X29.70218 Y178.71344 E0.015930
G1 X27.10126 Y178.01653 E0.082738
G1 X27.60338 Y177.76069 E0.017316
G1 X29.45929 Y178.25798 E0.059039
G1 X29.21952 Y177.80335 E0.015793
G1 X28.10549 Y177.50485 E0.035438
G1 X28.60761 Y177.24901 E0.017316
G1 X28.98287 Y177.34956 E0.011938
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.24309 Y69.60229 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F1500
G2 X29.87539 Y67.03001 I-1.96999 J-0.60229 E0.099428
G2 X27.30312 Y68.39771 I-0.60229 J1.96999 E0.099428
G2 X28.67082 Y70.96999 I1.96999 J0.60229 E0.099428
G2 X31.24309 Y69.60229 I0.60229 J-1.96999 E0.099428
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X19.13144 Y70.12466 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F1500
G1 X28.94147 Y75.12312 E0.338308
G3 X34.41006 Y65.65124 I99.05853 J50.87688 E0.336205
G1 X25.17626 Y59.65473 E0.338308
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X19.53249 Y70.12699 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F1800
G1 X19.46799 Y69.88627 E0.007657
G1 X19.72560 Y69.39077 E0.017160
G1 X19.98459 Y70.35735 E0.030748
G1 X20.43670 Y70.58770 E0.015591
G1 X19.98419 Y68.89892 E0.053722
G1 X20.24373 Y68.41062 E0.016992
G1 X20.88881 Y70.81806 E0.076584
G1 X21.34091 Y71.04842 E0.015591
G1 X20.50422 Y67.92585 E0.099333
G1 X20.76564 Y67.44454 E0.016830
G1 X21.79302 Y71.27878 E0.121972
G1 X22.24512 Y71.50914 E0.015591
G1 X21.02797 Y66.96667 E0.144501
G1 X21.29121 Y66.49215 E0.016674
G1 X22.69723 Y71.73950 E0.166924
G1 X23.14934 Y71.96986 E0.015591
G1 X21.55534 Y66.02098 E0.189241
G1 X21.82034 Y65.55307 E0.016523
G1 X23.60144 Y72.20022 E0.211454
G1 X24.05355 Y72.43058 E0.015591
G1 X22.08622 Y65.08842 E0.233563
G1 X22.35295 Y64.62695 E0.016378
G1 X24.50566 Y72.66094 E0.255570
G1 X24.95776 Y72.89130 E0.015591
G1 X22.62053 Y64.16863 E0.277478
G1 X22.88894 Y63.71345 E0.016237
G1 X25.40987 Y73.12166 E0.299286
G1 X25.86197 Y73.35202 E0.015591
G1 X23.15818 Y63.26132 E0.320997
G1 X23.42822 Y62.81222 E0.016102
G1 X26.31408 Y73.58238 E0.342611
G1 X26.76619 Y73.81274 E0.015591
G1 X23.69908 Y62.36614 E0.364129
G1 X23.97073 Y61.92302 E0.015971
G1 X27.21829 Y74.04310 E0.385554
G1 X27.67040 Y74.27346 E0.015591
G1 X24.24316 Y61.48282 E0.406885
G1 X24.51636 Y61.04549 E0.015844
G1 X28.12251 Y74.50382 E0.428125
G1 X28.57461 Y74.73418 E0.015591
G1 X27.34253 Y70.13600 E0.146273
G1 X27.03318 Y68.98148 E0.036727
G1 X24.79033 Y60.61105 E0.266273
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.90346 Y70.77247 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X28.95629 Y74.70171 E0.124994
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.20072 Y68.14982 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X25.06506 Y60.17943 E0.253547
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X28.36792 Y71.04895 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X29.21411 Y74.20697 E0.100460
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.46472 Y67.67815 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X25.41367 Y60.02353 E0.243502
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X28.79570 Y71.18853 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X29.47298 Y73.71618 E0.080408
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.76540 Y67.34338 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X25.88629 Y60.33046 E0.223089
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X29.19955 Y71.23879 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X29.73290 Y73.22929 E0.063320
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X28.09001 Y67.09793 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X26.35891 Y60.63738 E0.205517
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X29.58443 Y71.21826 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X29.99385 Y72.74622 E0.048606
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X28.43359 Y66.92327 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X26.83153 Y60.94431 E0.190198
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X29.95237 Y71.13451 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X30.25581 Y72.26694 E0.036024
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X28.79411 Y66.81182 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X27.30416 Y61.25123 E0.176889
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.30372 Y70.98882 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X30.51876 Y71.79136 E0.025530
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X29.17123 Y66.76233 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X27.77678 Y61.55815 E0.165551
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.63726 Y70.77670 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X30.78269 Y71.31944 E0.017265
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X29.56615 Y66.77925 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X28.24940 Y61.86508 E0.156326
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.94963 Y70.48554 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X31.04759 Y70.85113 E0.011630
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X29.98224 Y66.87522 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X28.72202 Y62.17200 E0.149615
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.23272 Y70.08513 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X31.31343 Y70.38636 E0.009583
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.42762 Y67.08045 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X29.19464 Y62.47893 E0.146380
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.46102 Y69.48023 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X31.58022 Y69.92509 E0.014152
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.92778 Y67.49016 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X29.66726 Y62.78585 E0.149649
G1 X30.13989 Y63.09277 E0.017316
G1 X31.84793 Y69.46727 E0.202780
G1 X32.11655 Y69.01286 E0.016220
G1 X30.61251 Y63.39970 E0.178561
G1 X31.08513 Y63.70662 E0.017316
G1 X32.38607 Y68.56181 E0.154449
G1 X32.65648 Y68.11406 E0.016072
G1 X31.55775 Y64.01355 E0.130442
G1 X32.03037 Y64.32047 E0.017316
G1 X32.92776 Y67.66956 E0.106538
G1 X33.19991 Y67.22831 E0.015930
G1 X32.50299 Y64.62740 E0.082738
G1 X32.97562 Y64.93432 E0.017316
G1 X33.47290 Y66.79023 E0.059039
G1 X33.74674 Y66.35527 E0.015793
G1 X33.44824 Y65.24124 E0.035438
G1 X33.92086 Y65.54817 E0.017316
G1 X34.02141 Y65.92343 E0.011938
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.96999 Y12.60229 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F1500
G2 X128.60229 Y10.03001 I-1.96999 J-0.60229 E0.099428
G2 X126.03001 Y11.39771 I-0.60229 J1.96999 E0.099428
G2 X127.39771 Y13.96999 I1.96999 J0.60229 E0.099428
G2 X129.96999 Y12.60229 I0.60229 J-1.96999 E0.099428
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X121.95518 Y3.77939 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F1500
G1 X122.53140 Y14.77436 E0.338308
G3 X133.46860 Y14.77436 I5.46860 J111.22564 E0.336205
G1 X134.04482 Y3.77939 E0.338308
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X122.15369 Y4.12787 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F1800
G1 X122.32991 Y3.95165 E0.007657
G1 X122.88783 Y3.92700 E0.017160
G1 X122.18025 Y4.63459 E0.030748
G1 X122.20681 Y5.14130 E0.015591
G1 X123.44308 Y3.90502 E0.053722
G1 X123.99573 Y3.88564 E0.016992
G1 X122.23336 Y5.64802 E0.076584
G1 X122.25992 Y6.15473 E0.015591
G1 X124.54580 Y3.86885 E0.099333
G1 X125.09333 Y3.85459 E0.016830
G1 X122.28647 Y6.66145 E0.121972
G1 X122.31303 Y7.16816 E0.015591
G1 X125.63835 Y3.84284 E0.144501
G1 X126.18091 Y3.83355 E0.016674
G1 X122.33958 Y7.67488 E0.166924
G1 X122.36614 Y8.18159 E0.015591
G1 X126.72102 Y3.82671 E0.189241
G1 X127.25875 Y3.82225 E0.016523
G1 X122.39270 Y8.68831 E0.211454
G1 X122.41925 Y9.19502 E0.015591
G1 X127.79409 Y3.82019 E0.233563
G1 X128.32710 Y3.82045 E0.016378
G1 X122.44581 Y9.70174 E0.255570
G1 X122.47236 Y10.20845 E0.015591
G1 X128.85780 Y3.82301 E0.277478
G1 X129.38621 Y3.82788 E0.016237
G1 X122.49892 Y10.71517 E0.299286
G1 X122.52547 Y11.22189 E0.015591
G1 X129.91238 Y3.83498 E0.320997
G1 X130.43634 Y3.84430 E0.016102
G1 X122.55203 Y11.72860 E0.342611
G1 X122.57859 Y12.23532 E0.015591
G1 X130.95808 Y3.85583 E0.364129
G1 X131.47766 Y3.86952 E0.015971
G1 X122.60514 Y12.74203 E0.385554
G1 X122.63170 Y13.24875 E0.015591
G1 X131.99510 Y3.88535 E0.406885
G1 X132.51043 Y3.90328 E0.015844
G1 X122.65825 Y13.75546 E0.428125
G1 X122.68481 Y14.26218 E0.015591
G1 X126.05091 Y10.89608 E0.146273
G1 X126.89608 Y10.05091 E0.036727
G1 X133.02366 Y3.92333 E0.266273
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.78017 Y11.70008 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X122.90377 Y14.57649 E0.124994
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X127.70008 Y9.78017 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.53481 Y3.94544 E0.253547
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.77297 Y12.24056 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X123.46114 Y14.55239 E0.100460
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X128.24056 Y9.77297 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.84413 Y4.16940 E0.243502
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.86598 Y12.68082 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X124.01561 Y14.53119 E0.080408
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X128.68082 Y9.86598 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.81464 Y4.73216 E0.223089
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X126.02437 Y13.05570 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X124.56723 Y14.51284 E0.063320
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.05570 Y10.02437 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.78514 Y5.29493 E0.205517
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X126.23460 Y13.37875 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X125.11605 Y14.49730 E0.048606
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.37875 Y10.23460 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.75565 Y5.85769 E0.190198
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X126.49109 Y13.65552 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X125.66210 Y14.48451 E0.036024
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.65552 Y10.49109 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.72616 Y6.42046 E0.176889
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X126.79294 Y13.88695 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X126.20544 Y14.47445 E0.025530
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.88695 Y10.79294 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.69666 Y6.98322 E0.165551
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X127.14341 Y14.06975 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X126.74610 Y14.46706 E0.017265
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.06975 Y11.14341 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.66717 Y7.54599 E0.156326
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X127.55174 Y14.19468 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X127.28412 Y14.46231 E0.011630
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.19468 Y11.55174 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.63768 Y8.10875 E0.149615
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X128.04006 Y14.23964 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X127.81954 Y14.46016 E0.009583
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.23964 Y12.04006 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.60818 Y8.67151 E0.146380
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X128.67807 Y14.13490 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X128.35240 Y14.46057 E0.014152
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.13490 Y12.67807 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X133.57869 Y9.23428 E0.149649
G1 X133.54920 Y9.79704 E0.017316
G1 X128.88275 Y14.46349 E0.202780
G1 X129.41058 Y14.46893 E0.016220
G1 X133.51970 Y10.35981 E0.178561
G1 X133.49021 Y10.92257 E0.017316
G1 X129.93597 Y14.47682 E0.154449
G1 X130.45894 Y14.48712 E0.016072
G1 X133.46072 Y11.48534 E0.130442
G1 X133.43122 Y12.04810 E0.017316
G1 X130.97952 Y14.49980 E0.106538
G1 X131.49773 Y14.51487 E0.015930
G1 X133.40173 Y12.61086 E0.082738
G1 X133.37224 Y13.17363 E0.017316
G1 X132.01362 Y14.53225 E0.059039
G1 X132.52722 Y14.55191 E0.015793
G1 X133.34275 Y13.73639 E0.035438
G1 X133.31325 Y14.29916 E0.017316
G1 X133.03854 Y14.57387 E0.011938
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.69688 Y69.60229 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F1500
G2 X227.32918 Y67.03001 I-1.96999 J-0.60229 E0.099428
G2 X224.75691 Y68.39771 I-0.60229 J1.96999 E0.099428
G2 X226.12461 Y70.96999 I1.96999 J0.60229 E0.099428
G2 X228.69688 Y69.60229 I0.60229 J-1.96999 E0.099428
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X230.82374 Y59.65473 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F1500
G1 X221.58994 Y65.65124 E0.338308
G3 X227.05853 Y75.12312 I-93.58994 J60.34876 E0.336205
G1 X236.86856 Y70.12466 E0.338308
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X230.62121 Y60.00089 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F1800
G1 X230.86192 Y60.06539 E0.007657
G1 X231.16223 Y60.53623 E0.017160
G1 X230.19566 Y60.27724 E0.030748
G1 X229.77011 Y60.55360 E0.015591
G1 X231.45889 Y61.00611 E0.053722
G1 X231.75200 Y61.47503 E0.016992
G1 X229.34456 Y60.82995 E0.076584
G1 X228.91900 Y61.10631 E0.015591
G1 X232.04158 Y61.94300 E0.099333
G1 X232.32769 Y62.41005 E0.016830
G1 X228.49345 Y61.38266 E0.121972
G1 X228.06790 Y61.65902 E0.015591
G1 X232.61038 Y62.87617 E0.144501
G1 X232.88971 Y63.34140 E0.016674
G1 X227.64235 Y61.93538 E0.166924
G1 X227.21680 Y62.21173 E0.015591
G1 X233.16569 Y63.80573 E0.189241
G1 X233.43841 Y64.26919 E0.016523
G1 X226.79125 Y62.48809 E0.211454
G1 X226.36570 Y62.76444 E0.015591
G1 X233.70787 Y64.73177 E0.233563
G1 X233.97414 Y65.19350 E0.016378
G1 X225.94015 Y63.04080 E0.255570
G1 X225.51460 Y63.31715 E0.015591
G1 X234.23728 Y65.65439 E0.277478
G1 X234.49727 Y66.11443 E0.016237
G1 X225.08905 Y63.59351 E0.299286
G1 X224.66350 Y63.86986 E0.015591
G1 X234.75420 Y66.57366 E0.320997
G1 X235.00811 Y67.03208 E0.016102
G1 X224.23795 Y64.14622 E0.342611
G1 X223.81240 Y64.42258 E0.015591
G1 X235.25900 Y67.48968 E0.364129
G1 X235.50693 Y67.94650 E0.015971
G1 X223.38685 Y64.69893 E0.385554
G1 X222.96130 Y64.97529 E0.015591
G1 X235.75194 Y68.40253 E0.406885
G1 X235.99407 Y68.85779 E0.015844
G1 X222.53575 Y65.25164 E0.428125
G1 X222.11020 Y65.52800 E0.015591
G1 X226.70838 Y66.76008 E0.146273
G1 X227.86290 Y67.06943 E0.036727
G1 X236.23332 Y69.31228 E0.266273
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.87672 Y66.92762 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X221.94747 Y65.87478 E0.124994
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.49937 Y67.63035 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X236.46975 Y69.76601 E0.253547
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.40504 Y67.19161 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X222.24703 Y66.34542 E0.100460
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.77585 Y68.09482 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X236.43046 Y70.14586 E0.243502
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.07028 Y67.49229 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X222.54262 Y66.81501 E0.080408
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.91542 Y68.52260 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X235.92835 Y70.40170 E0.223089
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.82482 Y67.81691 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X222.83433 Y67.28355 E0.063320
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.96569 Y68.92645 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X235.42623 Y70.65755 E0.205517
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.65017 Y68.16049 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X223.12220 Y67.75107 E0.048606
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.94515 Y69.31133 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X234.92412 Y70.91339 E0.190198
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.53872 Y68.52101 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X223.40630 Y68.21758 E0.036024
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.86141 Y69.67927 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X234.42200 Y71.16923 E0.176889
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.48922 Y68.89813 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X223.68668 Y68.68309 E0.025530
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.71572 Y70.03061 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X233.91989 Y71.42507 E0.165551
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.50615 Y69.29304 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X223.96341 Y69.14762 E0.017265
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.50360 Y70.36416 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X233.41777 Y71.68091 E0.156326
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.60211 Y69.70914 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X224.23653 Y69.61118 E0.011630
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.21244 Y70.67652 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X232.91566 Y71.93675 E0.149615
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.80734 Y70.15451 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X224.50611 Y70.07380 E0.009583
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X227.81202 Y70.95961 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X232.41354 Y72.19259 E0.146380
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.21705 Y70.65467 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X224.77219 Y70.53547 E0.014152
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X227.20712 Y71.18791 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1800
G1 X231.91143 Y72.44843 E0.149649
G1 X231.40931 Y72.70427 E0.017316
G1 X225.03482 Y70.99623 E0.202780
G1 X225.29403 Y71.45606 E0.016220
G1 X230.90720 Y72.96011 E0.178561
G1 X230.40508 Y73.21595 E0.017316
G1 X225.54989 Y71.91500 E0.154449
G1 X225.80246 Y72.37306 E0.016072
G1 X229.90297 Y73.47179 E0.130442
G1 X229.40085 Y73.72763 E0.017316
G1 X226.05176 Y72.83024 E0.106538
G1 X226.29782 Y73.28656 E0.015930
G1 X228.89874 Y73.98347 E0.082738
G1 X228.39662 Y74.23931 E0.017316
G1 X226.54071 Y73.74202 E0.059039
G1 X226.78048 Y74.19665 E0.015793
G1 X227.89451 Y74.49515 E0.035438
G1 X227.39239 Y74.75099 E0.017316
G1 X227.01713 Y74.65044 E0.011938
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X244.99162 Y161.76793 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.37434
M204 S1000
G1 F1500
G3 X92.23207 Y242.99162 I-116.99162 J-35.76793 E5.189694
G3 X11.00838 Y90.23207 I35.76793 J-116.99162 E5.189694
G3 X163.76793 Y9.00838 I116.99162 J35.76793 E5.189694
G3 X244.99162 Y161.76793 I-35.76793 J116.99162 E5.189694
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X245.30855 Y161.86482 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G3 X92.13518 Y243.30855 I-117.30855 J-35.86482 E5.203753
G3 X10.69145 Y90.13518 I35.86482 J-117.30855 E5.203753
G3 X163.86482 Y8.69145 I117.30855 J35.86482 E5.203753
G3 X245.30855 Y161.86482 I-35.86482 J117.30855 E5.203753
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X245.62548 Y161.96172 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G3 X92.03828 Y243.62548 I-117.62548 J-35.96172 E5.217812
G3 X10.37452 Y90.03828 I35.96172 J-117.62548 E5.217812
G3 X163.96172 Y8.37452 I117.62548 J35.96172 E5.217812
G3 X245.62548 Y161.96172 I-35.96172 J117.62548 E5.217812
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X245.94242 Y162.05862 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G3 X91.94138 Y243.94242 I-117.94242 J-36.05862 E5.231871
G3 X10.05758 Y89.94138 I36.05862 J-117.94242 E5.231871
G3 X164.05862 Y8.05758 I117.94242 J36.05862 E5.231871
G3 X245.94242 Y162.05862 I-36.05862 J117.94242 E5.231871
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X246.25935 Y162.15551 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F1500
; ANALYTIC_ROLLING_SURFACE_START
G3 X91.84449 Y244.25935 I-118.25935 J-36.15551 E5.245930
G3 X9.74065 Y89.84449 I36.15551 J-118.25935 E5.245930
G3 X164.15551 Y7.74065 I118.25935 J36.15551 E5.245930
G3 X246.25935 Y162.15551 I-36.15551 J118.25935 E5.245930
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 0.400
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 2/20
M73 L2
M991 S0 P1
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.92161 Y183.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X227.58767 Y184.80529 I1.80529 J-0.86078 E0.104212
G2 X228.53218 Y182.13922 I-0.86078 J-1.80529 E0.104212
G2 X225.86612 Y181.19471 I-1.80529 J0.86078 E0.104212
G2 X224.92161 Y183.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X236.82912 Y181.78790 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X227.03247 Y176.79626 E0.364726
G3 X221.50709 Y186.36650 I-99.03247 J-50.79626 E0.366725
G1 X230.72830 Y192.35483 E0.364726
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.05334 Y177.21439 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X227.27432 Y177.15518 E0.007589
G1 X227.81638 Y177.43137 E0.020181
G1 X226.79861 Y177.70408 E0.034952
G1 X226.54028 Y178.19474 E0.018394
G1 X228.35844 Y177.70757 E0.062440
G1 X228.90051 Y177.98376 E0.020181
G1 X226.27829 Y178.68638 E0.090052
G1 X226.01260 Y179.17901 E0.018567
G1 X229.44257 Y178.25996 E0.117792
G1 X229.98463 Y178.53615 E0.020181
G1 X225.74315 Y179.67265 E0.145661
G1 X225.46989 Y180.16731 E0.018746
G1 X230.52669 Y178.81235 E0.173661
G1 X231.06876 Y179.08854 E0.020181
G1 X225.19276 Y180.66301 E0.201793
G1 X224.91171 Y181.15976 E0.018933
G1 X231.61082 Y179.36474 E0.230061
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.06858 Y181.53916 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.62668 Y181.65757 E0.015176
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.43262 Y180.90572 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.15288 Y179.64093 E0.162103
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.73100 Y182.05106 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.33758 Y182.15647 E0.013511
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.98092 Y181.18024 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.69494 Y179.91712 E0.161889
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.57068 Y182.51545 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.04437 Y182.65648 E0.018075
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.35196 Y181.50226 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.23701 Y180.19332 E0.167762
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.51744 Y182.95116 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.74699 Y183.15760 E0.026459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.61592 Y181.85298 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.77907 Y180.46951 E0.177313
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.54719 Y183.36463 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.44538 Y183.65986 E0.037839
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.79689 Y182.22593 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.32113 Y180.74571 E0.189714
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.65105 Y183.75824 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.13943 Y184.16328 E0.051912
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.90375 Y182.61873 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.86319 Y181.02190 E0.204659
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.82885 Y184.13204 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.82910 Y184.66787 E0.068675
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.93667 Y183.03135 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.40526 Y181.29810 E0.222144
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.08905 Y184.48376 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.51433 Y185.17365 E0.088421
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.88719 Y183.46605 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.94732 Y181.57429 E0.242459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.45483 Y184.80718 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.19499 Y185.68066 E0.111950
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.73213 Y183.92904 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48938 Y181.85049 E0.266400
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.99275 Y185.08449 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.87105 Y186.18890 E0.141547
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.40493 Y184.43815 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.32593 Y182.31572 E0.272023
G1 X236.06972 Y182.80582 E0.018345
G1 X222.15215 Y186.53502 E0.477957
G1 X222.61156 Y186.83336 E0.018171
G1 X235.81023 Y183.29678 E0.453269
G1 X235.54736 Y183.78866 E0.018500
G1 X223.07096 Y187.13170 E0.428465
G1 X223.53037 Y187.43004 E0.018171
G1 X235.28113 Y184.28144 E0.403545
G1 X235.01144 Y184.77514 E0.018661
G1 X223.98978 Y187.72838 E0.378506
G1 X224.44918 Y188.02673 E0.018171
G1 X234.73827 Y185.26977 E0.353348
G1 X234.46159 Y185.76535 E0.018828
G1 X224.90859 Y188.32507 E0.328069
G1 X225.36800 Y188.62341 E0.018171
G1 X234.18130 Y186.26189 E0.302667
G1 X233.89740 Y186.75940 E0.019001
G1 X225.82740 Y188.92175 E0.277140
G1 X226.28681 Y189.22010 E0.018171
G1 X233.60984 Y187.25790 E0.251487
G1 X233.31851 Y187.75740 E0.019182
G1 X226.74622 Y189.51844 E0.225706
G1 X227.20562 Y189.81678 E0.018171
G1 X233.02341 Y188.25791 E0.199795
G1 X232.72448 Y188.75945 E0.019368
G1 X227.66503 Y190.11512 E0.173752
G1 X228.12444 Y190.41346 E0.018171
G1 X232.42166 Y189.26203 E0.147575
G1 X232.11486 Y189.76567 E0.019563
G1 X228.58384 Y190.71181 E0.121262
G1 X229.04325 Y191.01015 E0.018171
G1 X231.80405 Y190.27039 E0.094811
G1 X231.48916 Y190.77621 E0.019764
G1 X229.50266 Y191.30849 E0.068221
G1 X229.96206 Y191.60683 E0.018171
G1 X231.17014 Y191.28313 E0.041488
G1 X230.84690 Y191.79118 E0.019975
G1 X230.42147 Y191.90518 E0.014610
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.19471 Y240.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X128.86078 Y241.80529 I1.80529 J-0.86078 E0.104212
G2 X129.80529 Y239.13922 I-0.86078 J-1.80529 E0.104212
G2 X127.13922 Y238.19471 I-1.80529 J0.86078 E0.104212
G2 X126.19471 Y240.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X134.10082 Y248.14273 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.52538 Y237.16276 E0.364726
G3 X122.47462 Y237.16276 I-5.52538 J-111.16276 E0.366725
G1 X121.89918 Y248.14273 E0.364726
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X133.17371 Y237.38990 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.33548 Y237.55167 E0.007589
G1 X133.36732 Y238.15921 E0.020181
G1 X132.62225 Y237.41415 E0.034952
G1 X132.06816 Y237.43575 E0.018394
G1 X133.39915 Y238.76675 E0.062440
G1 X133.43099 Y239.37428 E0.020181
G1 X131.51140 Y237.45469 E0.090052
G1 X130.95192 Y237.47091 E0.018567
G1 X133.46283 Y239.98182 E0.117792
G1 X133.49467 Y240.58936 E0.020181
G1 X130.38969 Y237.48438 E0.145661
G1 X129.82468 Y237.49506 E0.018746
G1 X133.52651 Y241.19689 E0.173661
G1 X133.55835 Y241.80443 E0.020181
G1 X129.25683 Y237.50290 E0.201793
G1 X128.68611 Y237.50788 E0.018933
G1 X133.59019 Y242.41197 E0.230061
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X128.43596 Y237.83344 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.11247 Y237.50994 E0.015176
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X130.16656 Y239.56404 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.62203 Y243.01951 E0.162103
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X127.82386 Y237.79703 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.53585 Y237.50903 E0.013511
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X130.20297 Y240.17614 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.65387 Y243.62704 E0.161889
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X127.34152 Y237.89039 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.95623 Y237.50510 E0.018075
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X130.10961 Y240.65848 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.68571 Y244.23458 E0.167762
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.93757 Y238.06214 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.37356 Y237.49813 E0.026459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.93786 Y241.06243 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.71755 Y244.84212 E0.177313
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.59437 Y238.29464 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.78779 Y237.48805 E0.037839
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.70536 Y241.40563 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.74939 Y245.44965 E0.189714
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.30542 Y238.58139 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.19884 Y237.47480 E0.051912
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.41861 Y241.69458 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.78123 Y246.05719 E0.204659
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.07060 Y238.92226 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.60669 Y237.45834 E0.068675
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.07774 Y241.92940 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.81307 Y246.66473 E0.222144
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X125.89611 Y239.32346 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.01128 Y237.43864 E0.088421
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X128.67654 Y242.10389 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.84491 Y247.27227 E0.242459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X125.79890 Y239.80196 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.41253 Y237.41558 E0.111950
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X128.19804 Y242.20110 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87675 Y247.87980 E0.266400
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X125.82770 Y240.40645 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.81041 Y237.38916 E0.141547
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X127.59355 Y242.17230 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.39212 Y247.97087 E0.272023
G1 X132.83958 Y247.99403 E0.018345
G1 X122.65121 Y237.80566 E0.477957
G1 X122.62254 Y238.35269 E0.018171
G1 X132.28465 Y248.01479 E0.453269
G1 X131.72723 Y248.03308 E0.018500
G1 X122.59388 Y238.89972 E0.428465
G1 X122.56521 Y239.44675 E0.018171
G1 X131.16736 Y248.04890 E0.403545
G1 X130.60496 Y248.06219 E0.018661
G1 X122.53654 Y239.99378 E0.378506
G1 X122.50787 Y240.54081 E0.018171
G1 X130.04000 Y248.07294 E0.353348
G1 X129.47249 Y248.08112 E0.018828
G1 X122.47920 Y241.08784 E0.328069
G1 X122.45053 Y241.63487 E0.018171
G1 X128.90232 Y248.08665 E0.302667
G1 X128.32951 Y248.08954 E0.019001
G1 X122.42186 Y242.18189 E0.277140
G1 X122.39320 Y242.72892 E0.018171
G1 X127.75403 Y248.08975 E0.251487
G1 X127.17578 Y248.08721 E0.019182
G1 X122.36453 Y243.27595 E0.225706
G1 X122.33586 Y243.82298 E0.018171
G1 X126.59478 Y248.08190 E0.199795
G1 X126.01097 Y248.07379 E0.019368
G1 X122.30719 Y244.37001 E0.173752
G1 X122.27852 Y244.91704 E0.018171
G1 X125.42431 Y248.06283 E0.147575
G1 X124.83474 Y248.04895 E0.019563
G1 X122.24985 Y245.46407 E0.121262
G1 X122.22118 Y246.01110 E0.018171
G1 X124.24223 Y248.03214 E0.094811
G1 X123.64674 Y248.01235 E0.019764
G1 X122.19252 Y246.55813 E0.068221
G1 X122.16385 Y247.10515 E0.018171
G1 X123.04822 Y247.98953 E0.041488
G1 X122.44662 Y247.96362 E0.019975
G1 X122.13518 Y247.65218 E0.014610
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.46782 Y183.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X30.13388 Y184.80529 I1.80529 J-0.86078 E0.104212
G2 X31.07839 Y182.13922 I-0.86078 J-1.80529 E0.104212
G2 X28.41233 Y181.19471 I-1.80529 J0.86078 E0.104212
G2 X27.46782 Y183.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X25.27170 Y192.35483 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.49291 Y186.36650 E0.364726
G3 X28.96753 Y176.79626 I93.50709 J-60.36650 E0.366725
G1 X19.17088 Y181.78790 E0.364726
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X34.12037 Y186.17551 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X34.06116 Y186.39649 E0.007589
G1 X33.55093 Y186.72784 E0.020181
G1 X33.82365 Y185.71006 E0.034952
G1 X33.52789 Y185.24101 E0.018394
G1 X33.04071 Y187.05918 E0.062440
G1 X32.53049 Y187.39052 E0.020181
G1 X33.23311 Y184.76830 E0.090052
G1 X32.93932 Y184.29189 E0.018567
G1 X32.02027 Y187.72186 E0.117792
G1 X31.51004 Y188.05321 E0.020181
G1 X32.64654 Y183.81172 E0.145661
G1 X32.35479 Y183.32774 E0.018746
G1 X30.99982 Y188.38455 E0.173661
G1 X30.48960 Y188.71589 E0.020181
G1 X32.06406 Y182.83990 E0.201793
G1 X31.77439 Y182.34812 E0.018933
G1 X29.97937 Y189.04723 E0.230061
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.36738 Y182.29427 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.48579 Y181.85237 E0.015176
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.73394 Y184.65832 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.46915 Y189.37858 E0.162103
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.09286 Y181.74597 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.19828 Y181.35255 E0.013511
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.22205 Y184.99590 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.95893 Y189.70992 E0.161889
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.77084 Y181.37493 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.91187 Y180.84862 E0.018075
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X29.75765 Y185.15622 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.44871 Y190.04126 E0.167762
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.42013 Y181.11098 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.62657 Y180.34052 E0.026459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X29.32195 Y185.20945 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.93848 Y190.37260 E0.177313
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.04718 Y180.93001 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.34241 Y179.82819 E0.037839
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.90848 Y185.17970 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.42826 Y190.70395 E0.189714
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X29.65437 Y180.82315 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.05941 Y179.31153 E0.051912
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.51487 Y185.07584 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.91804 Y191.03529 E0.204659
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X29.24175 Y180.79022 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.77759 Y178.79048 E0.068675
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.14107 Y184.89805 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.40781 Y191.36663 E0.222144
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.80706 Y180.83971 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.49695 Y178.26498 E0.088421
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.78935 Y184.63784 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.89759 Y191.69797 E0.242459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.34407 Y180.99477 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.21754 Y177.73493 E0.111950
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.46592 Y184.27206 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38737 Y192.02932 E0.266400
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.83496 Y181.32196 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.93936 Y177.20027 E0.141547
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.18861 Y183.73415 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.06619 Y191.65515 E0.272023
G1 X24.76986 Y191.18821 E0.018345
G1 X28.49906 Y177.27065 E0.477957
G1 X28.01099 Y177.51933 E0.018171
G1 X24.47441 Y190.71801 E0.453269
G1 X24.17987 Y190.24442 E0.018500
G1 X27.52291 Y177.76802 E0.428465
G1 X27.03484 Y178.01671 E0.018171
G1 X23.88623 Y189.76746 E0.403545
G1 X23.59352 Y189.28706 E0.018661
G1 X26.54676 Y178.26539 E0.378506
G1 X26.05869 Y178.51408 E0.018171
G1 X23.30173 Y188.80317 E0.353348
G1 X23.01089 Y188.31577 E0.018828
G1 X25.57061 Y178.76277 E0.328069
G1 X25.08254 Y179.01145 E0.018171
G1 X22.72102 Y187.82476 E0.302667
G1 X22.43211 Y187.33014 E0.019001
G1 X24.59446 Y179.26014 E0.277140
G1 X24.10639 Y179.50883 E0.018171
G1 X22.14419 Y186.83186 E0.251487
G1 X21.85727 Y186.32981 E0.019182
G1 X23.61831 Y179.75751 E0.225706
G1 X23.13023 Y180.00620 E0.018171
G1 X21.57136 Y185.82399 E0.199795
G1 X21.28648 Y185.31434 E0.019368
G1 X22.64216 Y180.25489 E0.173752
G1 X22.15408 Y180.50357 E0.018171
G1 X21.00265 Y184.80080 E0.147575
G1 X20.71988 Y184.28328 E0.019563
G1 X21.66601 Y180.75226 E0.121262
G1 X21.17793 Y181.00095 E0.018171
G1 X20.43818 Y183.76175 E0.094811
G1 X20.15758 Y183.23614 E0.019764
G1 X20.68986 Y181.24963 E0.068221
G1 X20.20178 Y181.49832 E0.018171
G1 X19.87808 Y182.70639 E0.041488
G1 X19.59971 Y182.17244 E0.019975
G1 X19.71371 Y181.74701 E0.014610
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.46782 Y69.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X30.13388 Y70.80529 I1.80529 J-0.86078 E0.104212
G2 X31.07839 Y68.13922 I-0.86078 J-1.80529 E0.104212
G2 X28.41233 Y67.19471 I-1.80529 J0.86078 E0.104212
G2 X27.46782 Y69.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X19.17088 Y70.21210 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X28.96753 Y75.20374 E0.364726
G3 X34.49291 Y65.63350 I99.03247 J50.79626 E0.366725
G1 X25.27170 Y59.64517 E0.364726
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.94666 Y74.78561 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X28.72568 Y74.84482 E0.007589
G1 X28.18362 Y74.56863 E0.020181
G1 X29.20139 Y74.29592 E0.034952
G1 X29.45972 Y73.80526 E0.018394
G1 X27.64156 Y74.29243 E0.062440
G1 X27.09949 Y74.01624 E0.020181
G1 X29.72171 Y73.31362 E0.090052
G1 X29.98740 Y72.82099 E0.018567
G1 X26.55743 Y73.74004 E0.117792
G1 X26.01537 Y73.46385 E0.020181
G1 X30.25685 Y72.32735 E0.145661
G1 X30.53011 Y71.83269 E0.018746
G1 X25.47331 Y73.18765 E0.173661
G1 X24.93124 Y72.91146 E0.020181
G1 X30.80724 Y71.33699 E0.201793
G1 X31.08829 Y70.84024 E0.018933
G1 X24.38918 Y72.63526 E0.230061
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.93142 Y70.46084 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.37332 Y70.34243 E0.015176
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.56738 Y71.09428 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.84712 Y72.35907 E0.162103
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.26900 Y69.94894 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.66242 Y69.84353 E0.013511
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.01908 Y70.81976 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.30506 Y72.08288 E0.161889
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.42932 Y69.48455 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.95563 Y69.34352 E0.018075
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.64804 Y70.49774 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.76299 Y71.80668 E0.167762
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.48256 Y69.04884 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.25301 Y68.84240 E0.026459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.38408 Y70.14702 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.22093 Y71.53049 E0.177313
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.45281 Y68.63537 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.55462 Y68.34014 E0.037839
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.20311 Y69.77407 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.67887 Y71.25429 E0.189714
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.34895 Y68.24176 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.86057 Y67.83672 E0.051912
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.09625 Y69.38127 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.13681 Y70.97810 E0.204659
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.17115 Y67.86796 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.17090 Y67.33213 E0.068675
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.06333 Y68.96865 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.59474 Y70.70190 E0.222144
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.91095 Y67.51624 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.48567 Y66.82635 E0.088421
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.11281 Y68.53395 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.05268 Y70.42571 E0.242459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.54517 Y67.19282 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.80501 Y66.31934 E0.111950
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.26787 Y68.07096 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51062 Y70.14951 E0.266400
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.00725 Y66.91551 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.12895 Y65.81110 E0.141547
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.59507 Y67.56185 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.67407 Y69.68428 E0.272023
G1 X19.93028 Y69.19418 E0.018345
G1 X33.84785 Y65.46498 E0.477957
G1 X33.38844 Y65.16664 E0.018171
G1 X20.18977 Y68.70322 E0.453269
G1 X20.45264 Y68.21134 E0.018500
G1 X32.92904 Y64.86830 E0.428465
G1 X32.46963 Y64.56996 E0.018171
G1 X20.71887 Y67.71856 E0.403545
G1 X20.98856 Y67.22486 E0.018661
G1 X32.01022 Y64.27162 E0.378506
G1 X31.55082 Y63.97327 E0.018171
G1 X21.26173 Y66.73023 E0.353348
G1 X21.53841 Y66.23465 E0.018828
G1 X31.09141 Y63.67493 E0.328069
G1 X30.63200 Y63.37659 E0.018171
G1 X21.81870 Y65.73811 E0.302667
G1 X22.10260 Y65.24060 E0.019001
G1 X30.17260 Y63.07825 E0.277140
G1 X29.71319 Y62.77990 E0.018171
G1 X22.39016 Y64.74210 E0.251487
G1 X22.68149 Y64.24260 E0.019182
G1 X29.25378 Y62.48156 E0.225706
G1 X28.79438 Y62.18322 E0.018171
G1 X22.97659 Y63.74209 E0.199795
G1 X23.27552 Y63.24055 E0.019368
G1 X28.33497 Y61.88488 E0.173752
G1 X27.87556 Y61.58654 E0.018171
G1 X23.57834 Y62.73797 E0.147575
G1 X23.88514 Y62.23433 E0.019563
G1 X27.41616 Y61.28819 E0.121262
G1 X26.95675 Y60.98985 E0.018171
G1 X24.19595 Y61.72961 E0.094811
G1 X24.51084 Y61.22379 E0.019764
G1 X26.49734 Y60.69151 E0.068221
G1 X26.03794 Y60.39317 E0.018171
G1 X24.82986 Y60.71687 E0.041488
G1 X25.15310 Y60.20882 E0.019975
G1 X25.57853 Y60.09482 E0.014610
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.19471 Y12.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X128.86078 Y13.80529 I1.80529 J-0.86078 E0.104212
G2 X129.80529 Y11.13922 I-0.86078 J-1.80529 E0.104212
G2 X127.13922 Y10.19471 I-1.80529 J0.86078 E0.104212
G2 X126.19471 Y12.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X121.89918 Y3.85727 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.47462 Y14.83724 E0.364726
G3 X133.52538 Y14.83724 I5.52538 J111.16276 E0.366725
G1 X134.10082 Y3.85727 E0.364726
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X122.82629 Y14.61010 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.66452 Y14.44833 E0.007589
G1 X122.63268 Y13.84079 E0.020181
G1 X123.37775 Y14.58585 E0.034952
G1 X123.93184 Y14.56425 E0.018394
G1 X122.60085 Y13.23325 E0.062440
G1 X122.56901 Y12.62572 E0.020181
G1 X124.48860 Y14.54531 E0.090052
G1 X125.04808 Y14.52909 E0.018567
G1 X122.53717 Y12.01818 E0.117792
G1 X122.50533 Y11.41064 E0.020181
G1 X125.61031 Y14.51562 E0.145661
G1 X126.17532 Y14.50494 E0.018746
G1 X122.47349 Y10.80311 E0.173661
G1 X122.44165 Y10.19557 E0.020181
G1 X126.74317 Y14.49710 E0.201793
G1 X127.31389 Y14.49212 E0.018933
G1 X122.40981 Y9.58803 E0.230061
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X127.56404 Y14.16656 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.88753 Y14.49006 E0.015176
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X125.83344 Y12.43596 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.37797 Y8.98049 E0.162103
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X128.17614 Y14.20297 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.46415 Y14.49097 E0.013511
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X125.79703 Y11.82386 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.34613 Y8.37296 E0.161889
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X128.65848 Y14.10961 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.04377 Y14.49490 E0.018075
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X125.89039 Y11.34152 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.31429 Y7.76542 E0.167762
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.06243 Y13.93786 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.62644 Y14.50187 E0.026459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.06214 Y10.93757 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.28245 Y7.15788 E0.177313
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.40563 Y13.70536 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.21221 Y14.51195 E0.037839
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.29464 Y10.59437 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.25061 Y6.55035 E0.189714
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.69458 Y13.41861 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.80116 Y14.52520 E0.051912
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.58139 Y10.30542 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.21877 Y5.94281 E0.204659
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.92940 Y13.07774 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.39331 Y14.54166 E0.068675
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.92226 Y10.07060 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.18693 Y5.33527 E0.222144
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X130.10389 Y12.67654 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.98872 Y14.56136 E0.088421
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X127.32346 Y9.89611 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.15509 Y4.72773 E0.242459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X130.20110 Y12.19804 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.58747 Y14.58442 E0.111950
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X127.80196 Y9.79890 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12325 Y4.12020 E0.266400
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X130.17230 Y11.59355 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.18959 Y14.61084 E0.141547
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X128.40645 Y9.82770 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.60788 Y4.02913 E0.272023
G1 X123.16042 Y4.00597 E0.018345
G1 X133.34879 Y14.19434 E0.477957
G1 X133.37746 Y13.64731 E0.018171
G1 X123.71535 Y3.98521 E0.453269
G1 X124.27277 Y3.96692 E0.018500
G1 X133.40612 Y13.10028 E0.428465
G1 X133.43479 Y12.55325 E0.018171
G1 X124.83264 Y3.95110 E0.403545
G1 X125.39504 Y3.93781 E0.018661
G1 X133.46346 Y12.00622 E0.378506
G1 X133.49213 Y11.45919 E0.018171
G1 X125.96000 Y3.92706 E0.353348
G1 X126.52751 Y3.91888 E0.018828
G1 X133.52080 Y10.91216 E0.328069
G1 X133.54947 Y10.36513 E0.018171
G1 X127.09768 Y3.91335 E0.302667
G1 X127.67049 Y3.91046 E0.019001
G1 X133.57814 Y9.81811 E0.277140
G1 X133.60680 Y9.27108 E0.018171
G1 X128.24597 Y3.91025 E0.251487
G1 X128.82422 Y3.91279 E0.019182
G1 X133.63547 Y8.72405 E0.225706
G1 X133.66414 Y8.17702 E0.018171
G1 X129.40522 Y3.91810 E0.199795
G1 X129.98903 Y3.92621 E0.019368
G1 X133.69281 Y7.62999 E0.173752
G1 X133.72148 Y7.08296 E0.018171
G1 X130.57569 Y3.93717 E0.147575
G1 X131.16526 Y3.95105 E0.019563
G1 X133.75015 Y6.53593 E0.121262
G1 X133.77882 Y5.98890 E0.018171
G1 X131.75777 Y3.96786 E0.094811
G1 X132.35326 Y3.98765 E0.019764
G1 X133.80748 Y5.44187 E0.068221
G1 X133.83615 Y4.89485 E0.018171
G1 X132.95178 Y4.01047 E0.041488
G1 X133.55338 Y4.03638 E0.019975
G1 X133.86482 Y4.34782 E0.014610
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.92161 Y69.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X227.58767 Y70.80529 I1.80529 J-0.86078 E0.104212
G2 X228.53218 Y68.13922 I-0.86078 J-1.80529 E0.104212
G2 X225.86612 Y67.19471 I-1.80529 J0.86078 E0.104212
G2 X224.92161 Y69.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X230.72830 Y59.64517 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.50709 Y65.63350 E0.364726
G3 X227.03247 Y75.20374 I-93.50709 J60.36650 E0.366725
G1 X236.82912 Y70.21210 E0.364726
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X221.87963 Y65.82449 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X221.93884 Y65.60351 E0.007589
G1 X222.44907 Y65.27216 E0.020181
G1 X222.17635 Y66.28994 E0.034952
G1 X222.47211 Y66.75899 E0.018394
G1 X222.95929 Y64.94082 E0.062440
G1 X223.46951 Y64.60948 E0.020181
G1 X222.76689 Y67.23170 E0.090052
G1 X223.06068 Y67.70811 E0.018567
G1 X223.97973 Y64.27814 E0.117792
G1 X224.48996 Y63.94679 E0.020181
G1 X223.35346 Y68.18828 E0.145661
G1 X223.64521 Y68.67226 E0.018746
G1 X225.00018 Y63.61545 E0.173661
G1 X225.51040 Y63.28411 E0.020181
G1 X223.93594 Y69.16010 E0.201793
G1 X224.22561 Y69.65188 E0.018933
G1 X226.02063 Y62.95277 E0.230061
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.63262 Y69.70573 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.51421 Y70.14763 E0.015176
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.26606 Y67.34168 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.53085 Y62.62142 E0.162103
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.90714 Y70.25403 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.80172 Y70.64745 E0.013511
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.77795 Y67.00410 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.04107 Y62.29008 E0.161889
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.22916 Y70.62507 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.08813 Y71.15138 E0.018075
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X226.24235 Y66.84378 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.55129 Y61.95874 E0.167762
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.57987 Y70.88902 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.37343 Y71.65948 E0.026459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X226.67805 Y66.79055 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.06152 Y61.62740 E0.177313
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.95282 Y71.06999 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.65759 Y72.17181 E0.037839
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.09152 Y66.82030 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.57174 Y61.29605 E0.189714
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X226.34563 Y71.17685 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.94059 Y72.68847 E0.051912
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.48513 Y66.92416 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.08196 Y60.96471 E0.204659
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X226.75825 Y71.20978 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.22241 Y73.20952 E0.068675
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.85893 Y67.10195 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.59219 Y60.63337 E0.222144
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.19294 Y71.16029 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.50305 Y73.73502 E0.088421
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.21065 Y67.36216 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.10241 Y60.30203 E0.242459
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.65593 Y71.00523 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.78246 Y74.26507 E0.111950
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.53408 Y67.72794 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61263 Y59.97068 E0.266400
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.16504 Y70.67804 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.06064 Y74.79973 E0.141547
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.81139 Y68.26585 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.93381 Y60.34485 E0.272023
G1 X231.23014 Y60.81179 E0.018345
G1 X227.50094 Y74.72935 E0.477957
G1 X227.98901 Y74.48067 E0.018171
G1 X231.52559 Y61.28199 E0.453269
G1 X231.82013 Y61.75558 E0.018500
G1 X228.47709 Y74.23198 E0.428465
G1 X228.96516 Y73.98329 E0.018171
G1 X232.11377 Y62.23254 E0.403545
G1 X232.40648 Y62.71294 E0.018661
G1 X229.45324 Y73.73461 E0.378506
G1 X229.94131 Y73.48592 E0.018171
G1 X232.69827 Y63.19683 E0.353348
G1 X232.98911 Y63.68423 E0.018828
G1 X230.42939 Y73.23723 E0.328069
G1 X230.91746 Y72.98855 E0.018171
G1 X233.27898 Y64.17524 E0.302667
G1 X233.56789 Y64.66986 E0.019001
G1 X231.40554 Y72.73986 E0.277140
G1 X231.89361 Y72.49117 E0.018171
G1 X233.85581 Y65.16814 E0.251487
G1 X234.14273 Y65.67019 E0.019182
G1 X232.38169 Y72.24249 E0.225706
G1 X232.86977 Y71.99380 E0.018171
G1 X234.42864 Y66.17601 E0.199795
G1 X234.71352 Y66.68566 E0.019368
G1 X233.35784 Y71.74511 E0.173752
G1 X233.84592 Y71.49643 E0.018171
G1 X234.99735 Y67.19920 E0.147575
G1 X235.28012 Y67.71672 E0.019563
G1 X234.33399 Y71.24774 E0.121262
G1 X234.82207 Y70.99905 E0.018171
G1 X235.56182 Y68.23825 E0.094811
G1 X235.84242 Y68.76386 E0.019764
G1 X235.31014 Y70.75037 E0.068221
G1 X235.79822 Y70.50168 E0.018171
G1 X236.12192 Y69.29361 E0.041488
G1 X236.40029 Y69.82756 E0.019975
G1 X236.28629 Y70.25299 E0.014610
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X17.62730 Y178.62672 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.40434
M204 S1000
G1 F3600
G3 X75.37328 Y15.62730 I110.37270 J-52.62672 E5.656693
G3 X238.37270 Y73.37328 I52.62672 J110.37270 E5.656693
G3 X180.62672 Y236.37270 I-110.37270 J52.62672 E5.656693
G3 X17.62730 Y178.62672 I-52.62672 J-110.37270 E5.656693
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X17.30107 Y178.78227 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X75.21773 Y15.30107 I110.69893 J-52.78227 E5.673413
G3 X238.69893 Y73.21773 I52.78227 J110.69893 E5.673413
G3 X180.78227 Y236.69893 I-110.69893 J52.78227 E5.673413
G3 X17.30107 Y178.78227 I-52.78227 J-110.69893 E5.673413
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X16.97484 Y178.93782 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X75.06218 Y14.97484 I111.02516 J-52.93782 E5.690132
G3 X239.02516 Y73.06218 I52.93782 J111.02516 E5.690132
G3 X180.93782 Y237.02516 I-111.02516 J52.93782 E5.690132
G3 X16.97484 Y178.93782 I-52.93782 J-111.02516 E5.690132
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X16.64861 Y179.09337 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X74.90663 Y14.64861 I111.35139 J-53.09337 E5.706852
G3 X239.35139 Y72.90663 I53.09337 J111.35139 E5.706852
G3 X181.09337 Y237.35139 I-111.35139 J53.09337 E5.706852
G3 X16.64861 Y179.09337 I-53.09337 J-111.35139 E5.706852
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X16.32238 Y179.24892 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X74.75108 Y14.32238 I111.67762 J-53.24892 E5.723571
G3 X239.67762 Y72.75108 I53.24892 J111.67762 E5.723571
G3 X181.24892 Y237.67762 I-111.67762 J53.24892 E5.723571
G3 X16.32238 Y179.24892 I-53.24892 J-111.67762 E5.723571
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 0.600
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 3/20
M73 L3
M991 S0 P2
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.44850 Y181.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X224.94226 Y182.27840 I-0.72160 J1.78463 E0.100304
G2 X226.00529 Y184.78463 I1.78463 J0.72160 E0.100304
G2 X228.51153 Y183.72160 I0.72160 J-1.78463 E0.100304
G2 X227.44850 Y181.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X236.26017 Y181.64952 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X236.37148 Y182.06495 E0.014266
G1 X236.09327 Y182.59948 E0.019989
G1 X235.77210 Y181.40084 E0.041164
G1 X235.28402 Y181.15215 E0.018171
G1 X235.81393 Y183.12980 E0.067916
G1 X235.53348 Y183.65597 E0.019779
G1 X234.79595 Y180.90346 E0.094526
G1 X234.30787 Y180.65478 E0.018171
G1 X235.25192 Y184.17803 E0.120996
G1 X234.96929 Y184.69606 E0.019575
G1 X233.81979 Y180.40609 E0.147326
G1 X233.33172 Y180.15740 E0.018171
G1 X234.68560 Y185.21014 E0.173521
G1 X234.40086 Y185.72032 E0.019381
G1 X232.84364 Y179.90872 E0.199582
G1 X232.35557 Y179.66003 E0.018171
G1 X234.11508 Y186.22663 E0.225510
G1 X233.82829 Y186.72914 E0.019193
G1 X231.86749 Y179.41134 E0.251308
G1 X231.37942 Y179.16266 E0.018171
G1 X233.54051 Y187.22794 E0.276978
G1 X233.25172 Y187.72302 E0.019012
G1 X230.89134 Y178.91397 E0.302521
G1 X230.40327 Y178.66528 E0.018171
G1 X232.96197 Y188.21449 E0.327939
G1 X232.67126 Y188.70236 E0.018839
G1 X229.91519 Y178.41660 E0.353234
G1 X229.42712 Y178.16791 E0.018171
G1 X232.37959 Y189.18669 E0.378407
G1 X232.08700 Y189.66755 E0.018672
G1 X228.93904 Y177.91922 E0.403461
G1 X228.45097 Y177.67054 E0.018171
G1 X231.79347 Y190.14493 E0.428396
G1 X231.49904 Y190.61894 E0.018510
G1 X227.96289 Y177.42185 E0.453215
G1 X227.47482 Y177.17316 E0.018171
G1 X231.20371 Y191.08957 E0.477917
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y191.55690 E0.273231
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.18873 Y184.55603 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X226.77845 Y180.86563 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.83873 Y184.82264 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X226.36512 Y180.89588 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.46565 Y185.00311 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.97232 Y181.00280 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.07202 Y185.10691 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.60012 Y181.18655 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X226.65781 Y185.13388 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.25118 Y181.45713 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.93297 Y181.84239 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.75212 Y184.89948 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.19831 Y182.24626 E0.237277
G1 X223.90878 Y182.73854 E0.018945
G1 X225.53941 Y188.82416 E0.208992
G1 X225.02919 Y188.49281 E0.020181
G1 X223.61819 Y183.22690 E0.180842
G1 X223.32657 Y183.71137 E0.018758
G1 X224.51897 Y188.16147 E0.152826
G1 X224.00874 Y187.83013 E0.020181
G1 X223.03392 Y184.19202 E0.124940
G1 X222.74026 Y184.66890 E0.018578
G1 X223.49852 Y187.49879 E0.097184
G1 X222.98830 Y187.16744 E0.020181
G1 X222.44560 Y185.14207 E0.069555
G1 X222.14997 Y185.61158 E0.018405
G1 X222.47808 Y186.83610 E0.042053
G1 X221.96785 Y186.50476 E0.020181
G1 X221.85336 Y186.07747 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X128.72160 Y238.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X126.21537 Y239.27840 I-0.72160 J1.78463 E0.100304
G2 X127.27840 Y241.78463 I1.78463 J0.72160 E0.100304
G2 X129.78463 Y240.72160 I0.72160 J-1.78463 E0.100304
G2 X128.72160 Y238.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X133.93618 Y247.58082 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.63207 Y247.88493 E0.014266
G1 X133.03005 Y247.91126 E0.019989
G1 X133.90752 Y247.03379 E0.041164
G1 X133.87885 Y246.48676 E0.018171
G1 X132.43111 Y247.93450 E0.067916
G1 X131.83521 Y247.95471 E0.019779
G1 X133.85018 Y245.93973 E0.094526
G1 X133.82151 Y245.39270 E0.018171
G1 X131.24231 Y247.97191 E0.120996
G1 X130.65236 Y247.98615 E0.019575
G1 X133.79284 Y244.84568 E0.147326
G1 X133.76417 Y244.29865 E0.018171
G1 X130.06531 Y247.99750 E0.173521
G1 X129.48112 Y248.00601 E0.019381
G1 X133.73550 Y243.75162 E0.199582
G1 X133.70684 Y243.20459 E0.018171
G1 X128.89975 Y248.01167 E0.225510
G1 X128.32116 Y248.01456 E0.019193
G1 X133.67817 Y242.65756 E0.251308
G1 X133.64950 Y242.11053 E0.018171
G1 X127.74530 Y248.01473 E0.276978
G1 X127.17215 Y248.01218 E0.019012
G1 X133.62083 Y241.56350 E0.302521
G1 X133.59216 Y241.01647 E0.018171
G1 X126.60166 Y248.00697 E0.327939
G1 X126.03379 Y247.99915 E0.018839
G1 X133.56349 Y240.46944 E0.353234
G1 X133.53482 Y239.92242 E0.018171
G1 X125.46852 Y247.98872 E0.378407
G1 X124.90578 Y247.97576 E0.018672
G1 X133.50616 Y239.37539 E0.403461
G1 X133.47749 Y238.82836 E0.018171
G1 X124.34560 Y247.96025 E0.428396
G1 X123.78787 Y247.94227 E0.018510
G1 X133.44882 Y238.28133 E0.453215
G1 X133.42015 Y237.73430 E0.018171
G1 X123.23264 Y247.92181 E0.477917
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y247.89895 E0.273231
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X127.38335 Y242.04400 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.87419 Y238.97746 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.97746 Y241.87419 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.64133 Y238.63463 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.63463 Y241.64133 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.35234 Y238.34792 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.34792 Y241.35234 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.00711 Y238.11746 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.11746 Y241.00711 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X128.59831 Y237.95056 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X128.10556 Y237.86761 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X125.86761 Y240.10556 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X127.38847 Y237.43331 E0.237277
G1 X126.81737 Y237.42871 E0.018945
G1 X122.36239 Y241.88369 E0.208992
G1 X122.39423 Y241.27615 E0.020181
G1 X126.24915 Y237.42123 E0.180842
G1 X125.68377 Y237.41091 E0.018758
G1 X122.42607 Y240.66861 E0.152826
G1 X122.45791 Y240.06108 E0.020181
G1 X125.12119 Y237.39779 E0.124940
G1 X124.56137 Y237.38192 E0.018578
G1 X122.48975 Y239.45354 E0.097184
G1 X122.52159 Y238.84600 E0.020181
G1 X124.00427 Y237.36333 E0.069555
G1 X123.44984 Y237.34205 E0.018405
G1 X122.55343 Y238.23846 E0.042053
G1 X122.58527 Y237.63093 E0.020181
G1 X122.89806 Y237.31813 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.99471 Y181.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X27.48847 Y182.27840 I-0.72160 J1.78463 E0.100304
G2 X28.55150 Y184.78463 I1.78463 J0.72160 E0.100304
G2 X31.05774 Y183.72160 I0.72160 J-1.78463 E0.100304
G2 X29.99471 Y181.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X25.67601 Y191.93130 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X25.26059 Y191.81998 E0.014266
G1 X24.93678 Y191.31178 E0.019989
G1 X26.13542 Y191.63295 E0.041164
G1 X26.59483 Y191.33461 E0.018171
G1 X24.61718 Y190.80470 E0.067916
G1 X24.30173 Y190.29874 E0.019779
G1 X27.05423 Y191.03627 E0.094526
G1 X27.51364 Y190.73793 E0.018171
G1 X23.99039 Y189.79387 E0.120996
G1 X23.68307 Y189.29009 E0.019575
G1 X27.97305 Y190.43959 E0.147326
G1 X28.43245 Y190.14124 E0.018171
G1 X23.37972 Y188.78737 E0.173521
G1 X23.08026 Y188.28569 E0.019381
G1 X28.89186 Y189.84290 E0.199582
G1 X29.35127 Y189.54456 E0.018171
G1 X22.78467 Y187.78504 E0.225510
G1 X22.49287 Y187.28542 E0.019193
G1 X29.81067 Y189.24622 E0.251308
G1 X30.27008 Y188.94787 E0.018171
G1 X22.20479 Y186.78679 E0.276978
G1 X21.92043 Y186.28915 E0.019012
G1 X30.72949 Y188.64953 E0.302521
G1 X31.18889 Y188.35119 E0.018171
G1 X21.63969 Y185.79249 E0.327939
G1 X21.36253 Y185.29678 E0.018839
G1 X31.64830 Y188.05285 E0.353234
G1 X32.10771 Y187.75451 E0.018171
G1 X21.08893 Y184.80203 E0.378407
G1 X20.81879 Y184.30821 E0.018672
G1 X32.56711 Y187.45616 E0.403461
G1 X33.02652 Y187.15782 E0.018171
G1 X20.55213 Y183.81532 E0.428396
G1 X20.28883 Y183.32333 E0.018510
G1 X33.48593 Y186.85948 E0.453215
G1 X33.94533 Y186.56114 E0.018171
G1 X20.02893 Y182.83225 E0.477917
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y182.34205 E0.273231
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.19462 Y183.48797 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X31.09574 Y184.11183 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.13874 Y183.05156 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X31.27622 Y183.73875 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.16898 Y182.63822 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X31.38002 Y183.34512 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.27590 Y182.24543 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X31.40698 Y182.93091 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.45966 Y181.87323 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X31.34713 Y182.49343 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X31.17258 Y182.02522 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X28.11550 Y181.20608 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X31.19016 Y181.18705 E0.237277
G1 X30.90859 Y180.69017 E0.018945
G1 X24.82298 Y179.05953 E0.208992
G1 X25.36504 Y178.78334 E0.020181
G1 X30.63096 Y180.19433 E0.180842
G1 X30.35721 Y179.69954 E0.018758
G1 X25.90710 Y178.50714 E0.152826
G1 X26.44916 Y178.23095 E0.020181
G1 X30.08728 Y179.20578 E0.124940
G1 X29.82111 Y178.71302 E0.018578
G1 X26.99123 Y177.95475 E0.097184
G1 X27.53329 Y177.67856 E0.020181
G1 X29.55866 Y178.22126 E0.069555
G1 X29.29988 Y177.73047 E0.018405
G1 X28.07535 Y177.40236 E0.042053
G1 X28.61741 Y177.12617 E0.020181
G1 X29.04470 Y177.24066 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.99471 Y67.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X27.48847 Y68.27840 I-0.72160 J1.78463 E0.100304
G2 X28.55150 Y70.78463 I1.78463 J0.72160 E0.100304
G2 X31.05774 Y69.72160 I0.72160 J-1.78463 E0.100304
G2 X29.99471 Y67.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X19.73983 Y70.35048 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X19.62852 Y69.93505 E0.014266
G1 X19.90673 Y69.40052 E0.019989
G1 X20.22790 Y70.59916 E0.041164
G1 X20.71598 Y70.84785 E0.018171
G1 X20.18607 Y68.87020 E0.067916
G1 X20.46652 Y68.34403 E0.019779
G1 X21.20405 Y71.09654 E0.094526
G1 X21.69213 Y71.34522 E0.018171
G1 X20.74808 Y67.82197 E0.120996
G1 X21.03071 Y67.30394 E0.019575
G1 X22.18021 Y71.59391 E0.147326
G1 X22.66828 Y71.84260 E0.018171
G1 X21.31440 Y66.78986 E0.173521
G1 X21.59914 Y66.27968 E0.019381
G1 X23.15636 Y72.09128 E0.199582
G1 X23.64443 Y72.33997 E0.018171
G1 X21.88492 Y65.77337 E0.225510
G1 X22.17171 Y65.27086 E0.019193
G1 X24.13251 Y72.58866 E0.251308
G1 X24.62058 Y72.83734 E0.018171
G1 X22.45949 Y64.77206 E0.276978
G1 X22.74828 Y64.27698 E0.019012
G1 X25.10866 Y73.08603 E0.302521
G1 X25.59673 Y73.33472 E0.018171
G1 X23.03803 Y63.78551 E0.327939
G1 X23.32874 Y63.29764 E0.018839
G1 X26.08481 Y73.58340 E0.353234
G1 X26.57288 Y73.83209 E0.018171
G1 X23.62041 Y62.81331 E0.378407
G1 X23.91300 Y62.33245 E0.018672
G1 X27.06096 Y74.08078 E0.403461
G1 X27.54903 Y74.32946 E0.018171
G1 X24.20653 Y61.85507 E0.428396
G1 X24.50096 Y61.38106 E0.018510
G1 X28.03711 Y74.57815 E0.453215
G1 X28.52518 Y74.82684 E0.018171
G1 X24.79629 Y60.91043 E0.477917
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y60.44310 E0.273231
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.81127 Y67.44397 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.22155 Y71.13437 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X28.16127 Y67.17736 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.63488 Y71.10412 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X28.53435 Y66.99689 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.02768 Y70.99720 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X28.92798 Y66.89309 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.39988 Y70.81345 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.34219 Y66.86612 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.74882 Y70.54287 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X31.06703 Y70.15761 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.24788 Y67.10052 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.80169 Y69.75374 E0.237277
G1 X32.09122 Y69.26146 E0.018945
G1 X30.46059 Y63.17584 E0.208992
G1 X30.97081 Y63.50719 E0.020181
G1 X32.38181 Y68.77310 E0.180842
G1 X32.67343 Y68.28863 E0.018758
G1 X31.48103 Y63.83853 E0.152826
G1 X31.99126 Y64.16987 E0.020181
G1 X32.96608 Y67.80798 E0.124940
G1 X33.25974 Y67.33110 E0.018578
G1 X32.50148 Y64.50121 E0.097184
G1 X33.01170 Y64.83256 E0.020181
G1 X33.55440 Y66.85793 E0.069555
G1 X33.85003 Y66.38842 E0.018405
G1 X33.52192 Y65.16390 E0.042053
G1 X34.03215 Y65.49524 E0.020181
G1 X34.14664 Y65.92253 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X128.72160 Y10.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X126.21537 Y11.27840 I-0.72160 J1.78463 E0.100304
G2 X127.27840 Y13.78463 I1.78463 J0.72160 E0.100304
G2 X129.78463 Y12.72160 I0.72160 J-1.78463 E0.100304
G2 X128.72160 Y10.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X122.06382 Y4.41918 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.36793 Y4.11507 E0.014266
G1 X122.96995 Y4.08874 E0.019989
G1 X122.09248 Y4.96621 E0.041164
G1 X122.12115 Y5.51324 E0.018171
G1 X123.56889 Y4.06550 E0.067916
G1 X124.16479 Y4.04529 E0.019779
G1 X122.14982 Y6.06027 E0.094526
G1 X122.17849 Y6.60730 E0.018171
G1 X124.75769 Y4.02809 E0.120996
G1 X125.34764 Y4.01385 E0.019575
G1 X122.20716 Y7.15432 E0.147326
G1 X122.23583 Y7.70135 E0.018171
G1 X125.93469 Y4.00250 E0.173521
G1 X126.51888 Y3.99399 E0.019381
G1 X122.26450 Y8.24838 E0.199582
G1 X122.29316 Y8.79541 E0.018171
G1 X127.10025 Y3.98833 E0.225510
G1 X127.67884 Y3.98544 E0.019193
G1 X122.32183 Y9.34244 E0.251308
G1 X122.35050 Y9.88947 E0.018171
G1 X128.25470 Y3.98527 E0.276978
G1 X128.82785 Y3.98782 E0.019012
G1 X122.37917 Y10.43650 E0.302521
G1 X122.40784 Y10.98353 E0.018171
G1 X129.39834 Y3.99303 E0.327939
G1 X129.96621 Y4.00085 E0.018839
G1 X122.43651 Y11.53056 E0.353234
G1 X122.46518 Y12.07758 E0.018171
G1 X130.53148 Y4.01128 E0.378407
G1 X131.09422 Y4.02424 E0.018672
G1 X122.49384 Y12.62461 E0.403461
G1 X122.52251 Y13.17164 E0.018171
G1 X131.65440 Y4.03975 E0.428396
G1 X132.21213 Y4.05773 E0.018510
G1 X122.55118 Y13.71867 E0.453215
G1 X122.57985 Y14.26570 E0.018171
G1 X132.76736 Y4.07819 E0.477917
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y4.10105 E0.273231
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X128.61665 Y9.95600 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.12581 Y13.02254 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.02254 Y10.12581 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.35867 Y13.36537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.36537 Y10.35867 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.64766 Y13.65208 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.65208 Y10.64766 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.99289 Y13.88254 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.88254 Y10.99289 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X127.40169 Y14.04944 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X127.89444 Y14.13239 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X130.13239 Y11.89444 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X128.61153 Y14.56669 E0.237277
G1 X129.18263 Y14.57129 E0.018945
G1 X133.63761 Y10.11631 E0.208992
G1 X133.60577 Y10.72385 E0.020181
G1 X129.75085 Y14.57877 E0.180842
G1 X130.31623 Y14.58909 E0.018758
G1 X133.57393 Y11.33139 E0.152826
G1 X133.54209 Y11.93892 E0.020181
G1 X130.87881 Y14.60221 E0.124940
G1 X131.43863 Y14.61808 E0.018578
G1 X133.51025 Y12.54646 E0.097184
G1 X133.47841 Y13.15400 E0.020181
G1 X131.99573 Y14.63667 E0.069555
G1 X132.55016 Y14.65795 E0.018405
G1 X133.44657 Y13.76154 E0.042053
G1 X133.41473 Y14.36907 E0.020181
G1 X133.10194 Y14.68187 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.44850 Y67.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X224.94226 Y68.27840 I-0.72160 J1.78463 E0.100304
G2 X226.00529 Y70.78463 I1.78463 J0.72160 E0.100304
G2 X228.51153 Y69.72160 I0.72160 J-1.78463 E0.100304
G2 X227.44850 Y67.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X230.32399 Y60.06870 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X230.73941 Y60.18002 E0.014266
G1 X231.06322 Y60.68822 E0.019989
G1 X229.86458 Y60.36705 E0.041164
G1 X229.40517 Y60.66539 E0.018171
G1 X231.38282 Y61.19530 E0.067916
G1 X231.69827 Y61.70126 E0.019779
G1 X228.94577 Y60.96373 E0.094526
G1 X228.48636 Y61.26207 E0.018171
G1 X232.00961 Y62.20613 E0.120996
G1 X232.31693 Y62.70991 E0.019575
G1 X228.02695 Y61.56041 E0.147326
G1 X227.56755 Y61.85876 E0.018171
G1 X232.62028 Y63.21263 E0.173521
G1 X232.91974 Y63.71431 E0.019381
G1 X227.10814 Y62.15710 E0.199582
G1 X226.64873 Y62.45544 E0.018171
G1 X233.21533 Y64.21496 E0.225510
G1 X233.50713 Y64.71458 E0.019193
G1 X226.18933 Y62.75378 E0.251308
G1 X225.72992 Y63.05213 E0.018171
G1 X233.79521 Y65.21321 E0.276978
G1 X234.07957 Y65.71085 E0.019012
G1 X225.27051 Y63.35047 E0.302521
G1 X224.81111 Y63.64881 E0.018171
G1 X234.36031 Y66.20751 E0.327939
G1 X234.63747 Y66.70322 E0.018839
G1 X224.35170 Y63.94715 E0.353234
G1 X223.89229 Y64.24549 E0.018171
G1 X234.91107 Y67.19797 E0.378407
G1 X235.18121 Y67.69179 E0.018672
G1 X223.43289 Y64.54384 E0.403461
G1 X222.97348 Y64.84218 E0.018171
G1 X235.44787 Y68.18468 E0.428396
G1 X235.71117 Y68.67667 E0.018510
G1 X222.51407 Y65.14052 E0.453215
G1 X222.05467 Y65.43886 E0.018171
G1 X235.97107 Y69.16775 E0.477917
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y69.65795 E0.273231
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.80538 Y68.51203 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.90426 Y67.88817 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.86126 Y68.94844 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.72378 Y68.26125 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.83102 Y69.36178 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.61998 Y68.65488 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.72410 Y69.75457 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.59302 Y69.06909 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.54034 Y70.12677 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.65287 Y69.50657 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.82742 Y69.97478 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.88450 Y70.79392 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X224.80984 Y70.81295 E0.237277
G1 X225.09141 Y71.30983 E0.018945
G1 X231.17702 Y72.94047 E0.208992
G1 X230.63496 Y73.21666 E0.020181
G1 X225.36904 Y71.80567 E0.180842
G1 X225.64279 Y72.30046 E0.018758
G1 X230.09290 Y73.49286 E0.152826
G1 X229.55084 Y73.76905 E0.020181
G1 X225.91272 Y72.79422 E0.124940
G1 X226.17889 Y73.28698 E0.018578
G1 X229.00877 Y74.04525 E0.097184
G1 X228.46671 Y74.32144 E0.020181
G1 X226.44134 Y73.77874 E0.069555
G1 X226.70012 Y74.26953 E0.018405
G1 X227.92465 Y74.59764 E0.042053
G1 X227.38259 Y74.87383 E0.020181
G1 X226.95530 Y74.75934 E0.014674
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X173.81407 Y12.69463 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X241.30537 Y171.81407 I-45.81407 J113.30537 E6.123232
G3 X82.18593 Y239.30537 I-113.30537 J-45.81407 E6.123232
G3 X14.69463 Y80.18593 I45.81407 J-113.30537 E6.123232
G3 X173.81407 Y12.69463 I113.30537 J45.81407 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X173.96079 Y12.33175 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X241.66825 Y171.96079 I-45.96079 J113.66825 E6.142842
G3 X82.03921 Y239.66825 I-113.66825 J-45.96079 E6.142842
G3 X14.33175 Y80.03921 I45.96079 J-113.66825 E6.142842
G3 X173.96079 Y12.33175 I113.66825 J45.96079 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X174.10752 Y11.96888 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X242.03112 Y172.10752 I-46.10752 J114.03112 E6.162452
G3 X81.89248 Y240.03112 I-114.03112 J-46.10752 E6.162452
G3 X13.96888 Y79.89248 I46.10752 J-114.03112 E6.162452
G3 X174.10752 Y11.96888 I114.03112 J46.10752 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X174.25424 Y11.60600 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X242.39400 Y172.25424 I-46.25424 J114.39400 E6.182063
G3 X81.74576 Y240.39400 I-114.39400 J-46.25424 E6.182063
G3 X13.60600 Y79.74576 I46.25424 J-114.39400 E6.182063
G3 X174.25424 Y11.60600 I114.39400 J46.25424 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X174.40097 Y11.24313 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X242.75687 Y172.40097 I-46.40097 J114.75687 E6.201673
G3 X81.59903 Y240.75687 I-114.75687 J-46.40097 E6.201673
G3 X13.24313 Y79.59903 I46.40097 J-114.75687 E6.201673
G3 X174.40097 Y11.24313 I114.75687 J46.40097 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 0.800
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 4/20
M73 L4
M991 S0 P3
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.40031 Y184.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X228.53026 Y182.32658 I-0.67342 J-1.80337 E0.100304
G2 X226.05348 Y181.19663 I-1.80337 J0.67342 E0.100304
G2 X224.92353 Y183.67342 I0.67342 J1.80337 E0.100304
G2 X227.40031 Y184.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X226.95530 Y177.24066 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X227.38259 Y177.12617 E0.014674
G1 X227.92465 Y177.40236 E0.020181
G1 X226.70012 Y177.73047 E0.042053
G1 X226.44134 Y178.22126 E0.018405
G1 X228.46671 Y177.67856 E0.069555
G1 X229.00877 Y177.95475 E0.020181
G1 X226.17889 Y178.71302 E0.097184
G1 X225.91272 Y179.20578 E0.018578
G1 X229.55084 Y178.23095 E0.124940
G1 X230.09290 Y178.50714 E0.020181
G1 X225.64279 Y179.69954 E0.152826
G1 X225.36904 Y180.19433 E0.018758
G1 X230.63496 Y178.78334 E0.180842
G1 X231.17702 Y179.05953 E0.020181
G1 X225.09141 Y180.69017 E0.208992
G1 X224.80984 Y181.18705 E0.018945
G1 X231.71909 Y179.33573 E0.237277
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X224.82742 Y182.02522 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.88450 Y181.20608 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.26977 Y181.52429 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X224.59302 Y182.93091 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.54034 Y181.87323 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X224.61998 Y183.34512 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.72410 Y182.24543 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X224.72378 Y183.73875 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.83102 Y182.63822 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X224.90426 Y184.11183 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.86126 Y183.05156 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X225.17086 Y184.46183 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.80538 Y183.48797 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X225.55039 Y184.78158 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y182.34205 E0.273231
G1 X235.97107 Y182.83225 E0.018354
G1 X222.05467 Y186.56114 E0.477917
G1 X222.51407 Y186.85948 E0.018171
G1 X235.71117 Y183.32333 E0.453215
G1 X235.44787 Y183.81532 E0.018510
G1 X222.97348 Y187.15782 E0.428396
G1 X223.43289 Y187.45616 E0.018171
G1 X235.18121 Y184.30821 E0.403461
G1 X234.91107 Y184.80203 E0.018672
G1 X223.89229 Y187.75451 E0.378407
G1 X224.35170 Y188.05285 E0.018171
G1 X234.63747 Y185.29678 E0.353234
G1 X234.36031 Y185.79249 E0.018839
G1 X224.81111 Y188.35119 E0.327939
G1 X225.27051 Y188.64953 E0.018171
G1 X234.07957 Y186.28915 E0.302521
G1 X233.79521 Y186.78679 E0.019012
G1 X225.72992 Y188.94787 E0.276978
G1 X226.18933 Y189.24622 E0.018171
G1 X233.50713 Y187.28542 E0.251308
G1 X233.21533 Y187.78504 E0.019193
G1 X226.64873 Y189.54456 E0.225510
G1 X227.10814 Y189.84290 E0.018171
G1 X232.91974 Y188.28569 E0.199582
G1 X232.62028 Y188.78737 E0.019381
G1 X227.56755 Y190.14124 E0.173521
G1 X228.02695 Y190.43959 E0.018171
G1 X232.31693 Y189.29009 E0.147326
G1 X232.00961 Y189.79387 E0.019575
G1 X228.48636 Y190.73793 E0.120996
G1 X228.94577 Y191.03627 E0.018171
G1 X231.69827 Y190.29874 E0.094526
G1 X231.38282 Y190.80470 E0.019779
G1 X229.40517 Y191.33461 E0.067916
G1 X229.86458 Y191.63295 E0.018171
G1 X231.06322 Y191.31178 E0.041164
G1 X230.73941 Y191.81998 E0.019989
G1 X230.32399 Y191.93130 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.67342 Y241.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.80337 Y239.32658 I-0.67342 J-1.80337 E0.100304
G2 X127.32658 Y238.19663 I-1.80337 J0.67342 E0.100304
G2 X126.19663 Y240.67342 I0.67342 J1.80337 E0.100304
G2 X128.67342 Y241.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X133.10194 Y237.31813 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.41473 Y237.63093 E0.014674
G1 X133.44657 Y238.23846 E0.020181
G1 X132.55016 Y237.34205 E0.042053
G1 X131.99573 Y237.36333 E0.018405
G1 X133.47841 Y238.84600 E0.069555
G1 X133.51025 Y239.45354 E0.020181
G1 X131.43863 Y237.38192 E0.097184
G1 X130.87881 Y237.39779 E0.018578
G1 X133.54209 Y240.06108 E0.124940
G1 X133.57393 Y240.66861 E0.020181
G1 X130.31623 Y237.41091 E0.152826
G1 X129.75085 Y237.42123 E0.018758
G1 X133.60577 Y241.27615 E0.180842
G1 X133.63761 Y241.88369 E0.020181
G1 X129.18263 Y237.42871 E0.208992
G1 X128.61153 Y237.43331 E0.018945
G1 X133.66945 Y242.49123 E0.237277
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X127.89444 Y237.86761 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X130.13239 Y240.10556 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X130.04944 Y240.59831 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X126.99289 Y238.11746 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X129.88254 Y241.00711 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X126.64766 Y238.34792 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X129.65208 Y241.35234 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X126.35867 Y238.63463 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X129.36537 Y241.64133 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X126.12581 Y238.97746 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X129.02254 Y241.87419 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X125.95600 Y239.38335 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.61665 Y242.04400 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X125.86885 Y239.87191 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y247.89895 E0.273231
G1 X132.76736 Y247.92181 E0.018354
G1 X122.57985 Y237.73430 E0.477917
G1 X122.55118 Y238.28133 E0.018171
G1 X132.21213 Y247.94227 E0.453215
G1 X131.65440 Y247.96025 E0.018510
G1 X122.52251 Y238.82836 E0.428396
G1 X122.49384 Y239.37539 E0.018171
G1 X131.09422 Y247.97576 E0.403461
G1 X130.53148 Y247.98872 E0.018672
G1 X122.46518 Y239.92242 E0.378407
G1 X122.43651 Y240.46944 E0.018171
G1 X129.96621 Y247.99915 E0.353234
G1 X129.39834 Y248.00697 E0.018839
G1 X122.40784 Y241.01647 E0.327939
G1 X122.37917 Y241.56350 E0.018171
G1 X128.82785 Y248.01218 E0.302521
G1 X128.25470 Y248.01473 E0.019012
G1 X122.35050 Y242.11053 E0.276978
G1 X122.32183 Y242.65756 E0.018171
G1 X127.67884 Y248.01456 E0.251308
G1 X127.10025 Y248.01167 E0.019193
G1 X122.29316 Y243.20459 E0.225510
G1 X122.26450 Y243.75162 E0.018171
G1 X126.51888 Y248.00601 E0.199582
G1 X125.93469 Y247.99750 E0.019381
G1 X122.23583 Y244.29865 E0.173521
G1 X122.20716 Y244.84568 E0.018171
G1 X125.34764 Y247.98615 E0.147326
G1 X124.75769 Y247.97191 E0.019575
G1 X122.17849 Y245.39270 E0.120996
G1 X122.14982 Y245.93973 E0.018171
G1 X124.16479 Y247.95471 E0.094526
G1 X123.56889 Y247.93450 E0.019779
G1 X122.12115 Y246.48676 E0.067916
G1 X122.09248 Y247.03379 E0.018171
G1 X122.96995 Y247.91126 E0.041164
G1 X122.36793 Y247.88493 E0.019989
G1 X122.06382 Y247.58082 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X29.94652 Y184.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X31.07647 Y182.32658 I-0.67342 J-1.80337 E0.100304
G2 X28.59969 Y181.19663 I-1.80337 J0.67342 E0.100304
G2 X27.46974 Y183.67342 I0.67342 J1.80337 E0.100304
G2 X29.94652 Y184.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X34.14664 Y186.07747 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X34.03215 Y186.50476 E0.014674
G1 X33.52192 Y186.83610 E0.020181
G1 X33.85003 Y185.61158 E0.042053
G1 X33.55440 Y185.14207 E0.018405
G1 X33.01170 Y187.16744 E0.069555
G1 X32.50148 Y187.49879 E0.020181
G1 X33.25974 Y184.66890 E0.097184
G1 X32.96608 Y184.19202 E0.018578
G1 X31.99126 Y187.83013 E0.124940
G1 X31.48103 Y188.16147 E0.020181
G1 X32.67343 Y183.71137 E0.152826
G1 X32.38181 Y183.22690 E0.018758
G1 X30.97081 Y188.49281 E0.180842
G1 X30.46059 Y188.82416 E0.020181
G1 X32.09122 Y182.73854 E0.208992
G1 X31.80169 Y182.24626 E0.018945
G1 X29.95036 Y189.15550 E0.237277
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X31.06703 Y181.84239 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X30.24788 Y184.89948 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X29.77967 Y185.07402 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X30.39988 Y181.18655 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X29.34219 Y185.13388 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X30.02768 Y181.00280 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.92798 Y185.10691 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X29.63488 Y180.89588 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.53435 Y185.00311 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X29.22155 Y180.86563 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.16127 Y184.82264 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.78513 Y180.92152 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.81127 Y184.55603 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.31846 Y181.09033 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y191.55690 E0.273231
G1 X24.79629 Y191.08957 E0.018354
G1 X28.52518 Y177.17316 E0.477917
G1 X28.03711 Y177.42185 E0.018171
G1 X24.50096 Y190.61894 E0.453215
G1 X24.20653 Y190.14493 E0.018510
G1 X27.54903 Y177.67054 E0.428396
G1 X27.06096 Y177.91922 E0.018171
G1 X23.91300 Y189.66755 E0.403461
G1 X23.62041 Y189.18669 E0.018672
G1 X26.57288 Y178.16791 E0.378407
G1 X26.08481 Y178.41660 E0.018171
G1 X23.32874 Y188.70236 E0.353234
G1 X23.03803 Y188.21449 E0.018839
G1 X25.59673 Y178.66528 E0.327939
G1 X25.10866 Y178.91397 E0.018171
G1 X22.74828 Y187.72302 E0.302521
G1 X22.45949 Y187.22794 E0.019012
G1 X24.62058 Y179.16266 E0.276978
G1 X24.13251 Y179.41134 E0.018171
G1 X22.17171 Y186.72914 E0.251308
G1 X21.88492 Y186.22663 E0.019193
G1 X23.64443 Y179.66003 E0.225510
G1 X23.15636 Y179.90872 E0.018171
G1 X21.59914 Y185.72032 E0.199582
G1 X21.31440 Y185.21014 E0.019381
G1 X22.66828 Y180.15740 E0.173521
G1 X22.18021 Y180.40609 E0.018171
G1 X21.03071 Y184.69606 E0.147326
G1 X20.74808 Y184.17803 E0.019575
G1 X21.69213 Y180.65478 E0.120996
G1 X21.20405 Y180.90346 E0.018171
G1 X20.46652 Y183.65597 E0.094526
G1 X20.18607 Y183.12980 E0.019779
G1 X20.71598 Y181.15215 E0.067916
G1 X20.22790 Y181.40084 E0.018171
G1 X19.90673 Y182.59948 E0.041164
G1 X19.62852 Y182.06495 E0.019989
G1 X19.73983 Y181.64952 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X29.94652 Y70.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X31.07647 Y68.32658 I-0.67342 J-1.80337 E0.100304
G2 X28.59969 Y67.19663 I-1.80337 J0.67342 E0.100304
G2 X27.46974 Y69.67342 I0.67342 J1.80337 E0.100304
G2 X29.94652 Y70.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X29.04470 Y74.75934 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X28.61741 Y74.87383 E0.014674
G1 X28.07535 Y74.59764 E0.020181
G1 X29.29988 Y74.26953 E0.042053
G1 X29.55866 Y73.77874 E0.018405
G1 X27.53329 Y74.32144 E0.069555
G1 X26.99123 Y74.04525 E0.020181
G1 X29.82111 Y73.28698 E0.097184
G1 X30.08728 Y72.79422 E0.018578
G1 X26.44916 Y73.76905 E0.124940
G1 X25.90710 Y73.49286 E0.020181
G1 X30.35721 Y72.30046 E0.152826
G1 X30.63096 Y71.80567 E0.018758
G1 X25.36504 Y73.21666 E0.180842
G1 X24.82298 Y72.94047 E0.020181
G1 X30.90859 Y71.30983 E0.208992
G1 X31.19016 Y70.81295 E0.018945
G1 X24.28091 Y72.66427 E0.237277
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X31.17258 Y69.97478 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.11550 Y70.79392 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.73023 Y70.47571 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X31.40698 Y69.06909 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.45966 Y70.12677 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X31.38002 Y68.65488 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.27590 Y69.75457 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X31.27622 Y68.26125 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.16898 Y69.36178 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X31.09574 Y67.88817 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.13874 Y68.94844 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X30.82914 Y67.53817 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.19462 Y68.51203 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X30.44961 Y67.21842 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y69.65795 E0.273231
G1 X20.02893 Y69.16775 E0.018354
G1 X33.94533 Y65.43886 E0.477917
G1 X33.48593 Y65.14052 E0.018171
G1 X20.28883 Y68.67667 E0.453215
G1 X20.55213 Y68.18468 E0.018510
G1 X33.02652 Y64.84218 E0.428396
G1 X32.56711 Y64.54384 E0.018171
G1 X20.81879 Y67.69179 E0.403461
G1 X21.08893 Y67.19797 E0.018672
G1 X32.10771 Y64.24549 E0.378407
G1 X31.64830 Y63.94715 E0.018171
G1 X21.36253 Y66.70322 E0.353234
G1 X21.63969 Y66.20751 E0.018839
G1 X31.18889 Y63.64881 E0.327939
G1 X30.72949 Y63.35047 E0.018171
G1 X21.92043 Y65.71085 E0.302521
G1 X22.20479 Y65.21321 E0.019012
G1 X30.27008 Y63.05213 E0.276978
G1 X29.81067 Y62.75378 E0.018171
G1 X22.49287 Y64.71458 E0.251308
G1 X22.78467 Y64.21496 E0.019193
G1 X29.35127 Y62.45544 E0.225510
G1 X28.89186 Y62.15710 E0.018171
G1 X23.08026 Y63.71431 E0.199582
G1 X23.37972 Y63.21263 E0.019381
G1 X28.43245 Y61.85876 E0.173521
G1 X27.97305 Y61.56041 E0.018171
G1 X23.68307 Y62.70991 E0.147326
G1 X23.99039 Y62.20613 E0.019575
G1 X27.51364 Y61.26207 E0.120996
G1 X27.05423 Y60.96373 E0.018171
G1 X24.30173 Y61.70126 E0.094526
G1 X24.61718 Y61.19530 E0.019779
G1 X26.59483 Y60.66539 E0.067916
G1 X26.13542 Y60.36705 E0.018171
G1 X24.93678 Y60.68822 E0.041164
G1 X25.26059 Y60.18002 E0.019989
G1 X25.67601 Y60.06870 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.67342 Y13.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.80337 Y11.32658 I-0.67342 J-1.80337 E0.100304
G2 X127.32658 Y10.19663 I-1.80337 J0.67342 E0.100304
G2 X126.19663 Y12.67342 I0.67342 J1.80337 E0.100304
G2 X128.67342 Y13.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X122.89806 Y14.68187 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.58527 Y14.36907 E0.014674
G1 X122.55343 Y13.76154 E0.020181
G1 X123.44984 Y14.65795 E0.042053
G1 X124.00427 Y14.63667 E0.018405
G1 X122.52159 Y13.15400 E0.069555
G1 X122.48975 Y12.54646 E0.020181
G1 X124.56137 Y14.61808 E0.097184
G1 X125.12119 Y14.60221 E0.018578
G1 X122.45791 Y11.93892 E0.124940
G1 X122.42607 Y11.33139 E0.020181
G1 X125.68377 Y14.58909 E0.152826
G1 X126.24915 Y14.57877 E0.018758
G1 X122.39423 Y10.72385 E0.180842
G1 X122.36239 Y10.11631 E0.020181
G1 X126.81737 Y14.57129 E0.208992
G1 X127.38847 Y14.56669 E0.018945
G1 X122.33055 Y9.50877 E0.237277
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.10556 Y14.13239 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X125.86761 Y11.89444 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X125.95056 Y11.40169 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X129.00711 Y13.88254 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X126.11746 Y10.99289 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X129.35234 Y13.65208 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X126.34792 Y10.64766 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X129.64133 Y13.36537 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X126.63463 Y10.35867 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X129.87419 Y13.02254 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X126.97746 Y10.12581 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X130.04400 Y12.61665 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X127.38335 Y9.95600 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X130.13115 Y12.12809 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y4.10105 E0.273231
G1 X123.23264 Y4.07819 E0.018354
G1 X133.42015 Y14.26570 E0.477917
G1 X133.44882 Y13.71867 E0.018171
G1 X123.78787 Y4.05773 E0.453215
G1 X124.34560 Y4.03975 E0.018510
G1 X133.47749 Y13.17164 E0.428396
G1 X133.50616 Y12.62461 E0.018171
G1 X124.90578 Y4.02424 E0.403461
G1 X125.46852 Y4.01128 E0.018672
G1 X133.53482 Y12.07758 E0.378407
G1 X133.56349 Y11.53056 E0.018171
G1 X126.03379 Y4.00085 E0.353234
G1 X126.60166 Y3.99303 E0.018839
G1 X133.59216 Y10.98353 E0.327939
G1 X133.62083 Y10.43650 E0.018171
G1 X127.17215 Y3.98782 E0.302521
G1 X127.74530 Y3.98527 E0.019012
G1 X133.64950 Y9.88947 E0.276978
G1 X133.67817 Y9.34244 E0.018171
G1 X128.32116 Y3.98544 E0.251308
G1 X128.89975 Y3.98833 E0.019193
G1 X133.70684 Y8.79541 E0.225510
G1 X133.73550 Y8.24838 E0.018171
G1 X129.48112 Y3.99399 E0.199582
G1 X130.06531 Y4.00250 E0.019381
G1 X133.76417 Y7.70135 E0.173521
G1 X133.79284 Y7.15432 E0.018171
G1 X130.65236 Y4.01385 E0.147326
G1 X131.24231 Y4.02809 E0.019575
G1 X133.82151 Y6.60730 E0.120996
G1 X133.85018 Y6.06027 E0.018171
G1 X131.83521 Y4.04529 E0.094526
G1 X132.43111 Y4.06550 E0.019779
G1 X133.87885 Y5.51324 E0.067916
G1 X133.90752 Y4.96621 E0.018171
G1 X133.03005 Y4.08874 E0.041164
G1 X133.63207 Y4.11507 E0.019989
G1 X133.93618 Y4.41918 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.40031 Y70.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X228.53026 Y68.32658 I-0.67342 J-1.80337 E0.100304
G2 X226.05348 Y67.19663 I-1.80337 J0.67342 E0.100304
G2 X224.92353 Y69.67342 I0.67342 J1.80337 E0.100304
G2 X227.40031 Y70.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X221.85336 Y65.92253 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X221.96785 Y65.49524 E0.014674
G1 X222.47808 Y65.16390 E0.020181
G1 X222.14997 Y66.38842 E0.042053
G1 X222.44560 Y66.85793 E0.018405
G1 X222.98830 Y64.83256 E0.069555
G1 X223.49852 Y64.50121 E0.020181
G1 X222.74026 Y67.33110 E0.097184
G1 X223.03392 Y67.80798 E0.018578
G1 X224.00874 Y64.16987 E0.124940
G1 X224.51897 Y63.83853 E0.020181
G1 X223.32657 Y68.28863 E0.152826
G1 X223.61819 Y68.77310 E0.018758
G1 X225.02919 Y63.50719 E0.180842
G1 X225.53941 Y63.17584 E0.020181
G1 X223.90878 Y69.26146 E0.208992
G1 X224.19831 Y69.75374 E0.018945
G1 X226.04964 Y62.84450 E0.237277
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X224.93297 Y70.15761 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X225.75212 Y67.10052 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X226.22033 Y66.92598 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X225.60012 Y70.81345 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X226.65781 Y66.86612 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X225.97232 Y70.99720 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.07202 Y66.89309 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X226.36512 Y71.10412 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.46565 Y66.99689 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X226.77845 Y71.13437 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.83873 Y67.17736 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.21487 Y71.07848 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.18873 Y67.44397 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.68154 Y70.90967 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y60.44310 E0.273231
G1 X231.20371 Y60.91043 E0.018354
G1 X227.47482 Y74.82684 E0.477917
G1 X227.96289 Y74.57815 E0.018171
G1 X231.49904 Y61.38106 E0.453215
G1 X231.79347 Y61.85507 E0.018510
G1 X228.45097 Y74.32946 E0.428396
G1 X228.93904 Y74.08078 E0.018171
G1 X232.08700 Y62.33245 E0.403461
G1 X232.37959 Y62.81331 E0.018672
G1 X229.42712 Y73.83209 E0.378407
G1 X229.91519 Y73.58340 E0.018171
G1 X232.67126 Y63.29764 E0.353234
G1 X232.96197 Y63.78551 E0.018839
G1 X230.40327 Y73.33472 E0.327939
G1 X230.89134 Y73.08603 E0.018171
G1 X233.25172 Y64.27698 E0.302521
G1 X233.54051 Y64.77206 E0.019012
G1 X231.37942 Y72.83734 E0.276978
G1 X231.86749 Y72.58866 E0.018171
G1 X233.82829 Y65.27086 E0.251308
G1 X234.11508 Y65.77337 E0.019193
G1 X232.35557 Y72.33997 E0.225510
G1 X232.84364 Y72.09128 E0.018171
G1 X234.40086 Y66.27968 E0.199582
G1 X234.68560 Y66.78986 E0.019381
G1 X233.33172 Y71.84260 E0.173521
G1 X233.81979 Y71.59391 E0.018171
G1 X234.96929 Y67.30394 E0.147326
G1 X235.25192 Y67.82197 E0.019575
G1 X234.30787 Y71.34522 E0.120996
G1 X234.79595 Y71.09654 E0.018171
G1 X235.53348 Y68.34403 E0.094526
G1 X235.81393 Y68.87020 E0.019779
G1 X235.28402 Y70.84785 E0.067916
G1 X235.77210 Y70.59916 E0.018171
G1 X236.09327 Y69.40052 E0.041164
G1 X236.37148 Y69.93505 E0.019989
G1 X236.26017 Y70.35048 E0.014266
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X170.75481 Y240.49481 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X13.50519 Y168.75481 I-42.75481 J-114.49481 E6.123232
G3 X85.24519 Y11.50519 I114.49481 J-42.75481 E6.123232
G3 X242.49481 Y83.24519 I42.75481 J114.49481 E6.123232
G3 X170.75481 Y240.49481 I-114.49481 J42.75481 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X170.89174 Y240.86150 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X13.13850 Y168.89174 I-42.89174 J-114.86150 E6.142842
G3 X85.10826 Y11.13850 I114.86150 J-42.89174 E6.142842
G3 X242.86150 Y83.10826 I42.89174 J114.86150 E6.142842
G3 X170.89174 Y240.86150 I-114.86150 J42.89174 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X171.02867 Y241.22818 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X12.77182 Y169.02867 I-43.02867 J-115.22818 E6.162452
G3 X84.97133 Y10.77182 I115.22818 J-43.02867 E6.162452
G3 X243.22818 Y82.97133 I43.02867 J115.22818 E6.162452
G3 X171.02867 Y241.22818 I-115.22818 J43.02867 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X171.16560 Y241.59487 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X12.40513 Y169.16560 I-43.16560 J-115.59487 E6.182063
G3 X84.83440 Y10.40513 I115.59487 J-43.16560 E6.182063
G3 X243.59487 Y82.83440 I43.16560 J115.59487 E6.182063
G3 X171.16560 Y241.59487 I-115.59487 J43.16560 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X171.30252 Y241.96155 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X12.03845 Y169.30252 I-43.30252 J-115.96155 E6.201673
G3 X84.69748 Y10.03845 I115.96155 J-43.30252 E6.201673
G3 X243.96155 Y82.69748 I43.30252 J115.96155 E6.201673
G3 X171.30252 Y241.96155 I-115.96155 J43.30252 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 1.000
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 5/20
M73 L5
M991 S0 P4
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.01218 Y182.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X225.85203 Y184.71471 I1.71471 J0.87486 E0.100304
G2 X228.44161 Y183.87486 I0.87486 J-1.71471 E0.100304
G2 X227.60176 Y181.28529 I-1.71471 J-0.87486 E0.100304
G2 X225.01218 Y182.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X236.26017 Y181.64952 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X236.37148 Y182.06495 E0.014266
G1 X236.09327 Y182.59948 E0.019989
G1 X235.77210 Y181.40084 E0.041164
G1 X235.28402 Y181.15215 E0.018171
G1 X235.81393 Y183.12980 E0.067916
G1 X235.53348 Y183.65597 E0.019779
G1 X234.79595 Y180.90346 E0.094526
G1 X234.30787 Y180.65478 E0.018171
G1 X235.25192 Y184.17803 E0.120996
G1 X234.96929 Y184.69606 E0.019575
G1 X233.81979 Y180.40609 E0.147326
G1 X233.33172 Y180.15740 E0.018171
G1 X234.68560 Y185.21014 E0.173521
G1 X234.40086 Y185.72032 E0.019381
G1 X232.84364 Y179.90872 E0.199582
G1 X232.35557 Y179.66003 E0.018171
G1 X234.11508 Y186.22663 E0.225510
G1 X233.82829 Y186.72914 E0.019193
G1 X231.86749 Y179.41134 E0.251308
G1 X231.37942 Y179.16266 E0.018171
G1 X233.54051 Y187.22794 E0.276978
G1 X233.25172 Y187.72302 E0.019012
G1 X230.89134 Y178.91397 E0.302521
G1 X230.40327 Y178.66528 E0.018171
G1 X232.96197 Y188.21449 E0.327939
G1 X232.67126 Y188.70236 E0.018839
G1 X229.91519 Y178.41660 E0.353234
G1 X229.42712 Y178.16791 E0.018171
G1 X232.37959 Y189.18669 E0.378407
G1 X232.08700 Y189.66755 E0.018672
G1 X228.93904 Y177.91922 E0.403461
G1 X228.45097 Y177.67054 E0.018171
G1 X231.79347 Y190.14493 E0.428396
G1 X231.49904 Y190.61894 E0.018510
G1 X227.96289 Y177.42185 E0.453215
G1 X227.47482 Y177.17316 E0.018171
G1 X231.20371 Y191.08957 E0.477917
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y191.55690 E0.273231
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.18873 Y184.55603 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X226.77845 Y180.86563 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.83873 Y184.82264 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X226.36512 Y180.89588 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.46565 Y185.00311 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.97232 Y181.00280 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.07202 Y185.10691 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.60012 Y181.18655 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X226.65781 Y185.13388 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.25118 Y181.45713 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X224.93297 Y181.84239 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.75212 Y184.89948 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.19831 Y182.24626 E0.237277
G1 X223.90878 Y182.73854 E0.018945
G1 X225.53941 Y188.82416 E0.208992
G1 X225.02919 Y188.49281 E0.020181
G1 X223.61819 Y183.22690 E0.180842
G1 X223.32657 Y183.71137 E0.018758
G1 X224.51897 Y188.16147 E0.152826
G1 X224.00874 Y187.83013 E0.020181
G1 X223.03392 Y184.19202 E0.124940
G1 X222.74026 Y184.66890 E0.018578
G1 X223.49852 Y187.49879 E0.097184
G1 X222.98830 Y187.16744 E0.020181
G1 X222.44560 Y185.14207 E0.069555
G1 X222.14997 Y185.61158 E0.018405
G1 X222.47808 Y186.83610 E0.042053
G1 X221.96785 Y186.50476 E0.020181
G1 X221.85336 Y186.07747 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.28529 Y239.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X127.12514 Y241.71471 I1.71471 J0.87486 E0.100304
G2 X129.71471 Y240.87486 I0.87486 J-1.71471 E0.100304
G2 X128.87486 Y238.28529 I-1.71471 J-0.87486 E0.100304
G2 X126.28529 Y239.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X133.93618 Y247.58082 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.63207 Y247.88493 E0.014266
G1 X133.03005 Y247.91126 E0.019989
G1 X133.90752 Y247.03379 E0.041164
G1 X133.87885 Y246.48676 E0.018171
G1 X132.43111 Y247.93450 E0.067916
G1 X131.83521 Y247.95471 E0.019779
G1 X133.85018 Y245.93973 E0.094526
G1 X133.82151 Y245.39270 E0.018171
G1 X131.24231 Y247.97191 E0.120996
G1 X130.65236 Y247.98615 E0.019575
G1 X133.79284 Y244.84568 E0.147326
G1 X133.76417 Y244.29865 E0.018171
G1 X130.06531 Y247.99750 E0.173521
G1 X129.48112 Y248.00601 E0.019381
G1 X133.73550 Y243.75162 E0.199582
G1 X133.70684 Y243.20459 E0.018171
G1 X128.89975 Y248.01167 E0.225510
G1 X128.32116 Y248.01456 E0.019193
G1 X133.67817 Y242.65756 E0.251308
G1 X133.64950 Y242.11053 E0.018171
G1 X127.74530 Y248.01473 E0.276978
G1 X127.17215 Y248.01218 E0.019012
G1 X133.62083 Y241.56350 E0.302521
G1 X133.59216 Y241.01647 E0.018171
G1 X126.60166 Y248.00697 E0.327939
G1 X126.03379 Y247.99915 E0.018839
G1 X133.56349 Y240.46944 E0.353234
G1 X133.53482 Y239.92242 E0.018171
G1 X125.46852 Y247.98872 E0.378407
G1 X124.90578 Y247.97576 E0.018672
G1 X133.50616 Y239.37539 E0.403461
G1 X133.47749 Y238.82836 E0.018171
G1 X124.34560 Y247.96025 E0.428396
G1 X123.78787 Y247.94227 E0.018510
G1 X133.44882 Y238.28133 E0.453215
G1 X133.42015 Y237.73430 E0.018171
G1 X123.23264 Y247.92181 E0.477917
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y247.89895 E0.273231
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X127.38335 Y242.04400 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X129.87419 Y238.97746 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.97746 Y241.87419 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X129.64133 Y238.63463 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.63463 Y241.64133 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X129.35234 Y238.34792 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.34792 Y241.35234 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X129.00711 Y238.11746 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.11746 Y241.00711 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X128.59831 Y237.95056 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X128.10556 Y237.86761 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X125.86761 Y240.10556 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X127.38847 Y237.43331 E0.237277
G1 X126.81737 Y237.42871 E0.018945
G1 X122.36239 Y241.88369 E0.208992
G1 X122.39423 Y241.27615 E0.020181
G1 X126.24915 Y237.42123 E0.180842
G1 X125.68377 Y237.41091 E0.018758
G1 X122.42607 Y240.66861 E0.152826
G1 X122.45791 Y240.06108 E0.020181
G1 X125.12119 Y237.39779 E0.124940
G1 X124.56137 Y237.38192 E0.018578
G1 X122.48975 Y239.45354 E0.097184
G1 X122.52159 Y238.84600 E0.020181
G1 X124.00427 Y237.36333 E0.069555
G1 X123.44984 Y237.34205 E0.018405
G1 X122.55343 Y238.23846 E0.042053
G1 X122.58527 Y237.63093 E0.020181
G1 X122.89806 Y237.31813 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.55839 Y182.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X28.39824 Y184.71471 I1.71471 J0.87486 E0.100304
G2 X30.98782 Y183.87486 I0.87486 J-1.71471 E0.100304
G2 X30.14797 Y181.28529 I-1.71471 J-0.87486 E0.100304
G2 X27.55839 Y182.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X25.67601 Y191.93130 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X25.26059 Y191.81998 E0.014266
G1 X24.93678 Y191.31178 E0.019989
G1 X26.13542 Y191.63295 E0.041164
G1 X26.59483 Y191.33461 E0.018171
G1 X24.61718 Y190.80470 E0.067916
G1 X24.30173 Y190.29874 E0.019779
G1 X27.05423 Y191.03627 E0.094526
G1 X27.51364 Y190.73793 E0.018171
G1 X23.99039 Y189.79387 E0.120996
G1 X23.68307 Y189.29009 E0.019575
G1 X27.97305 Y190.43959 E0.147326
G1 X28.43245 Y190.14124 E0.018171
G1 X23.37972 Y188.78737 E0.173521
G1 X23.08026 Y188.28569 E0.019381
G1 X28.89186 Y189.84290 E0.199582
G1 X29.35127 Y189.54456 E0.018171
G1 X22.78467 Y187.78504 E0.225510
G1 X22.49287 Y187.28542 E0.019193
G1 X29.81067 Y189.24622 E0.251308
G1 X30.27008 Y188.94787 E0.018171
G1 X22.20479 Y186.78679 E0.276978
G1 X21.92043 Y186.28915 E0.019012
G1 X30.72949 Y188.64953 E0.302521
G1 X31.18889 Y188.35119 E0.018171
G1 X21.63969 Y185.79249 E0.327939
G1 X21.36253 Y185.29678 E0.018839
G1 X31.64830 Y188.05285 E0.353234
G1 X32.10771 Y187.75451 E0.018171
G1 X21.08893 Y184.80203 E0.378407
G1 X20.81879 Y184.30821 E0.018672
G1 X32.56711 Y187.45616 E0.403461
G1 X33.02652 Y187.15782 E0.018171
G1 X20.55213 Y183.81532 E0.428396
G1 X20.28883 Y183.32333 E0.018510
G1 X33.48593 Y186.85948 E0.453215
G1 X33.94533 Y186.56114 E0.018171
G1 X20.02893 Y182.83225 E0.477917
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y182.34205 E0.273231
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.19462 Y183.48797 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X31.09574 Y184.11183 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.13874 Y183.05156 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X31.27622 Y183.73875 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.16898 Y182.63822 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X31.38002 Y183.34512 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.27590 Y182.24543 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X31.40698 Y182.93091 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.45966 Y181.87323 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X31.34713 Y182.49343 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X31.17258 Y182.02522 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.11550 Y181.20608 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X31.19016 Y181.18705 E0.237277
G1 X30.90859 Y180.69017 E0.018945
G1 X24.82298 Y179.05953 E0.208992
G1 X25.36504 Y178.78334 E0.020181
G1 X30.63096 Y180.19433 E0.180842
G1 X30.35721 Y179.69954 E0.018758
G1 X25.90710 Y178.50714 E0.152826
G1 X26.44916 Y178.23095 E0.020181
G1 X30.08728 Y179.20578 E0.124940
G1 X29.82111 Y178.71302 E0.018578
G1 X26.99123 Y177.95475 E0.097184
G1 X27.53329 Y177.67856 E0.020181
G1 X29.55866 Y178.22126 E0.069555
G1 X29.29988 Y177.73047 E0.018405
G1 X28.07535 Y177.40236 E0.042053
G1 X28.61741 Y177.12617 E0.020181
G1 X29.04470 Y177.24066 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.55839 Y68.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X28.39824 Y70.71471 I1.71471 J0.87486 E0.100304
G2 X30.98782 Y69.87486 I0.87486 J-1.71471 E0.100304
G2 X30.14797 Y67.28529 I-1.71471 J-0.87486 E0.100304
G2 X27.55839 Y68.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X19.73983 Y70.35048 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X19.62852 Y69.93505 E0.014266
G1 X19.90673 Y69.40052 E0.019989
G1 X20.22790 Y70.59916 E0.041164
G1 X20.71598 Y70.84785 E0.018171
G1 X20.18607 Y68.87020 E0.067916
G1 X20.46652 Y68.34403 E0.019779
G1 X21.20405 Y71.09654 E0.094526
G1 X21.69213 Y71.34522 E0.018171
G1 X20.74808 Y67.82197 E0.120996
G1 X21.03071 Y67.30394 E0.019575
G1 X22.18021 Y71.59391 E0.147326
G1 X22.66828 Y71.84260 E0.018171
G1 X21.31440 Y66.78986 E0.173521
G1 X21.59914 Y66.27968 E0.019381
G1 X23.15636 Y72.09128 E0.199582
G1 X23.64443 Y72.33997 E0.018171
G1 X21.88492 Y65.77337 E0.225510
G1 X22.17171 Y65.27086 E0.019193
G1 X24.13251 Y72.58866 E0.251308
G1 X24.62058 Y72.83734 E0.018171
G1 X22.45949 Y64.77206 E0.276978
G1 X22.74828 Y64.27698 E0.019012
G1 X25.10866 Y73.08603 E0.302521
G1 X25.59673 Y73.33472 E0.018171
G1 X23.03803 Y63.78551 E0.327939
G1 X23.32874 Y63.29764 E0.018839
G1 X26.08481 Y73.58340 E0.353234
G1 X26.57288 Y73.83209 E0.018171
G1 X23.62041 Y62.81331 E0.378407
G1 X23.91300 Y62.33245 E0.018672
G1 X27.06096 Y74.08078 E0.403461
G1 X27.54903 Y74.32946 E0.018171
G1 X24.20653 Y61.85507 E0.428396
G1 X24.50096 Y61.38106 E0.018510
G1 X28.03711 Y74.57815 E0.453215
G1 X28.52518 Y74.82684 E0.018171
G1 X24.79629 Y60.91043 E0.477917
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y60.44310 E0.273231
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.81127 Y67.44397 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X29.22155 Y71.13437 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.16127 Y67.17736 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X29.63488 Y71.10412 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.53435 Y66.99689 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.02768 Y70.99720 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.92798 Y66.89309 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.39988 Y70.81345 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X29.34219 Y66.86612 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.74882 Y70.54287 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X31.06703 Y70.15761 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.24788 Y67.10052 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.80169 Y69.75374 E0.237277
G1 X32.09122 Y69.26146 E0.018945
G1 X30.46059 Y63.17584 E0.208992
G1 X30.97081 Y63.50719 E0.020181
G1 X32.38181 Y68.77310 E0.180842
G1 X32.67343 Y68.28863 E0.018758
G1 X31.48103 Y63.83853 E0.152826
G1 X31.99126 Y64.16987 E0.020181
G1 X32.96608 Y67.80798 E0.124940
G1 X33.25974 Y67.33110 E0.018578
G1 X32.50148 Y64.50121 E0.097184
G1 X33.01170 Y64.83256 E0.020181
G1 X33.55440 Y66.85793 E0.069555
G1 X33.85003 Y66.38842 E0.018405
G1 X33.52192 Y65.16390 E0.042053
G1 X34.03215 Y65.49524 E0.020181
G1 X34.14664 Y65.92253 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.28529 Y11.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X127.12514 Y13.71471 I1.71471 J0.87486 E0.100304
G2 X129.71471 Y12.87486 I0.87486 J-1.71471 E0.100304
G2 X128.87486 Y10.28529 I-1.71471 J-0.87486 E0.100304
G2 X126.28529 Y11.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X122.06382 Y4.41918 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.36793 Y4.11507 E0.014266
G1 X122.96995 Y4.08874 E0.019989
G1 X122.09248 Y4.96621 E0.041164
G1 X122.12115 Y5.51324 E0.018171
G1 X123.56889 Y4.06550 E0.067916
G1 X124.16479 Y4.04529 E0.019779
G1 X122.14982 Y6.06027 E0.094526
G1 X122.17849 Y6.60730 E0.018171
G1 X124.75769 Y4.02809 E0.120996
G1 X125.34764 Y4.01385 E0.019575
G1 X122.20716 Y7.15432 E0.147326
G1 X122.23583 Y7.70135 E0.018171
G1 X125.93469 Y4.00250 E0.173521
G1 X126.51888 Y3.99399 E0.019381
G1 X122.26450 Y8.24838 E0.199582
G1 X122.29316 Y8.79541 E0.018171
G1 X127.10025 Y3.98833 E0.225510
G1 X127.67884 Y3.98544 E0.019193
G1 X122.32183 Y9.34244 E0.251308
G1 X122.35050 Y9.88947 E0.018171
G1 X128.25470 Y3.98527 E0.276978
G1 X128.82785 Y3.98782 E0.019012
G1 X122.37917 Y10.43650 E0.302521
G1 X122.40784 Y10.98353 E0.018171
G1 X129.39834 Y3.99303 E0.327939
G1 X129.96621 Y4.00085 E0.018839
G1 X122.43651 Y11.53056 E0.353234
G1 X122.46518 Y12.07758 E0.018171
G1 X130.53148 Y4.01128 E0.378407
G1 X131.09422 Y4.02424 E0.018672
G1 X122.49384 Y12.62461 E0.403461
G1 X122.52251 Y13.17164 E0.018171
G1 X131.65440 Y4.03975 E0.428396
G1 X132.21213 Y4.05773 E0.018510
G1 X122.55118 Y13.71867 E0.453215
G1 X122.57985 Y14.26570 E0.018171
G1 X132.76736 Y4.07819 E0.477917
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y4.10105 E0.273231
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X128.61665 Y9.95600 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.12581 Y13.02254 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X129.02254 Y10.12581 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.35867 Y13.36537 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X129.36537 Y10.35867 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.64766 Y13.65208 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X129.65208 Y10.64766 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.99289 Y13.88254 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X129.88254 Y10.99289 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X127.40169 Y14.04944 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X127.89444 Y14.13239 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X130.13239 Y11.89444 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X128.61153 Y14.56669 E0.237277
G1 X129.18263 Y14.57129 E0.018945
G1 X133.63761 Y10.11631 E0.208992
G1 X133.60577 Y10.72385 E0.020181
G1 X129.75085 Y14.57877 E0.180842
G1 X130.31623 Y14.58909 E0.018758
G1 X133.57393 Y11.33139 E0.152826
G1 X133.54209 Y11.93892 E0.020181
G1 X130.87881 Y14.60221 E0.124940
G1 X131.43863 Y14.61808 E0.018578
G1 X133.51025 Y12.54646 E0.097184
G1 X133.47841 Y13.15400 E0.020181
G1 X131.99573 Y14.63667 E0.069555
G1 X132.55016 Y14.65795 E0.018405
G1 X133.44657 Y13.76154 E0.042053
G1 X133.41473 Y14.36907 E0.020181
G1 X133.10194 Y14.68187 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.01218 Y68.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X225.85203 Y70.71471 I1.71471 J0.87486 E0.100304
G2 X228.44161 Y69.87486 I0.87486 J-1.71471 E0.100304
G2 X227.60176 Y67.28529 I-1.71471 J-0.87486 E0.100304
G2 X225.01218 Y68.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X230.32399 Y60.06870 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X230.73941 Y60.18002 E0.014266
G1 X231.06322 Y60.68822 E0.019989
G1 X229.86458 Y60.36705 E0.041164
G1 X229.40517 Y60.66539 E0.018171
G1 X231.38282 Y61.19530 E0.067916
G1 X231.69827 Y61.70126 E0.019779
G1 X228.94577 Y60.96373 E0.094526
G1 X228.48636 Y61.26207 E0.018171
G1 X232.00961 Y62.20613 E0.120996
G1 X232.31693 Y62.70991 E0.019575
G1 X228.02695 Y61.56041 E0.147326
G1 X227.56755 Y61.85876 E0.018171
G1 X232.62028 Y63.21263 E0.173521
G1 X232.91974 Y63.71431 E0.019381
G1 X227.10814 Y62.15710 E0.199582
G1 X226.64873 Y62.45544 E0.018171
G1 X233.21533 Y64.21496 E0.225510
G1 X233.50713 Y64.71458 E0.019193
G1 X226.18933 Y62.75378 E0.251308
G1 X225.72992 Y63.05213 E0.018171
G1 X233.79521 Y65.21321 E0.276978
G1 X234.07957 Y65.71085 E0.019012
G1 X225.27051 Y63.35047 E0.302521
G1 X224.81111 Y63.64881 E0.018171
G1 X234.36031 Y66.20751 E0.327939
G1 X234.63747 Y66.70322 E0.018839
G1 X224.35170 Y63.94715 E0.353234
G1 X223.89229 Y64.24549 E0.018171
G1 X234.91107 Y67.19797 E0.378407
G1 X235.18121 Y67.69179 E0.018672
G1 X223.43289 Y64.54384 E0.403461
G1 X222.97348 Y64.84218 E0.018171
G1 X235.44787 Y68.18468 E0.428396
G1 X235.71117 Y68.67667 E0.018510
G1 X222.51407 Y65.14052 E0.453215
G1 X222.05467 Y65.43886 E0.018171
G1 X235.97107 Y69.16775 E0.477917
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y69.65795 E0.273231
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.80538 Y68.51203 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X224.90426 Y67.88817 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.86126 Y68.94844 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X224.72378 Y68.26125 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.83102 Y69.36178 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X224.61998 Y68.65488 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.72410 Y69.75457 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X224.59302 Y69.06909 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.54034 Y70.12677 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X224.65287 Y69.50657 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X224.82742 Y69.97478 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.88450 Y70.79392 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X224.80984 Y70.81295 E0.237277
G1 X225.09141 Y71.30983 E0.018945
G1 X231.17702 Y72.94047 E0.208992
G1 X230.63496 Y73.21666 E0.020181
G1 X225.36904 Y71.80567 E0.180842
G1 X225.64279 Y72.30046 E0.018758
G1 X230.09290 Y73.49286 E0.152826
G1 X229.55084 Y73.76905 E0.020181
G1 X225.91272 Y72.79422 E0.124940
G1 X226.17889 Y73.28698 E0.018578
G1 X229.00877 Y74.04525 E0.097184
G1 X228.46671 Y74.32144 E0.020181
G1 X226.44134 Y73.77874 E0.069555
G1 X226.70012 Y74.26953 E0.018405
G1 X227.92465 Y74.59764 E0.042053
G1 X227.38259 Y74.87383 E0.020181
G1 X226.95530 Y74.75934 E0.014674
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X19.13380 Y70.45555 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X183.54445 Y17.13380 I108.86620 J55.54445 E6.123232
G3 X236.86620 Y181.54445 I-55.54445 J108.86620 E6.123232
G3 X72.45555 Y234.86620 I-108.86620 J-55.54445 E6.123232
G3 X19.13380 Y70.45555 I55.54445 J-108.86620 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X18.78514 Y70.27766 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X183.72234 Y16.78514 I109.21486 J55.72234 E6.142842
G3 X237.21486 Y181.72234 I-55.72234 J109.21486 E6.142842
G3 X72.27766 Y235.21486 I-109.21486 J-55.72234 E6.142842
G3 X18.78514 Y70.27766 I55.72234 J-109.21486 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X18.43648 Y70.09977 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X183.90023 Y16.43648 I109.56352 J55.90023 E6.162452
G3 X237.56352 Y181.90023 I-55.90023 J109.56352 E6.162452
G3 X72.09977 Y235.56352 I-109.56352 J-55.90023 E6.162452
G3 X18.43648 Y70.09977 I55.90023 J-109.56352 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X18.08782 Y69.92189 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X184.07811 Y16.08782 I109.91218 J56.07811 E6.182063
G3 X237.91218 Y182.07811 I-56.07811 J109.91218 E6.182063
G3 X71.92189 Y235.91218 I-109.91218 J-56.07811 E6.182063
G3 X18.08782 Y69.92189 I56.07811 J-109.91218 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X17.73917 Y69.74400 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X184.25600 Y15.73917 I110.26083 J56.25600 E6.201673
G3 X238.26083 Y182.25600 I-56.25600 J110.26083 E6.201673
G3 X71.74400 Y236.26083 I-110.26083 J-56.25600 E6.201673
G3 X17.73917 Y69.74400 I56.25600 J-110.26083 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 1.200
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 6/20
M73 L6
M991 S0 P5
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.58223 Y182.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X226.21372 Y181.14466 I-1.85534 J0.51318 E0.100304
G2 X224.87156 Y183.51318 I0.51318 J1.85534 E0.100304
G2 X227.24007 Y184.85534 I1.85534 J-0.51318 E0.100304
G2 X228.58223 Y182.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X226.95530 Y177.24066 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X227.38259 Y177.12617 E0.014674
G1 X227.92465 Y177.40236 E0.020181
G1 X226.70012 Y177.73047 E0.042053
G1 X226.44134 Y178.22126 E0.018405
G1 X228.46671 Y177.67856 E0.069555
G1 X229.00877 Y177.95475 E0.020181
G1 X226.17889 Y178.71302 E0.097184
G1 X225.91272 Y179.20578 E0.018578
G1 X229.55084 Y178.23095 E0.124940
G1 X230.09290 Y178.50714 E0.020181
G1 X225.64279 Y179.69954 E0.152826
G1 X225.36904 Y180.19433 E0.018758
G1 X230.63496 Y178.78334 E0.180842
G1 X231.17702 Y179.05953 E0.020181
G1 X225.09141 Y180.69017 E0.208992
G1 X224.80984 Y181.18705 E0.018945
G1 X231.71909 Y179.33573 E0.237277
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X224.82742 Y182.02522 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.88450 Y181.20608 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.26977 Y181.52429 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X224.59302 Y182.93091 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.54034 Y181.87323 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X224.61998 Y183.34512 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.72410 Y182.24543 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X224.72378 Y183.73875 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.83102 Y182.63822 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X224.90426 Y184.11183 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.86126 Y183.05156 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X225.17086 Y184.46183 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.80538 Y183.48797 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X225.55039 Y184.78158 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y182.34205 E0.273231
G1 X235.97107 Y182.83225 E0.018354
G1 X222.05467 Y186.56114 E0.477917
G1 X222.51407 Y186.85948 E0.018171
G1 X235.71117 Y183.32333 E0.453215
G1 X235.44787 Y183.81532 E0.018510
G1 X222.97348 Y187.15782 E0.428396
G1 X223.43289 Y187.45616 E0.018171
G1 X235.18121 Y184.30821 E0.403461
G1 X234.91107 Y184.80203 E0.018672
G1 X223.89229 Y187.75451 E0.378407
G1 X224.35170 Y188.05285 E0.018171
G1 X234.63747 Y185.29678 E0.353234
G1 X234.36031 Y185.79249 E0.018839
G1 X224.81111 Y188.35119 E0.327939
G1 X225.27051 Y188.64953 E0.018171
G1 X234.07957 Y186.28915 E0.302521
G1 X233.79521 Y186.78679 E0.019012
G1 X225.72992 Y188.94787 E0.276978
G1 X226.18933 Y189.24622 E0.018171
G1 X233.50713 Y187.28542 E0.251308
G1 X233.21533 Y187.78504 E0.019193
G1 X226.64873 Y189.54456 E0.225510
G1 X227.10814 Y189.84290 E0.018171
G1 X232.91974 Y188.28569 E0.199582
G1 X232.62028 Y188.78737 E0.019381
G1 X227.56755 Y190.14124 E0.173521
G1 X228.02695 Y190.43959 E0.018171
G1 X232.31693 Y189.29009 E0.147326
G1 X232.00961 Y189.79387 E0.019575
G1 X228.48636 Y190.73793 E0.120996
G1 X228.94577 Y191.03627 E0.018171
G1 X231.69827 Y190.29874 E0.094526
G1 X231.38282 Y190.80470 E0.019779
G1 X229.40517 Y191.33461 E0.067916
G1 X229.86458 Y191.63295 E0.018171
G1 X231.06322 Y191.31178 E0.041164
G1 X230.73941 Y191.81998 E0.019989
G1 X230.32399 Y191.93130 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.85534 Y239.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X127.48682 Y238.14466 I-1.85534 J0.51318 E0.100304
G2 X126.14466 Y240.51318 I0.51318 J1.85534 E0.100304
G2 X128.51318 Y241.85534 I1.85534 J-0.51318 E0.100304
G2 X129.85534 Y239.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X133.10194 Y237.31813 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.41473 Y237.63093 E0.014674
G1 X133.44657 Y238.23846 E0.020181
G1 X132.55016 Y237.34205 E0.042053
G1 X131.99573 Y237.36333 E0.018405
G1 X133.47841 Y238.84600 E0.069555
G1 X133.51025 Y239.45354 E0.020181
G1 X131.43863 Y237.38192 E0.097184
G1 X130.87881 Y237.39779 E0.018578
G1 X133.54209 Y240.06108 E0.124940
G1 X133.57393 Y240.66861 E0.020181
G1 X130.31623 Y237.41091 E0.152826
G1 X129.75085 Y237.42123 E0.018758
G1 X133.60577 Y241.27615 E0.180842
G1 X133.63761 Y241.88369 E0.020181
G1 X129.18263 Y237.42871 E0.208992
G1 X128.61153 Y237.43331 E0.018945
G1 X133.66945 Y242.49123 E0.237277
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X127.89444 Y237.86761 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X130.13239 Y240.10556 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X130.04944 Y240.59831 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X126.99289 Y238.11746 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.88254 Y241.00711 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X126.64766 Y238.34792 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.65208 Y241.35234 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X126.35867 Y238.63463 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.36537 Y241.64133 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X126.12581 Y238.97746 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.02254 Y241.87419 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X125.95600 Y239.38335 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X128.61665 Y242.04400 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X125.86885 Y239.87191 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y247.89895 E0.273231
G1 X132.76736 Y247.92181 E0.018354
G1 X122.57985 Y237.73430 E0.477917
G1 X122.55118 Y238.28133 E0.018171
G1 X132.21213 Y247.94227 E0.453215
G1 X131.65440 Y247.96025 E0.018510
G1 X122.52251 Y238.82836 E0.428396
G1 X122.49384 Y239.37539 E0.018171
G1 X131.09422 Y247.97576 E0.403461
G1 X130.53148 Y247.98872 E0.018672
G1 X122.46518 Y239.92242 E0.378407
G1 X122.43651 Y240.46944 E0.018171
G1 X129.96621 Y247.99915 E0.353234
G1 X129.39834 Y248.00697 E0.018839
G1 X122.40784 Y241.01647 E0.327939
G1 X122.37917 Y241.56350 E0.018171
G1 X128.82785 Y248.01218 E0.302521
G1 X128.25470 Y248.01473 E0.019012
G1 X122.35050 Y242.11053 E0.276978
G1 X122.32183 Y242.65756 E0.018171
G1 X127.67884 Y248.01456 E0.251308
G1 X127.10025 Y248.01167 E0.019193
G1 X122.29316 Y243.20459 E0.225510
G1 X122.26450 Y243.75162 E0.018171
G1 X126.51888 Y248.00601 E0.199582
G1 X125.93469 Y247.99750 E0.019381
G1 X122.23583 Y244.29865 E0.173521
G1 X122.20716 Y244.84568 E0.018171
G1 X125.34764 Y247.98615 E0.147326
G1 X124.75769 Y247.97191 E0.019575
G1 X122.17849 Y245.39270 E0.120996
G1 X122.14982 Y245.93973 E0.018171
G1 X124.16479 Y247.95471 E0.094526
G1 X123.56889 Y247.93450 E0.019779
G1 X122.12115 Y246.48676 E0.067916
G1 X122.09248 Y247.03379 E0.018171
G1 X122.96995 Y247.91126 E0.041164
G1 X122.36793 Y247.88493 E0.019989
G1 X122.06382 Y247.58082 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.12844 Y182.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X28.75993 Y181.14466 I-1.85534 J0.51318 E0.100304
G2 X27.41777 Y183.51318 I0.51318 J1.85534 E0.100304
G2 X29.78628 Y184.85534 I1.85534 J-0.51318 E0.100304
G2 X31.12844 Y182.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X34.14664 Y186.07747 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X34.03215 Y186.50476 E0.014674
G1 X33.52192 Y186.83610 E0.020181
G1 X33.85003 Y185.61158 E0.042053
G1 X33.55440 Y185.14207 E0.018405
G1 X33.01170 Y187.16744 E0.069555
G1 X32.50148 Y187.49879 E0.020181
G1 X33.25974 Y184.66890 E0.097184
G1 X32.96608 Y184.19202 E0.018578
G1 X31.99126 Y187.83013 E0.124940
G1 X31.48103 Y188.16147 E0.020181
G1 X32.67343 Y183.71137 E0.152826
G1 X32.38181 Y183.22690 E0.018758
G1 X30.97081 Y188.49281 E0.180842
G1 X30.46059 Y188.82416 E0.020181
G1 X32.09122 Y182.73854 E0.208992
G1 X31.80169 Y182.24626 E0.018945
G1 X29.95036 Y189.15550 E0.237277
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.06703 Y181.84239 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X30.24788 Y184.89948 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X29.77967 Y185.07402 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X30.39988 Y181.18655 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X29.34219 Y185.13388 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X30.02768 Y181.00280 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.92798 Y185.10691 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X29.63488 Y180.89588 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.53435 Y185.00311 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X29.22155 Y180.86563 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.16127 Y184.82264 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.78513 Y180.92152 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.81127 Y184.55603 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.31846 Y181.09033 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y191.55690 E0.273231
G1 X24.79629 Y191.08957 E0.018354
G1 X28.52518 Y177.17316 E0.477917
G1 X28.03711 Y177.42185 E0.018171
G1 X24.50096 Y190.61894 E0.453215
G1 X24.20653 Y190.14493 E0.018510
G1 X27.54903 Y177.67054 E0.428396
G1 X27.06096 Y177.91922 E0.018171
G1 X23.91300 Y189.66755 E0.403461
G1 X23.62041 Y189.18669 E0.018672
G1 X26.57288 Y178.16791 E0.378407
G1 X26.08481 Y178.41660 E0.018171
G1 X23.32874 Y188.70236 E0.353234
G1 X23.03803 Y188.21449 E0.018839
G1 X25.59673 Y178.66528 E0.327939
G1 X25.10866 Y178.91397 E0.018171
G1 X22.74828 Y187.72302 E0.302521
G1 X22.45949 Y187.22794 E0.019012
G1 X24.62058 Y179.16266 E0.276978
G1 X24.13251 Y179.41134 E0.018171
G1 X22.17171 Y186.72914 E0.251308
G1 X21.88492 Y186.22663 E0.019193
G1 X23.64443 Y179.66003 E0.225510
G1 X23.15636 Y179.90872 E0.018171
G1 X21.59914 Y185.72032 E0.199582
G1 X21.31440 Y185.21014 E0.019381
G1 X22.66828 Y180.15740 E0.173521
G1 X22.18021 Y180.40609 E0.018171
G1 X21.03071 Y184.69606 E0.147326
G1 X20.74808 Y184.17803 E0.019575
G1 X21.69213 Y180.65478 E0.120996
G1 X21.20405 Y180.90346 E0.018171
G1 X20.46652 Y183.65597 E0.094526
G1 X20.18607 Y183.12980 E0.019779
G1 X20.71598 Y181.15215 E0.067916
G1 X20.22790 Y181.40084 E0.018171
G1 X19.90673 Y182.59948 E0.041164
G1 X19.62852 Y182.06495 E0.019989
G1 X19.73983 Y181.64952 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.12844 Y68.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X28.75993 Y67.14466 I-1.85534 J0.51318 E0.100304
G2 X27.41777 Y69.51318 I0.51318 J1.85534 E0.100304
G2 X29.78628 Y70.85534 I1.85534 J-0.51318 E0.100304
G2 X31.12844 Y68.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X29.04470 Y74.75934 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X28.61741 Y74.87383 E0.014674
G1 X28.07535 Y74.59764 E0.020181
G1 X29.29988 Y74.26953 E0.042053
G1 X29.55866 Y73.77874 E0.018405
G1 X27.53329 Y74.32144 E0.069555
G1 X26.99123 Y74.04525 E0.020181
G1 X29.82111 Y73.28698 E0.097184
G1 X30.08728 Y72.79422 E0.018578
G1 X26.44916 Y73.76905 E0.124940
G1 X25.90710 Y73.49286 E0.020181
G1 X30.35721 Y72.30046 E0.152826
G1 X30.63096 Y71.80567 E0.018758
G1 X25.36504 Y73.21666 E0.180842
G1 X24.82298 Y72.94047 E0.020181
G1 X30.90859 Y71.30983 E0.208992
G1 X31.19016 Y70.81295 E0.018945
G1 X24.28091 Y72.66427 E0.237277
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.17258 Y69.97478 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.11550 Y70.79392 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.73023 Y70.47571 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.40698 Y69.06909 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.45966 Y70.12677 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.38002 Y68.65488 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.27590 Y69.75457 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.27622 Y68.26125 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.16898 Y69.36178 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.09574 Y67.88817 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.13874 Y68.94844 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X30.82914 Y67.53817 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.19462 Y68.51203 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X30.44961 Y67.21842 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y69.65795 E0.273231
G1 X20.02893 Y69.16775 E0.018354
G1 X33.94533 Y65.43886 E0.477917
G1 X33.48593 Y65.14052 E0.018171
G1 X20.28883 Y68.67667 E0.453215
G1 X20.55213 Y68.18468 E0.018510
G1 X33.02652 Y64.84218 E0.428396
G1 X32.56711 Y64.54384 E0.018171
G1 X20.81879 Y67.69179 E0.403461
G1 X21.08893 Y67.19797 E0.018672
G1 X32.10771 Y64.24549 E0.378407
G1 X31.64830 Y63.94715 E0.018171
G1 X21.36253 Y66.70322 E0.353234
G1 X21.63969 Y66.20751 E0.018839
G1 X31.18889 Y63.64881 E0.327939
G1 X30.72949 Y63.35047 E0.018171
G1 X21.92043 Y65.71085 E0.302521
G1 X22.20479 Y65.21321 E0.019012
G1 X30.27008 Y63.05213 E0.276978
G1 X29.81067 Y62.75378 E0.018171
G1 X22.49287 Y64.71458 E0.251308
G1 X22.78467 Y64.21496 E0.019193
G1 X29.35127 Y62.45544 E0.225510
G1 X28.89186 Y62.15710 E0.018171
G1 X23.08026 Y63.71431 E0.199582
G1 X23.37972 Y63.21263 E0.019381
G1 X28.43245 Y61.85876 E0.173521
G1 X27.97305 Y61.56041 E0.018171
G1 X23.68307 Y62.70991 E0.147326
G1 X23.99039 Y62.20613 E0.019575
G1 X27.51364 Y61.26207 E0.120996
G1 X27.05423 Y60.96373 E0.018171
G1 X24.30173 Y61.70126 E0.094526
G1 X24.61718 Y61.19530 E0.019779
G1 X26.59483 Y60.66539 E0.067916
G1 X26.13542 Y60.36705 E0.018171
G1 X24.93678 Y60.68822 E0.041164
G1 X25.26059 Y60.18002 E0.019989
G1 X25.67601 Y60.06870 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.85534 Y11.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X127.48682 Y10.14466 I-1.85534 J0.51318 E0.100304
G2 X126.14466 Y12.51318 I0.51318 J1.85534 E0.100304
G2 X128.51318 Y13.85534 I1.85534 J-0.51318 E0.100304
G2 X129.85534 Y11.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X122.89806 Y14.68187 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.58527 Y14.36907 E0.014674
G1 X122.55343 Y13.76154 E0.020181
G1 X123.44984 Y14.65795 E0.042053
G1 X124.00427 Y14.63667 E0.018405
G1 X122.52159 Y13.15400 E0.069555
G1 X122.48975 Y12.54646 E0.020181
G1 X124.56137 Y14.61808 E0.097184
G1 X125.12119 Y14.60221 E0.018578
G1 X122.45791 Y11.93892 E0.124940
G1 X122.42607 Y11.33139 E0.020181
G1 X125.68377 Y14.58909 E0.152826
G1 X126.24915 Y14.57877 E0.018758
G1 X122.39423 Y10.72385 E0.180842
G1 X122.36239 Y10.11631 E0.020181
G1 X126.81737 Y14.57129 E0.208992
G1 X127.38847 Y14.56669 E0.018945
G1 X122.33055 Y9.50877 E0.237277
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X128.10556 Y14.13239 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X125.86761 Y11.89444 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X125.95056 Y11.40169 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.00711 Y13.88254 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X126.11746 Y10.99289 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.35234 Y13.65208 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X126.34792 Y10.64766 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.64133 Y13.36537 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X126.63463 Y10.35867 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.87419 Y13.02254 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X126.97746 Y10.12581 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X130.04400 Y12.61665 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X127.38335 Y9.95600 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X130.13115 Y12.12809 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y4.10105 E0.273231
G1 X123.23264 Y4.07819 E0.018354
G1 X133.42015 Y14.26570 E0.477917
G1 X133.44882 Y13.71867 E0.018171
G1 X123.78787 Y4.05773 E0.453215
G1 X124.34560 Y4.03975 E0.018510
G1 X133.47749 Y13.17164 E0.428396
G1 X133.50616 Y12.62461 E0.018171
G1 X124.90578 Y4.02424 E0.403461
G1 X125.46852 Y4.01128 E0.018672
G1 X133.53482 Y12.07758 E0.378407
G1 X133.56349 Y11.53056 E0.018171
G1 X126.03379 Y4.00085 E0.353234
G1 X126.60166 Y3.99303 E0.018839
G1 X133.59216 Y10.98353 E0.327939
G1 X133.62083 Y10.43650 E0.018171
G1 X127.17215 Y3.98782 E0.302521
G1 X127.74530 Y3.98527 E0.019012
G1 X133.64950 Y9.88947 E0.276978
G1 X133.67817 Y9.34244 E0.018171
G1 X128.32116 Y3.98544 E0.251308
G1 X128.89975 Y3.98833 E0.019193
G1 X133.70684 Y8.79541 E0.225510
G1 X133.73550 Y8.24838 E0.018171
G1 X129.48112 Y3.99399 E0.199582
G1 X130.06531 Y4.00250 E0.019381
G1 X133.76417 Y7.70135 E0.173521
G1 X133.79284 Y7.15432 E0.018171
G1 X130.65236 Y4.01385 E0.147326
G1 X131.24231 Y4.02809 E0.019575
G1 X133.82151 Y6.60730 E0.120996
G1 X133.85018 Y6.06027 E0.018171
G1 X131.83521 Y4.04529 E0.094526
G1 X132.43111 Y4.06550 E0.019779
G1 X133.87885 Y5.51324 E0.067916
G1 X133.90752 Y4.96621 E0.018171
G1 X133.03005 Y4.08874 E0.041164
G1 X133.63207 Y4.11507 E0.019989
G1 X133.93618 Y4.41918 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.58223 Y68.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X226.21372 Y67.14466 I-1.85534 J0.51318 E0.100304
G2 X224.87156 Y69.51318 I0.51318 J1.85534 E0.100304
G2 X227.24007 Y70.85534 I1.85534 J-0.51318 E0.100304
G2 X228.58223 Y68.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X221.85336 Y65.92253 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X221.96785 Y65.49524 E0.014674
G1 X222.47808 Y65.16390 E0.020181
G1 X222.14997 Y66.38842 E0.042053
G1 X222.44560 Y66.85793 E0.018405
G1 X222.98830 Y64.83256 E0.069555
G1 X223.49852 Y64.50121 E0.020181
G1 X222.74026 Y67.33110 E0.097184
G1 X223.03392 Y67.80798 E0.018578
G1 X224.00874 Y64.16987 E0.124940
G1 X224.51897 Y63.83853 E0.020181
G1 X223.32657 Y68.28863 E0.152826
G1 X223.61819 Y68.77310 E0.018758
G1 X225.02919 Y63.50719 E0.180842
G1 X225.53941 Y63.17584 E0.020181
G1 X223.90878 Y69.26146 E0.208992
G1 X224.19831 Y69.75374 E0.018945
G1 X226.04964 Y62.84450 E0.237277
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X224.93297 Y70.15761 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X225.75212 Y67.10052 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X226.22033 Y66.92598 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X225.60012 Y70.81345 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X226.65781 Y66.86612 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X225.97232 Y70.99720 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.07202 Y66.89309 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X226.36512 Y71.10412 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.46565 Y66.99689 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X226.77845 Y71.13437 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.83873 Y67.17736 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.21487 Y71.07848 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.18873 Y67.44397 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.68154 Y70.90967 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y60.44310 E0.273231
G1 X231.20371 Y60.91043 E0.018354
G1 X227.47482 Y74.82684 E0.477917
G1 X227.96289 Y74.57815 E0.018171
G1 X231.49904 Y61.38106 E0.453215
G1 X231.79347 Y61.85507 E0.018510
G1 X228.45097 Y74.32946 E0.428396
G1 X228.93904 Y74.08078 E0.018171
G1 X232.08700 Y62.33245 E0.403461
G1 X232.37959 Y62.81331 E0.018672
G1 X229.42712 Y73.83209 E0.378407
G1 X229.91519 Y73.58340 E0.018171
G1 X232.67126 Y63.29764 E0.353234
G1 X232.96197 Y63.78551 E0.018839
G1 X230.40327 Y73.33472 E0.327939
G1 X230.89134 Y73.08603 E0.018171
G1 X233.25172 Y64.27698 E0.302521
G1 X233.54051 Y64.77206 E0.019012
G1 X231.37942 Y72.83734 E0.276978
G1 X231.86749 Y72.58866 E0.018171
G1 X233.82829 Y65.27086 E0.251308
G1 X234.11508 Y65.77337 E0.019193
G1 X232.35557 Y72.33997 E0.225510
G1 X232.84364 Y72.09128 E0.018171
G1 X234.40086 Y66.27968 E0.199582
G1 X234.68560 Y66.78986 E0.019381
G1 X233.33172 Y71.84260 E0.173521
G1 X233.81979 Y71.59391 E0.018171
G1 X234.96929 Y67.30394 E0.147326
G1 X235.25192 Y67.82197 E0.019575
G1 X234.30787 Y71.34522 E0.120996
G1 X234.79595 Y71.09654 E0.018171
G1 X235.53348 Y68.34403 E0.094526
G1 X235.81393 Y68.87020 E0.019779
G1 X235.28402 Y70.84785 E0.067916
G1 X235.77210 Y70.59916 E0.018171
G1 X236.09327 Y69.40052 E0.041164
G1 X236.37148 Y69.93505 E0.019989
G1 X236.26017 Y70.35048 E0.014266
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X245.79429 Y93.41868 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X160.58132 Y243.79429 I-117.79429 J32.58132 E6.123232
G3 X10.20571 Y158.58132 I-32.58132 J-117.79429 E6.123232
G3 X95.41868 Y8.20571 I117.79429 J-32.58132 E6.123232
G3 X245.79429 Y93.41868 I32.58132 J117.79429 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X246.17154 Y93.31434 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X160.68566 Y244.17154 I-118.17154 J32.68566 E6.142842
G3 X9.82846 Y158.68566 I-32.68566 J-118.17154 E6.142842
G3 X95.31434 Y7.82846 I118.17154 J-32.68566 E6.142842
G3 X246.17154 Y93.31434 I32.68566 J118.17154 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X246.54879 Y93.20999 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X160.79001 Y244.54879 I-118.54879 J32.79001 E6.162452
G3 X9.45121 Y158.79001 I-32.79001 J-118.54879 E6.162452
G3 X95.20999 Y7.45121 I118.54879 J-32.79001 E6.162452
G3 X246.54879 Y93.20999 I32.79001 J118.54879 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X246.92604 Y93.10565 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X160.89435 Y244.92604 I-118.92604 J32.89435 E6.182063
G3 X9.07396 Y158.89435 I-32.89435 J-118.92604 E6.182063
G3 X95.10565 Y7.07396 I118.92604 J-32.89435 E6.182063
G3 X246.92604 Y93.10565 I32.89435 J118.92604 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X247.30329 Y93.00130 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X160.99870 Y245.30329 I-119.30329 J32.99870 E6.201673
G3 X8.69671 Y158.99870 I-32.99870 J-119.30329 E6.201673
G3 X95.00130 Y6.69671 I119.30329 J-32.99870 E6.201673
G3 X247.30329 Y93.00130 I32.99870 J119.30329 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 1.400
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 7/20
M73 L7
M991 S0 P6
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.70547 Y184.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X228.35856 Y184.02142 I1.02142 J-1.63166 E0.100304
G2 X227.74832 Y181.36834 I-1.63166 J-1.02142 E0.100304
G2 X225.09523 Y181.97858 I-1.02142 J1.63166 E0.100304
G2 X225.70547 Y184.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X236.26017 Y181.64952 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X236.37148 Y182.06495 E0.014266
G1 X236.09327 Y182.59948 E0.019989
G1 X235.77210 Y181.40084 E0.041164
G1 X235.28402 Y181.15215 E0.018171
G1 X235.81393 Y183.12980 E0.067916
G1 X235.53348 Y183.65597 E0.019779
G1 X234.79595 Y180.90346 E0.094526
G1 X234.30787 Y180.65478 E0.018171
G1 X235.25192 Y184.17803 E0.120996
G1 X234.96929 Y184.69606 E0.019575
G1 X233.81979 Y180.40609 E0.147326
G1 X233.33172 Y180.15740 E0.018171
G1 X234.68560 Y185.21014 E0.173521
G1 X234.40086 Y185.72032 E0.019381
G1 X232.84364 Y179.90872 E0.199582
G1 X232.35557 Y179.66003 E0.018171
G1 X234.11508 Y186.22663 E0.225510
G1 X233.82829 Y186.72914 E0.019193
G1 X231.86749 Y179.41134 E0.251308
G1 X231.37942 Y179.16266 E0.018171
G1 X233.54051 Y187.22794 E0.276978
G1 X233.25172 Y187.72302 E0.019012
G1 X230.89134 Y178.91397 E0.302521
G1 X230.40327 Y178.66528 E0.018171
G1 X232.96197 Y188.21449 E0.327939
G1 X232.67126 Y188.70236 E0.018839
G1 X229.91519 Y178.41660 E0.353234
G1 X229.42712 Y178.16791 E0.018171
G1 X232.37959 Y189.18669 E0.378407
G1 X232.08700 Y189.66755 E0.018672
G1 X228.93904 Y177.91922 E0.403461
G1 X228.45097 Y177.67054 E0.018171
G1 X231.79347 Y190.14493 E0.428396
G1 X231.49904 Y190.61894 E0.018510
G1 X227.96289 Y177.42185 E0.453215
G1 X227.47482 Y177.17316 E0.018171
G1 X231.20371 Y191.08957 E0.477917
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y191.55690 E0.273231
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.18873 Y184.55603 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X226.77845 Y180.86563 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.83873 Y184.82264 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X226.36512 Y180.89588 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.46565 Y185.00311 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.97232 Y181.00280 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.07202 Y185.10691 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.60012 Y181.18655 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X226.65781 Y185.13388 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.25118 Y181.45713 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X224.93297 Y181.84239 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.75212 Y184.89948 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.19831 Y182.24626 E0.237277
G1 X223.90878 Y182.73854 E0.018945
G1 X225.53941 Y188.82416 E0.208992
G1 X225.02919 Y188.49281 E0.020181
G1 X223.61819 Y183.22690 E0.180842
G1 X223.32657 Y183.71137 E0.018758
G1 X224.51897 Y188.16147 E0.152826
G1 X224.00874 Y187.83013 E0.020181
G1 X223.03392 Y184.19202 E0.124940
G1 X222.74026 Y184.66890 E0.018578
G1 X223.49852 Y187.49879 E0.097184
G1 X222.98830 Y187.16744 E0.020181
G1 X222.44560 Y185.14207 E0.069555
G1 X222.14997 Y185.61158 E0.018405
G1 X222.47808 Y186.83610 E0.042053
G1 X221.96785 Y186.50476 E0.020181
G1 X221.85336 Y186.07747 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.97858 Y241.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.63166 Y241.02142 I1.02142 J-1.63166 E0.100304
G2 X129.02142 Y238.36834 I-1.63166 J-1.02142 E0.100304
G2 X126.36834 Y238.97858 I-1.02142 J1.63166 E0.100304
G2 X126.97858 Y241.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X133.93618 Y247.58082 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.63207 Y247.88493 E0.014266
G1 X133.03005 Y247.91126 E0.019989
G1 X133.90752 Y247.03379 E0.041164
G1 X133.87885 Y246.48676 E0.018171
G1 X132.43111 Y247.93450 E0.067916
G1 X131.83521 Y247.95471 E0.019779
G1 X133.85018 Y245.93973 E0.094526
G1 X133.82151 Y245.39270 E0.018171
G1 X131.24231 Y247.97191 E0.120996
G1 X130.65236 Y247.98615 E0.019575
G1 X133.79284 Y244.84568 E0.147326
G1 X133.76417 Y244.29865 E0.018171
G1 X130.06531 Y247.99750 E0.173521
G1 X129.48112 Y248.00601 E0.019381
G1 X133.73550 Y243.75162 E0.199582
G1 X133.70684 Y243.20459 E0.018171
G1 X128.89975 Y248.01167 E0.225510
G1 X128.32116 Y248.01456 E0.019193
G1 X133.67817 Y242.65756 E0.251308
G1 X133.64950 Y242.11053 E0.018171
G1 X127.74530 Y248.01473 E0.276978
G1 X127.17215 Y248.01218 E0.019012
G1 X133.62083 Y241.56350 E0.302521
G1 X133.59216 Y241.01647 E0.018171
G1 X126.60166 Y248.00697 E0.327939
G1 X126.03379 Y247.99915 E0.018839
G1 X133.56349 Y240.46944 E0.353234
G1 X133.53482 Y239.92242 E0.018171
G1 X125.46852 Y247.98872 E0.378407
G1 X124.90578 Y247.97576 E0.018672
G1 X133.50616 Y239.37539 E0.403461
G1 X133.47749 Y238.82836 E0.018171
G1 X124.34560 Y247.96025 E0.428396
G1 X123.78787 Y247.94227 E0.018510
G1 X133.44882 Y238.28133 E0.453215
G1 X133.42015 Y237.73430 E0.018171
G1 X123.23264 Y247.92181 E0.477917
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y247.89895 E0.273231
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X127.38335 Y242.04400 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X129.87419 Y238.97746 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.97746 Y241.87419 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X129.64133 Y238.63463 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.63463 Y241.64133 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X129.35234 Y238.34792 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.34792 Y241.35234 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X129.00711 Y238.11746 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.11746 Y241.00711 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X128.59831 Y237.95056 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X128.10556 Y237.86761 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X125.86761 Y240.10556 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X127.38847 Y237.43331 E0.237277
G1 X126.81737 Y237.42871 E0.018945
G1 X122.36239 Y241.88369 E0.208992
G1 X122.39423 Y241.27615 E0.020181
G1 X126.24915 Y237.42123 E0.180842
G1 X125.68377 Y237.41091 E0.018758
G1 X122.42607 Y240.66861 E0.152826
G1 X122.45791 Y240.06108 E0.020181
G1 X125.12119 Y237.39779 E0.124940
G1 X124.56137 Y237.38192 E0.018578
G1 X122.48975 Y239.45354 E0.097184
G1 X122.52159 Y238.84600 E0.020181
G1 X124.00427 Y237.36333 E0.069555
G1 X123.44984 Y237.34205 E0.018405
G1 X122.55343 Y238.23846 E0.042053
G1 X122.58527 Y237.63093 E0.020181
G1 X122.89806 Y237.31813 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.25168 Y184.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X30.90477 Y184.02142 I1.02142 J-1.63166 E0.100304
G2 X30.29453 Y181.36834 I-1.63166 J-1.02142 E0.100304
G2 X27.64144 Y181.97858 I-1.02142 J1.63166 E0.100304
G2 X28.25168 Y184.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X25.67601 Y191.93130 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X25.26059 Y191.81998 E0.014266
G1 X24.93678 Y191.31178 E0.019989
G1 X26.13542 Y191.63295 E0.041164
G1 X26.59483 Y191.33461 E0.018171
G1 X24.61718 Y190.80470 E0.067916
G1 X24.30173 Y190.29874 E0.019779
G1 X27.05423 Y191.03627 E0.094526
G1 X27.51364 Y190.73793 E0.018171
G1 X23.99039 Y189.79387 E0.120996
G1 X23.68307 Y189.29009 E0.019575
G1 X27.97305 Y190.43959 E0.147326
G1 X28.43245 Y190.14124 E0.018171
G1 X23.37972 Y188.78737 E0.173521
G1 X23.08026 Y188.28569 E0.019381
G1 X28.89186 Y189.84290 E0.199582
G1 X29.35127 Y189.54456 E0.018171
G1 X22.78467 Y187.78504 E0.225510
G1 X22.49287 Y187.28542 E0.019193
G1 X29.81067 Y189.24622 E0.251308
G1 X30.27008 Y188.94787 E0.018171
G1 X22.20479 Y186.78679 E0.276978
G1 X21.92043 Y186.28915 E0.019012
G1 X30.72949 Y188.64953 E0.302521
G1 X31.18889 Y188.35119 E0.018171
G1 X21.63969 Y185.79249 E0.327939
G1 X21.36253 Y185.29678 E0.018839
G1 X31.64830 Y188.05285 E0.353234
G1 X32.10771 Y187.75451 E0.018171
G1 X21.08893 Y184.80203 E0.378407
G1 X20.81879 Y184.30821 E0.018672
G1 X32.56711 Y187.45616 E0.403461
G1 X33.02652 Y187.15782 E0.018171
G1 X20.55213 Y183.81532 E0.428396
G1 X20.28883 Y183.32333 E0.018510
G1 X33.48593 Y186.85948 E0.453215
G1 X33.94533 Y186.56114 E0.018171
G1 X20.02893 Y182.83225 E0.477917
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y182.34205 E0.273231
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.19462 Y183.48797 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X31.09574 Y184.11183 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.13874 Y183.05156 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X31.27622 Y183.73875 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.16898 Y182.63822 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X31.38002 Y183.34512 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.27590 Y182.24543 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X31.40698 Y182.93091 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.45966 Y181.87323 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X31.34713 Y182.49343 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X31.17258 Y182.02522 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.11550 Y181.20608 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X31.19016 Y181.18705 E0.237277
G1 X30.90859 Y180.69017 E0.018945
G1 X24.82298 Y179.05953 E0.208992
G1 X25.36504 Y178.78334 E0.020181
G1 X30.63096 Y180.19433 E0.180842
G1 X30.35721 Y179.69954 E0.018758
G1 X25.90710 Y178.50714 E0.152826
G1 X26.44916 Y178.23095 E0.020181
G1 X30.08728 Y179.20578 E0.124940
G1 X29.82111 Y178.71302 E0.018578
G1 X26.99123 Y177.95475 E0.097184
G1 X27.53329 Y177.67856 E0.020181
G1 X29.55866 Y178.22126 E0.069555
G1 X29.29988 Y177.73047 E0.018405
G1 X28.07535 Y177.40236 E0.042053
G1 X28.61741 Y177.12617 E0.020181
G1 X29.04470 Y177.24066 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.25168 Y70.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X30.90477 Y70.02142 I1.02142 J-1.63166 E0.100304
G2 X30.29453 Y67.36834 I-1.63166 J-1.02142 E0.100304
G2 X27.64144 Y67.97858 I-1.02142 J1.63166 E0.100304
G2 X28.25168 Y70.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X19.73983 Y70.35048 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X19.62852 Y69.93505 E0.014266
G1 X19.90673 Y69.40052 E0.019989
G1 X20.22790 Y70.59916 E0.041164
G1 X20.71598 Y70.84785 E0.018171
G1 X20.18607 Y68.87020 E0.067916
G1 X20.46652 Y68.34403 E0.019779
G1 X21.20405 Y71.09654 E0.094526
G1 X21.69213 Y71.34522 E0.018171
G1 X20.74808 Y67.82197 E0.120996
G1 X21.03071 Y67.30394 E0.019575
G1 X22.18021 Y71.59391 E0.147326
G1 X22.66828 Y71.84260 E0.018171
G1 X21.31440 Y66.78986 E0.173521
G1 X21.59914 Y66.27968 E0.019381
G1 X23.15636 Y72.09128 E0.199582
G1 X23.64443 Y72.33997 E0.018171
G1 X21.88492 Y65.77337 E0.225510
G1 X22.17171 Y65.27086 E0.019193
G1 X24.13251 Y72.58866 E0.251308
G1 X24.62058 Y72.83734 E0.018171
G1 X22.45949 Y64.77206 E0.276978
G1 X22.74828 Y64.27698 E0.019012
G1 X25.10866 Y73.08603 E0.302521
G1 X25.59673 Y73.33472 E0.018171
G1 X23.03803 Y63.78551 E0.327939
G1 X23.32874 Y63.29764 E0.018839
G1 X26.08481 Y73.58340 E0.353234
G1 X26.57288 Y73.83209 E0.018171
G1 X23.62041 Y62.81331 E0.378407
G1 X23.91300 Y62.33245 E0.018672
G1 X27.06096 Y74.08078 E0.403461
G1 X27.54903 Y74.32946 E0.018171
G1 X24.20653 Y61.85507 E0.428396
G1 X24.50096 Y61.38106 E0.018510
G1 X28.03711 Y74.57815 E0.453215
G1 X28.52518 Y74.82684 E0.018171
G1 X24.79629 Y60.91043 E0.477917
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y60.44310 E0.273231
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.81127 Y67.44397 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X29.22155 Y71.13437 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.16127 Y67.17736 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X29.63488 Y71.10412 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.53435 Y66.99689 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.02768 Y70.99720 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.92798 Y66.89309 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.39988 Y70.81345 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X29.34219 Y66.86612 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.74882 Y70.54287 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X31.06703 Y70.15761 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.24788 Y67.10052 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.80169 Y69.75374 E0.237277
G1 X32.09122 Y69.26146 E0.018945
G1 X30.46059 Y63.17584 E0.208992
G1 X30.97081 Y63.50719 E0.020181
G1 X32.38181 Y68.77310 E0.180842
G1 X32.67343 Y68.28863 E0.018758
G1 X31.48103 Y63.83853 E0.152826
G1 X31.99126 Y64.16987 E0.020181
G1 X32.96608 Y67.80798 E0.124940
G1 X33.25974 Y67.33110 E0.018578
G1 X32.50148 Y64.50121 E0.097184
G1 X33.01170 Y64.83256 E0.020181
G1 X33.55440 Y66.85793 E0.069555
G1 X33.85003 Y66.38842 E0.018405
G1 X33.52192 Y65.16390 E0.042053
G1 X34.03215 Y65.49524 E0.020181
G1 X34.14664 Y65.92253 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.97858 Y13.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.63166 Y13.02142 I1.02142 J-1.63166 E0.100304
G2 X129.02142 Y10.36834 I-1.63166 J-1.02142 E0.100304
G2 X126.36834 Y10.97858 I-1.02142 J1.63166 E0.100304
G2 X126.97858 Y13.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X122.06382 Y4.41918 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.36793 Y4.11507 E0.014266
G1 X122.96995 Y4.08874 E0.019989
G1 X122.09248 Y4.96621 E0.041164
G1 X122.12115 Y5.51324 E0.018171
G1 X123.56889 Y4.06550 E0.067916
G1 X124.16479 Y4.04529 E0.019779
G1 X122.14982 Y6.06027 E0.094526
G1 X122.17849 Y6.60730 E0.018171
G1 X124.75769 Y4.02809 E0.120996
G1 X125.34764 Y4.01385 E0.019575
G1 X122.20716 Y7.15432 E0.147326
G1 X122.23583 Y7.70135 E0.018171
G1 X125.93469 Y4.00250 E0.173521
G1 X126.51888 Y3.99399 E0.019381
G1 X122.26450 Y8.24838 E0.199582
G1 X122.29316 Y8.79541 E0.018171
G1 X127.10025 Y3.98833 E0.225510
G1 X127.67884 Y3.98544 E0.019193
G1 X122.32183 Y9.34244 E0.251308
G1 X122.35050 Y9.88947 E0.018171
G1 X128.25470 Y3.98527 E0.276978
G1 X128.82785 Y3.98782 E0.019012
G1 X122.37917 Y10.43650 E0.302521
G1 X122.40784 Y10.98353 E0.018171
G1 X129.39834 Y3.99303 E0.327939
G1 X129.96621 Y4.00085 E0.018839
G1 X122.43651 Y11.53056 E0.353234
G1 X122.46518 Y12.07758 E0.018171
G1 X130.53148 Y4.01128 E0.378407
G1 X131.09422 Y4.02424 E0.018672
G1 X122.49384 Y12.62461 E0.403461
G1 X122.52251 Y13.17164 E0.018171
G1 X131.65440 Y4.03975 E0.428396
G1 X132.21213 Y4.05773 E0.018510
G1 X122.55118 Y13.71867 E0.453215
G1 X122.57985 Y14.26570 E0.018171
G1 X132.76736 Y4.07819 E0.477917
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y4.10105 E0.273231
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X128.61665 Y9.95600 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.12581 Y13.02254 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X129.02254 Y10.12581 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.35867 Y13.36537 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X129.36537 Y10.35867 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.64766 Y13.65208 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X129.65208 Y10.64766 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.99289 Y13.88254 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X129.88254 Y10.99289 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X127.40169 Y14.04944 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X127.89444 Y14.13239 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X130.13239 Y11.89444 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X128.61153 Y14.56669 E0.237277
G1 X129.18263 Y14.57129 E0.018945
G1 X133.63761 Y10.11631 E0.208992
G1 X133.60577 Y10.72385 E0.020181
G1 X129.75085 Y14.57877 E0.180842
G1 X130.31623 Y14.58909 E0.018758
G1 X133.57393 Y11.33139 E0.152826
G1 X133.54209 Y11.93892 E0.020181
G1 X130.87881 Y14.60221 E0.124940
G1 X131.43863 Y14.61808 E0.018578
G1 X133.51025 Y12.54646 E0.097184
G1 X133.47841 Y13.15400 E0.020181
G1 X131.99573 Y14.63667 E0.069555
G1 X132.55016 Y14.65795 E0.018405
G1 X133.44657 Y13.76154 E0.042053
G1 X133.41473 Y14.36907 E0.020181
G1 X133.10194 Y14.68187 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.70547 Y70.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X228.35856 Y70.02142 I1.02142 J-1.63166 E0.100304
G2 X227.74832 Y67.36834 I-1.63166 J-1.02142 E0.100304
G2 X225.09523 Y67.97858 I-1.02142 J1.63166 E0.100304
G2 X225.70547 Y70.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X230.32399 Y60.06870 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X230.73941 Y60.18002 E0.014266
G1 X231.06322 Y60.68822 E0.019989
G1 X229.86458 Y60.36705 E0.041164
G1 X229.40517 Y60.66539 E0.018171
G1 X231.38282 Y61.19530 E0.067916
G1 X231.69827 Y61.70126 E0.019779
G1 X228.94577 Y60.96373 E0.094526
G1 X228.48636 Y61.26207 E0.018171
G1 X232.00961 Y62.20613 E0.120996
G1 X232.31693 Y62.70991 E0.019575
G1 X228.02695 Y61.56041 E0.147326
G1 X227.56755 Y61.85876 E0.018171
G1 X232.62028 Y63.21263 E0.173521
G1 X232.91974 Y63.71431 E0.019381
G1 X227.10814 Y62.15710 E0.199582
G1 X226.64873 Y62.45544 E0.018171
G1 X233.21533 Y64.21496 E0.225510
G1 X233.50713 Y64.71458 E0.019193
G1 X226.18933 Y62.75378 E0.251308
G1 X225.72992 Y63.05213 E0.018171
G1 X233.79521 Y65.21321 E0.276978
G1 X234.07957 Y65.71085 E0.019012
G1 X225.27051 Y63.35047 E0.302521
G1 X224.81111 Y63.64881 E0.018171
G1 X234.36031 Y66.20751 E0.327939
G1 X234.63747 Y66.70322 E0.018839
G1 X224.35170 Y63.94715 E0.353234
G1 X223.89229 Y64.24549 E0.018171
G1 X234.91107 Y67.19797 E0.378407
G1 X235.18121 Y67.69179 E0.018672
G1 X223.43289 Y64.54384 E0.403461
G1 X222.97348 Y64.84218 E0.018171
G1 X235.44787 Y68.18468 E0.428396
G1 X235.71117 Y68.67667 E0.018510
G1 X222.51407 Y65.14052 E0.453215
G1 X222.05467 Y65.43886 E0.018171
G1 X235.97107 Y69.16775 E0.477917
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y69.65795 E0.273231
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.80538 Y68.51203 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X224.90426 Y67.88817 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.86126 Y68.94844 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X224.72378 Y68.26125 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.83102 Y69.36178 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X224.61998 Y68.65488 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.72410 Y69.75457 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X224.59302 Y69.06909 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.54034 Y70.12677 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X224.65287 Y69.50657 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X224.82742 Y69.97478 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.88450 Y70.79392 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X224.80984 Y70.81295 E0.237277
G1 X225.09141 Y71.30983 E0.018945
G1 X231.17702 Y72.94047 E0.208992
G1 X230.63496 Y73.21666 E0.020181
G1 X225.36904 Y71.80567 E0.180842
G1 X225.64279 Y72.30046 E0.018758
G1 X230.09290 Y73.49286 E0.152826
G1 X229.55084 Y73.76905 E0.020181
G1 X225.91272 Y72.79422 E0.124940
G1 X226.17889 Y73.28698 E0.018578
G1 X229.00877 Y74.04525 E0.097184
G1 X228.46671 Y74.32144 E0.020181
G1 X226.44134 Y73.77874 E0.069555
G1 X226.70012 Y74.26953 E0.018405
G1 X227.92465 Y74.59764 E0.042053
G1 X227.38259 Y74.87383 E0.020181
G1 X226.95530 Y74.75934 E0.014674
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X63.15052 Y229.59335 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X24.40665 Y61.15052 I64.84948 J-103.59335 E6.123232
G3 X192.84948 Y22.40665 I103.59335 J64.84948 E6.123232
G3 X231.59335 Y190.84948 I-64.84948 J103.59335 E6.123232
G3 X63.15052 Y229.59335 I-103.59335 J-64.84948 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X62.94283 Y229.92512 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X24.07488 Y60.94283 I65.05717 J-103.92512 E6.142842
G3 X193.05717 Y22.07488 I103.92512 J65.05717 E6.142842
G3 X231.92512 Y191.05717 I-65.05717 J103.92512 E6.142842
G3 X62.94283 Y229.92512 I-103.92512 J-65.05717 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X62.73514 Y230.25689 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X23.74311 Y60.73514 I65.26486 J-104.25689 E6.162452
G3 X193.26486 Y21.74311 I104.25689 J65.26486 E6.162452
G3 X232.25689 Y191.26486 I-65.26486 J104.25689 E6.162452
G3 X62.73514 Y230.25689 I-104.25689 J-65.26486 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X62.52745 Y230.58866 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X23.41134 Y60.52745 I65.47255 J-104.58866 E6.182063
G3 X193.47255 Y21.41134 I104.58866 J65.47255 E6.182063
G3 X232.58866 Y191.47255 I-65.47255 J104.58866 E6.182063
G3 X62.52745 Y230.58866 I-104.58866 J-65.47255 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X62.31977 Y230.92043 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X23.07957 Y60.31977 I65.68023 J-104.92043 E6.201673
G3 X193.68023 Y21.07957 I104.92043 J65.68023 E6.201673
G3 X232.92043 Y191.68023 I-65.68023 J104.92043 E6.201673
G3 X62.31977 Y230.92043 I-104.92043 J-65.68023 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 1.600
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 8/20
M73 L8
M991 S0 P7
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X226.37789 Y181.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X224.83380 Y183.34901 I0.34901 J1.89310 E0.100304
G2 X227.07590 Y184.89310 I1.89310 J-0.34901 E0.100304
G2 X228.61999 Y182.65099 I-0.34901 J-1.89310 E0.100304
G2 X226.37789 Y181.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X226.95530 Y177.24066 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X227.38259 Y177.12617 E0.014674
G1 X227.92465 Y177.40236 E0.020181
G1 X226.70012 Y177.73047 E0.042053
G1 X226.44134 Y178.22126 E0.018405
G1 X228.46671 Y177.67856 E0.069555
G1 X229.00877 Y177.95475 E0.020181
G1 X226.17889 Y178.71302 E0.097184
G1 X225.91272 Y179.20578 E0.018578
G1 X229.55084 Y178.23095 E0.124940
G1 X230.09290 Y178.50714 E0.020181
G1 X225.64279 Y179.69954 E0.152826
G1 X225.36904 Y180.19433 E0.018758
G1 X230.63496 Y178.78334 E0.180842
G1 X231.17702 Y179.05953 E0.020181
G1 X225.09141 Y180.69017 E0.208992
G1 X224.80984 Y181.18705 E0.018945
G1 X231.71909 Y179.33573 E0.237277
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X224.82742 Y182.02522 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.88450 Y181.20608 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.26977 Y181.52429 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X224.59302 Y182.93091 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.54034 Y181.87323 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X224.61998 Y183.34512 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.72410 Y182.24543 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X224.72378 Y183.73875 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.83102 Y182.63822 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X224.90426 Y184.11183 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.86126 Y183.05156 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X225.17086 Y184.46183 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.80538 Y183.48797 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X225.55039 Y184.78158 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y182.34205 E0.273231
G1 X235.97107 Y182.83225 E0.018354
G1 X222.05467 Y186.56114 E0.477917
G1 X222.51407 Y186.85948 E0.018171
G1 X235.71117 Y183.32333 E0.453215
G1 X235.44787 Y183.81532 E0.018510
G1 X222.97348 Y187.15782 E0.428396
G1 X223.43289 Y187.45616 E0.018171
G1 X235.18121 Y184.30821 E0.403461
G1 X234.91107 Y184.80203 E0.018672
G1 X223.89229 Y187.75451 E0.378407
G1 X224.35170 Y188.05285 E0.018171
G1 X234.63747 Y185.29678 E0.353234
G1 X234.36031 Y185.79249 E0.018839
G1 X224.81111 Y188.35119 E0.327939
G1 X225.27051 Y188.64953 E0.018171
G1 X234.07957 Y186.28915 E0.302521
G1 X233.79521 Y186.78679 E0.019012
G1 X225.72992 Y188.94787 E0.276978
G1 X226.18933 Y189.24622 E0.018171
G1 X233.50713 Y187.28542 E0.251308
G1 X233.21533 Y187.78504 E0.019193
G1 X226.64873 Y189.54456 E0.225510
G1 X227.10814 Y189.84290 E0.018171
G1 X232.91974 Y188.28569 E0.199582
G1 X232.62028 Y188.78737 E0.019381
G1 X227.56755 Y190.14124 E0.173521
G1 X228.02695 Y190.43959 E0.018171
G1 X232.31693 Y189.29009 E0.147326
G1 X232.00961 Y189.79387 E0.019575
G1 X228.48636 Y190.73793 E0.120996
G1 X228.94577 Y191.03627 E0.018171
G1 X231.69827 Y190.29874 E0.094526
G1 X231.38282 Y190.80470 E0.019779
G1 X229.40517 Y191.33461 E0.067916
G1 X229.86458 Y191.63295 E0.018171
G1 X231.06322 Y191.31178 E0.041164
G1 X230.73941 Y191.81998 E0.019989
G1 X230.32399 Y191.93130 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.65099 Y238.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X126.10690 Y240.34901 I0.34901 J1.89310 E0.100304
G2 X128.34901 Y241.89310 I1.89310 J-0.34901 E0.100304
G2 X129.89310 Y239.65099 I-0.34901 J-1.89310 E0.100304
G2 X127.65099 Y238.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X133.10194 Y237.31813 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.41473 Y237.63093 E0.014674
G1 X133.44657 Y238.23846 E0.020181
G1 X132.55016 Y237.34205 E0.042053
G1 X131.99573 Y237.36333 E0.018405
G1 X133.47841 Y238.84600 E0.069555
G1 X133.51025 Y239.45354 E0.020181
G1 X131.43863 Y237.38192 E0.097184
G1 X130.87881 Y237.39779 E0.018578
G1 X133.54209 Y240.06108 E0.124940
G1 X133.57393 Y240.66861 E0.020181
G1 X130.31623 Y237.41091 E0.152826
G1 X129.75085 Y237.42123 E0.018758
G1 X133.60577 Y241.27615 E0.180842
G1 X133.63761 Y241.88369 E0.020181
G1 X129.18263 Y237.42871 E0.208992
G1 X128.61153 Y237.43331 E0.018945
G1 X133.66945 Y242.49123 E0.237277
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.89444 Y237.86761 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X130.13239 Y240.10556 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X130.04944 Y240.59831 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X126.99289 Y238.11746 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X129.88254 Y241.00711 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X126.64766 Y238.34792 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X129.65208 Y241.35234 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X126.35867 Y238.63463 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X129.36537 Y241.64133 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X126.12581 Y238.97746 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X129.02254 Y241.87419 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X125.95600 Y239.38335 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X128.61665 Y242.04400 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X125.86885 Y239.87191 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y247.89895 E0.273231
G1 X132.76736 Y247.92181 E0.018354
G1 X122.57985 Y237.73430 E0.477917
G1 X122.55118 Y238.28133 E0.018171
G1 X132.21213 Y247.94227 E0.453215
G1 X131.65440 Y247.96025 E0.018510
G1 X122.52251 Y238.82836 E0.428396
G1 X122.49384 Y239.37539 E0.018171
G1 X131.09422 Y247.97576 E0.403461
G1 X130.53148 Y247.98872 E0.018672
G1 X122.46518 Y239.92242 E0.378407
G1 X122.43651 Y240.46944 E0.018171
G1 X129.96621 Y247.99915 E0.353234
G1 X129.39834 Y248.00697 E0.018839
G1 X122.40784 Y241.01647 E0.327939
G1 X122.37917 Y241.56350 E0.018171
G1 X128.82785 Y248.01218 E0.302521
G1 X128.25470 Y248.01473 E0.019012
G1 X122.35050 Y242.11053 E0.276978
G1 X122.32183 Y242.65756 E0.018171
G1 X127.67884 Y248.01456 E0.251308
G1 X127.10025 Y248.01167 E0.019193
G1 X122.29316 Y243.20459 E0.225510
G1 X122.26450 Y243.75162 E0.018171
G1 X126.51888 Y248.00601 E0.199582
G1 X125.93469 Y247.99750 E0.019381
G1 X122.23583 Y244.29865 E0.173521
G1 X122.20716 Y244.84568 E0.018171
G1 X125.34764 Y247.98615 E0.147326
G1 X124.75769 Y247.97191 E0.019575
G1 X122.17849 Y245.39270 E0.120996
G1 X122.14982 Y245.93973 E0.018171
G1 X124.16479 Y247.95471 E0.094526
G1 X123.56889 Y247.93450 E0.019779
G1 X122.12115 Y246.48676 E0.067916
G1 X122.09248 Y247.03379 E0.018171
G1 X122.96995 Y247.91126 E0.041164
G1 X122.36793 Y247.88493 E0.019989
G1 X122.06382 Y247.58082 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.92410 Y181.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X27.38001 Y183.34901 I0.34901 J1.89310 E0.100304
G2 X29.62211 Y184.89310 I1.89310 J-0.34901 E0.100304
G2 X31.16620 Y182.65099 I-0.34901 J-1.89310 E0.100304
G2 X28.92410 Y181.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X34.14664 Y186.07747 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X34.03215 Y186.50476 E0.014674
G1 X33.52192 Y186.83610 E0.020181
G1 X33.85003 Y185.61158 E0.042053
G1 X33.55440 Y185.14207 E0.018405
G1 X33.01170 Y187.16744 E0.069555
G1 X32.50148 Y187.49879 E0.020181
G1 X33.25974 Y184.66890 E0.097184
G1 X32.96608 Y184.19202 E0.018578
G1 X31.99126 Y187.83013 E0.124940
G1 X31.48103 Y188.16147 E0.020181
G1 X32.67343 Y183.71137 E0.152826
G1 X32.38181 Y183.22690 E0.018758
G1 X30.97081 Y188.49281 E0.180842
G1 X30.46059 Y188.82416 E0.020181
G1 X32.09122 Y182.73854 E0.208992
G1 X31.80169 Y182.24626 E0.018945
G1 X29.95036 Y189.15550 E0.237277
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X31.06703 Y181.84239 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X30.24788 Y184.89948 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X29.77967 Y185.07402 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X30.39988 Y181.18655 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X29.34219 Y185.13388 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X30.02768 Y181.00280 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.92798 Y185.10691 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X29.63488 Y180.89588 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.53435 Y185.00311 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X29.22155 Y180.86563 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.16127 Y184.82264 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.78513 Y180.92152 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.81127 Y184.55603 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.31846 Y181.09033 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y191.55690 E0.273231
G1 X24.79629 Y191.08957 E0.018354
G1 X28.52518 Y177.17316 E0.477917
G1 X28.03711 Y177.42185 E0.018171
G1 X24.50096 Y190.61894 E0.453215
G1 X24.20653 Y190.14493 E0.018510
G1 X27.54903 Y177.67054 E0.428396
G1 X27.06096 Y177.91922 E0.018171
G1 X23.91300 Y189.66755 E0.403461
G1 X23.62041 Y189.18669 E0.018672
G1 X26.57288 Y178.16791 E0.378407
G1 X26.08481 Y178.41660 E0.018171
G1 X23.32874 Y188.70236 E0.353234
G1 X23.03803 Y188.21449 E0.018839
G1 X25.59673 Y178.66528 E0.327939
G1 X25.10866 Y178.91397 E0.018171
G1 X22.74828 Y187.72302 E0.302521
G1 X22.45949 Y187.22794 E0.019012
G1 X24.62058 Y179.16266 E0.276978
G1 X24.13251 Y179.41134 E0.018171
G1 X22.17171 Y186.72914 E0.251308
G1 X21.88492 Y186.22663 E0.019193
G1 X23.64443 Y179.66003 E0.225510
G1 X23.15636 Y179.90872 E0.018171
G1 X21.59914 Y185.72032 E0.199582
G1 X21.31440 Y185.21014 E0.019381
G1 X22.66828 Y180.15740 E0.173521
G1 X22.18021 Y180.40609 E0.018171
G1 X21.03071 Y184.69606 E0.147326
G1 X20.74808 Y184.17803 E0.019575
G1 X21.69213 Y180.65478 E0.120996
G1 X21.20405 Y180.90346 E0.018171
G1 X20.46652 Y183.65597 E0.094526
G1 X20.18607 Y183.12980 E0.019779
G1 X20.71598 Y181.15215 E0.067916
G1 X20.22790 Y181.40084 E0.018171
G1 X19.90673 Y182.59948 E0.041164
G1 X19.62852 Y182.06495 E0.019989
G1 X19.73983 Y181.64952 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.92410 Y67.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X27.38001 Y69.34901 I0.34901 J1.89310 E0.100304
G2 X29.62211 Y70.89310 I1.89310 J-0.34901 E0.100304
G2 X31.16620 Y68.65099 I-0.34901 J-1.89310 E0.100304
G2 X28.92410 Y67.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X29.04470 Y74.75934 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X28.61741 Y74.87383 E0.014674
G1 X28.07535 Y74.59764 E0.020181
G1 X29.29988 Y74.26953 E0.042053
G1 X29.55866 Y73.77874 E0.018405
G1 X27.53329 Y74.32144 E0.069555
G1 X26.99123 Y74.04525 E0.020181
G1 X29.82111 Y73.28698 E0.097184
G1 X30.08728 Y72.79422 E0.018578
G1 X26.44916 Y73.76905 E0.124940
G1 X25.90710 Y73.49286 E0.020181
G1 X30.35721 Y72.30046 E0.152826
G1 X30.63096 Y71.80567 E0.018758
G1 X25.36504 Y73.21666 E0.180842
G1 X24.82298 Y72.94047 E0.020181
G1 X30.90859 Y71.30983 E0.208992
G1 X31.19016 Y70.81295 E0.018945
G1 X24.28091 Y72.66427 E0.237277
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X31.17258 Y69.97478 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.11550 Y70.79392 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.73023 Y70.47571 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X31.40698 Y69.06909 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.45966 Y70.12677 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X31.38002 Y68.65488 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.27590 Y69.75457 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X31.27622 Y68.26125 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.16898 Y69.36178 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X31.09574 Y67.88817 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.13874 Y68.94844 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X30.82914 Y67.53817 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.19462 Y68.51203 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X30.44961 Y67.21842 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y69.65795 E0.273231
G1 X20.02893 Y69.16775 E0.018354
G1 X33.94533 Y65.43886 E0.477917
G1 X33.48593 Y65.14052 E0.018171
G1 X20.28883 Y68.67667 E0.453215
G1 X20.55213 Y68.18468 E0.018510
G1 X33.02652 Y64.84218 E0.428396
G1 X32.56711 Y64.54384 E0.018171
G1 X20.81879 Y67.69179 E0.403461
G1 X21.08893 Y67.19797 E0.018672
G1 X32.10771 Y64.24549 E0.378407
G1 X31.64830 Y63.94715 E0.018171
G1 X21.36253 Y66.70322 E0.353234
G1 X21.63969 Y66.20751 E0.018839
G1 X31.18889 Y63.64881 E0.327939
G1 X30.72949 Y63.35047 E0.018171
G1 X21.92043 Y65.71085 E0.302521
G1 X22.20479 Y65.21321 E0.019012
G1 X30.27008 Y63.05213 E0.276978
G1 X29.81067 Y62.75378 E0.018171
G1 X22.49287 Y64.71458 E0.251308
G1 X22.78467 Y64.21496 E0.019193
G1 X29.35127 Y62.45544 E0.225510
G1 X28.89186 Y62.15710 E0.018171
G1 X23.08026 Y63.71431 E0.199582
G1 X23.37972 Y63.21263 E0.019381
G1 X28.43245 Y61.85876 E0.173521
G1 X27.97305 Y61.56041 E0.018171
G1 X23.68307 Y62.70991 E0.147326
G1 X23.99039 Y62.20613 E0.019575
G1 X27.51364 Y61.26207 E0.120996
G1 X27.05423 Y60.96373 E0.018171
G1 X24.30173 Y61.70126 E0.094526
G1 X24.61718 Y61.19530 E0.019779
G1 X26.59483 Y60.66539 E0.067916
G1 X26.13542 Y60.36705 E0.018171
G1 X24.93678 Y60.68822 E0.041164
G1 X25.26059 Y60.18002 E0.019989
G1 X25.67601 Y60.06870 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.65099 Y10.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X126.10690 Y12.34901 I0.34901 J1.89310 E0.100304
G2 X128.34901 Y13.89310 I1.89310 J-0.34901 E0.100304
G2 X129.89310 Y11.65099 I-0.34901 J-1.89310 E0.100304
G2 X127.65099 Y10.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X122.89806 Y14.68187 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.58527 Y14.36907 E0.014674
G1 X122.55343 Y13.76154 E0.020181
G1 X123.44984 Y14.65795 E0.042053
G1 X124.00427 Y14.63667 E0.018405
G1 X122.52159 Y13.15400 E0.069555
G1 X122.48975 Y12.54646 E0.020181
G1 X124.56137 Y14.61808 E0.097184
G1 X125.12119 Y14.60221 E0.018578
G1 X122.45791 Y11.93892 E0.124940
G1 X122.42607 Y11.33139 E0.020181
G1 X125.68377 Y14.58909 E0.152826
G1 X126.24915 Y14.57877 E0.018758
G1 X122.39423 Y10.72385 E0.180842
G1 X122.36239 Y10.11631 E0.020181
G1 X126.81737 Y14.57129 E0.208992
G1 X127.38847 Y14.56669 E0.018945
G1 X122.33055 Y9.50877 E0.237277
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X128.10556 Y14.13239 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X125.86761 Y11.89444 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X125.95056 Y11.40169 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X129.00711 Y13.88254 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X126.11746 Y10.99289 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X129.35234 Y13.65208 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X126.34792 Y10.64766 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X129.64133 Y13.36537 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X126.63463 Y10.35867 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X129.87419 Y13.02254 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X126.97746 Y10.12581 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X130.04400 Y12.61665 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.38335 Y9.95600 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X130.13115 Y12.12809 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y4.10105 E0.273231
G1 X123.23264 Y4.07819 E0.018354
G1 X133.42015 Y14.26570 E0.477917
G1 X133.44882 Y13.71867 E0.018171
G1 X123.78787 Y4.05773 E0.453215
G1 X124.34560 Y4.03975 E0.018510
G1 X133.47749 Y13.17164 E0.428396
G1 X133.50616 Y12.62461 E0.018171
G1 X124.90578 Y4.02424 E0.403461
G1 X125.46852 Y4.01128 E0.018672
G1 X133.53482 Y12.07758 E0.378407
G1 X133.56349 Y11.53056 E0.018171
G1 X126.03379 Y4.00085 E0.353234
G1 X126.60166 Y3.99303 E0.018839
G1 X133.59216 Y10.98353 E0.327939
G1 X133.62083 Y10.43650 E0.018171
G1 X127.17215 Y3.98782 E0.302521
G1 X127.74530 Y3.98527 E0.019012
G1 X133.64950 Y9.88947 E0.276978
G1 X133.67817 Y9.34244 E0.018171
G1 X128.32116 Y3.98544 E0.251308
G1 X128.89975 Y3.98833 E0.019193
G1 X133.70684 Y8.79541 E0.225510
G1 X133.73550 Y8.24838 E0.018171
G1 X129.48112 Y3.99399 E0.199582
G1 X130.06531 Y4.00250 E0.019381
G1 X133.76417 Y7.70135 E0.173521
G1 X133.79284 Y7.15432 E0.018171
G1 X130.65236 Y4.01385 E0.147326
G1 X131.24231 Y4.02809 E0.019575
G1 X133.82151 Y6.60730 E0.120996
G1 X133.85018 Y6.06027 E0.018171
G1 X131.83521 Y4.04529 E0.094526
G1 X132.43111 Y4.06550 E0.019779
G1 X133.87885 Y5.51324 E0.067916
G1 X133.90752 Y4.96621 E0.018171
G1 X133.03005 Y4.08874 E0.041164
G1 X133.63207 Y4.11507 E0.019989
G1 X133.93618 Y4.41918 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X226.37789 Y67.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X224.83380 Y69.34901 I0.34901 J1.89310 E0.100304
G2 X227.07590 Y70.89310 I1.89310 J-0.34901 E0.100304
G2 X228.61999 Y68.65099 I-0.34901 J-1.89310 E0.100304
G2 X226.37789 Y67.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X221.85336 Y65.92253 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X221.96785 Y65.49524 E0.014674
G1 X222.47808 Y65.16390 E0.020181
G1 X222.14997 Y66.38842 E0.042053
G1 X222.44560 Y66.85793 E0.018405
G1 X222.98830 Y64.83256 E0.069555
G1 X223.49852 Y64.50121 E0.020181
G1 X222.74026 Y67.33110 E0.097184
G1 X223.03392 Y67.80798 E0.018578
G1 X224.00874 Y64.16987 E0.124940
G1 X224.51897 Y63.83853 E0.020181
G1 X223.32657 Y68.28863 E0.152826
G1 X223.61819 Y68.77310 E0.018758
G1 X225.02919 Y63.50719 E0.180842
G1 X225.53941 Y63.17584 E0.020181
G1 X223.90878 Y69.26146 E0.208992
G1 X224.19831 Y69.75374 E0.018945
G1 X226.04964 Y62.84450 E0.237277
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X224.93297 Y70.15761 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X225.75212 Y67.10052 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X226.22033 Y66.92598 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X225.60012 Y70.81345 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X226.65781 Y66.86612 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X225.97232 Y70.99720 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.07202 Y66.89309 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X226.36512 Y71.10412 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.46565 Y66.99689 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X226.77845 Y71.13437 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.83873 Y67.17736 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.21487 Y71.07848 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.18873 Y67.44397 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.68154 Y70.90967 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y60.44310 E0.273231
G1 X231.20371 Y60.91043 E0.018354
G1 X227.47482 Y74.82684 E0.477917
G1 X227.96289 Y74.57815 E0.018171
G1 X231.49904 Y61.38106 E0.453215
G1 X231.79347 Y61.85507 E0.018510
G1 X228.45097 Y74.32946 E0.428396
G1 X228.93904 Y74.08078 E0.018171
G1 X232.08700 Y62.33245 E0.403461
G1 X232.37959 Y62.81331 E0.018672
G1 X229.42712 Y73.83209 E0.378407
G1 X229.91519 Y73.58340 E0.018171
G1 X232.67126 Y63.29764 E0.353234
G1 X232.96197 Y63.78551 E0.018839
G1 X230.40327 Y73.33472 E0.327939
G1 X230.89134 Y73.08603 E0.018171
G1 X233.25172 Y64.27698 E0.302521
G1 X233.54051 Y64.77206 E0.019012
G1 X231.37942 Y72.83734 E0.276978
G1 X231.86749 Y72.58866 E0.018171
G1 X233.82829 Y65.27086 E0.251308
G1 X234.11508 Y65.77337 E0.019193
G1 X232.35557 Y72.33997 E0.225510
G1 X232.84364 Y72.09128 E0.018171
G1 X234.40086 Y66.27968 E0.199582
G1 X234.68560 Y66.78986 E0.019381
G1 X233.33172 Y71.84260 E0.173521
G1 X233.81979 Y71.59391 E0.018171
G1 X234.96929 Y67.30394 E0.147326
G1 X235.25192 Y67.82197 E0.019575
G1 X234.30787 Y71.34522 E0.120996
G1 X234.79595 Y71.09654 E0.018171
G1 X235.53348 Y68.34403 E0.094526
G1 X235.81393 Y68.87020 E0.019779
G1 X235.28402 Y70.84785 E0.067916
G1 X235.77210 Y70.59916 E0.018171
G1 X236.09327 Y69.40052 E0.041164
G1 X236.37148 Y69.93505 E0.019989
G1 X236.26017 Y70.35048 E0.014266
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X105.84169 Y5.80830 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X248.19170 Y103.84169 I22.15831 J120.19170 E6.123232
G3 X150.15831 Y246.19170 I-120.19170 J22.15831 E6.123232
G3 X7.80830 Y148.15831 I-22.15831 J-120.19170 E6.123232
G3 X105.84169 Y5.80830 I120.19170 J-22.15831 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X105.77072 Y5.42337 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X248.57663 Y103.77072 I22.22928 J120.57663 E6.142842
G3 X150.22928 Y246.57663 I-120.57663 J22.22928 E6.142842
G3 X7.42337 Y148.22928 I-22.22928 J-120.57663 E6.142842
G3 X105.77072 Y5.42337 I120.57663 J-22.22928 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X105.69976 Y5.03844 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X248.96156 Y103.69976 I22.30024 J120.96156 E6.162452
G3 X150.30024 Y246.96156 I-120.96156 J22.30024 E6.162452
G3 X7.03844 Y148.30024 I-22.30024 J-120.96156 E6.162452
G3 X105.69976 Y5.03844 I120.96156 J-22.30024 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X105.62879 Y4.65351 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X249.34649 Y103.62879 I22.37121 J121.34649 E6.182063
G3 X150.37121 Y247.34649 I-121.34649 J22.37121 E6.182063
G3 X6.65351 Y148.37121 I-22.37121 J-121.34649 E6.182063
G3 X105.62879 Y4.65351 I121.34649 J-22.37121 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X105.55783 Y4.26858 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X249.73142 Y103.55783 I22.44217 J121.73142 E6.201673
G3 X150.44217 Y247.73142 I-121.73142 J22.44217 E6.201673
G3 X6.26858 Y148.44217 I-22.44217 J-121.73142 E6.201673
G3 X105.55783 Y4.26858 I121.73142 J-22.44217 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 1.800
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 9/20
M73 L9
M991 S0 P8
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.26301 Y184.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X227.88706 Y181.46388 I-1.53612 J-1.16016 E0.100304
G2 X225.19078 Y181.83984 I-1.16016 J1.53612 E0.100304
G2 X225.56674 Y184.53612 I1.53612 J1.16016 E0.100304
G2 X228.26301 Y184.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X236.26017 Y181.64952 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X236.37148 Y182.06495 E0.014266
G1 X236.09327 Y182.59948 E0.019989
G1 X235.77210 Y181.40084 E0.041164
G1 X235.28402 Y181.15215 E0.018171
G1 X235.81393 Y183.12980 E0.067916
G1 X235.53348 Y183.65597 E0.019779
G1 X234.79595 Y180.90346 E0.094526
G1 X234.30787 Y180.65478 E0.018171
G1 X235.25192 Y184.17803 E0.120996
G1 X234.96929 Y184.69606 E0.019575
G1 X233.81979 Y180.40609 E0.147326
G1 X233.33172 Y180.15740 E0.018171
G1 X234.68560 Y185.21014 E0.173521
G1 X234.40086 Y185.72032 E0.019381
G1 X232.84364 Y179.90872 E0.199582
G1 X232.35557 Y179.66003 E0.018171
G1 X234.11508 Y186.22663 E0.225510
G1 X233.82829 Y186.72914 E0.019193
G1 X231.86749 Y179.41134 E0.251308
G1 X231.37942 Y179.16266 E0.018171
G1 X233.54051 Y187.22794 E0.276978
G1 X233.25172 Y187.72302 E0.019012
G1 X230.89134 Y178.91397 E0.302521
G1 X230.40327 Y178.66528 E0.018171
G1 X232.96197 Y188.21449 E0.327939
G1 X232.67126 Y188.70236 E0.018839
G1 X229.91519 Y178.41660 E0.353234
G1 X229.42712 Y178.16791 E0.018171
G1 X232.37959 Y189.18669 E0.378407
G1 X232.08700 Y189.66755 E0.018672
G1 X228.93904 Y177.91922 E0.403461
G1 X228.45097 Y177.67054 E0.018171
G1 X231.79347 Y190.14493 E0.428396
G1 X231.49904 Y190.61894 E0.018510
G1 X227.96289 Y177.42185 E0.453215
G1 X227.47482 Y177.17316 E0.018171
G1 X231.20371 Y191.08957 E0.477917
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y191.55690 E0.273231
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.18873 Y184.55603 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.77845 Y180.86563 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.83873 Y184.82264 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.36512 Y180.89588 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.46565 Y185.00311 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.97232 Y181.00280 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.07202 Y185.10691 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.60012 Y181.18655 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.65781 Y185.13388 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.25118 Y181.45713 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X224.93297 Y181.84239 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.75212 Y184.89948 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.19831 Y182.24626 E0.237277
G1 X223.90878 Y182.73854 E0.018945
G1 X225.53941 Y188.82416 E0.208992
G1 X225.02919 Y188.49281 E0.020181
G1 X223.61819 Y183.22690 E0.180842
G1 X223.32657 Y183.71137 E0.018758
G1 X224.51897 Y188.16147 E0.152826
G1 X224.00874 Y187.83013 E0.020181
G1 X223.03392 Y184.19202 E0.124940
G1 X222.74026 Y184.66890 E0.018578
G1 X223.49852 Y187.49879 E0.097184
G1 X222.98830 Y187.16744 E0.020181
G1 X222.44560 Y185.14207 E0.069555
G1 X222.14997 Y185.61158 E0.018405
G1 X222.47808 Y186.83610 E0.042053
G1 X221.96785 Y186.50476 E0.020181
G1 X221.85336 Y186.07747 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.53612 Y241.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.16016 Y238.46388 I-1.53612 J-1.16016 E0.100304
G2 X126.46388 Y238.83984 I-1.16016 J1.53612 E0.100304
G2 X126.83984 Y241.53612 I1.53612 J1.16016 E0.100304
G2 X129.53612 Y241.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X133.93618 Y247.58082 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.63207 Y247.88493 E0.014266
G1 X133.03005 Y247.91126 E0.019989
G1 X133.90752 Y247.03379 E0.041164
G1 X133.87885 Y246.48676 E0.018171
G1 X132.43111 Y247.93450 E0.067916
G1 X131.83521 Y247.95471 E0.019779
G1 X133.85018 Y245.93973 E0.094526
G1 X133.82151 Y245.39270 E0.018171
G1 X131.24231 Y247.97191 E0.120996
G1 X130.65236 Y247.98615 E0.019575
G1 X133.79284 Y244.84568 E0.147326
G1 X133.76417 Y244.29865 E0.018171
G1 X130.06531 Y247.99750 E0.173521
G1 X129.48112 Y248.00601 E0.019381
G1 X133.73550 Y243.75162 E0.199582
G1 X133.70684 Y243.20459 E0.018171
G1 X128.89975 Y248.01167 E0.225510
G1 X128.32116 Y248.01456 E0.019193
G1 X133.67817 Y242.65756 E0.251308
G1 X133.64950 Y242.11053 E0.018171
G1 X127.74530 Y248.01473 E0.276978
G1 X127.17215 Y248.01218 E0.019012
G1 X133.62083 Y241.56350 E0.302521
G1 X133.59216 Y241.01647 E0.018171
G1 X126.60166 Y248.00697 E0.327939
G1 X126.03379 Y247.99915 E0.018839
G1 X133.56349 Y240.46944 E0.353234
G1 X133.53482 Y239.92242 E0.018171
G1 X125.46852 Y247.98872 E0.378407
G1 X124.90578 Y247.97576 E0.018672
G1 X133.50616 Y239.37539 E0.403461
G1 X133.47749 Y238.82836 E0.018171
G1 X124.34560 Y247.96025 E0.428396
G1 X123.78787 Y247.94227 E0.018510
G1 X133.44882 Y238.28133 E0.453215
G1 X133.42015 Y237.73430 E0.018171
G1 X123.23264 Y247.92181 E0.477917
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y247.89895 E0.273231
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X127.38335 Y242.04400 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.87419 Y238.97746 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X126.97746 Y241.87419 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.64133 Y238.63463 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X126.63463 Y241.64133 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.35234 Y238.34792 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X126.34792 Y241.35234 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.00711 Y238.11746 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X126.11746 Y241.00711 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X128.59831 Y237.95056 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X128.10556 Y237.86761 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X125.86761 Y240.10556 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X127.38847 Y237.43331 E0.237277
G1 X126.81737 Y237.42871 E0.018945
G1 X122.36239 Y241.88369 E0.208992
G1 X122.39423 Y241.27615 E0.020181
G1 X126.24915 Y237.42123 E0.180842
G1 X125.68377 Y237.41091 E0.018758
G1 X122.42607 Y240.66861 E0.152826
G1 X122.45791 Y240.06108 E0.020181
G1 X125.12119 Y237.39779 E0.124940
G1 X124.56137 Y237.38192 E0.018578
G1 X122.48975 Y239.45354 E0.097184
G1 X122.52159 Y238.84600 E0.020181
G1 X124.00427 Y237.36333 E0.069555
G1 X123.44984 Y237.34205 E0.018405
G1 X122.55343 Y238.23846 E0.042053
G1 X122.58527 Y237.63093 E0.020181
G1 X122.89806 Y237.31813 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.80922 Y184.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X30.43326 Y181.46388 I-1.53612 J-1.16016 E0.100304
G2 X27.73699 Y181.83984 I-1.16016 J1.53612 E0.100304
G2 X28.11294 Y184.53612 I1.53612 J1.16016 E0.100304
G2 X30.80922 Y184.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X25.67601 Y191.93130 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X25.26059 Y191.81998 E0.014266
G1 X24.93678 Y191.31178 E0.019989
G1 X26.13542 Y191.63295 E0.041164
G1 X26.59483 Y191.33461 E0.018171
G1 X24.61718 Y190.80470 E0.067916
G1 X24.30173 Y190.29874 E0.019779
G1 X27.05423 Y191.03627 E0.094526
G1 X27.51364 Y190.73793 E0.018171
G1 X23.99039 Y189.79387 E0.120996
G1 X23.68307 Y189.29009 E0.019575
G1 X27.97305 Y190.43959 E0.147326
G1 X28.43245 Y190.14124 E0.018171
G1 X23.37972 Y188.78737 E0.173521
G1 X23.08026 Y188.28569 E0.019381
G1 X28.89186 Y189.84290 E0.199582
G1 X29.35127 Y189.54456 E0.018171
G1 X22.78467 Y187.78504 E0.225510
G1 X22.49287 Y187.28542 E0.019193
G1 X29.81067 Y189.24622 E0.251308
G1 X30.27008 Y188.94787 E0.018171
G1 X22.20479 Y186.78679 E0.276978
G1 X21.92043 Y186.28915 E0.019012
G1 X30.72949 Y188.64953 E0.302521
G1 X31.18889 Y188.35119 E0.018171
G1 X21.63969 Y185.79249 E0.327939
G1 X21.36253 Y185.29678 E0.018839
G1 X31.64830 Y188.05285 E0.353234
G1 X32.10771 Y187.75451 E0.018171
G1 X21.08893 Y184.80203 E0.378407
G1 X20.81879 Y184.30821 E0.018672
G1 X32.56711 Y187.45616 E0.403461
G1 X33.02652 Y187.15782 E0.018171
G1 X20.55213 Y183.81532 E0.428396
G1 X20.28883 Y183.32333 E0.018510
G1 X33.48593 Y186.85948 E0.453215
G1 X33.94533 Y186.56114 E0.018171
G1 X20.02893 Y182.83225 E0.477917
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y182.34205 E0.273231
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.19462 Y183.48797 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X31.09574 Y184.11183 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.13874 Y183.05156 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X31.27622 Y183.73875 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.16898 Y182.63822 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X31.38002 Y183.34512 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.27590 Y182.24543 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X31.40698 Y182.93091 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.45966 Y181.87323 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X31.34713 Y182.49343 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X31.17258 Y182.02522 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.11550 Y181.20608 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X31.19016 Y181.18705 E0.237277
G1 X30.90859 Y180.69017 E0.018945
G1 X24.82298 Y179.05953 E0.208992
G1 X25.36504 Y178.78334 E0.020181
G1 X30.63096 Y180.19433 E0.180842
G1 X30.35721 Y179.69954 E0.018758
G1 X25.90710 Y178.50714 E0.152826
G1 X26.44916 Y178.23095 E0.020181
G1 X30.08728 Y179.20578 E0.124940
G1 X29.82111 Y178.71302 E0.018578
G1 X26.99123 Y177.95475 E0.097184
G1 X27.53329 Y177.67856 E0.020181
G1 X29.55866 Y178.22126 E0.069555
G1 X29.29988 Y177.73047 E0.018405
G1 X28.07535 Y177.40236 E0.042053
G1 X28.61741 Y177.12617 E0.020181
G1 X29.04470 Y177.24066 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.80922 Y70.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X30.43326 Y67.46388 I-1.53612 J-1.16016 E0.100304
G2 X27.73699 Y67.83984 I-1.16016 J1.53612 E0.100304
G2 X28.11294 Y70.53612 I1.53612 J1.16016 E0.100304
G2 X30.80922 Y70.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X19.73983 Y70.35048 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X19.62852 Y69.93505 E0.014266
G1 X19.90673 Y69.40052 E0.019989
G1 X20.22790 Y70.59916 E0.041164
G1 X20.71598 Y70.84785 E0.018171
G1 X20.18607 Y68.87020 E0.067916
G1 X20.46652 Y68.34403 E0.019779
G1 X21.20405 Y71.09654 E0.094526
G1 X21.69213 Y71.34522 E0.018171
G1 X20.74808 Y67.82197 E0.120996
G1 X21.03071 Y67.30394 E0.019575
G1 X22.18021 Y71.59391 E0.147326
G1 X22.66828 Y71.84260 E0.018171
G1 X21.31440 Y66.78986 E0.173521
G1 X21.59914 Y66.27968 E0.019381
G1 X23.15636 Y72.09128 E0.199582
G1 X23.64443 Y72.33997 E0.018171
G1 X21.88492 Y65.77337 E0.225510
G1 X22.17171 Y65.27086 E0.019193
G1 X24.13251 Y72.58866 E0.251308
G1 X24.62058 Y72.83734 E0.018171
G1 X22.45949 Y64.77206 E0.276978
G1 X22.74828 Y64.27698 E0.019012
G1 X25.10866 Y73.08603 E0.302521
G1 X25.59673 Y73.33472 E0.018171
G1 X23.03803 Y63.78551 E0.327939
G1 X23.32874 Y63.29764 E0.018839
G1 X26.08481 Y73.58340 E0.353234
G1 X26.57288 Y73.83209 E0.018171
G1 X23.62041 Y62.81331 E0.378407
G1 X23.91300 Y62.33245 E0.018672
G1 X27.06096 Y74.08078 E0.403461
G1 X27.54903 Y74.32946 E0.018171
G1 X24.20653 Y61.85507 E0.428396
G1 X24.50096 Y61.38106 E0.018510
G1 X28.03711 Y74.57815 E0.453215
G1 X28.52518 Y74.82684 E0.018171
G1 X24.79629 Y60.91043 E0.477917
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y60.44310 E0.273231
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.81127 Y67.44397 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X29.22155 Y71.13437 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.16127 Y67.17736 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X29.63488 Y71.10412 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.53435 Y66.99689 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.02768 Y70.99720 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.92798 Y66.89309 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.39988 Y70.81345 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X29.34219 Y66.86612 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.74882 Y70.54287 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X31.06703 Y70.15761 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.24788 Y67.10052 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.80169 Y69.75374 E0.237277
G1 X32.09122 Y69.26146 E0.018945
G1 X30.46059 Y63.17584 E0.208992
G1 X30.97081 Y63.50719 E0.020181
G1 X32.38181 Y68.77310 E0.180842
G1 X32.67343 Y68.28863 E0.018758
G1 X31.48103 Y63.83853 E0.152826
G1 X31.99126 Y64.16987 E0.020181
G1 X32.96608 Y67.80798 E0.124940
G1 X33.25974 Y67.33110 E0.018578
G1 X32.50148 Y64.50121 E0.097184
G1 X33.01170 Y64.83256 E0.020181
G1 X33.55440 Y66.85793 E0.069555
G1 X33.85003 Y66.38842 E0.018405
G1 X33.52192 Y65.16390 E0.042053
G1 X34.03215 Y65.49524 E0.020181
G1 X34.14664 Y65.92253 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.53612 Y13.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.16016 Y10.46388 I-1.53612 J-1.16016 E0.100304
G2 X126.46388 Y10.83984 I-1.16016 J1.53612 E0.100304
G2 X126.83984 Y13.53612 I1.53612 J1.16016 E0.100304
G2 X129.53612 Y13.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X122.06382 Y4.41918 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.36793 Y4.11507 E0.014266
G1 X122.96995 Y4.08874 E0.019989
G1 X122.09248 Y4.96621 E0.041164
G1 X122.12115 Y5.51324 E0.018171
G1 X123.56889 Y4.06550 E0.067916
G1 X124.16479 Y4.04529 E0.019779
G1 X122.14982 Y6.06027 E0.094526
G1 X122.17849 Y6.60730 E0.018171
G1 X124.75769 Y4.02809 E0.120996
G1 X125.34764 Y4.01385 E0.019575
G1 X122.20716 Y7.15432 E0.147326
G1 X122.23583 Y7.70135 E0.018171
G1 X125.93469 Y4.00250 E0.173521
G1 X126.51888 Y3.99399 E0.019381
G1 X122.26450 Y8.24838 E0.199582
G1 X122.29316 Y8.79541 E0.018171
G1 X127.10025 Y3.98833 E0.225510
G1 X127.67884 Y3.98544 E0.019193
G1 X122.32183 Y9.34244 E0.251308
G1 X122.35050 Y9.88947 E0.018171
G1 X128.25470 Y3.98527 E0.276978
G1 X128.82785 Y3.98782 E0.019012
G1 X122.37917 Y10.43650 E0.302521
G1 X122.40784 Y10.98353 E0.018171
G1 X129.39834 Y3.99303 E0.327939
G1 X129.96621 Y4.00085 E0.018839
G1 X122.43651 Y11.53056 E0.353234
G1 X122.46518 Y12.07758 E0.018171
G1 X130.53148 Y4.01128 E0.378407
G1 X131.09422 Y4.02424 E0.018672
G1 X122.49384 Y12.62461 E0.403461
G1 X122.52251 Y13.17164 E0.018171
G1 X131.65440 Y4.03975 E0.428396
G1 X132.21213 Y4.05773 E0.018510
G1 X122.55118 Y13.71867 E0.453215
G1 X122.57985 Y14.26570 E0.018171
G1 X132.76736 Y4.07819 E0.477917
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y4.10105 E0.273231
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X128.61665 Y9.95600 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X126.12581 Y13.02254 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.02254 Y10.12581 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X126.35867 Y13.36537 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.36537 Y10.35867 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X126.64766 Y13.65208 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.65208 Y10.64766 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X126.99289 Y13.88254 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.88254 Y10.99289 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X127.40169 Y14.04944 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X127.89444 Y14.13239 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X130.13239 Y11.89444 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X128.61153 Y14.56669 E0.237277
G1 X129.18263 Y14.57129 E0.018945
G1 X133.63761 Y10.11631 E0.208992
G1 X133.60577 Y10.72385 E0.020181
G1 X129.75085 Y14.57877 E0.180842
G1 X130.31623 Y14.58909 E0.018758
G1 X133.57393 Y11.33139 E0.152826
G1 X133.54209 Y11.93892 E0.020181
G1 X130.87881 Y14.60221 E0.124940
G1 X131.43863 Y14.61808 E0.018578
G1 X133.51025 Y12.54646 E0.097184
G1 X133.47841 Y13.15400 E0.020181
G1 X131.99573 Y14.63667 E0.069555
G1 X132.55016 Y14.65795 E0.018405
G1 X133.44657 Y13.76154 E0.042053
G1 X133.41473 Y14.36907 E0.020181
G1 X133.10194 Y14.68187 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.26301 Y70.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X227.88706 Y67.46388 I-1.53612 J-1.16016 E0.100304
G2 X225.19078 Y67.83984 I-1.16016 J1.53612 E0.100304
G2 X225.56674 Y70.53612 I1.53612 J1.16016 E0.100304
G2 X228.26301 Y70.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X230.32399 Y60.06870 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X230.73941 Y60.18002 E0.014266
G1 X231.06322 Y60.68822 E0.019989
G1 X229.86458 Y60.36705 E0.041164
G1 X229.40517 Y60.66539 E0.018171
G1 X231.38282 Y61.19530 E0.067916
G1 X231.69827 Y61.70126 E0.019779
G1 X228.94577 Y60.96373 E0.094526
G1 X228.48636 Y61.26207 E0.018171
G1 X232.00961 Y62.20613 E0.120996
G1 X232.31693 Y62.70991 E0.019575
G1 X228.02695 Y61.56041 E0.147326
G1 X227.56755 Y61.85876 E0.018171
G1 X232.62028 Y63.21263 E0.173521
G1 X232.91974 Y63.71431 E0.019381
G1 X227.10814 Y62.15710 E0.199582
G1 X226.64873 Y62.45544 E0.018171
G1 X233.21533 Y64.21496 E0.225510
G1 X233.50713 Y64.71458 E0.019193
G1 X226.18933 Y62.75378 E0.251308
G1 X225.72992 Y63.05213 E0.018171
G1 X233.79521 Y65.21321 E0.276978
G1 X234.07957 Y65.71085 E0.019012
G1 X225.27051 Y63.35047 E0.302521
G1 X224.81111 Y63.64881 E0.018171
G1 X234.36031 Y66.20751 E0.327939
G1 X234.63747 Y66.70322 E0.018839
G1 X224.35170 Y63.94715 E0.353234
G1 X223.89229 Y64.24549 E0.018171
G1 X234.91107 Y67.19797 E0.378407
G1 X235.18121 Y67.69179 E0.018672
G1 X223.43289 Y64.54384 E0.403461
G1 X222.97348 Y64.84218 E0.018171
G1 X235.44787 Y68.18468 E0.428396
G1 X235.71117 Y68.67667 E0.018510
G1 X222.51407 Y65.14052 E0.453215
G1 X222.05467 Y65.43886 E0.018171
G1 X235.97107 Y69.16775 E0.477917
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y69.65795 E0.273231
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.80538 Y68.51203 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X224.90426 Y67.88817 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.86126 Y68.94844 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X224.72378 Y68.26125 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.83102 Y69.36178 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X224.61998 Y68.65488 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.72410 Y69.75457 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X224.59302 Y69.06909 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.54034 Y70.12677 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X224.65287 Y69.50657 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X224.82742 Y69.97478 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.88450 Y70.79392 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X224.80984 Y70.81295 E0.237277
G1 X225.09141 Y71.30983 E0.018945
G1 X231.17702 Y72.94047 E0.208992
G1 X230.63496 Y73.21666 E0.020181
G1 X225.36904 Y71.80567 E0.180842
G1 X225.64279 Y72.30046 E0.018758
G1 X230.09290 Y73.49286 E0.152826
G1 X229.55084 Y73.76905 E0.020181
G1 X225.91272 Y72.79422 E0.124940
G1 X226.17889 Y73.28698 E0.018578
G1 X229.00877 Y74.04525 E0.097184
G1 X228.46671 Y74.32144 E0.020181
G1 X226.44134 Y73.77874 E0.069555
G1 X226.70012 Y74.26953 E0.018405
G1 X227.92465 Y74.59764 E0.042053
G1 X227.38259 Y74.87383 E0.020181
G1 X226.95530 Y74.75934 E0.014674
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.52718 Y199.65790 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X54.34210 Y223.52718 I-97.52718 J-73.65790 E6.123232
G3 X30.47282 Y52.34210 I73.65790 J-97.52718 E6.123232
G3 X201.65790 Y28.47282 I97.52718 J73.65790 E6.123232
G3 X225.52718 Y199.65790 I-73.65790 J97.52718 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.83952 Y199.89380 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X54.10620 Y223.83952 I-97.83952 J-73.89380 E6.142842
G3 X30.16048 Y52.10620 I73.89380 J-97.83952 E6.142842
G3 X201.89380 Y28.16048 I97.83952 J73.89380 E6.142842
G3 X225.83952 Y199.89380 I-73.89380 J97.83952 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.15186 Y200.12969 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X53.87031 Y224.15186 I-98.15186 J-74.12969 E6.162452
G3 X29.84814 Y51.87031 I74.12969 J-98.15186 E6.162452
G3 X202.12969 Y27.84814 I98.15186 J74.12969 E6.162452
G3 X226.15186 Y200.12969 I-74.12969 J98.15186 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.46421 Y200.36559 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X53.63441 Y224.46421 I-98.46421 J-74.36559 E6.182063
G3 X29.53579 Y51.63441 I74.36559 J-98.46421 E6.182063
G3 X202.36559 Y27.53579 I98.46421 J74.36559 E6.182063
G3 X226.46421 Y200.36559 I-74.36559 J98.46421 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.77655 Y200.60149 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X53.39851 Y224.77655 I-98.77655 J-74.60149 E6.201673
G3 X29.22345 Y51.39851 I74.60149 J-98.77655 E6.201673
G3 X202.60149 Y27.22345 I98.77655 J74.60149 E6.201673
G3 X226.77655 Y200.60149 I-74.60149 J98.77655 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 2.000
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 10/20
M73 L10
M991 S0 P9
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.81053 Y183.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X226.90906 Y184.91636 I1.91636 J-0.18217 E0.100304
G2 X228.64326 Y182.81783 I-0.18217 J-1.91636 E0.100304
G2 X226.54473 Y181.08364 I-1.91636 J0.18217 E0.100304
G2 X224.81053 Y183.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X226.95530 Y177.24066 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X227.38259 Y177.12617 E0.014674
G1 X227.92465 Y177.40236 E0.020181
G1 X226.70012 Y177.73047 E0.042053
G1 X226.44134 Y178.22126 E0.018405
G1 X228.46671 Y177.67856 E0.069555
G1 X229.00877 Y177.95475 E0.020181
G1 X226.17889 Y178.71302 E0.097184
G1 X225.91272 Y179.20578 E0.018578
G1 X229.55084 Y178.23095 E0.124940
G1 X230.09290 Y178.50714 E0.020181
G1 X225.64279 Y179.69954 E0.152826
G1 X225.36904 Y180.19433 E0.018758
G1 X230.63496 Y178.78334 E0.180842
G1 X231.17702 Y179.05953 E0.020181
G1 X225.09141 Y180.69017 E0.208992
G1 X224.80984 Y181.18705 E0.018945
G1 X231.71909 Y179.33573 E0.237277
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.82742 Y182.02522 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.88450 Y181.20608 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.26977 Y181.52429 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.59302 Y182.93091 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.54034 Y181.87323 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.61998 Y183.34512 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.72410 Y182.24543 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.72378 Y183.73875 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.83102 Y182.63822 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.90426 Y184.11183 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.86126 Y183.05156 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X225.17086 Y184.46183 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.80538 Y183.48797 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X225.55039 Y184.78158 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y182.34205 E0.273231
G1 X235.97107 Y182.83225 E0.018354
G1 X222.05467 Y186.56114 E0.477917
G1 X222.51407 Y186.85948 E0.018171
G1 X235.71117 Y183.32333 E0.453215
G1 X235.44787 Y183.81532 E0.018510
G1 X222.97348 Y187.15782 E0.428396
G1 X223.43289 Y187.45616 E0.018171
G1 X235.18121 Y184.30821 E0.403461
G1 X234.91107 Y184.80203 E0.018672
G1 X223.89229 Y187.75451 E0.378407
G1 X224.35170 Y188.05285 E0.018171
G1 X234.63747 Y185.29678 E0.353234
G1 X234.36031 Y185.79249 E0.018839
G1 X224.81111 Y188.35119 E0.327939
G1 X225.27051 Y188.64953 E0.018171
G1 X234.07957 Y186.28915 E0.302521
G1 X233.79521 Y186.78679 E0.019012
G1 X225.72992 Y188.94787 E0.276978
G1 X226.18933 Y189.24622 E0.018171
G1 X233.50713 Y187.28542 E0.251308
G1 X233.21533 Y187.78504 E0.019193
G1 X226.64873 Y189.54456 E0.225510
G1 X227.10814 Y189.84290 E0.018171
G1 X232.91974 Y188.28569 E0.199582
G1 X232.62028 Y188.78737 E0.019381
G1 X227.56755 Y190.14124 E0.173521
G1 X228.02695 Y190.43959 E0.018171
G1 X232.31693 Y189.29009 E0.147326
G1 X232.00961 Y189.79387 E0.019575
G1 X228.48636 Y190.73793 E0.120996
G1 X228.94577 Y191.03627 E0.018171
G1 X231.69827 Y190.29874 E0.094526
G1 X231.38282 Y190.80470 E0.019779
G1 X229.40517 Y191.33461 E0.067916
G1 X229.86458 Y191.63295 E0.018171
G1 X231.06322 Y191.31178 E0.041164
G1 X230.73941 Y191.81998 E0.019989
G1 X230.32399 Y191.93130 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.08364 Y240.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X128.18217 Y241.91636 I1.91636 J-0.18217 E0.100304
G2 X129.91636 Y239.81783 I-0.18217 J-1.91636 E0.100304
G2 X127.81783 Y238.08364 I-1.91636 J0.18217 E0.100304
G2 X126.08364 Y240.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X133.10194 Y237.31813 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.41473 Y237.63093 E0.014674
G1 X133.44657 Y238.23846 E0.020181
G1 X132.55016 Y237.34205 E0.042053
G1 X131.99573 Y237.36333 E0.018405
G1 X133.47841 Y238.84600 E0.069555
G1 X133.51025 Y239.45354 E0.020181
G1 X131.43863 Y237.38192 E0.097184
G1 X130.87881 Y237.39779 E0.018578
G1 X133.54209 Y240.06108 E0.124940
G1 X133.57393 Y240.66861 E0.020181
G1 X130.31623 Y237.41091 E0.152826
G1 X129.75085 Y237.42123 E0.018758
G1 X133.60577 Y241.27615 E0.180842
G1 X133.63761 Y241.88369 E0.020181
G1 X129.18263 Y237.42871 E0.208992
G1 X128.61153 Y237.43331 E0.018945
G1 X133.66945 Y242.49123 E0.237277
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X127.89444 Y237.86761 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X130.13239 Y240.10556 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X130.04944 Y240.59831 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.99289 Y238.11746 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X129.88254 Y241.00711 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.64766 Y238.34792 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X129.65208 Y241.35234 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.35867 Y238.63463 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X129.36537 Y241.64133 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.12581 Y238.97746 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X129.02254 Y241.87419 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X125.95600 Y239.38335 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X128.61665 Y242.04400 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X125.86885 Y239.87191 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y247.89895 E0.273231
G1 X132.76736 Y247.92181 E0.018354
G1 X122.57985 Y237.73430 E0.477917
G1 X122.55118 Y238.28133 E0.018171
G1 X132.21213 Y247.94227 E0.453215
G1 X131.65440 Y247.96025 E0.018510
G1 X122.52251 Y238.82836 E0.428396
G1 X122.49384 Y239.37539 E0.018171
G1 X131.09422 Y247.97576 E0.403461
G1 X130.53148 Y247.98872 E0.018672
G1 X122.46518 Y239.92242 E0.378407
G1 X122.43651 Y240.46944 E0.018171
G1 X129.96621 Y247.99915 E0.353234
G1 X129.39834 Y248.00697 E0.018839
G1 X122.40784 Y241.01647 E0.327939
G1 X122.37917 Y241.56350 E0.018171
G1 X128.82785 Y248.01218 E0.302521
G1 X128.25470 Y248.01473 E0.019012
G1 X122.35050 Y242.11053 E0.276978
G1 X122.32183 Y242.65756 E0.018171
G1 X127.67884 Y248.01456 E0.251308
G1 X127.10025 Y248.01167 E0.019193
G1 X122.29316 Y243.20459 E0.225510
G1 X122.26450 Y243.75162 E0.018171
G1 X126.51888 Y248.00601 E0.199582
G1 X125.93469 Y247.99750 E0.019381
G1 X122.23583 Y244.29865 E0.173521
G1 X122.20716 Y244.84568 E0.018171
G1 X125.34764 Y247.98615 E0.147326
G1 X124.75769 Y247.97191 E0.019575
G1 X122.17849 Y245.39270 E0.120996
G1 X122.14982 Y245.93973 E0.018171
G1 X124.16479 Y247.95471 E0.094526
G1 X123.56889 Y247.93450 E0.019779
G1 X122.12115 Y246.48676 E0.067916
G1 X122.09248 Y247.03379 E0.018171
G1 X122.96995 Y247.91126 E0.041164
G1 X122.36793 Y247.88493 E0.019989
G1 X122.06382 Y247.58082 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.35674 Y183.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X29.45527 Y184.91636 I1.91636 J-0.18217 E0.100304
G2 X31.18947 Y182.81783 I-0.18217 J-1.91636 E0.100304
G2 X29.09094 Y181.08364 I-1.91636 J0.18217 E0.100304
G2 X27.35674 Y183.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X34.14664 Y186.07747 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X34.03215 Y186.50476 E0.014674
G1 X33.52192 Y186.83610 E0.020181
G1 X33.85003 Y185.61158 E0.042053
G1 X33.55440 Y185.14207 E0.018405
G1 X33.01170 Y187.16744 E0.069555
G1 X32.50148 Y187.49879 E0.020181
G1 X33.25974 Y184.66890 E0.097184
G1 X32.96608 Y184.19202 E0.018578
G1 X31.99126 Y187.83013 E0.124940
G1 X31.48103 Y188.16147 E0.020181
G1 X32.67343 Y183.71137 E0.152826
G1 X32.38181 Y183.22690 E0.018758
G1 X30.97081 Y188.49281 E0.180842
G1 X30.46059 Y188.82416 E0.020181
G1 X32.09122 Y182.73854 E0.208992
G1 X31.80169 Y182.24626 E0.018945
G1 X29.95036 Y189.15550 E0.237277
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X31.06703 Y181.84239 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X30.24788 Y184.89948 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X29.77967 Y185.07402 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X30.39988 Y181.18655 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X29.34219 Y185.13388 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X30.02768 Y181.00280 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.92798 Y185.10691 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X29.63488 Y180.89588 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.53435 Y185.00311 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X29.22155 Y180.86563 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.16127 Y184.82264 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.78513 Y180.92152 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.81127 Y184.55603 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.31846 Y181.09033 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y191.55690 E0.273231
G1 X24.79629 Y191.08957 E0.018354
G1 X28.52518 Y177.17316 E0.477917
G1 X28.03711 Y177.42185 E0.018171
G1 X24.50096 Y190.61894 E0.453215
G1 X24.20653 Y190.14493 E0.018510
G1 X27.54903 Y177.67054 E0.428396
G1 X27.06096 Y177.91922 E0.018171
G1 X23.91300 Y189.66755 E0.403461
G1 X23.62041 Y189.18669 E0.018672
G1 X26.57288 Y178.16791 E0.378407
G1 X26.08481 Y178.41660 E0.018171
G1 X23.32874 Y188.70236 E0.353234
G1 X23.03803 Y188.21449 E0.018839
G1 X25.59673 Y178.66528 E0.327939
G1 X25.10866 Y178.91397 E0.018171
G1 X22.74828 Y187.72302 E0.302521
G1 X22.45949 Y187.22794 E0.019012
G1 X24.62058 Y179.16266 E0.276978
G1 X24.13251 Y179.41134 E0.018171
G1 X22.17171 Y186.72914 E0.251308
G1 X21.88492 Y186.22663 E0.019193
G1 X23.64443 Y179.66003 E0.225510
G1 X23.15636 Y179.90872 E0.018171
G1 X21.59914 Y185.72032 E0.199582
G1 X21.31440 Y185.21014 E0.019381
G1 X22.66828 Y180.15740 E0.173521
G1 X22.18021 Y180.40609 E0.018171
G1 X21.03071 Y184.69606 E0.147326
G1 X20.74808 Y184.17803 E0.019575
G1 X21.69213 Y180.65478 E0.120996
G1 X21.20405 Y180.90346 E0.018171
G1 X20.46652 Y183.65597 E0.094526
G1 X20.18607 Y183.12980 E0.019779
G1 X20.71598 Y181.15215 E0.067916
G1 X20.22790 Y181.40084 E0.018171
G1 X19.90673 Y182.59948 E0.041164
G1 X19.62852 Y182.06495 E0.019989
G1 X19.73983 Y181.64952 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.35674 Y69.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X29.45527 Y70.91636 I1.91636 J-0.18217 E0.100304
G2 X31.18947 Y68.81783 I-0.18217 J-1.91636 E0.100304
G2 X29.09094 Y67.08364 I-1.91636 J0.18217 E0.100304
G2 X27.35674 Y69.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X29.04470 Y74.75934 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X28.61741 Y74.87383 E0.014674
G1 X28.07535 Y74.59764 E0.020181
G1 X29.29988 Y74.26953 E0.042053
G1 X29.55866 Y73.77874 E0.018405
G1 X27.53329 Y74.32144 E0.069555
G1 X26.99123 Y74.04525 E0.020181
G1 X29.82111 Y73.28698 E0.097184
G1 X30.08728 Y72.79422 E0.018578
G1 X26.44916 Y73.76905 E0.124940
G1 X25.90710 Y73.49286 E0.020181
G1 X30.35721 Y72.30046 E0.152826
G1 X30.63096 Y71.80567 E0.018758
G1 X25.36504 Y73.21666 E0.180842
G1 X24.82298 Y72.94047 E0.020181
G1 X30.90859 Y71.30983 E0.208992
G1 X31.19016 Y70.81295 E0.018945
G1 X24.28091 Y72.66427 E0.237277
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X31.17258 Y69.97478 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.11550 Y70.79392 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.73023 Y70.47571 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X31.40698 Y69.06909 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.45966 Y70.12677 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X31.38002 Y68.65488 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.27590 Y69.75457 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X31.27622 Y68.26125 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.16898 Y69.36178 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X31.09574 Y67.88817 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.13874 Y68.94844 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X30.82914 Y67.53817 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.19462 Y68.51203 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X30.44961 Y67.21842 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y69.65795 E0.273231
G1 X20.02893 Y69.16775 E0.018354
G1 X33.94533 Y65.43886 E0.477917
G1 X33.48593 Y65.14052 E0.018171
G1 X20.28883 Y68.67667 E0.453215
G1 X20.55213 Y68.18468 E0.018510
G1 X33.02652 Y64.84218 E0.428396
G1 X32.56711 Y64.54384 E0.018171
G1 X20.81879 Y67.69179 E0.403461
G1 X21.08893 Y67.19797 E0.018672
G1 X32.10771 Y64.24549 E0.378407
G1 X31.64830 Y63.94715 E0.018171
G1 X21.36253 Y66.70322 E0.353234
G1 X21.63969 Y66.20751 E0.018839
G1 X31.18889 Y63.64881 E0.327939
G1 X30.72949 Y63.35047 E0.018171
G1 X21.92043 Y65.71085 E0.302521
G1 X22.20479 Y65.21321 E0.019012
G1 X30.27008 Y63.05213 E0.276978
G1 X29.81067 Y62.75378 E0.018171
G1 X22.49287 Y64.71458 E0.251308
G1 X22.78467 Y64.21496 E0.019193
G1 X29.35127 Y62.45544 E0.225510
G1 X28.89186 Y62.15710 E0.018171
G1 X23.08026 Y63.71431 E0.199582
G1 X23.37972 Y63.21263 E0.019381
G1 X28.43245 Y61.85876 E0.173521
G1 X27.97305 Y61.56041 E0.018171
G1 X23.68307 Y62.70991 E0.147326
G1 X23.99039 Y62.20613 E0.019575
G1 X27.51364 Y61.26207 E0.120996
G1 X27.05423 Y60.96373 E0.018171
G1 X24.30173 Y61.70126 E0.094526
G1 X24.61718 Y61.19530 E0.019779
G1 X26.59483 Y60.66539 E0.067916
G1 X26.13542 Y60.36705 E0.018171
G1 X24.93678 Y60.68822 E0.041164
G1 X25.26059 Y60.18002 E0.019989
G1 X25.67601 Y60.06870 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.08364 Y12.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X128.18217 Y13.91636 I1.91636 J-0.18217 E0.100304
G2 X129.91636 Y11.81783 I-0.18217 J-1.91636 E0.100304
G2 X127.81783 Y10.08364 I-1.91636 J0.18217 E0.100304
G2 X126.08364 Y12.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X122.89806 Y14.68187 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.58527 Y14.36907 E0.014674
G1 X122.55343 Y13.76154 E0.020181
G1 X123.44984 Y14.65795 E0.042053
G1 X124.00427 Y14.63667 E0.018405
G1 X122.52159 Y13.15400 E0.069555
G1 X122.48975 Y12.54646 E0.020181
G1 X124.56137 Y14.61808 E0.097184
G1 X125.12119 Y14.60221 E0.018578
G1 X122.45791 Y11.93892 E0.124940
G1 X122.42607 Y11.33139 E0.020181
G1 X125.68377 Y14.58909 E0.152826
G1 X126.24915 Y14.57877 E0.018758
G1 X122.39423 Y10.72385 E0.180842
G1 X122.36239 Y10.11631 E0.020181
G1 X126.81737 Y14.57129 E0.208992
G1 X127.38847 Y14.56669 E0.018945
G1 X122.33055 Y9.50877 E0.237277
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X128.10556 Y14.13239 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X125.86761 Y11.89444 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X125.95056 Y11.40169 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X129.00711 Y13.88254 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.11746 Y10.99289 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X129.35234 Y13.65208 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.34792 Y10.64766 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X129.64133 Y13.36537 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.63463 Y10.35867 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X129.87419 Y13.02254 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.97746 Y10.12581 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X130.04400 Y12.61665 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X127.38335 Y9.95600 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X130.13115 Y12.12809 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y4.10105 E0.273231
G1 X123.23264 Y4.07819 E0.018354
G1 X133.42015 Y14.26570 E0.477917
G1 X133.44882 Y13.71867 E0.018171
G1 X123.78787 Y4.05773 E0.453215
G1 X124.34560 Y4.03975 E0.018510
G1 X133.47749 Y13.17164 E0.428396
G1 X133.50616 Y12.62461 E0.018171
G1 X124.90578 Y4.02424 E0.403461
G1 X125.46852 Y4.01128 E0.018672
G1 X133.53482 Y12.07758 E0.378407
G1 X133.56349 Y11.53056 E0.018171
G1 X126.03379 Y4.00085 E0.353234
G1 X126.60166 Y3.99303 E0.018839
G1 X133.59216 Y10.98353 E0.327939
G1 X133.62083 Y10.43650 E0.018171
G1 X127.17215 Y3.98782 E0.302521
G1 X127.74530 Y3.98527 E0.019012
G1 X133.64950 Y9.88947 E0.276978
G1 X133.67817 Y9.34244 E0.018171
G1 X128.32116 Y3.98544 E0.251308
G1 X128.89975 Y3.98833 E0.019193
G1 X133.70684 Y8.79541 E0.225510
G1 X133.73550 Y8.24838 E0.018171
G1 X129.48112 Y3.99399 E0.199582
G1 X130.06531 Y4.00250 E0.019381
G1 X133.76417 Y7.70135 E0.173521
G1 X133.79284 Y7.15432 E0.018171
G1 X130.65236 Y4.01385 E0.147326
G1 X131.24231 Y4.02809 E0.019575
G1 X133.82151 Y6.60730 E0.120996
G1 X133.85018 Y6.06027 E0.018171
G1 X131.83521 Y4.04529 E0.094526
G1 X132.43111 Y4.06550 E0.019779
G1 X133.87885 Y5.51324 E0.067916
G1 X133.90752 Y4.96621 E0.018171
G1 X133.03005 Y4.08874 E0.041164
G1 X133.63207 Y4.11507 E0.019989
G1 X133.93618 Y4.41918 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.81053 Y69.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X226.90906 Y70.91636 I1.91636 J-0.18217 E0.100304
G2 X228.64326 Y68.81783 I-0.18217 J-1.91636 E0.100304
G2 X226.54473 Y67.08364 I-1.91636 J0.18217 E0.100304
G2 X224.81053 Y69.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X221.85336 Y65.92253 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X221.96785 Y65.49524 E0.014674
G1 X222.47808 Y65.16390 E0.020181
G1 X222.14997 Y66.38842 E0.042053
G1 X222.44560 Y66.85793 E0.018405
G1 X222.98830 Y64.83256 E0.069555
G1 X223.49852 Y64.50121 E0.020181
G1 X222.74026 Y67.33110 E0.097184
G1 X223.03392 Y67.80798 E0.018578
G1 X224.00874 Y64.16987 E0.124940
G1 X224.51897 Y63.83853 E0.020181
G1 X223.32657 Y68.28863 E0.152826
G1 X223.61819 Y68.77310 E0.018758
G1 X225.02919 Y63.50719 E0.180842
G1 X225.53941 Y63.17584 E0.020181
G1 X223.90878 Y69.26146 E0.208992
G1 X224.19831 Y69.75374 E0.018945
G1 X226.04964 Y62.84450 E0.237277
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.93297 Y70.15761 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X225.75212 Y67.10052 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X226.22033 Y66.92598 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X225.60012 Y70.81345 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X226.65781 Y66.86612 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X225.97232 Y70.99720 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.07202 Y66.89309 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X226.36512 Y71.10412 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.46565 Y66.99689 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X226.77845 Y71.13437 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.83873 Y67.17736 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.21487 Y71.07848 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.18873 Y67.44397 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.68154 Y70.90967 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y60.44310 E0.273231
G1 X231.20371 Y60.91043 E0.018354
G1 X227.47482 Y74.82684 E0.477917
G1 X227.96289 Y74.57815 E0.018171
G1 X231.49904 Y61.38106 E0.453215
G1 X231.79347 Y61.85507 E0.018510
G1 X228.45097 Y74.32946 E0.428396
G1 X228.93904 Y74.08078 E0.018171
G1 X232.08700 Y62.33245 E0.403461
G1 X232.37959 Y62.81331 E0.018672
G1 X229.42712 Y73.83209 E0.378407
G1 X229.91519 Y73.58340 E0.018171
G1 X232.67126 Y63.29764 E0.353234
G1 X232.96197 Y63.78551 E0.018839
G1 X230.40327 Y73.33472 E0.327939
G1 X230.89134 Y73.08603 E0.018171
G1 X233.25172 Y64.27698 E0.302521
G1 X233.54051 Y64.77206 E0.019012
G1 X231.37942 Y72.83734 E0.276978
G1 X231.86749 Y72.58866 E0.018171
G1 X233.82829 Y65.27086 E0.251308
G1 X234.11508 Y65.77337 E0.019193
G1 X232.35557 Y72.33997 E0.225510
G1 X232.84364 Y72.09128 E0.018171
G1 X234.40086 Y66.27968 E0.199582
G1 X234.68560 Y66.78986 E0.019381
G1 X233.33172 Y71.84260 E0.173521
G1 X233.81979 Y71.59391 E0.018171
G1 X234.96929 Y67.30394 E0.147326
G1 X235.25192 Y67.82197 E0.019575
G1 X234.30787 Y71.34522 E0.120996
G1 X234.79595 Y71.09654 E0.018171
G1 X235.53348 Y68.34403 E0.094526
G1 X235.81393 Y68.87020 E0.019779
G1 X235.28402 Y70.84785 E0.067916
G1 X235.77210 Y70.59916 E0.018171
G1 X236.09327 Y69.40052 E0.041164
G1 X236.37148 Y69.93505 E0.019989
G1 X236.26017 Y70.35048 E0.014266
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X6.33130 Y137.56562 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X116.43438 Y4.33130 I121.66870 J-11.56562 E6.123232
G3 X249.66870 Y114.43438 I11.56562 J121.66870 E6.123232
G3 X139.56562 Y247.66870 I-121.66870 J11.56562 E6.123232
G3 X6.33130 Y137.56562 I-11.56562 J-121.66870 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X5.94164 Y137.60266 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X116.39734 Y3.94164 I122.05836 J-11.60266 E6.142842
G3 X250.05836 Y114.39734 I11.60266 J122.05836 E6.142842
G3 X139.60266 Y248.05836 I-122.05836 J11.60266 E6.142842
G3 X5.94164 Y137.60266 I-11.60266 J-122.05836 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X5.55198 Y137.63970 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X116.36030 Y3.55198 I122.44802 J-11.63970 E6.162452
G3 X250.44802 Y114.36030 I11.63970 J122.44802 E6.162452
G3 X139.63970 Y248.44802 I-122.44802 J11.63970 E6.162452
G3 X5.55198 Y137.63970 I-11.63970 J-122.44802 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X5.16232 Y137.67674 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X116.32326 Y3.16232 I122.83768 J-11.67674 E6.182063
G3 X250.83768 Y114.32326 I11.67674 J122.83768 E6.182063
G3 X139.67674 Y248.83768 I-122.83768 J11.67674 E6.182063
G3 X5.16232 Y137.67674 I-11.67674 J-122.83768 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X4.77266 Y137.71378 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X116.28622 Y2.77266 I123.22734 J-11.71378 E6.201673
G3 X251.22734 Y114.28622 I11.71378 J123.22734 E6.201673
G3 X139.71378 Y249.22734 I-123.22734 J11.71378 E6.201673
G3 X4.77266 Y137.71378 I-11.71378 J-123.22734 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 2.200
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 11/20
M73 L11
M991 S0 P10
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.01691 Y181.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X225.29809 Y181.70999 I-1.29001 J1.42881 E0.100304
G2 X225.43688 Y184.42881 I1.42881 J1.29001 E0.100304
G2 X228.15570 Y184.29001 I1.29001 J-1.42881 E0.100304
G2 X228.01691 Y181.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X236.26017 Y181.64952 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X236.37148 Y182.06495 E0.014266
G1 X236.09327 Y182.59948 E0.019989
G1 X235.77210 Y181.40084 E0.041164
G1 X235.28402 Y181.15215 E0.018171
G1 X235.81393 Y183.12980 E0.067916
G1 X235.53348 Y183.65597 E0.019779
G1 X234.79595 Y180.90346 E0.094526
G1 X234.30787 Y180.65478 E0.018171
G1 X235.25192 Y184.17803 E0.120996
G1 X234.96929 Y184.69606 E0.019575
G1 X233.81979 Y180.40609 E0.147326
G1 X233.33172 Y180.15740 E0.018171
G1 X234.68560 Y185.21014 E0.173521
G1 X234.40086 Y185.72032 E0.019381
G1 X232.84364 Y179.90872 E0.199582
G1 X232.35557 Y179.66003 E0.018171
G1 X234.11508 Y186.22663 E0.225510
G1 X233.82829 Y186.72914 E0.019193
G1 X231.86749 Y179.41134 E0.251308
G1 X231.37942 Y179.16266 E0.018171
G1 X233.54051 Y187.22794 E0.276978
G1 X233.25172 Y187.72302 E0.019012
G1 X230.89134 Y178.91397 E0.302521
G1 X230.40327 Y178.66528 E0.018171
G1 X232.96197 Y188.21449 E0.327939
G1 X232.67126 Y188.70236 E0.018839
G1 X229.91519 Y178.41660 E0.353234
G1 X229.42712 Y178.16791 E0.018171
G1 X232.37959 Y189.18669 E0.378407
G1 X232.08700 Y189.66755 E0.018672
G1 X228.93904 Y177.91922 E0.403461
G1 X228.45097 Y177.67054 E0.018171
G1 X231.79347 Y190.14493 E0.428396
G1 X231.49904 Y190.61894 E0.018510
G1 X227.96289 Y177.42185 E0.453215
G1 X227.47482 Y177.17316 E0.018171
G1 X231.20371 Y191.08957 E0.477917
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y191.55690 E0.273231
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.18873 Y184.55603 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X226.77845 Y180.86563 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.83873 Y184.82264 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X226.36512 Y180.89588 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.46565 Y185.00311 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.97232 Y181.00280 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.07202 Y185.10691 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.60012 Y181.18655 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X226.65781 Y185.13388 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.25118 Y181.45713 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X224.93297 Y181.84239 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.75212 Y184.89948 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.19831 Y182.24626 E0.237277
G1 X223.90878 Y182.73854 E0.018945
G1 X225.53941 Y188.82416 E0.208992
G1 X225.02919 Y188.49281 E0.020181
G1 X223.61819 Y183.22690 E0.180842
G1 X223.32657 Y183.71137 E0.018758
G1 X224.51897 Y188.16147 E0.152826
G1 X224.00874 Y187.83013 E0.020181
G1 X223.03392 Y184.19202 E0.124940
G1 X222.74026 Y184.66890 E0.018578
G1 X223.49852 Y187.49879 E0.097184
G1 X222.98830 Y187.16744 E0.020181
G1 X222.44560 Y185.14207 E0.069555
G1 X222.14997 Y185.61158 E0.018405
G1 X222.47808 Y186.83610 E0.042053
G1 X221.96785 Y186.50476 E0.020181
G1 X221.85336 Y186.07747 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.29001 Y238.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X126.57119 Y238.70999 I-1.29001 J1.42881 E0.100304
G2 X126.70999 Y241.42881 I1.42881 J1.29001 E0.100304
G2 X129.42881 Y241.29001 I1.29001 J-1.42881 E0.100304
G2 X129.29001 Y238.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X133.93618 Y247.58082 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.63207 Y247.88493 E0.014266
G1 X133.03005 Y247.91126 E0.019989
G1 X133.90752 Y247.03379 E0.041164
G1 X133.87885 Y246.48676 E0.018171
G1 X132.43111 Y247.93450 E0.067916
G1 X131.83521 Y247.95471 E0.019779
G1 X133.85018 Y245.93973 E0.094526
G1 X133.82151 Y245.39270 E0.018171
G1 X131.24231 Y247.97191 E0.120996
G1 X130.65236 Y247.98615 E0.019575
G1 X133.79284 Y244.84568 E0.147326
G1 X133.76417 Y244.29865 E0.018171
G1 X130.06531 Y247.99750 E0.173521
G1 X129.48112 Y248.00601 E0.019381
G1 X133.73550 Y243.75162 E0.199582
G1 X133.70684 Y243.20459 E0.018171
G1 X128.89975 Y248.01167 E0.225510
G1 X128.32116 Y248.01456 E0.019193
G1 X133.67817 Y242.65756 E0.251308
G1 X133.64950 Y242.11053 E0.018171
G1 X127.74530 Y248.01473 E0.276978
G1 X127.17215 Y248.01218 E0.019012
G1 X133.62083 Y241.56350 E0.302521
G1 X133.59216 Y241.01647 E0.018171
G1 X126.60166 Y248.00697 E0.327939
G1 X126.03379 Y247.99915 E0.018839
G1 X133.56349 Y240.46944 E0.353234
G1 X133.53482 Y239.92242 E0.018171
G1 X125.46852 Y247.98872 E0.378407
G1 X124.90578 Y247.97576 E0.018672
G1 X133.50616 Y239.37539 E0.403461
G1 X133.47749 Y238.82836 E0.018171
G1 X124.34560 Y247.96025 E0.428396
G1 X123.78787 Y247.94227 E0.018510
G1 X133.44882 Y238.28133 E0.453215
G1 X133.42015 Y237.73430 E0.018171
G1 X123.23264 Y247.92181 E0.477917
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y247.89895 E0.273231
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X127.38335 Y242.04400 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.87419 Y238.97746 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X126.97746 Y241.87419 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.64133 Y238.63463 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X126.63463 Y241.64133 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.35234 Y238.34792 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X126.34792 Y241.35234 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.00711 Y238.11746 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X126.11746 Y241.00711 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X128.59831 Y237.95056 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X128.10556 Y237.86761 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X125.86761 Y240.10556 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X127.38847 Y237.43331 E0.237277
G1 X126.81737 Y237.42871 E0.018945
G1 X122.36239 Y241.88369 E0.208992
G1 X122.39423 Y241.27615 E0.020181
G1 X126.24915 Y237.42123 E0.180842
G1 X125.68377 Y237.41091 E0.018758
G1 X122.42607 Y240.66861 E0.152826
G1 X122.45791 Y240.06108 E0.020181
G1 X125.12119 Y237.39779 E0.124940
G1 X124.56137 Y237.38192 E0.018578
G1 X122.48975 Y239.45354 E0.097184
G1 X122.52159 Y238.84600 E0.020181
G1 X124.00427 Y237.36333 E0.069555
G1 X123.44984 Y237.34205 E0.018405
G1 X122.55343 Y238.23846 E0.042053
G1 X122.58527 Y237.63093 E0.020181
G1 X122.89806 Y237.31813 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.56312 Y181.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X27.84430 Y181.70999 I-1.29001 J1.42881 E0.100304
G2 X27.98309 Y184.42881 I1.42881 J1.29001 E0.100304
G2 X30.70191 Y184.29001 I1.29001 J-1.42881 E0.100304
G2 X30.56312 Y181.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X25.67601 Y191.93130 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X25.26059 Y191.81998 E0.014266
G1 X24.93678 Y191.31178 E0.019989
G1 X26.13542 Y191.63295 E0.041164
G1 X26.59483 Y191.33461 E0.018171
G1 X24.61718 Y190.80470 E0.067916
G1 X24.30173 Y190.29874 E0.019779
G1 X27.05423 Y191.03627 E0.094526
G1 X27.51364 Y190.73793 E0.018171
G1 X23.99039 Y189.79387 E0.120996
G1 X23.68307 Y189.29009 E0.019575
G1 X27.97305 Y190.43959 E0.147326
G1 X28.43245 Y190.14124 E0.018171
G1 X23.37972 Y188.78737 E0.173521
G1 X23.08026 Y188.28569 E0.019381
G1 X28.89186 Y189.84290 E0.199582
G1 X29.35127 Y189.54456 E0.018171
G1 X22.78467 Y187.78504 E0.225510
G1 X22.49287 Y187.28542 E0.019193
G1 X29.81067 Y189.24622 E0.251308
G1 X30.27008 Y188.94787 E0.018171
G1 X22.20479 Y186.78679 E0.276978
G1 X21.92043 Y186.28915 E0.019012
G1 X30.72949 Y188.64953 E0.302521
G1 X31.18889 Y188.35119 E0.018171
G1 X21.63969 Y185.79249 E0.327939
G1 X21.36253 Y185.29678 E0.018839
G1 X31.64830 Y188.05285 E0.353234
G1 X32.10771 Y187.75451 E0.018171
G1 X21.08893 Y184.80203 E0.378407
G1 X20.81879 Y184.30821 E0.018672
G1 X32.56711 Y187.45616 E0.403461
G1 X33.02652 Y187.15782 E0.018171
G1 X20.55213 Y183.81532 E0.428396
G1 X20.28883 Y183.32333 E0.018510
G1 X33.48593 Y186.85948 E0.453215
G1 X33.94533 Y186.56114 E0.018171
G1 X20.02893 Y182.83225 E0.477917
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y182.34205 E0.273231
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.19462 Y183.48797 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X31.09574 Y184.11183 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.13874 Y183.05156 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X31.27622 Y183.73875 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.16898 Y182.63822 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X31.38002 Y183.34512 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.27590 Y182.24543 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X31.40698 Y182.93091 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.45966 Y181.87323 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X31.34713 Y182.49343 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X31.17258 Y182.02522 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.11550 Y181.20608 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X31.19016 Y181.18705 E0.237277
G1 X30.90859 Y180.69017 E0.018945
G1 X24.82298 Y179.05953 E0.208992
G1 X25.36504 Y178.78334 E0.020181
G1 X30.63096 Y180.19433 E0.180842
G1 X30.35721 Y179.69954 E0.018758
G1 X25.90710 Y178.50714 E0.152826
G1 X26.44916 Y178.23095 E0.020181
G1 X30.08728 Y179.20578 E0.124940
G1 X29.82111 Y178.71302 E0.018578
G1 X26.99123 Y177.95475 E0.097184
G1 X27.53329 Y177.67856 E0.020181
G1 X29.55866 Y178.22126 E0.069555
G1 X29.29988 Y177.73047 E0.018405
G1 X28.07535 Y177.40236 E0.042053
G1 X28.61741 Y177.12617 E0.020181
G1 X29.04470 Y177.24066 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.56312 Y67.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X27.84430 Y67.70999 I-1.29001 J1.42881 E0.100304
G2 X27.98309 Y70.42881 I1.42881 J1.29001 E0.100304
G2 X30.70191 Y70.29001 I1.29001 J-1.42881 E0.100304
G2 X30.56312 Y67.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X19.73983 Y70.35048 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X19.62852 Y69.93505 E0.014266
G1 X19.90673 Y69.40052 E0.019989
G1 X20.22790 Y70.59916 E0.041164
G1 X20.71598 Y70.84785 E0.018171
G1 X20.18607 Y68.87020 E0.067916
G1 X20.46652 Y68.34403 E0.019779
G1 X21.20405 Y71.09654 E0.094526
G1 X21.69213 Y71.34522 E0.018171
G1 X20.74808 Y67.82197 E0.120996
G1 X21.03071 Y67.30394 E0.019575
G1 X22.18021 Y71.59391 E0.147326
G1 X22.66828 Y71.84260 E0.018171
G1 X21.31440 Y66.78986 E0.173521
G1 X21.59914 Y66.27968 E0.019381
G1 X23.15636 Y72.09128 E0.199582
G1 X23.64443 Y72.33997 E0.018171
G1 X21.88492 Y65.77337 E0.225510
G1 X22.17171 Y65.27086 E0.019193
G1 X24.13251 Y72.58866 E0.251308
G1 X24.62058 Y72.83734 E0.018171
G1 X22.45949 Y64.77206 E0.276978
G1 X22.74828 Y64.27698 E0.019012
G1 X25.10866 Y73.08603 E0.302521
G1 X25.59673 Y73.33472 E0.018171
G1 X23.03803 Y63.78551 E0.327939
G1 X23.32874 Y63.29764 E0.018839
G1 X26.08481 Y73.58340 E0.353234
G1 X26.57288 Y73.83209 E0.018171
G1 X23.62041 Y62.81331 E0.378407
G1 X23.91300 Y62.33245 E0.018672
G1 X27.06096 Y74.08078 E0.403461
G1 X27.54903 Y74.32946 E0.018171
G1 X24.20653 Y61.85507 E0.428396
G1 X24.50096 Y61.38106 E0.018510
G1 X28.03711 Y74.57815 E0.453215
G1 X28.52518 Y74.82684 E0.018171
G1 X24.79629 Y60.91043 E0.477917
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y60.44310 E0.273231
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.81127 Y67.44397 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X29.22155 Y71.13437 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.16127 Y67.17736 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X29.63488 Y71.10412 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.53435 Y66.99689 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.02768 Y70.99720 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.92798 Y66.89309 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.39988 Y70.81345 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X29.34219 Y66.86612 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.74882 Y70.54287 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X31.06703 Y70.15761 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.24788 Y67.10052 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.80169 Y69.75374 E0.237277
G1 X32.09122 Y69.26146 E0.018945
G1 X30.46059 Y63.17584 E0.208992
G1 X30.97081 Y63.50719 E0.020181
G1 X32.38181 Y68.77310 E0.180842
G1 X32.67343 Y68.28863 E0.018758
G1 X31.48103 Y63.83853 E0.152826
G1 X31.99126 Y64.16987 E0.020181
G1 X32.96608 Y67.80798 E0.124940
G1 X33.25974 Y67.33110 E0.018578
G1 X32.50148 Y64.50121 E0.097184
G1 X33.01170 Y64.83256 E0.020181
G1 X33.55440 Y66.85793 E0.069555
G1 X33.85003 Y66.38842 E0.018405
G1 X33.52192 Y65.16390 E0.042053
G1 X34.03215 Y65.49524 E0.020181
G1 X34.14664 Y65.92253 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.29001 Y10.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X126.57119 Y10.70999 I-1.29001 J1.42881 E0.100304
G2 X126.70999 Y13.42881 I1.42881 J1.29001 E0.100304
G2 X129.42881 Y13.29001 I1.29001 J-1.42881 E0.100304
G2 X129.29001 Y10.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X122.06382 Y4.41918 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.36793 Y4.11507 E0.014266
G1 X122.96995 Y4.08874 E0.019989
G1 X122.09248 Y4.96621 E0.041164
G1 X122.12115 Y5.51324 E0.018171
G1 X123.56889 Y4.06550 E0.067916
G1 X124.16479 Y4.04529 E0.019779
G1 X122.14982 Y6.06027 E0.094526
G1 X122.17849 Y6.60730 E0.018171
G1 X124.75769 Y4.02809 E0.120996
G1 X125.34764 Y4.01385 E0.019575
G1 X122.20716 Y7.15432 E0.147326
G1 X122.23583 Y7.70135 E0.018171
G1 X125.93469 Y4.00250 E0.173521
G1 X126.51888 Y3.99399 E0.019381
G1 X122.26450 Y8.24838 E0.199582
G1 X122.29316 Y8.79541 E0.018171
G1 X127.10025 Y3.98833 E0.225510
G1 X127.67884 Y3.98544 E0.019193
G1 X122.32183 Y9.34244 E0.251308
G1 X122.35050 Y9.88947 E0.018171
G1 X128.25470 Y3.98527 E0.276978
G1 X128.82785 Y3.98782 E0.019012
G1 X122.37917 Y10.43650 E0.302521
G1 X122.40784 Y10.98353 E0.018171
G1 X129.39834 Y3.99303 E0.327939
G1 X129.96621 Y4.00085 E0.018839
G1 X122.43651 Y11.53056 E0.353234
G1 X122.46518 Y12.07758 E0.018171
G1 X130.53148 Y4.01128 E0.378407
G1 X131.09422 Y4.02424 E0.018672
G1 X122.49384 Y12.62461 E0.403461
G1 X122.52251 Y13.17164 E0.018171
G1 X131.65440 Y4.03975 E0.428396
G1 X132.21213 Y4.05773 E0.018510
G1 X122.55118 Y13.71867 E0.453215
G1 X122.57985 Y14.26570 E0.018171
G1 X132.76736 Y4.07819 E0.477917
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y4.10105 E0.273231
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X128.61665 Y9.95600 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X126.12581 Y13.02254 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.02254 Y10.12581 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X126.35867 Y13.36537 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.36537 Y10.35867 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X126.64766 Y13.65208 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.65208 Y10.64766 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X126.99289 Y13.88254 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.88254 Y10.99289 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X127.40169 Y14.04944 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X127.89444 Y14.13239 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X130.13239 Y11.89444 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X128.61153 Y14.56669 E0.237277
G1 X129.18263 Y14.57129 E0.018945
G1 X133.63761 Y10.11631 E0.208992
G1 X133.60577 Y10.72385 E0.020181
G1 X129.75085 Y14.57877 E0.180842
G1 X130.31623 Y14.58909 E0.018758
G1 X133.57393 Y11.33139 E0.152826
G1 X133.54209 Y11.93892 E0.020181
G1 X130.87881 Y14.60221 E0.124940
G1 X131.43863 Y14.61808 E0.018578
G1 X133.51025 Y12.54646 E0.097184
G1 X133.47841 Y13.15400 E0.020181
G1 X131.99573 Y14.63667 E0.069555
G1 X132.55016 Y14.65795 E0.018405
G1 X133.44657 Y13.76154 E0.042053
G1 X133.41473 Y14.36907 E0.020181
G1 X133.10194 Y14.68187 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.01691 Y67.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X225.29809 Y67.70999 I-1.29001 J1.42881 E0.100304
G2 X225.43688 Y70.42881 I1.42881 J1.29001 E0.100304
G2 X228.15570 Y70.29001 I1.29001 J-1.42881 E0.100304
G2 X228.01691 Y67.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X230.32399 Y60.06870 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X230.73941 Y60.18002 E0.014266
G1 X231.06322 Y60.68822 E0.019989
G1 X229.86458 Y60.36705 E0.041164
G1 X229.40517 Y60.66539 E0.018171
G1 X231.38282 Y61.19530 E0.067916
G1 X231.69827 Y61.70126 E0.019779
G1 X228.94577 Y60.96373 E0.094526
G1 X228.48636 Y61.26207 E0.018171
G1 X232.00961 Y62.20613 E0.120996
G1 X232.31693 Y62.70991 E0.019575
G1 X228.02695 Y61.56041 E0.147326
G1 X227.56755 Y61.85876 E0.018171
G1 X232.62028 Y63.21263 E0.173521
G1 X232.91974 Y63.71431 E0.019381
G1 X227.10814 Y62.15710 E0.199582
G1 X226.64873 Y62.45544 E0.018171
G1 X233.21533 Y64.21496 E0.225510
G1 X233.50713 Y64.71458 E0.019193
G1 X226.18933 Y62.75378 E0.251308
G1 X225.72992 Y63.05213 E0.018171
G1 X233.79521 Y65.21321 E0.276978
G1 X234.07957 Y65.71085 E0.019012
G1 X225.27051 Y63.35047 E0.302521
G1 X224.81111 Y63.64881 E0.018171
G1 X234.36031 Y66.20751 E0.327939
G1 X234.63747 Y66.70322 E0.018839
G1 X224.35170 Y63.94715 E0.353234
G1 X223.89229 Y64.24549 E0.018171
G1 X234.91107 Y67.19797 E0.378407
G1 X235.18121 Y67.69179 E0.018672
G1 X223.43289 Y64.54384 E0.403461
G1 X222.97348 Y64.84218 E0.018171
G1 X235.44787 Y68.18468 E0.428396
G1 X235.71117 Y68.67667 E0.018510
G1 X222.51407 Y65.14052 E0.453215
G1 X222.05467 Y65.43886 E0.018171
G1 X235.97107 Y69.16775 E0.477917
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y69.65795 E0.273231
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.80538 Y68.51203 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X224.90426 Y67.88817 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.86126 Y68.94844 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X224.72378 Y68.26125 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.83102 Y69.36178 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X224.61998 Y68.65488 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.72410 Y69.75457 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X224.59302 Y69.06909 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.54034 Y70.12677 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X224.65287 Y69.50657 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X224.82742 Y69.97478 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.88450 Y70.79392 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X224.80984 Y70.81295 E0.237277
G1 X225.09141 Y71.30983 E0.018945
G1 X231.17702 Y72.94047 E0.208992
G1 X230.63496 Y73.21666 E0.020181
G1 X225.36904 Y71.80567 E0.180842
G1 X225.64279 Y72.30046 E0.018758
G1 X230.09290 Y73.49286 E0.152826
G1 X229.55084 Y73.76905 E0.020181
G1 X225.91272 Y72.79422 E0.124940
G1 X226.17889 Y73.28698 E0.018578
G1 X229.00877 Y74.04525 E0.097184
G1 X228.46671 Y74.32144 E0.020181
G1 X226.44134 Y73.77874 E0.069555
G1 X226.70012 Y74.26953 E0.018405
G1 X227.92465 Y74.59764 E0.042053
G1 X227.38259 Y74.87383 E0.020181
G1 X226.95530 Y74.75934 E0.014674
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X209.90225 Y35.28584 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X218.71416 Y207.90225 I-81.90225 J90.71416 E6.123232
G3 X46.09775 Y216.71416 I-90.71416 J-81.90225 E6.123232
G3 X37.28584 Y44.09775 I81.90225 J-90.71416 E6.123232
G3 X209.90225 Y35.28584 I90.71416 J81.90225 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X210.16455 Y34.99532 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X219.00468 Y208.16455 I-82.16455 J91.00468 E6.142842
G3 X45.83545 Y217.00468 I-91.00468 J-82.16455 E6.142842
G3 X36.99532 Y43.83545 I82.16455 J-91.00468 E6.142842
G3 X210.16455 Y34.99532 I91.00468 J82.16455 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X210.42685 Y34.70480 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X219.29520 Y208.42685 I-82.42685 J91.29520 E6.162452
G3 X45.57315 Y217.29520 I-91.29520 J-82.42685 E6.162452
G3 X36.70480 Y43.57315 I82.42685 J-91.29520 E6.162452
G3 X210.42685 Y34.70480 I91.29520 J82.42685 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X210.68915 Y34.41427 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X219.58573 Y208.68915 I-82.68915 J91.58573 E6.182063
G3 X45.31085 Y217.58573 I-91.58573 J-82.68915 E6.182063
G3 X36.41427 Y43.31085 I82.68915 J-91.58573 E6.182063
G3 X210.68915 Y34.41427 I91.58573 J82.68915 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X210.95146 Y34.12375 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X219.87625 Y208.95146 I-82.95146 J91.87625 E6.201673
G3 X45.04854 Y217.87625 I-91.87625 J-82.95146 E6.201673
G3 X36.12375 Y43.04854 I82.95146 J-91.87625 E6.201673
G3 X210.95146 Y34.12375 I91.87625 J82.95146 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 2.400
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 12/20
M73 L12
M991 S0 P11
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X226.74083 Y184.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X228.65185 Y182.98607 I-0.01393 J-1.92495 E0.100304
G2 X226.71297 Y181.07505 I-1.92495 J0.01393 E0.100304
G2 X224.80195 Y183.01393 I0.01393 J1.92495 E0.100304
G2 X226.74083 Y184.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X226.95530 Y177.24066 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X227.38259 Y177.12617 E0.014674
G1 X227.92465 Y177.40236 E0.020181
G1 X226.70012 Y177.73047 E0.042053
G1 X226.44134 Y178.22126 E0.018405
G1 X228.46671 Y177.67856 E0.069555
G1 X229.00877 Y177.95475 E0.020181
G1 X226.17889 Y178.71302 E0.097184
G1 X225.91272 Y179.20578 E0.018578
G1 X229.55084 Y178.23095 E0.124940
G1 X230.09290 Y178.50714 E0.020181
G1 X225.64279 Y179.69954 E0.152826
G1 X225.36904 Y180.19433 E0.018758
G1 X230.63496 Y178.78334 E0.180842
G1 X231.17702 Y179.05953 E0.020181
G1 X225.09141 Y180.69017 E0.208992
G1 X224.80984 Y181.18705 E0.018945
G1 X231.71909 Y179.33573 E0.237277
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X224.82742 Y182.02522 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.88450 Y181.20608 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.26977 Y181.52429 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X224.59302 Y182.93091 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.54034 Y181.87323 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X224.61998 Y183.34512 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.72410 Y182.24543 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X224.72378 Y183.73875 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.83102 Y182.63822 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X224.90426 Y184.11183 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.86126 Y183.05156 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X225.17086 Y184.46183 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.80538 Y183.48797 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X225.55039 Y184.78158 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y182.34205 E0.273231
G1 X235.97107 Y182.83225 E0.018354
G1 X222.05467 Y186.56114 E0.477917
G1 X222.51407 Y186.85948 E0.018171
G1 X235.71117 Y183.32333 E0.453215
G1 X235.44787 Y183.81532 E0.018510
G1 X222.97348 Y187.15782 E0.428396
G1 X223.43289 Y187.45616 E0.018171
G1 X235.18121 Y184.30821 E0.403461
G1 X234.91107 Y184.80203 E0.018672
G1 X223.89229 Y187.75451 E0.378407
G1 X224.35170 Y188.05285 E0.018171
G1 X234.63747 Y185.29678 E0.353234
G1 X234.36031 Y185.79249 E0.018839
G1 X224.81111 Y188.35119 E0.327939
G1 X225.27051 Y188.64953 E0.018171
G1 X234.07957 Y186.28915 E0.302521
G1 X233.79521 Y186.78679 E0.019012
G1 X225.72992 Y188.94787 E0.276978
G1 X226.18933 Y189.24622 E0.018171
G1 X233.50713 Y187.28542 E0.251308
G1 X233.21533 Y187.78504 E0.019193
G1 X226.64873 Y189.54456 E0.225510
G1 X227.10814 Y189.84290 E0.018171
G1 X232.91974 Y188.28569 E0.199582
G1 X232.62028 Y188.78737 E0.019381
G1 X227.56755 Y190.14124 E0.173521
G1 X228.02695 Y190.43959 E0.018171
G1 X232.31693 Y189.29009 E0.147326
G1 X232.00961 Y189.79387 E0.019575
G1 X228.48636 Y190.73793 E0.120996
G1 X228.94577 Y191.03627 E0.018171
G1 X231.69827 Y190.29874 E0.094526
G1 X231.38282 Y190.80470 E0.019779
G1 X229.40517 Y191.33461 E0.067916
G1 X229.86458 Y191.63295 E0.018171
G1 X231.06322 Y191.31178 E0.041164
G1 X230.73941 Y191.81998 E0.019989
G1 X230.32399 Y191.93130 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.01393 Y241.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.92495 Y239.98607 I-0.01393 J-1.92495 E0.100304
G2 X127.98607 Y238.07505 I-1.92495 J0.01393 E0.100304
G2 X126.07505 Y240.01393 I0.01393 J1.92495 E0.100304
G2 X128.01393 Y241.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X133.10194 Y237.31813 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.41473 Y237.63093 E0.014674
G1 X133.44657 Y238.23846 E0.020181
G1 X132.55016 Y237.34205 E0.042053
G1 X131.99573 Y237.36333 E0.018405
G1 X133.47841 Y238.84600 E0.069555
G1 X133.51025 Y239.45354 E0.020181
G1 X131.43863 Y237.38192 E0.097184
G1 X130.87881 Y237.39779 E0.018578
G1 X133.54209 Y240.06108 E0.124940
G1 X133.57393 Y240.66861 E0.020181
G1 X130.31623 Y237.41091 E0.152826
G1 X129.75085 Y237.42123 E0.018758
G1 X133.60577 Y241.27615 E0.180842
G1 X133.63761 Y241.88369 E0.020181
G1 X129.18263 Y237.42871 E0.208992
G1 X128.61153 Y237.43331 E0.018945
G1 X133.66945 Y242.49123 E0.237277
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X127.89444 Y237.86761 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X130.13239 Y240.10556 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X130.04944 Y240.59831 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X126.99289 Y238.11746 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X129.88254 Y241.00711 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X126.64766 Y238.34792 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X129.65208 Y241.35234 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X126.35867 Y238.63463 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X129.36537 Y241.64133 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X126.12581 Y238.97746 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X129.02254 Y241.87419 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X125.95600 Y239.38335 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.61665 Y242.04400 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X125.86885 Y239.87191 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y247.89895 E0.273231
G1 X132.76736 Y247.92181 E0.018354
G1 X122.57985 Y237.73430 E0.477917
G1 X122.55118 Y238.28133 E0.018171
G1 X132.21213 Y247.94227 E0.453215
G1 X131.65440 Y247.96025 E0.018510
G1 X122.52251 Y238.82836 E0.428396
G1 X122.49384 Y239.37539 E0.018171
G1 X131.09422 Y247.97576 E0.403461
G1 X130.53148 Y247.98872 E0.018672
G1 X122.46518 Y239.92242 E0.378407
G1 X122.43651 Y240.46944 E0.018171
G1 X129.96621 Y247.99915 E0.353234
G1 X129.39834 Y248.00697 E0.018839
G1 X122.40784 Y241.01647 E0.327939
G1 X122.37917 Y241.56350 E0.018171
G1 X128.82785 Y248.01218 E0.302521
G1 X128.25470 Y248.01473 E0.019012
G1 X122.35050 Y242.11053 E0.276978
G1 X122.32183 Y242.65756 E0.018171
G1 X127.67884 Y248.01456 E0.251308
G1 X127.10025 Y248.01167 E0.019193
G1 X122.29316 Y243.20459 E0.225510
G1 X122.26450 Y243.75162 E0.018171
G1 X126.51888 Y248.00601 E0.199582
G1 X125.93469 Y247.99750 E0.019381
G1 X122.23583 Y244.29865 E0.173521
G1 X122.20716 Y244.84568 E0.018171
G1 X125.34764 Y247.98615 E0.147326
G1 X124.75769 Y247.97191 E0.019575
G1 X122.17849 Y245.39270 E0.120996
G1 X122.14982 Y245.93973 E0.018171
G1 X124.16479 Y247.95471 E0.094526
G1 X123.56889 Y247.93450 E0.019779
G1 X122.12115 Y246.48676 E0.067916
G1 X122.09248 Y247.03379 E0.018171
G1 X122.96995 Y247.91126 E0.041164
G1 X122.36793 Y247.88493 E0.019989
G1 X122.06382 Y247.58082 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X29.28703 Y184.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X31.19805 Y182.98607 I-0.01393 J-1.92495 E0.100304
G2 X29.25917 Y181.07505 I-1.92495 J0.01393 E0.100304
G2 X27.34815 Y183.01393 I0.01393 J1.92495 E0.100304
G2 X29.28703 Y184.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X34.14664 Y186.07747 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X34.03215 Y186.50476 E0.014674
G1 X33.52192 Y186.83610 E0.020181
G1 X33.85003 Y185.61158 E0.042053
G1 X33.55440 Y185.14207 E0.018405
G1 X33.01170 Y187.16744 E0.069555
G1 X32.50148 Y187.49879 E0.020181
G1 X33.25974 Y184.66890 E0.097184
G1 X32.96608 Y184.19202 E0.018578
G1 X31.99126 Y187.83013 E0.124940
G1 X31.48103 Y188.16147 E0.020181
G1 X32.67343 Y183.71137 E0.152826
G1 X32.38181 Y183.22690 E0.018758
G1 X30.97081 Y188.49281 E0.180842
G1 X30.46059 Y188.82416 E0.020181
G1 X32.09122 Y182.73854 E0.208992
G1 X31.80169 Y182.24626 E0.018945
G1 X29.95036 Y189.15550 E0.237277
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X31.06703 Y181.84239 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X30.24788 Y184.89948 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X29.77967 Y185.07402 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X30.39988 Y181.18655 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X29.34219 Y185.13388 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X30.02768 Y181.00280 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.92798 Y185.10691 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X29.63488 Y180.89588 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.53435 Y185.00311 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X29.22155 Y180.86563 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.16127 Y184.82264 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.78513 Y180.92152 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.81127 Y184.55603 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.31846 Y181.09033 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y191.55690 E0.273231
G1 X24.79629 Y191.08957 E0.018354
G1 X28.52518 Y177.17316 E0.477917
G1 X28.03711 Y177.42185 E0.018171
G1 X24.50096 Y190.61894 E0.453215
G1 X24.20653 Y190.14493 E0.018510
G1 X27.54903 Y177.67054 E0.428396
G1 X27.06096 Y177.91922 E0.018171
G1 X23.91300 Y189.66755 E0.403461
G1 X23.62041 Y189.18669 E0.018672
G1 X26.57288 Y178.16791 E0.378407
G1 X26.08481 Y178.41660 E0.018171
G1 X23.32874 Y188.70236 E0.353234
G1 X23.03803 Y188.21449 E0.018839
G1 X25.59673 Y178.66528 E0.327939
G1 X25.10866 Y178.91397 E0.018171
G1 X22.74828 Y187.72302 E0.302521
G1 X22.45949 Y187.22794 E0.019012
G1 X24.62058 Y179.16266 E0.276978
G1 X24.13251 Y179.41134 E0.018171
G1 X22.17171 Y186.72914 E0.251308
G1 X21.88492 Y186.22663 E0.019193
G1 X23.64443 Y179.66003 E0.225510
G1 X23.15636 Y179.90872 E0.018171
G1 X21.59914 Y185.72032 E0.199582
G1 X21.31440 Y185.21014 E0.019381
G1 X22.66828 Y180.15740 E0.173521
G1 X22.18021 Y180.40609 E0.018171
G1 X21.03071 Y184.69606 E0.147326
G1 X20.74808 Y184.17803 E0.019575
G1 X21.69213 Y180.65478 E0.120996
G1 X21.20405 Y180.90346 E0.018171
G1 X20.46652 Y183.65597 E0.094526
G1 X20.18607 Y183.12980 E0.019779
G1 X20.71598 Y181.15215 E0.067916
G1 X20.22790 Y181.40084 E0.018171
G1 X19.90673 Y182.59948 E0.041164
G1 X19.62852 Y182.06495 E0.019989
G1 X19.73983 Y181.64952 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X29.28703 Y70.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X31.19805 Y68.98607 I-0.01393 J-1.92495 E0.100304
G2 X29.25917 Y67.07505 I-1.92495 J0.01393 E0.100304
G2 X27.34815 Y69.01393 I0.01393 J1.92495 E0.100304
G2 X29.28703 Y70.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X29.04470 Y74.75934 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X28.61741 Y74.87383 E0.014674
G1 X28.07535 Y74.59764 E0.020181
G1 X29.29988 Y74.26953 E0.042053
G1 X29.55866 Y73.77874 E0.018405
G1 X27.53329 Y74.32144 E0.069555
G1 X26.99123 Y74.04525 E0.020181
G1 X29.82111 Y73.28698 E0.097184
G1 X30.08728 Y72.79422 E0.018578
G1 X26.44916 Y73.76905 E0.124940
G1 X25.90710 Y73.49286 E0.020181
G1 X30.35721 Y72.30046 E0.152826
G1 X30.63096 Y71.80567 E0.018758
G1 X25.36504 Y73.21666 E0.180842
G1 X24.82298 Y72.94047 E0.020181
G1 X30.90859 Y71.30983 E0.208992
G1 X31.19016 Y70.81295 E0.018945
G1 X24.28091 Y72.66427 E0.237277
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X31.17258 Y69.97478 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.11550 Y70.79392 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.73023 Y70.47571 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X31.40698 Y69.06909 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.45966 Y70.12677 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X31.38002 Y68.65488 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.27590 Y69.75457 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X31.27622 Y68.26125 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.16898 Y69.36178 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X31.09574 Y67.88817 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.13874 Y68.94844 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X30.82914 Y67.53817 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.19462 Y68.51203 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X30.44961 Y67.21842 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y69.65795 E0.273231
G1 X20.02893 Y69.16775 E0.018354
G1 X33.94533 Y65.43886 E0.477917
G1 X33.48593 Y65.14052 E0.018171
G1 X20.28883 Y68.67667 E0.453215
G1 X20.55213 Y68.18468 E0.018510
G1 X33.02652 Y64.84218 E0.428396
G1 X32.56711 Y64.54384 E0.018171
G1 X20.81879 Y67.69179 E0.403461
G1 X21.08893 Y67.19797 E0.018672
G1 X32.10771 Y64.24549 E0.378407
G1 X31.64830 Y63.94715 E0.018171
G1 X21.36253 Y66.70322 E0.353234
G1 X21.63969 Y66.20751 E0.018839
G1 X31.18889 Y63.64881 E0.327939
G1 X30.72949 Y63.35047 E0.018171
G1 X21.92043 Y65.71085 E0.302521
G1 X22.20479 Y65.21321 E0.019012
G1 X30.27008 Y63.05213 E0.276978
G1 X29.81067 Y62.75378 E0.018171
G1 X22.49287 Y64.71458 E0.251308
G1 X22.78467 Y64.21496 E0.019193
G1 X29.35127 Y62.45544 E0.225510
G1 X28.89186 Y62.15710 E0.018171
G1 X23.08026 Y63.71431 E0.199582
G1 X23.37972 Y63.21263 E0.019381
G1 X28.43245 Y61.85876 E0.173521
G1 X27.97305 Y61.56041 E0.018171
G1 X23.68307 Y62.70991 E0.147326
G1 X23.99039 Y62.20613 E0.019575
G1 X27.51364 Y61.26207 E0.120996
G1 X27.05423 Y60.96373 E0.018171
G1 X24.30173 Y61.70126 E0.094526
G1 X24.61718 Y61.19530 E0.019779
G1 X26.59483 Y60.66539 E0.067916
G1 X26.13542 Y60.36705 E0.018171
G1 X24.93678 Y60.68822 E0.041164
G1 X25.26059 Y60.18002 E0.019989
G1 X25.67601 Y60.06870 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.01393 Y13.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.92495 Y11.98607 I-0.01393 J-1.92495 E0.100304
G2 X127.98607 Y10.07505 I-1.92495 J0.01393 E0.100304
G2 X126.07505 Y12.01393 I0.01393 J1.92495 E0.100304
G2 X128.01393 Y13.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X122.89806 Y14.68187 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.58527 Y14.36907 E0.014674
G1 X122.55343 Y13.76154 E0.020181
G1 X123.44984 Y14.65795 E0.042053
G1 X124.00427 Y14.63667 E0.018405
G1 X122.52159 Y13.15400 E0.069555
G1 X122.48975 Y12.54646 E0.020181
G1 X124.56137 Y14.61808 E0.097184
G1 X125.12119 Y14.60221 E0.018578
G1 X122.45791 Y11.93892 E0.124940
G1 X122.42607 Y11.33139 E0.020181
G1 X125.68377 Y14.58909 E0.152826
G1 X126.24915 Y14.57877 E0.018758
G1 X122.39423 Y10.72385 E0.180842
G1 X122.36239 Y10.11631 E0.020181
G1 X126.81737 Y14.57129 E0.208992
G1 X127.38847 Y14.56669 E0.018945
G1 X122.33055 Y9.50877 E0.237277
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.10556 Y14.13239 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X125.86761 Y11.89444 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X125.95056 Y11.40169 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X129.00711 Y13.88254 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X126.11746 Y10.99289 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X129.35234 Y13.65208 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X126.34792 Y10.64766 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X129.64133 Y13.36537 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X126.63463 Y10.35867 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X129.87419 Y13.02254 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X126.97746 Y10.12581 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X130.04400 Y12.61665 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X127.38335 Y9.95600 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X130.13115 Y12.12809 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y4.10105 E0.273231
G1 X123.23264 Y4.07819 E0.018354
G1 X133.42015 Y14.26570 E0.477917
G1 X133.44882 Y13.71867 E0.018171
G1 X123.78787 Y4.05773 E0.453215
G1 X124.34560 Y4.03975 E0.018510
G1 X133.47749 Y13.17164 E0.428396
G1 X133.50616 Y12.62461 E0.018171
G1 X124.90578 Y4.02424 E0.403461
G1 X125.46852 Y4.01128 E0.018672
G1 X133.53482 Y12.07758 E0.378407
G1 X133.56349 Y11.53056 E0.018171
G1 X126.03379 Y4.00085 E0.353234
G1 X126.60166 Y3.99303 E0.018839
G1 X133.59216 Y10.98353 E0.327939
G1 X133.62083 Y10.43650 E0.018171
G1 X127.17215 Y3.98782 E0.302521
G1 X127.74530 Y3.98527 E0.019012
G1 X133.64950 Y9.88947 E0.276978
G1 X133.67817 Y9.34244 E0.018171
G1 X128.32116 Y3.98544 E0.251308
G1 X128.89975 Y3.98833 E0.019193
G1 X133.70684 Y8.79541 E0.225510
G1 X133.73550 Y8.24838 E0.018171
G1 X129.48112 Y3.99399 E0.199582
G1 X130.06531 Y4.00250 E0.019381
G1 X133.76417 Y7.70135 E0.173521
G1 X133.79284 Y7.15432 E0.018171
G1 X130.65236 Y4.01385 E0.147326
G1 X131.24231 Y4.02809 E0.019575
G1 X133.82151 Y6.60730 E0.120996
G1 X133.85018 Y6.06027 E0.018171
G1 X131.83521 Y4.04529 E0.094526
G1 X132.43111 Y4.06550 E0.019779
G1 X133.87885 Y5.51324 E0.067916
G1 X133.90752 Y4.96621 E0.018171
G1 X133.03005 Y4.08874 E0.041164
G1 X133.63207 Y4.11507 E0.019989
G1 X133.93618 Y4.41918 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X226.74083 Y70.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X228.65185 Y68.98607 I-0.01393 J-1.92495 E0.100304
G2 X226.71297 Y67.07505 I-1.92495 J0.01393 E0.100304
G2 X224.80195 Y69.01393 I0.01393 J1.92495 E0.100304
G2 X226.74083 Y70.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X221.85336 Y65.92253 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X221.96785 Y65.49524 E0.014674
G1 X222.47808 Y65.16390 E0.020181
G1 X222.14997 Y66.38842 E0.042053
G1 X222.44560 Y66.85793 E0.018405
G1 X222.98830 Y64.83256 E0.069555
G1 X223.49852 Y64.50121 E0.020181
G1 X222.74026 Y67.33110 E0.097184
G1 X223.03392 Y67.80798 E0.018578
G1 X224.00874 Y64.16987 E0.124940
G1 X224.51897 Y63.83853 E0.020181
G1 X223.32657 Y68.28863 E0.152826
G1 X223.61819 Y68.77310 E0.018758
G1 X225.02919 Y63.50719 E0.180842
G1 X225.53941 Y63.17584 E0.020181
G1 X223.90878 Y69.26146 E0.208992
G1 X224.19831 Y69.75374 E0.018945
G1 X226.04964 Y62.84450 E0.237277
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X224.93297 Y70.15761 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X225.75212 Y67.10052 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X226.22033 Y66.92598 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X225.60012 Y70.81345 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X226.65781 Y66.86612 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X225.97232 Y70.99720 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.07202 Y66.89309 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X226.36512 Y71.10412 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.46565 Y66.99689 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X226.77845 Y71.13437 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.83873 Y67.17736 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.21487 Y71.07848 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.18873 Y67.44397 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.68154 Y70.90967 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y60.44310 E0.273231
G1 X231.20371 Y60.91043 E0.018354
G1 X227.47482 Y74.82684 E0.477917
G1 X227.96289 Y74.57815 E0.018171
G1 X231.49904 Y61.38106 E0.453215
G1 X231.79347 Y61.85507 E0.018510
G1 X228.45097 Y74.32946 E0.428396
G1 X228.93904 Y74.08078 E0.018171
G1 X232.08700 Y62.33245 E0.403461
G1 X232.37959 Y62.81331 E0.018672
G1 X229.42712 Y73.83209 E0.378407
G1 X229.91519 Y73.58340 E0.018171
G1 X232.67126 Y63.29764 E0.353234
G1 X232.96197 Y63.78551 E0.018839
G1 X230.40327 Y73.33472 E0.327939
G1 X230.89134 Y73.08603 E0.018171
G1 X233.25172 Y64.27698 E0.302521
G1 X233.54051 Y64.77206 E0.019012
G1 X231.37942 Y72.83734 E0.276978
G1 X231.86749 Y72.58866 E0.018171
G1 X233.82829 Y65.27086 E0.251308
G1 X234.11508 Y65.77337 E0.019193
G1 X232.35557 Y72.33997 E0.225510
G1 X232.84364 Y72.09128 E0.018171
G1 X234.40086 Y66.27968 E0.199582
G1 X234.68560 Y66.78986 E0.019381
G1 X233.33172 Y71.84260 E0.173521
G1 X233.81979 Y71.59391 E0.018171
G1 X234.96929 Y67.30394 E0.147326
G1 X235.25192 Y67.82197 E0.019575
G1 X234.30787 Y71.34522 E0.120996
G1 X234.79595 Y71.09654 E0.018171
G1 X235.53348 Y68.34403 E0.094526
G1 X235.81393 Y68.87020 E0.019779
G1 X235.28402 Y70.84785 E0.067916
G1 X235.77210 Y70.59916 E0.018171
G1 X236.09327 Y69.40052 E0.041164
G1 X236.37148 Y69.93505 E0.019989
G1 X236.26017 Y70.35048 E0.014266
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.88436 Y248.21397 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X5.78603 Y126.88436 I-0.88436 J-122.21397 E6.123232
G3 X127.11564 Y3.78603 I122.21397 J-0.88436 E6.123232
G3 X250.21397 Y125.11564 I0.88436 J122.21397 E6.123232
G3 X128.88436 Y248.21397 I-122.21397 J0.88436 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.88720 Y248.60537 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X5.39463 Y126.88720 I-0.88720 J-122.60537 E6.142842
G3 X127.11280 Y3.39463 I122.60537 J-0.88720 E6.142842
G3 X250.60537 Y125.11280 I0.88720 J122.60537 E6.142842
G3 X128.88720 Y248.60537 I-122.60537 J0.88720 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.89003 Y248.99678 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X5.00322 Y126.89003 I-0.89003 J-122.99678 E6.162452
G3 X127.10997 Y3.00322 I122.99678 J-0.89003 E6.162452
G3 X250.99678 Y125.10997 I0.89003 J122.99678 E6.162452
G3 X128.89003 Y248.99678 I-122.99678 J0.89003 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.89286 Y249.38819 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X4.61181 Y126.89286 I-0.89286 J-123.38819 E6.182063
G3 X127.10714 Y2.61181 I123.38819 J-0.89286 E6.182063
G3 X251.38819 Y125.10714 I0.89286 J123.38819 E6.182063
G3 X128.89286 Y249.38819 I-123.38819 J0.89286 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.89569 Y249.77959 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X4.22041 Y126.89569 I-0.89569 J-123.77959 E6.201673
G3 X127.10431 Y2.22041 I123.77959 J-0.89569 E6.201673
G3 X251.77959 Y125.10431 I0.89569 J123.77959 E6.201673
G3 X128.89569 Y249.77959 I-123.77959 J0.89569 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 2.600
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 13/20
M73 L13
M991 S0 P12
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.41634 Y181.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X225.31691 Y184.31056 I1.31056 J1.40999 E0.100304
G2 X228.03745 Y184.40999 I1.40999 J-1.31056 E0.100304
G2 X228.13688 Y181.68944 I-1.31056 J-1.40999 E0.100304
G2 X225.41634 Y181.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X236.26017 Y181.64952 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X236.37148 Y182.06495 E0.014266
G1 X236.09327 Y182.59948 E0.019989
G1 X235.77210 Y181.40084 E0.041164
G1 X235.28402 Y181.15215 E0.018171
G1 X235.81393 Y183.12980 E0.067916
G1 X235.53348 Y183.65597 E0.019779
G1 X234.79595 Y180.90346 E0.094526
G1 X234.30787 Y180.65478 E0.018171
G1 X235.25192 Y184.17803 E0.120996
G1 X234.96929 Y184.69606 E0.019575
G1 X233.81979 Y180.40609 E0.147326
G1 X233.33172 Y180.15740 E0.018171
G1 X234.68560 Y185.21014 E0.173521
G1 X234.40086 Y185.72032 E0.019381
G1 X232.84364 Y179.90872 E0.199582
G1 X232.35557 Y179.66003 E0.018171
G1 X234.11508 Y186.22663 E0.225510
G1 X233.82829 Y186.72914 E0.019193
G1 X231.86749 Y179.41134 E0.251308
G1 X231.37942 Y179.16266 E0.018171
G1 X233.54051 Y187.22794 E0.276978
G1 X233.25172 Y187.72302 E0.019012
G1 X230.89134 Y178.91397 E0.302521
G1 X230.40327 Y178.66528 E0.018171
G1 X232.96197 Y188.21449 E0.327939
G1 X232.67126 Y188.70236 E0.018839
G1 X229.91519 Y178.41660 E0.353234
G1 X229.42712 Y178.16791 E0.018171
G1 X232.37959 Y189.18669 E0.378407
G1 X232.08700 Y189.66755 E0.018672
G1 X228.93904 Y177.91922 E0.403461
G1 X228.45097 Y177.67054 E0.018171
G1 X231.79347 Y190.14493 E0.428396
G1 X231.49904 Y190.61894 E0.018510
G1 X227.96289 Y177.42185 E0.453215
G1 X227.47482 Y177.17316 E0.018171
G1 X231.20371 Y191.08957 E0.477917
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y191.55690 E0.273231
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.18873 Y184.55603 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X226.77845 Y180.86563 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.83873 Y184.82264 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X226.36512 Y180.89588 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.46565 Y185.00311 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.97232 Y181.00280 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.07202 Y185.10691 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.60012 Y181.18655 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X226.65781 Y185.13388 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.25118 Y181.45713 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X224.93297 Y181.84239 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.75212 Y184.89948 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.19831 Y182.24626 E0.237277
G1 X223.90878 Y182.73854 E0.018945
G1 X225.53941 Y188.82416 E0.208992
G1 X225.02919 Y188.49281 E0.020181
G1 X223.61819 Y183.22690 E0.180842
G1 X223.32657 Y183.71137 E0.018758
G1 X224.51897 Y188.16147 E0.152826
G1 X224.00874 Y187.83013 E0.020181
G1 X223.03392 Y184.19202 E0.124940
G1 X222.74026 Y184.66890 E0.018578
G1 X223.49852 Y187.49879 E0.097184
G1 X222.98830 Y187.16744 E0.020181
G1 X222.44560 Y185.14207 E0.069555
G1 X222.14997 Y185.61158 E0.018405
G1 X222.47808 Y186.83610 E0.042053
G1 X221.96785 Y186.50476 E0.020181
G1 X221.85336 Y186.07747 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.68944 Y238.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X126.59001 Y241.31056 I1.31056 J1.40999 E0.100304
G2 X129.31056 Y241.40999 I1.40999 J-1.31056 E0.100304
G2 X129.40999 Y238.68944 I-1.31056 J-1.40999 E0.100304
G2 X126.68944 Y238.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X133.93618 Y247.58082 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.63207 Y247.88493 E0.014266
G1 X133.03005 Y247.91126 E0.019989
G1 X133.90752 Y247.03379 E0.041164
G1 X133.87885 Y246.48676 E0.018171
G1 X132.43111 Y247.93450 E0.067916
G1 X131.83521 Y247.95471 E0.019779
G1 X133.85018 Y245.93973 E0.094526
G1 X133.82151 Y245.39270 E0.018171
G1 X131.24231 Y247.97191 E0.120996
G1 X130.65236 Y247.98615 E0.019575
G1 X133.79284 Y244.84568 E0.147326
G1 X133.76417 Y244.29865 E0.018171
G1 X130.06531 Y247.99750 E0.173521
G1 X129.48112 Y248.00601 E0.019381
G1 X133.73550 Y243.75162 E0.199582
G1 X133.70684 Y243.20459 E0.018171
G1 X128.89975 Y248.01167 E0.225510
G1 X128.32116 Y248.01456 E0.019193
G1 X133.67817 Y242.65756 E0.251308
G1 X133.64950 Y242.11053 E0.018171
G1 X127.74530 Y248.01473 E0.276978
G1 X127.17215 Y248.01218 E0.019012
G1 X133.62083 Y241.56350 E0.302521
G1 X133.59216 Y241.01647 E0.018171
G1 X126.60166 Y248.00697 E0.327939
G1 X126.03379 Y247.99915 E0.018839
G1 X133.56349 Y240.46944 E0.353234
G1 X133.53482 Y239.92242 E0.018171
G1 X125.46852 Y247.98872 E0.378407
G1 X124.90578 Y247.97576 E0.018672
G1 X133.50616 Y239.37539 E0.403461
G1 X133.47749 Y238.82836 E0.018171
G1 X124.34560 Y247.96025 E0.428396
G1 X123.78787 Y247.94227 E0.018510
G1 X133.44882 Y238.28133 E0.453215
G1 X133.42015 Y237.73430 E0.018171
G1 X123.23264 Y247.92181 E0.477917
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y247.89895 E0.273231
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X127.38335 Y242.04400 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X129.87419 Y238.97746 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.97746 Y241.87419 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X129.64133 Y238.63463 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.63463 Y241.64133 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X129.35234 Y238.34792 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.34792 Y241.35234 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X129.00711 Y238.11746 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.11746 Y241.00711 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X128.59831 Y237.95056 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X128.10556 Y237.86761 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X125.86761 Y240.10556 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X127.38847 Y237.43331 E0.237277
G1 X126.81737 Y237.42871 E0.018945
G1 X122.36239 Y241.88369 E0.208992
G1 X122.39423 Y241.27615 E0.020181
G1 X126.24915 Y237.42123 E0.180842
G1 X125.68377 Y237.41091 E0.018758
G1 X122.42607 Y240.66861 E0.152826
G1 X122.45791 Y240.06108 E0.020181
G1 X125.12119 Y237.39779 E0.124940
G1 X124.56137 Y237.38192 E0.018578
G1 X122.48975 Y239.45354 E0.097184
G1 X122.52159 Y238.84600 E0.020181
G1 X124.00427 Y237.36333 E0.069555
G1 X123.44984 Y237.34205 E0.018405
G1 X122.55343 Y238.23846 E0.042053
G1 X122.58527 Y237.63093 E0.020181
G1 X122.89806 Y237.31813 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.96255 Y181.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X27.86312 Y184.31056 I1.31056 J1.40999 E0.100304
G2 X30.58366 Y184.40999 I1.40999 J-1.31056 E0.100304
G2 X30.68309 Y181.68944 I-1.31056 J-1.40999 E0.100304
G2 X27.96255 Y181.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X25.67601 Y191.93130 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X25.26059 Y191.81998 E0.014266
G1 X24.93678 Y191.31178 E0.019989
G1 X26.13542 Y191.63295 E0.041164
G1 X26.59483 Y191.33461 E0.018171
G1 X24.61718 Y190.80470 E0.067916
G1 X24.30173 Y190.29874 E0.019779
G1 X27.05423 Y191.03627 E0.094526
G1 X27.51364 Y190.73793 E0.018171
G1 X23.99039 Y189.79387 E0.120996
G1 X23.68307 Y189.29009 E0.019575
G1 X27.97305 Y190.43959 E0.147326
G1 X28.43245 Y190.14124 E0.018171
G1 X23.37972 Y188.78737 E0.173521
G1 X23.08026 Y188.28569 E0.019381
G1 X28.89186 Y189.84290 E0.199582
G1 X29.35127 Y189.54456 E0.018171
G1 X22.78467 Y187.78504 E0.225510
G1 X22.49287 Y187.28542 E0.019193
G1 X29.81067 Y189.24622 E0.251308
G1 X30.27008 Y188.94787 E0.018171
G1 X22.20479 Y186.78679 E0.276978
G1 X21.92043 Y186.28915 E0.019012
G1 X30.72949 Y188.64953 E0.302521
G1 X31.18889 Y188.35119 E0.018171
G1 X21.63969 Y185.79249 E0.327939
G1 X21.36253 Y185.29678 E0.018839
G1 X31.64830 Y188.05285 E0.353234
G1 X32.10771 Y187.75451 E0.018171
G1 X21.08893 Y184.80203 E0.378407
G1 X20.81879 Y184.30821 E0.018672
G1 X32.56711 Y187.45616 E0.403461
G1 X33.02652 Y187.15782 E0.018171
G1 X20.55213 Y183.81532 E0.428396
G1 X20.28883 Y183.32333 E0.018510
G1 X33.48593 Y186.85948 E0.453215
G1 X33.94533 Y186.56114 E0.018171
G1 X20.02893 Y182.83225 E0.477917
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y182.34205 E0.273231
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.19462 Y183.48797 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X31.09574 Y184.11183 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.13874 Y183.05156 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X31.27622 Y183.73875 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.16898 Y182.63822 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X31.38002 Y183.34512 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.27590 Y182.24543 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X31.40698 Y182.93091 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.45966 Y181.87323 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X31.34713 Y182.49343 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X31.17258 Y182.02522 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.11550 Y181.20608 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X31.19016 Y181.18705 E0.237277
G1 X30.90859 Y180.69017 E0.018945
G1 X24.82298 Y179.05953 E0.208992
G1 X25.36504 Y178.78334 E0.020181
G1 X30.63096 Y180.19433 E0.180842
G1 X30.35721 Y179.69954 E0.018758
G1 X25.90710 Y178.50714 E0.152826
G1 X26.44916 Y178.23095 E0.020181
G1 X30.08728 Y179.20578 E0.124940
G1 X29.82111 Y178.71302 E0.018578
G1 X26.99123 Y177.95475 E0.097184
G1 X27.53329 Y177.67856 E0.020181
G1 X29.55866 Y178.22126 E0.069555
G1 X29.29988 Y177.73047 E0.018405
G1 X28.07535 Y177.40236 E0.042053
G1 X28.61741 Y177.12617 E0.020181
G1 X29.04470 Y177.24066 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.96255 Y67.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X27.86312 Y70.31056 I1.31056 J1.40999 E0.100304
G2 X30.58366 Y70.40999 I1.40999 J-1.31056 E0.100304
G2 X30.68309 Y67.68944 I-1.31056 J-1.40999 E0.100304
G2 X27.96255 Y67.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X19.73983 Y70.35048 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X19.62852 Y69.93505 E0.014266
G1 X19.90673 Y69.40052 E0.019989
G1 X20.22790 Y70.59916 E0.041164
G1 X20.71598 Y70.84785 E0.018171
G1 X20.18607 Y68.87020 E0.067916
G1 X20.46652 Y68.34403 E0.019779
G1 X21.20405 Y71.09654 E0.094526
G1 X21.69213 Y71.34522 E0.018171
G1 X20.74808 Y67.82197 E0.120996
G1 X21.03071 Y67.30394 E0.019575
G1 X22.18021 Y71.59391 E0.147326
G1 X22.66828 Y71.84260 E0.018171
G1 X21.31440 Y66.78986 E0.173521
G1 X21.59914 Y66.27968 E0.019381
G1 X23.15636 Y72.09128 E0.199582
G1 X23.64443 Y72.33997 E0.018171
G1 X21.88492 Y65.77337 E0.225510
G1 X22.17171 Y65.27086 E0.019193
G1 X24.13251 Y72.58866 E0.251308
G1 X24.62058 Y72.83734 E0.018171
G1 X22.45949 Y64.77206 E0.276978
G1 X22.74828 Y64.27698 E0.019012
G1 X25.10866 Y73.08603 E0.302521
G1 X25.59673 Y73.33472 E0.018171
G1 X23.03803 Y63.78551 E0.327939
G1 X23.32874 Y63.29764 E0.018839
G1 X26.08481 Y73.58340 E0.353234
G1 X26.57288 Y73.83209 E0.018171
G1 X23.62041 Y62.81331 E0.378407
G1 X23.91300 Y62.33245 E0.018672
G1 X27.06096 Y74.08078 E0.403461
G1 X27.54903 Y74.32946 E0.018171
G1 X24.20653 Y61.85507 E0.428396
G1 X24.50096 Y61.38106 E0.018510
G1 X28.03711 Y74.57815 E0.453215
G1 X28.52518 Y74.82684 E0.018171
G1 X24.79629 Y60.91043 E0.477917
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y60.44310 E0.273231
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.81127 Y67.44397 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X29.22155 Y71.13437 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.16127 Y67.17736 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X29.63488 Y71.10412 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.53435 Y66.99689 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.02768 Y70.99720 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.92798 Y66.89309 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.39988 Y70.81345 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X29.34219 Y66.86612 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.74882 Y70.54287 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X31.06703 Y70.15761 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.24788 Y67.10052 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.80169 Y69.75374 E0.237277
G1 X32.09122 Y69.26146 E0.018945
G1 X30.46059 Y63.17584 E0.208992
G1 X30.97081 Y63.50719 E0.020181
G1 X32.38181 Y68.77310 E0.180842
G1 X32.67343 Y68.28863 E0.018758
G1 X31.48103 Y63.83853 E0.152826
G1 X31.99126 Y64.16987 E0.020181
G1 X32.96608 Y67.80798 E0.124940
G1 X33.25974 Y67.33110 E0.018578
G1 X32.50148 Y64.50121 E0.097184
G1 X33.01170 Y64.83256 E0.020181
G1 X33.55440 Y66.85793 E0.069555
G1 X33.85003 Y66.38842 E0.018405
G1 X33.52192 Y65.16390 E0.042053
G1 X34.03215 Y65.49524 E0.020181
G1 X34.14664 Y65.92253 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.68944 Y10.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X126.59001 Y13.31056 I1.31056 J1.40999 E0.100304
G2 X129.31056 Y13.40999 I1.40999 J-1.31056 E0.100304
G2 X129.40999 Y10.68944 I-1.31056 J-1.40999 E0.100304
G2 X126.68944 Y10.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X122.06382 Y4.41918 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.36793 Y4.11507 E0.014266
G1 X122.96995 Y4.08874 E0.019989
G1 X122.09248 Y4.96621 E0.041164
G1 X122.12115 Y5.51324 E0.018171
G1 X123.56889 Y4.06550 E0.067916
G1 X124.16479 Y4.04529 E0.019779
G1 X122.14982 Y6.06027 E0.094526
G1 X122.17849 Y6.60730 E0.018171
G1 X124.75769 Y4.02809 E0.120996
G1 X125.34764 Y4.01385 E0.019575
G1 X122.20716 Y7.15432 E0.147326
G1 X122.23583 Y7.70135 E0.018171
G1 X125.93469 Y4.00250 E0.173521
G1 X126.51888 Y3.99399 E0.019381
G1 X122.26450 Y8.24838 E0.199582
G1 X122.29316 Y8.79541 E0.018171
G1 X127.10025 Y3.98833 E0.225510
G1 X127.67884 Y3.98544 E0.019193
G1 X122.32183 Y9.34244 E0.251308
G1 X122.35050 Y9.88947 E0.018171
G1 X128.25470 Y3.98527 E0.276978
G1 X128.82785 Y3.98782 E0.019012
G1 X122.37917 Y10.43650 E0.302521
G1 X122.40784 Y10.98353 E0.018171
G1 X129.39834 Y3.99303 E0.327939
G1 X129.96621 Y4.00085 E0.018839
G1 X122.43651 Y11.53056 E0.353234
G1 X122.46518 Y12.07758 E0.018171
G1 X130.53148 Y4.01128 E0.378407
G1 X131.09422 Y4.02424 E0.018672
G1 X122.49384 Y12.62461 E0.403461
G1 X122.52251 Y13.17164 E0.018171
G1 X131.65440 Y4.03975 E0.428396
G1 X132.21213 Y4.05773 E0.018510
G1 X122.55118 Y13.71867 E0.453215
G1 X122.57985 Y14.26570 E0.018171
G1 X132.76736 Y4.07819 E0.477917
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y4.10105 E0.273231
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X128.61665 Y9.95600 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.12581 Y13.02254 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X129.02254 Y10.12581 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.35867 Y13.36537 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X129.36537 Y10.35867 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.64766 Y13.65208 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X129.65208 Y10.64766 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.99289 Y13.88254 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X129.88254 Y10.99289 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X127.40169 Y14.04944 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X127.89444 Y14.13239 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X130.13239 Y11.89444 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X128.61153 Y14.56669 E0.237277
G1 X129.18263 Y14.57129 E0.018945
G1 X133.63761 Y10.11631 E0.208992
G1 X133.60577 Y10.72385 E0.020181
G1 X129.75085 Y14.57877 E0.180842
G1 X130.31623 Y14.58909 E0.018758
G1 X133.57393 Y11.33139 E0.152826
G1 X133.54209 Y11.93892 E0.020181
G1 X130.87881 Y14.60221 E0.124940
G1 X131.43863 Y14.61808 E0.018578
G1 X133.51025 Y12.54646 E0.097184
G1 X133.47841 Y13.15400 E0.020181
G1 X131.99573 Y14.63667 E0.069555
G1 X132.55016 Y14.65795 E0.018405
G1 X133.44657 Y13.76154 E0.042053
G1 X133.41473 Y14.36907 E0.020181
G1 X133.10194 Y14.68187 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.41634 Y67.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X225.31691 Y70.31056 I1.31056 J1.40999 E0.100304
G2 X228.03745 Y70.40999 I1.40999 J-1.31056 E0.100304
G2 X228.13688 Y67.68944 I-1.31056 J-1.40999 E0.100304
G2 X225.41634 Y67.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X230.32399 Y60.06870 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X230.73941 Y60.18002 E0.014266
G1 X231.06322 Y60.68822 E0.019989
G1 X229.86458 Y60.36705 E0.041164
G1 X229.40517 Y60.66539 E0.018171
G1 X231.38282 Y61.19530 E0.067916
G1 X231.69827 Y61.70126 E0.019779
G1 X228.94577 Y60.96373 E0.094526
G1 X228.48636 Y61.26207 E0.018171
G1 X232.00961 Y62.20613 E0.120996
G1 X232.31693 Y62.70991 E0.019575
G1 X228.02695 Y61.56041 E0.147326
G1 X227.56755 Y61.85876 E0.018171
G1 X232.62028 Y63.21263 E0.173521
G1 X232.91974 Y63.71431 E0.019381
G1 X227.10814 Y62.15710 E0.199582
G1 X226.64873 Y62.45544 E0.018171
G1 X233.21533 Y64.21496 E0.225510
G1 X233.50713 Y64.71458 E0.019193
G1 X226.18933 Y62.75378 E0.251308
G1 X225.72992 Y63.05213 E0.018171
G1 X233.79521 Y65.21321 E0.276978
G1 X234.07957 Y65.71085 E0.019012
G1 X225.27051 Y63.35047 E0.302521
G1 X224.81111 Y63.64881 E0.018171
G1 X234.36031 Y66.20751 E0.327939
G1 X234.63747 Y66.70322 E0.018839
G1 X224.35170 Y63.94715 E0.353234
G1 X223.89229 Y64.24549 E0.018171
G1 X234.91107 Y67.19797 E0.378407
G1 X235.18121 Y67.69179 E0.018672
G1 X223.43289 Y64.54384 E0.403461
G1 X222.97348 Y64.84218 E0.018171
G1 X235.44787 Y68.18468 E0.428396
G1 X235.71117 Y68.67667 E0.018510
G1 X222.51407 Y65.14052 E0.453215
G1 X222.05467 Y65.43886 E0.018171
G1 X235.97107 Y69.16775 E0.477917
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y69.65795 E0.273231
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.80538 Y68.51203 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X224.90426 Y67.88817 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.86126 Y68.94844 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X224.72378 Y68.26125 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.83102 Y69.36178 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X224.61998 Y68.65488 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.72410 Y69.75457 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X224.59302 Y69.06909 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.54034 Y70.12677 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X224.65287 Y69.50657 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X224.82742 Y69.97478 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.88450 Y70.79392 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X224.80984 Y70.81295 E0.237277
G1 X225.09141 Y71.30983 E0.018945
G1 X231.17702 Y72.94047 E0.208992
G1 X230.63496 Y73.21666 E0.020181
G1 X225.36904 Y71.80567 E0.180842
G1 X225.64279 Y72.30046 E0.018758
G1 X230.09290 Y73.49286 E0.152826
G1 X229.55084 Y73.76905 E0.020181
G1 X225.91272 Y72.79422 E0.124940
G1 X226.17889 Y73.28698 E0.018578
G1 X229.00877 Y74.04525 E0.097184
G1 X228.46671 Y74.32144 E0.020181
G1 X226.44134 Y73.77874 E0.069555
G1 X226.70012 Y74.26953 E0.018405
G1 X227.92465 Y74.59764 E0.042053
G1 X227.38259 Y74.87383 E0.020181
G1 X226.95530 Y74.75934 E0.014674
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X44.79355 Y36.48060 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X217.51940 Y42.79355 I83.20645 J89.51940 E6.123232
G3 X211.20645 Y215.51940 I-89.51940 J83.20645 E6.123232
G3 X38.48060 Y209.20645 I-83.20645 J-89.51940 E6.123232
G3 X44.79355 Y36.48060 I89.51940 J-83.20645 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X44.52707 Y36.19391 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X217.80609 Y42.52707 I83.47293 J89.80609 E6.142842
G3 X211.47293 Y215.80609 I-89.80609 J83.47293 E6.142842
G3 X38.19391 Y209.47293 I-83.47293 J-89.80609 E6.142842
G3 X44.52707 Y36.19391 I89.80609 J-83.47293 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X44.26059 Y35.90721 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X218.09279 Y42.26059 I83.73941 J90.09279 E6.162452
G3 X211.73941 Y216.09279 I-90.09279 J83.73941 E6.162452
G3 X37.90721 Y209.73941 I-83.73941 J-90.09279 E6.162452
G3 X44.26059 Y35.90721 I90.09279 J-83.73941 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X43.99411 Y35.62051 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X218.37949 Y41.99411 I84.00589 J90.37949 E6.182063
G3 X212.00589 Y216.37949 I-90.37949 J84.00589 E6.182063
G3 X37.62051 Y210.00589 I-84.00589 J-90.37949 E6.182063
G3 X43.99411 Y35.62051 I90.37949 J-84.00589 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X43.72763 Y35.33381 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X218.66619 Y41.72763 I84.27237 J90.66619 E6.201673
G3 X212.27237 Y216.66619 I-90.66619 J84.27237 E6.201673
G3 X37.33381 Y210.27237 I-84.27237 J-90.66619 E6.201673
G3 X43.72763 Y35.33381 I90.66619 J-84.27237 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 2.800
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 14/20
M73 L14
M991 S0 P13
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.64569 Y183.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X226.88131 Y181.08120 I-1.91880 J-0.15441 E0.100304
G2 X224.80810 Y182.84559 I-0.15441 J1.91880 E0.100304
G2 X226.57248 Y184.91880 I1.91880 J0.15441 E0.100304
G2 X228.64569 Y183.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X226.95530 Y177.24066 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X227.38259 Y177.12617 E0.014674
G1 X227.92465 Y177.40236 E0.020181
G1 X226.70012 Y177.73047 E0.042053
G1 X226.44134 Y178.22126 E0.018405
G1 X228.46671 Y177.67856 E0.069555
G1 X229.00877 Y177.95475 E0.020181
G1 X226.17889 Y178.71302 E0.097184
G1 X225.91272 Y179.20578 E0.018578
G1 X229.55084 Y178.23095 E0.124940
G1 X230.09290 Y178.50714 E0.020181
G1 X225.64279 Y179.69954 E0.152826
G1 X225.36904 Y180.19433 E0.018758
G1 X230.63496 Y178.78334 E0.180842
G1 X231.17702 Y179.05953 E0.020181
G1 X225.09141 Y180.69017 E0.208992
G1 X224.80984 Y181.18705 E0.018945
G1 X231.71909 Y179.33573 E0.237277
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X224.82742 Y182.02522 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.88450 Y181.20608 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.26977 Y181.52429 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X224.59302 Y182.93091 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.54034 Y181.87323 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X224.61998 Y183.34512 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.72410 Y182.24543 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X224.72378 Y183.73875 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.83102 Y182.63822 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X224.90426 Y184.11183 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.86126 Y183.05156 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X225.17086 Y184.46183 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.80538 Y183.48797 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X225.55039 Y184.78158 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y182.34205 E0.273231
G1 X235.97107 Y182.83225 E0.018354
G1 X222.05467 Y186.56114 E0.477917
G1 X222.51407 Y186.85948 E0.018171
G1 X235.71117 Y183.32333 E0.453215
G1 X235.44787 Y183.81532 E0.018510
G1 X222.97348 Y187.15782 E0.428396
G1 X223.43289 Y187.45616 E0.018171
G1 X235.18121 Y184.30821 E0.403461
G1 X234.91107 Y184.80203 E0.018672
G1 X223.89229 Y187.75451 E0.378407
G1 X224.35170 Y188.05285 E0.018171
G1 X234.63747 Y185.29678 E0.353234
G1 X234.36031 Y185.79249 E0.018839
G1 X224.81111 Y188.35119 E0.327939
G1 X225.27051 Y188.64953 E0.018171
G1 X234.07957 Y186.28915 E0.302521
G1 X233.79521 Y186.78679 E0.019012
G1 X225.72992 Y188.94787 E0.276978
G1 X226.18933 Y189.24622 E0.018171
G1 X233.50713 Y187.28542 E0.251308
G1 X233.21533 Y187.78504 E0.019193
G1 X226.64873 Y189.54456 E0.225510
G1 X227.10814 Y189.84290 E0.018171
G1 X232.91974 Y188.28569 E0.199582
G1 X232.62028 Y188.78737 E0.019381
G1 X227.56755 Y190.14124 E0.173521
G1 X228.02695 Y190.43959 E0.018171
G1 X232.31693 Y189.29009 E0.147326
G1 X232.00961 Y189.79387 E0.019575
G1 X228.48636 Y190.73793 E0.120996
G1 X228.94577 Y191.03627 E0.018171
G1 X231.69827 Y190.29874 E0.094526
G1 X231.38282 Y190.80470 E0.019779
G1 X229.40517 Y191.33461 E0.067916
G1 X229.86458 Y191.63295 E0.018171
G1 X231.06322 Y191.31178 E0.041164
G1 X230.73941 Y191.81998 E0.019989
G1 X230.32399 Y191.93130 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.91880 Y240.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X128.15441 Y238.08120 I-1.91880 J-0.15441 E0.100304
G2 X126.08120 Y239.84559 I-0.15441 J1.91880 E0.100304
G2 X127.84559 Y241.91880 I1.91880 J0.15441 E0.100304
G2 X129.91880 Y240.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X133.10194 Y237.31813 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.41473 Y237.63093 E0.014674
G1 X133.44657 Y238.23846 E0.020181
G1 X132.55016 Y237.34205 E0.042053
G1 X131.99573 Y237.36333 E0.018405
G1 X133.47841 Y238.84600 E0.069555
G1 X133.51025 Y239.45354 E0.020181
G1 X131.43863 Y237.38192 E0.097184
G1 X130.87881 Y237.39779 E0.018578
G1 X133.54209 Y240.06108 E0.124940
G1 X133.57393 Y240.66861 E0.020181
G1 X130.31623 Y237.41091 E0.152826
G1 X129.75085 Y237.42123 E0.018758
G1 X133.60577 Y241.27615 E0.180842
G1 X133.63761 Y241.88369 E0.020181
G1 X129.18263 Y237.42871 E0.208992
G1 X128.61153 Y237.43331 E0.018945
G1 X133.66945 Y242.49123 E0.237277
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X127.89444 Y237.86761 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X130.13239 Y240.10556 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X130.04944 Y240.59831 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X126.99289 Y238.11746 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.88254 Y241.00711 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X126.64766 Y238.34792 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.65208 Y241.35234 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X126.35867 Y238.63463 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.36537 Y241.64133 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X126.12581 Y238.97746 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.02254 Y241.87419 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X125.95600 Y239.38335 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X128.61665 Y242.04400 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X125.86885 Y239.87191 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y247.89895 E0.273231
G1 X132.76736 Y247.92181 E0.018354
G1 X122.57985 Y237.73430 E0.477917
G1 X122.55118 Y238.28133 E0.018171
G1 X132.21213 Y247.94227 E0.453215
G1 X131.65440 Y247.96025 E0.018510
G1 X122.52251 Y238.82836 E0.428396
G1 X122.49384 Y239.37539 E0.018171
G1 X131.09422 Y247.97576 E0.403461
G1 X130.53148 Y247.98872 E0.018672
G1 X122.46518 Y239.92242 E0.378407
G1 X122.43651 Y240.46944 E0.018171
G1 X129.96621 Y247.99915 E0.353234
G1 X129.39834 Y248.00697 E0.018839
G1 X122.40784 Y241.01647 E0.327939
G1 X122.37917 Y241.56350 E0.018171
G1 X128.82785 Y248.01218 E0.302521
G1 X128.25470 Y248.01473 E0.019012
G1 X122.35050 Y242.11053 E0.276978
G1 X122.32183 Y242.65756 E0.018171
G1 X127.67884 Y248.01456 E0.251308
G1 X127.10025 Y248.01167 E0.019193
G1 X122.29316 Y243.20459 E0.225510
G1 X122.26450 Y243.75162 E0.018171
G1 X126.51888 Y248.00601 E0.199582
G1 X125.93469 Y247.99750 E0.019381
G1 X122.23583 Y244.29865 E0.173521
G1 X122.20716 Y244.84568 E0.018171
G1 X125.34764 Y247.98615 E0.147326
G1 X124.75769 Y247.97191 E0.019575
G1 X122.17849 Y245.39270 E0.120996
G1 X122.14982 Y245.93973 E0.018171
G1 X124.16479 Y247.95471 E0.094526
G1 X123.56889 Y247.93450 E0.019779
G1 X122.12115 Y246.48676 E0.067916
G1 X122.09248 Y247.03379 E0.018171
G1 X122.96995 Y247.91126 E0.041164
G1 X122.36793 Y247.88493 E0.019989
G1 X122.06382 Y247.58082 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.19190 Y183.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X29.42752 Y181.08120 I-1.91880 J-0.15441 E0.100304
G2 X27.35431 Y182.84559 I-0.15441 J1.91880 E0.100304
G2 X29.11869 Y184.91880 I1.91880 J0.15441 E0.100304
G2 X31.19190 Y183.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X34.14664 Y186.07747 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X34.03215 Y186.50476 E0.014674
G1 X33.52192 Y186.83610 E0.020181
G1 X33.85003 Y185.61158 E0.042053
G1 X33.55440 Y185.14207 E0.018405
G1 X33.01170 Y187.16744 E0.069555
G1 X32.50148 Y187.49879 E0.020181
G1 X33.25974 Y184.66890 E0.097184
G1 X32.96608 Y184.19202 E0.018578
G1 X31.99126 Y187.83013 E0.124940
G1 X31.48103 Y188.16147 E0.020181
G1 X32.67343 Y183.71137 E0.152826
G1 X32.38181 Y183.22690 E0.018758
G1 X30.97081 Y188.49281 E0.180842
G1 X30.46059 Y188.82416 E0.020181
G1 X32.09122 Y182.73854 E0.208992
G1 X31.80169 Y182.24626 E0.018945
G1 X29.95036 Y189.15550 E0.237277
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.06703 Y181.84239 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X30.24788 Y184.89948 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X29.77967 Y185.07402 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X30.39988 Y181.18655 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X29.34219 Y185.13388 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X30.02768 Y181.00280 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.92798 Y185.10691 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X29.63488 Y180.89588 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.53435 Y185.00311 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X29.22155 Y180.86563 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.16127 Y184.82264 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.78513 Y180.92152 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.81127 Y184.55603 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.31846 Y181.09033 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y191.55690 E0.273231
G1 X24.79629 Y191.08957 E0.018354
G1 X28.52518 Y177.17316 E0.477917
G1 X28.03711 Y177.42185 E0.018171
G1 X24.50096 Y190.61894 E0.453215
G1 X24.20653 Y190.14493 E0.018510
G1 X27.54903 Y177.67054 E0.428396
G1 X27.06096 Y177.91922 E0.018171
G1 X23.91300 Y189.66755 E0.403461
G1 X23.62041 Y189.18669 E0.018672
G1 X26.57288 Y178.16791 E0.378407
G1 X26.08481 Y178.41660 E0.018171
G1 X23.32874 Y188.70236 E0.353234
G1 X23.03803 Y188.21449 E0.018839
G1 X25.59673 Y178.66528 E0.327939
G1 X25.10866 Y178.91397 E0.018171
G1 X22.74828 Y187.72302 E0.302521
G1 X22.45949 Y187.22794 E0.019012
G1 X24.62058 Y179.16266 E0.276978
G1 X24.13251 Y179.41134 E0.018171
G1 X22.17171 Y186.72914 E0.251308
G1 X21.88492 Y186.22663 E0.019193
G1 X23.64443 Y179.66003 E0.225510
G1 X23.15636 Y179.90872 E0.018171
G1 X21.59914 Y185.72032 E0.199582
G1 X21.31440 Y185.21014 E0.019381
G1 X22.66828 Y180.15740 E0.173521
G1 X22.18021 Y180.40609 E0.018171
G1 X21.03071 Y184.69606 E0.147326
G1 X20.74808 Y184.17803 E0.019575
G1 X21.69213 Y180.65478 E0.120996
G1 X21.20405 Y180.90346 E0.018171
G1 X20.46652 Y183.65597 E0.094526
G1 X20.18607 Y183.12980 E0.019779
G1 X20.71598 Y181.15215 E0.067916
G1 X20.22790 Y181.40084 E0.018171
G1 X19.90673 Y182.59948 E0.041164
G1 X19.62852 Y182.06495 E0.019989
G1 X19.73983 Y181.64952 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.19190 Y69.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X29.42752 Y67.08120 I-1.91880 J-0.15441 E0.100304
G2 X27.35431 Y68.84559 I-0.15441 J1.91880 E0.100304
G2 X29.11869 Y70.91880 I1.91880 J0.15441 E0.100304
G2 X31.19190 Y69.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X29.04470 Y74.75934 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X28.61741 Y74.87383 E0.014674
G1 X28.07535 Y74.59764 E0.020181
G1 X29.29988 Y74.26953 E0.042053
G1 X29.55866 Y73.77874 E0.018405
G1 X27.53329 Y74.32144 E0.069555
G1 X26.99123 Y74.04525 E0.020181
G1 X29.82111 Y73.28698 E0.097184
G1 X30.08728 Y72.79422 E0.018578
G1 X26.44916 Y73.76905 E0.124940
G1 X25.90710 Y73.49286 E0.020181
G1 X30.35721 Y72.30046 E0.152826
G1 X30.63096 Y71.80567 E0.018758
G1 X25.36504 Y73.21666 E0.180842
G1 X24.82298 Y72.94047 E0.020181
G1 X30.90859 Y71.30983 E0.208992
G1 X31.19016 Y70.81295 E0.018945
G1 X24.28091 Y72.66427 E0.237277
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.17258 Y69.97478 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.11550 Y70.79392 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.73023 Y70.47571 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.40698 Y69.06909 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.45966 Y70.12677 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.38002 Y68.65488 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.27590 Y69.75457 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.27622 Y68.26125 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.16898 Y69.36178 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.09574 Y67.88817 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.13874 Y68.94844 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X30.82914 Y67.53817 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.19462 Y68.51203 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X30.44961 Y67.21842 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y69.65795 E0.273231
G1 X20.02893 Y69.16775 E0.018354
G1 X33.94533 Y65.43886 E0.477917
G1 X33.48593 Y65.14052 E0.018171
G1 X20.28883 Y68.67667 E0.453215
G1 X20.55213 Y68.18468 E0.018510
G1 X33.02652 Y64.84218 E0.428396
G1 X32.56711 Y64.54384 E0.018171
G1 X20.81879 Y67.69179 E0.403461
G1 X21.08893 Y67.19797 E0.018672
G1 X32.10771 Y64.24549 E0.378407
G1 X31.64830 Y63.94715 E0.018171
G1 X21.36253 Y66.70322 E0.353234
G1 X21.63969 Y66.20751 E0.018839
G1 X31.18889 Y63.64881 E0.327939
G1 X30.72949 Y63.35047 E0.018171
G1 X21.92043 Y65.71085 E0.302521
G1 X22.20479 Y65.21321 E0.019012
G1 X30.27008 Y63.05213 E0.276978
G1 X29.81067 Y62.75378 E0.018171
G1 X22.49287 Y64.71458 E0.251308
G1 X22.78467 Y64.21496 E0.019193
G1 X29.35127 Y62.45544 E0.225510
G1 X28.89186 Y62.15710 E0.018171
G1 X23.08026 Y63.71431 E0.199582
G1 X23.37972 Y63.21263 E0.019381
G1 X28.43245 Y61.85876 E0.173521
G1 X27.97305 Y61.56041 E0.018171
G1 X23.68307 Y62.70991 E0.147326
G1 X23.99039 Y62.20613 E0.019575
G1 X27.51364 Y61.26207 E0.120996
G1 X27.05423 Y60.96373 E0.018171
G1 X24.30173 Y61.70126 E0.094526
G1 X24.61718 Y61.19530 E0.019779
G1 X26.59483 Y60.66539 E0.067916
G1 X26.13542 Y60.36705 E0.018171
G1 X24.93678 Y60.68822 E0.041164
G1 X25.26059 Y60.18002 E0.019989
G1 X25.67601 Y60.06870 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.91880 Y12.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X128.15441 Y10.08120 I-1.91880 J-0.15441 E0.100304
G2 X126.08120 Y11.84559 I-0.15441 J1.91880 E0.100304
G2 X127.84559 Y13.91880 I1.91880 J0.15441 E0.100304
G2 X129.91880 Y12.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X122.89806 Y14.68187 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.58527 Y14.36907 E0.014674
G1 X122.55343 Y13.76154 E0.020181
G1 X123.44984 Y14.65795 E0.042053
G1 X124.00427 Y14.63667 E0.018405
G1 X122.52159 Y13.15400 E0.069555
G1 X122.48975 Y12.54646 E0.020181
G1 X124.56137 Y14.61808 E0.097184
G1 X125.12119 Y14.60221 E0.018578
G1 X122.45791 Y11.93892 E0.124940
G1 X122.42607 Y11.33139 E0.020181
G1 X125.68377 Y14.58909 E0.152826
G1 X126.24915 Y14.57877 E0.018758
G1 X122.39423 Y10.72385 E0.180842
G1 X122.36239 Y10.11631 E0.020181
G1 X126.81737 Y14.57129 E0.208992
G1 X127.38847 Y14.56669 E0.018945
G1 X122.33055 Y9.50877 E0.237277
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X128.10556 Y14.13239 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X125.86761 Y11.89444 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X125.95056 Y11.40169 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.00711 Y13.88254 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X126.11746 Y10.99289 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.35234 Y13.65208 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X126.34792 Y10.64766 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.64133 Y13.36537 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X126.63463 Y10.35867 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.87419 Y13.02254 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X126.97746 Y10.12581 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X130.04400 Y12.61665 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X127.38335 Y9.95600 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X130.13115 Y12.12809 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y4.10105 E0.273231
G1 X123.23264 Y4.07819 E0.018354
G1 X133.42015 Y14.26570 E0.477917
G1 X133.44882 Y13.71867 E0.018171
G1 X123.78787 Y4.05773 E0.453215
G1 X124.34560 Y4.03975 E0.018510
G1 X133.47749 Y13.17164 E0.428396
G1 X133.50616 Y12.62461 E0.018171
G1 X124.90578 Y4.02424 E0.403461
G1 X125.46852 Y4.01128 E0.018672
G1 X133.53482 Y12.07758 E0.378407
G1 X133.56349 Y11.53056 E0.018171
G1 X126.03379 Y4.00085 E0.353234
G1 X126.60166 Y3.99303 E0.018839
G1 X133.59216 Y10.98353 E0.327939
G1 X133.62083 Y10.43650 E0.018171
G1 X127.17215 Y3.98782 E0.302521
G1 X127.74530 Y3.98527 E0.019012
G1 X133.64950 Y9.88947 E0.276978
G1 X133.67817 Y9.34244 E0.018171
G1 X128.32116 Y3.98544 E0.251308
G1 X128.89975 Y3.98833 E0.019193
G1 X133.70684 Y8.79541 E0.225510
G1 X133.73550 Y8.24838 E0.018171
G1 X129.48112 Y3.99399 E0.199582
G1 X130.06531 Y4.00250 E0.019381
G1 X133.76417 Y7.70135 E0.173521
G1 X133.79284 Y7.15432 E0.018171
G1 X130.65236 Y4.01385 E0.147326
G1 X131.24231 Y4.02809 E0.019575
G1 X133.82151 Y6.60730 E0.120996
G1 X133.85018 Y6.06027 E0.018171
G1 X131.83521 Y4.04529 E0.094526
G1 X132.43111 Y4.06550 E0.019779
G1 X133.87885 Y5.51324 E0.067916
G1 X133.90752 Y4.96621 E0.018171
G1 X133.03005 Y4.08874 E0.041164
G1 X133.63207 Y4.11507 E0.019989
G1 X133.93618 Y4.41918 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.64569 Y69.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X226.88131 Y67.08120 I-1.91880 J-0.15441 E0.100304
G2 X224.80810 Y68.84559 I-0.15441 J1.91880 E0.100304
G2 X226.57248 Y70.91880 I1.91880 J0.15441 E0.100304
G2 X228.64569 Y69.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X221.85336 Y65.92253 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X221.96785 Y65.49524 E0.014674
G1 X222.47808 Y65.16390 E0.020181
G1 X222.14997 Y66.38842 E0.042053
G1 X222.44560 Y66.85793 E0.018405
G1 X222.98830 Y64.83256 E0.069555
G1 X223.49852 Y64.50121 E0.020181
G1 X222.74026 Y67.33110 E0.097184
G1 X223.03392 Y67.80798 E0.018578
G1 X224.00874 Y64.16987 E0.124940
G1 X224.51897 Y63.83853 E0.020181
G1 X223.32657 Y68.28863 E0.152826
G1 X223.61819 Y68.77310 E0.018758
G1 X225.02919 Y63.50719 E0.180842
G1 X225.53941 Y63.17584 E0.020181
G1 X223.90878 Y69.26146 E0.208992
G1 X224.19831 Y69.75374 E0.018945
G1 X226.04964 Y62.84450 E0.237277
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X224.93297 Y70.15761 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X225.75212 Y67.10052 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X226.22033 Y66.92598 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X225.60012 Y70.81345 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X226.65781 Y66.86612 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X225.97232 Y70.99720 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.07202 Y66.89309 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X226.36512 Y71.10412 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.46565 Y66.99689 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X226.77845 Y71.13437 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.83873 Y67.17736 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.21487 Y71.07848 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.18873 Y67.44397 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.68154 Y70.90967 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y60.44310 E0.273231
G1 X231.20371 Y60.91043 E0.018354
G1 X227.47482 Y74.82684 E0.477917
G1 X227.96289 Y74.57815 E0.018171
G1 X231.49904 Y61.38106 E0.453215
G1 X231.79347 Y61.85507 E0.018510
G1 X228.45097 Y74.32946 E0.428396
G1 X228.93904 Y74.08078 E0.018171
G1 X232.08700 Y62.33245 E0.403461
G1 X232.37959 Y62.81331 E0.018672
G1 X229.42712 Y73.83209 E0.378407
G1 X229.91519 Y73.58340 E0.018171
G1 X232.67126 Y63.29764 E0.353234
G1 X232.96197 Y63.78551 E0.018839
G1 X230.40327 Y73.33472 E0.327939
G1 X230.89134 Y73.08603 E0.018171
G1 X233.25172 Y64.27698 E0.302521
G1 X233.54051 Y64.77206 E0.019012
G1 X231.37942 Y72.83734 E0.276978
G1 X231.86749 Y72.58866 E0.018171
G1 X233.82829 Y65.27086 E0.251308
G1 X234.11508 Y65.77337 E0.019193
G1 X232.35557 Y72.33997 E0.225510
G1 X232.84364 Y72.09128 E0.018171
G1 X234.40086 Y66.27968 E0.199582
G1 X234.68560 Y66.78986 E0.019381
G1 X233.33172 Y71.84260 E0.173521
G1 X233.81979 Y71.59391 E0.018171
G1 X234.96929 Y67.30394 E0.147326
G1 X235.25192 Y67.82197 E0.019575
G1 X234.30787 Y71.34522 E0.120996
G1 X234.79595 Y71.09654 E0.018171
G1 X235.53348 Y68.34403 E0.094526
G1 X235.81393 Y68.87020 E0.019779
G1 X235.28402 Y70.84785 E0.067916
G1 X235.77210 Y70.59916 E0.018171
G1 X236.09327 Y69.40052 E0.041164
G1 X236.37148 Y69.93505 E0.019989
G1 X236.26017 Y70.35048 E0.014266
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X249.82333 Y135.80367 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X118.19633 Y247.82333 I-121.82333 J-9.80367 E6.123232
G3 X6.17667 Y116.19633 I9.80367 J-121.82333 E6.123232
G3 X137.80367 Y4.17667 I121.82333 J9.80367 E6.123232
G3 X249.82333 Y135.80367 I-9.80367 J121.82333 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X250.21349 Y135.83506 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X118.16494 Y248.21349 I-122.21349 J-9.83506 E6.142842
G3 X5.78651 Y116.16494 I9.83506 J-122.21349 E6.142842
G3 X137.83506 Y3.78651 I122.21349 J9.83506 E6.142842
G3 X250.21349 Y135.83506 I-9.83506 J122.21349 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X250.60364 Y135.86646 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X118.13354 Y248.60364 I-122.60364 J-9.86646 E6.162452
G3 X5.39636 Y116.13354 I9.86646 J-122.60364 E6.162452
G3 X137.86646 Y3.39636 I122.60364 J9.86646 E6.162452
G3 X250.60364 Y135.86646 I-9.86646 J122.60364 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X250.99380 Y135.89786 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X118.10214 Y248.99380 I-122.99380 J-9.89786 E6.182063
G3 X5.00620 Y116.10214 I9.89786 J-122.99380 E6.182063
G3 X137.89786 Y3.00620 I122.99380 J9.89786 E6.182063
G3 X250.99380 Y135.89786 I-9.89786 J122.99380 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X251.38395 Y135.92926 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X118.07074 Y249.38395 I-123.38395 J-9.92926 E6.201673
G3 X4.61605 Y116.07074 I9.92926 J-123.38395 E6.201673
G3 X137.92926 Y2.61605 I123.38395 J9.92926 E6.201673
G3 X251.38395 Y135.92926 I-9.92926 J123.38395 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 3.000
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 15/20
M73 L15
M991 S0 P14
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.20773 Y184.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X227.90916 Y184.51917 I1.51917 J-1.18227 E0.100304
G2 X228.24606 Y181.81773 I-1.18227 J-1.51917 E0.100304
G2 X225.54463 Y181.48083 I-1.51917 J1.18227 E0.100304
G2 X225.20773 Y184.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X236.26017 Y181.64952 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X236.37148 Y182.06495 E0.014266
G1 X236.09327 Y182.59948 E0.019989
G1 X235.77210 Y181.40084 E0.041164
G1 X235.28402 Y181.15215 E0.018171
G1 X235.81393 Y183.12980 E0.067916
G1 X235.53348 Y183.65597 E0.019779
G1 X234.79595 Y180.90346 E0.094526
G1 X234.30787 Y180.65478 E0.018171
G1 X235.25192 Y184.17803 E0.120996
G1 X234.96929 Y184.69606 E0.019575
G1 X233.81979 Y180.40609 E0.147326
G1 X233.33172 Y180.15740 E0.018171
G1 X234.68560 Y185.21014 E0.173521
G1 X234.40086 Y185.72032 E0.019381
G1 X232.84364 Y179.90872 E0.199582
G1 X232.35557 Y179.66003 E0.018171
G1 X234.11508 Y186.22663 E0.225510
G1 X233.82829 Y186.72914 E0.019193
G1 X231.86749 Y179.41134 E0.251308
G1 X231.37942 Y179.16266 E0.018171
G1 X233.54051 Y187.22794 E0.276978
G1 X233.25172 Y187.72302 E0.019012
G1 X230.89134 Y178.91397 E0.302521
G1 X230.40327 Y178.66528 E0.018171
G1 X232.96197 Y188.21449 E0.327939
G1 X232.67126 Y188.70236 E0.018839
G1 X229.91519 Y178.41660 E0.353234
G1 X229.42712 Y178.16791 E0.018171
G1 X232.37959 Y189.18669 E0.378407
G1 X232.08700 Y189.66755 E0.018672
G1 X228.93904 Y177.91922 E0.403461
G1 X228.45097 Y177.67054 E0.018171
G1 X231.79347 Y190.14493 E0.428396
G1 X231.49904 Y190.61894 E0.018510
G1 X227.96289 Y177.42185 E0.453215
G1 X227.47482 Y177.17316 E0.018171
G1 X231.20371 Y191.08957 E0.477917
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y191.55690 E0.273231
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.18873 Y184.55603 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X226.77845 Y180.86563 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.83873 Y184.82264 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X226.36512 Y180.89588 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.46565 Y185.00311 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.97232 Y181.00280 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.07202 Y185.10691 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.60012 Y181.18655 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X226.65781 Y185.13388 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.25118 Y181.45713 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X224.93297 Y181.84239 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.75212 Y184.89948 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.19831 Y182.24626 E0.237277
G1 X223.90878 Y182.73854 E0.018945
G1 X225.53941 Y188.82416 E0.208992
G1 X225.02919 Y188.49281 E0.020181
G1 X223.61819 Y183.22690 E0.180842
G1 X223.32657 Y183.71137 E0.018758
G1 X224.51897 Y188.16147 E0.152826
G1 X224.00874 Y187.83013 E0.020181
G1 X223.03392 Y184.19202 E0.124940
G1 X222.74026 Y184.66890 E0.018578
G1 X223.49852 Y187.49879 E0.097184
G1 X222.98830 Y187.16744 E0.020181
G1 X222.44560 Y185.14207 E0.069555
G1 X222.14997 Y185.61158 E0.018405
G1 X222.47808 Y186.83610 E0.042053
G1 X221.96785 Y186.50476 E0.020181
G1 X221.85336 Y186.07747 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.48083 Y241.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.18227 Y241.51917 I1.51917 J-1.18227 E0.100304
G2 X129.51917 Y238.81773 I-1.18227 J-1.51917 E0.100304
G2 X126.81773 Y238.48083 I-1.51917 J1.18227 E0.100304
G2 X126.48083 Y241.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X133.93618 Y247.58082 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.63207 Y247.88493 E0.014266
G1 X133.03005 Y247.91126 E0.019989
G1 X133.90752 Y247.03379 E0.041164
G1 X133.87885 Y246.48676 E0.018171
G1 X132.43111 Y247.93450 E0.067916
G1 X131.83521 Y247.95471 E0.019779
G1 X133.85018 Y245.93973 E0.094526
G1 X133.82151 Y245.39270 E0.018171
G1 X131.24231 Y247.97191 E0.120996
G1 X130.65236 Y247.98615 E0.019575
G1 X133.79284 Y244.84568 E0.147326
G1 X133.76417 Y244.29865 E0.018171
G1 X130.06531 Y247.99750 E0.173521
G1 X129.48112 Y248.00601 E0.019381
G1 X133.73550 Y243.75162 E0.199582
G1 X133.70684 Y243.20459 E0.018171
G1 X128.89975 Y248.01167 E0.225510
G1 X128.32116 Y248.01456 E0.019193
G1 X133.67817 Y242.65756 E0.251308
G1 X133.64950 Y242.11053 E0.018171
G1 X127.74530 Y248.01473 E0.276978
G1 X127.17215 Y248.01218 E0.019012
G1 X133.62083 Y241.56350 E0.302521
G1 X133.59216 Y241.01647 E0.018171
G1 X126.60166 Y248.00697 E0.327939
G1 X126.03379 Y247.99915 E0.018839
G1 X133.56349 Y240.46944 E0.353234
G1 X133.53482 Y239.92242 E0.018171
G1 X125.46852 Y247.98872 E0.378407
G1 X124.90578 Y247.97576 E0.018672
G1 X133.50616 Y239.37539 E0.403461
G1 X133.47749 Y238.82836 E0.018171
G1 X124.34560 Y247.96025 E0.428396
G1 X123.78787 Y247.94227 E0.018510
G1 X133.44882 Y238.28133 E0.453215
G1 X133.42015 Y237.73430 E0.018171
G1 X123.23264 Y247.92181 E0.477917
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y247.89895 E0.273231
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X127.38335 Y242.04400 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X129.87419 Y238.97746 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.97746 Y241.87419 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X129.64133 Y238.63463 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.63463 Y241.64133 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X129.35234 Y238.34792 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.34792 Y241.35234 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X129.00711 Y238.11746 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.11746 Y241.00711 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X128.59831 Y237.95056 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X128.10556 Y237.86761 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X125.86761 Y240.10556 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X127.38847 Y237.43331 E0.237277
G1 X126.81737 Y237.42871 E0.018945
G1 X122.36239 Y241.88369 E0.208992
G1 X122.39423 Y241.27615 E0.020181
G1 X126.24915 Y237.42123 E0.180842
G1 X125.68377 Y237.41091 E0.018758
G1 X122.42607 Y240.66861 E0.152826
G1 X122.45791 Y240.06108 E0.020181
G1 X125.12119 Y237.39779 E0.124940
G1 X124.56137 Y237.38192 E0.018578
G1 X122.48975 Y239.45354 E0.097184
G1 X122.52159 Y238.84600 E0.020181
G1 X124.00427 Y237.36333 E0.069555
G1 X123.44984 Y237.34205 E0.018405
G1 X122.55343 Y238.23846 E0.042053
G1 X122.58527 Y237.63093 E0.020181
G1 X122.89806 Y237.31813 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.75394 Y184.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X30.45537 Y184.51917 I1.51917 J-1.18227 E0.100304
G2 X30.79227 Y181.81773 I-1.18227 J-1.51917 E0.100304
G2 X28.09084 Y181.48083 I-1.51917 J1.18227 E0.100304
G2 X27.75394 Y184.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X25.67601 Y191.93130 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X25.26059 Y191.81998 E0.014266
G1 X24.93678 Y191.31178 E0.019989
G1 X26.13542 Y191.63295 E0.041164
G1 X26.59483 Y191.33461 E0.018171
G1 X24.61718 Y190.80470 E0.067916
G1 X24.30173 Y190.29874 E0.019779
G1 X27.05423 Y191.03627 E0.094526
G1 X27.51364 Y190.73793 E0.018171
G1 X23.99039 Y189.79387 E0.120996
G1 X23.68307 Y189.29009 E0.019575
G1 X27.97305 Y190.43959 E0.147326
G1 X28.43245 Y190.14124 E0.018171
G1 X23.37972 Y188.78737 E0.173521
G1 X23.08026 Y188.28569 E0.019381
G1 X28.89186 Y189.84290 E0.199582
G1 X29.35127 Y189.54456 E0.018171
G1 X22.78467 Y187.78504 E0.225510
G1 X22.49287 Y187.28542 E0.019193
G1 X29.81067 Y189.24622 E0.251308
G1 X30.27008 Y188.94787 E0.018171
G1 X22.20479 Y186.78679 E0.276978
G1 X21.92043 Y186.28915 E0.019012
G1 X30.72949 Y188.64953 E0.302521
G1 X31.18889 Y188.35119 E0.018171
G1 X21.63969 Y185.79249 E0.327939
G1 X21.36253 Y185.29678 E0.018839
G1 X31.64830 Y188.05285 E0.353234
G1 X32.10771 Y187.75451 E0.018171
G1 X21.08893 Y184.80203 E0.378407
G1 X20.81879 Y184.30821 E0.018672
G1 X32.56711 Y187.45616 E0.403461
G1 X33.02652 Y187.15782 E0.018171
G1 X20.55213 Y183.81532 E0.428396
G1 X20.28883 Y183.32333 E0.018510
G1 X33.48593 Y186.85948 E0.453215
G1 X33.94533 Y186.56114 E0.018171
G1 X20.02893 Y182.83225 E0.477917
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y182.34205 E0.273231
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.19462 Y183.48797 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X31.09574 Y184.11183 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.13874 Y183.05156 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X31.27622 Y183.73875 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.16898 Y182.63822 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X31.38002 Y183.34512 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.27590 Y182.24543 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X31.40698 Y182.93091 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.45966 Y181.87323 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X31.34713 Y182.49343 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X31.17258 Y182.02522 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.11550 Y181.20608 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X31.19016 Y181.18705 E0.237277
G1 X30.90859 Y180.69017 E0.018945
G1 X24.82298 Y179.05953 E0.208992
G1 X25.36504 Y178.78334 E0.020181
G1 X30.63096 Y180.19433 E0.180842
G1 X30.35721 Y179.69954 E0.018758
G1 X25.90710 Y178.50714 E0.152826
G1 X26.44916 Y178.23095 E0.020181
G1 X30.08728 Y179.20578 E0.124940
G1 X29.82111 Y178.71302 E0.018578
G1 X26.99123 Y177.95475 E0.097184
G1 X27.53329 Y177.67856 E0.020181
G1 X29.55866 Y178.22126 E0.069555
G1 X29.29988 Y177.73047 E0.018405
G1 X28.07535 Y177.40236 E0.042053
G1 X28.61741 Y177.12617 E0.020181
G1 X29.04470 Y177.24066 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.75394 Y70.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X30.45537 Y70.51917 I1.51917 J-1.18227 E0.100304
G2 X30.79227 Y67.81773 I-1.18227 J-1.51917 E0.100304
G2 X28.09084 Y67.48083 I-1.51917 J1.18227 E0.100304
G2 X27.75394 Y70.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X19.73983 Y70.35048 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X19.62852 Y69.93505 E0.014266
G1 X19.90673 Y69.40052 E0.019989
G1 X20.22790 Y70.59916 E0.041164
G1 X20.71598 Y70.84785 E0.018171
G1 X20.18607 Y68.87020 E0.067916
G1 X20.46652 Y68.34403 E0.019779
G1 X21.20405 Y71.09654 E0.094526
G1 X21.69213 Y71.34522 E0.018171
G1 X20.74808 Y67.82197 E0.120996
G1 X21.03071 Y67.30394 E0.019575
G1 X22.18021 Y71.59391 E0.147326
G1 X22.66828 Y71.84260 E0.018171
G1 X21.31440 Y66.78986 E0.173521
G1 X21.59914 Y66.27968 E0.019381
G1 X23.15636 Y72.09128 E0.199582
G1 X23.64443 Y72.33997 E0.018171
G1 X21.88492 Y65.77337 E0.225510
G1 X22.17171 Y65.27086 E0.019193
G1 X24.13251 Y72.58866 E0.251308
G1 X24.62058 Y72.83734 E0.018171
G1 X22.45949 Y64.77206 E0.276978
G1 X22.74828 Y64.27698 E0.019012
G1 X25.10866 Y73.08603 E0.302521
G1 X25.59673 Y73.33472 E0.018171
G1 X23.03803 Y63.78551 E0.327939
G1 X23.32874 Y63.29764 E0.018839
G1 X26.08481 Y73.58340 E0.353234
G1 X26.57288 Y73.83209 E0.018171
G1 X23.62041 Y62.81331 E0.378407
G1 X23.91300 Y62.33245 E0.018672
G1 X27.06096 Y74.08078 E0.403461
G1 X27.54903 Y74.32946 E0.018171
G1 X24.20653 Y61.85507 E0.428396
G1 X24.50096 Y61.38106 E0.018510
G1 X28.03711 Y74.57815 E0.453215
G1 X28.52518 Y74.82684 E0.018171
G1 X24.79629 Y60.91043 E0.477917
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y60.44310 E0.273231
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.81127 Y67.44397 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X29.22155 Y71.13437 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.16127 Y67.17736 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X29.63488 Y71.10412 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.53435 Y66.99689 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.02768 Y70.99720 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.92798 Y66.89309 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.39988 Y70.81345 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X29.34219 Y66.86612 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.74882 Y70.54287 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X31.06703 Y70.15761 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.24788 Y67.10052 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.80169 Y69.75374 E0.237277
G1 X32.09122 Y69.26146 E0.018945
G1 X30.46059 Y63.17584 E0.208992
G1 X30.97081 Y63.50719 E0.020181
G1 X32.38181 Y68.77310 E0.180842
G1 X32.67343 Y68.28863 E0.018758
G1 X31.48103 Y63.83853 E0.152826
G1 X31.99126 Y64.16987 E0.020181
G1 X32.96608 Y67.80798 E0.124940
G1 X33.25974 Y67.33110 E0.018578
G1 X32.50148 Y64.50121 E0.097184
G1 X33.01170 Y64.83256 E0.020181
G1 X33.55440 Y66.85793 E0.069555
G1 X33.85003 Y66.38842 E0.018405
G1 X33.52192 Y65.16390 E0.042053
G1 X34.03215 Y65.49524 E0.020181
G1 X34.14664 Y65.92253 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.48083 Y13.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.18227 Y13.51917 I1.51917 J-1.18227 E0.100304
G2 X129.51917 Y10.81773 I-1.18227 J-1.51917 E0.100304
G2 X126.81773 Y10.48083 I-1.51917 J1.18227 E0.100304
G2 X126.48083 Y13.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X122.06382 Y4.41918 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.36793 Y4.11507 E0.014266
G1 X122.96995 Y4.08874 E0.019989
G1 X122.09248 Y4.96621 E0.041164
G1 X122.12115 Y5.51324 E0.018171
G1 X123.56889 Y4.06550 E0.067916
G1 X124.16479 Y4.04529 E0.019779
G1 X122.14982 Y6.06027 E0.094526
G1 X122.17849 Y6.60730 E0.018171
G1 X124.75769 Y4.02809 E0.120996
G1 X125.34764 Y4.01385 E0.019575
G1 X122.20716 Y7.15432 E0.147326
G1 X122.23583 Y7.70135 E0.018171
G1 X125.93469 Y4.00250 E0.173521
G1 X126.51888 Y3.99399 E0.019381
G1 X122.26450 Y8.24838 E0.199582
G1 X122.29316 Y8.79541 E0.018171
G1 X127.10025 Y3.98833 E0.225510
G1 X127.67884 Y3.98544 E0.019193
G1 X122.32183 Y9.34244 E0.251308
G1 X122.35050 Y9.88947 E0.018171
G1 X128.25470 Y3.98527 E0.276978
G1 X128.82785 Y3.98782 E0.019012
G1 X122.37917 Y10.43650 E0.302521
G1 X122.40784 Y10.98353 E0.018171
G1 X129.39834 Y3.99303 E0.327939
G1 X129.96621 Y4.00085 E0.018839
G1 X122.43651 Y11.53056 E0.353234
G1 X122.46518 Y12.07758 E0.018171
G1 X130.53148 Y4.01128 E0.378407
G1 X131.09422 Y4.02424 E0.018672
G1 X122.49384 Y12.62461 E0.403461
G1 X122.52251 Y13.17164 E0.018171
G1 X131.65440 Y4.03975 E0.428396
G1 X132.21213 Y4.05773 E0.018510
G1 X122.55118 Y13.71867 E0.453215
G1 X122.57985 Y14.26570 E0.018171
G1 X132.76736 Y4.07819 E0.477917
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y4.10105 E0.273231
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X128.61665 Y9.95600 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.12581 Y13.02254 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X129.02254 Y10.12581 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.35867 Y13.36537 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X129.36537 Y10.35867 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.64766 Y13.65208 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X129.65208 Y10.64766 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.99289 Y13.88254 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X129.88254 Y10.99289 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X127.40169 Y14.04944 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X127.89444 Y14.13239 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X130.13239 Y11.89444 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X128.61153 Y14.56669 E0.237277
G1 X129.18263 Y14.57129 E0.018945
G1 X133.63761 Y10.11631 E0.208992
G1 X133.60577 Y10.72385 E0.020181
G1 X129.75085 Y14.57877 E0.180842
G1 X130.31623 Y14.58909 E0.018758
G1 X133.57393 Y11.33139 E0.152826
G1 X133.54209 Y11.93892 E0.020181
G1 X130.87881 Y14.60221 E0.124940
G1 X131.43863 Y14.61808 E0.018578
G1 X133.51025 Y12.54646 E0.097184
G1 X133.47841 Y13.15400 E0.020181
G1 X131.99573 Y14.63667 E0.069555
G1 X132.55016 Y14.65795 E0.018405
G1 X133.44657 Y13.76154 E0.042053
G1 X133.41473 Y14.36907 E0.020181
G1 X133.10194 Y14.68187 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.20773 Y70.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X227.90916 Y70.51917 I1.51917 J-1.18227 E0.100304
G2 X228.24606 Y67.81773 I-1.18227 J-1.51917 E0.100304
G2 X225.54463 Y67.48083 I-1.51917 J1.18227 E0.100304
G2 X225.20773 Y70.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X230.32399 Y60.06870 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X230.73941 Y60.18002 E0.014266
G1 X231.06322 Y60.68822 E0.019989
G1 X229.86458 Y60.36705 E0.041164
G1 X229.40517 Y60.66539 E0.018171
G1 X231.38282 Y61.19530 E0.067916
G1 X231.69827 Y61.70126 E0.019779
G1 X228.94577 Y60.96373 E0.094526
G1 X228.48636 Y61.26207 E0.018171
G1 X232.00961 Y62.20613 E0.120996
G1 X232.31693 Y62.70991 E0.019575
G1 X228.02695 Y61.56041 E0.147326
G1 X227.56755 Y61.85876 E0.018171
G1 X232.62028 Y63.21263 E0.173521
G1 X232.91974 Y63.71431 E0.019381
G1 X227.10814 Y62.15710 E0.199582
G1 X226.64873 Y62.45544 E0.018171
G1 X233.21533 Y64.21496 E0.225510
G1 X233.50713 Y64.71458 E0.019193
G1 X226.18933 Y62.75378 E0.251308
G1 X225.72992 Y63.05213 E0.018171
G1 X233.79521 Y65.21321 E0.276978
G1 X234.07957 Y65.71085 E0.019012
G1 X225.27051 Y63.35047 E0.302521
G1 X224.81111 Y63.64881 E0.018171
G1 X234.36031 Y66.20751 E0.327939
G1 X234.63747 Y66.70322 E0.018839
G1 X224.35170 Y63.94715 E0.353234
G1 X223.89229 Y64.24549 E0.018171
G1 X234.91107 Y67.19797 E0.378407
G1 X235.18121 Y67.69179 E0.018672
G1 X223.43289 Y64.54384 E0.403461
G1 X222.97348 Y64.84218 E0.018171
G1 X235.44787 Y68.18468 E0.428396
G1 X235.71117 Y68.67667 E0.018510
G1 X222.51407 Y65.14052 E0.453215
G1 X222.05467 Y65.43886 E0.018171
G1 X235.97107 Y69.16775 E0.477917
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y69.65795 E0.273231
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.80538 Y68.51203 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X224.90426 Y67.88817 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.86126 Y68.94844 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X224.72378 Y68.26125 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.83102 Y69.36178 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X224.61998 Y68.65488 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.72410 Y69.75457 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X224.59302 Y69.06909 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.54034 Y70.12677 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X224.65287 Y69.50657 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X224.82742 Y69.97478 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.88450 Y70.79392 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X224.80984 Y70.81295 E0.237277
G1 X225.09141 Y71.30983 E0.018945
G1 X231.17702 Y72.94047 E0.208992
G1 X230.63496 Y73.21666 E0.020181
G1 X225.36904 Y71.80567 E0.180842
G1 X225.64279 Y72.30046 E0.018758
G1 X230.09290 Y73.49286 E0.152826
G1 X229.55084 Y73.76905 E0.020181
G1 X225.91272 Y72.79422 E0.124940
G1 X226.17889 Y73.28698 E0.018578
G1 X229.00877 Y74.04525 E0.097184
G1 X228.46671 Y74.32144 E0.020181
G1 X226.44134 Y73.77874 E0.069555
G1 X226.70012 Y74.26953 E0.018405
G1 X227.92465 Y74.59764 E0.042053
G1 X227.38259 Y74.87383 E0.020181
G1 X226.95530 Y74.75934 E0.014674
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X31.54898 Y201.06156 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X52.93844 Y29.54898 I96.45102 J-75.06156 E6.123232
G3 X224.45102 Y50.93844 I75.06156 J96.45102 E6.123232
G3 X203.06156 Y222.45102 I-96.45102 J75.06156 E6.123232
G3 X31.54898 Y201.06156 I-75.06156 J-96.45102 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X31.24009 Y201.30195 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X52.69805 Y29.24009 I96.75991 J-75.30195 E6.142842
G3 X224.75991 Y50.69805 I75.30195 J96.75991 E6.142842
G3 X203.30195 Y222.75991 I-96.75991 J75.30195 E6.142842
G3 X31.24009 Y201.30195 I-75.30195 J-96.75991 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.93119 Y201.54235 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X52.45765 Y28.93119 I97.06881 J-75.54235 E6.162452
G3 X225.06881 Y50.45765 I75.54235 J97.06881 E6.162452
G3 X203.54235 Y223.06881 I-97.06881 J75.54235 E6.162452
G3 X30.93119 Y201.54235 I-75.54235 J-97.06881 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.62229 Y201.78274 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X52.21726 Y28.62229 I97.37771 J-75.78274 E6.182063
G3 X225.37771 Y50.21726 I75.78274 J97.37771 E6.182063
G3 X203.78274 Y223.37771 I-97.37771 J75.78274 E6.182063
G3 X30.62229 Y201.78274 I-75.78274 J-97.37771 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.31340 Y202.02314 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X51.97686 Y28.31340 I97.68660 J-76.02314 E6.201673
G3 X225.68660 Y49.97686 I76.02314 J97.68660 E6.201673
G3 X204.02314 Y223.68660 I-97.68660 J76.02314 E6.201673
G3 X30.31340 Y202.02314 I-76.02314 J-97.68660 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 3.200
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 16/20
M73 L16
M991 S0 P15
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.04847 Y181.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X224.82895 Y182.67842 I-0.32158 J1.89795 E0.100304
G2 X226.40532 Y184.89795 I1.89795 J0.32158 E0.100304
G2 X228.62485 Y183.32158 I0.32158 J-1.89795 E0.100304
G2 X227.04847 Y181.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X226.95530 Y177.24066 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X227.38259 Y177.12617 E0.014674
G1 X227.92465 Y177.40236 E0.020181
G1 X226.70012 Y177.73047 E0.042053
G1 X226.44134 Y178.22126 E0.018405
G1 X228.46671 Y177.67856 E0.069555
G1 X229.00877 Y177.95475 E0.020181
G1 X226.17889 Y178.71302 E0.097184
G1 X225.91272 Y179.20578 E0.018578
G1 X229.55084 Y178.23095 E0.124940
G1 X230.09290 Y178.50714 E0.020181
G1 X225.64279 Y179.69954 E0.152826
G1 X225.36904 Y180.19433 E0.018758
G1 X230.63496 Y178.78334 E0.180842
G1 X231.17702 Y179.05953 E0.020181
G1 X225.09141 Y180.69017 E0.208992
G1 X224.80984 Y181.18705 E0.018945
G1 X231.71909 Y179.33573 E0.237277
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X224.82742 Y182.02522 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.88450 Y181.20608 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.26977 Y181.52429 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X224.59302 Y182.93091 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.54034 Y181.87323 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X224.61998 Y183.34512 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.72410 Y182.24543 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X224.72378 Y183.73875 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.83102 Y182.63822 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X224.90426 Y184.11183 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.86126 Y183.05156 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X225.17086 Y184.46183 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.80538 Y183.48797 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X225.55039 Y184.78158 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y182.34205 E0.273231
G1 X235.97107 Y182.83225 E0.018354
G1 X222.05467 Y186.56114 E0.477917
G1 X222.51407 Y186.85948 E0.018171
G1 X235.71117 Y183.32333 E0.453215
G1 X235.44787 Y183.81532 E0.018510
G1 X222.97348 Y187.15782 E0.428396
G1 X223.43289 Y187.45616 E0.018171
G1 X235.18121 Y184.30821 E0.403461
G1 X234.91107 Y184.80203 E0.018672
G1 X223.89229 Y187.75451 E0.378407
G1 X224.35170 Y188.05285 E0.018171
G1 X234.63747 Y185.29678 E0.353234
G1 X234.36031 Y185.79249 E0.018839
G1 X224.81111 Y188.35119 E0.327939
G1 X225.27051 Y188.64953 E0.018171
G1 X234.07957 Y186.28915 E0.302521
G1 X233.79521 Y186.78679 E0.019012
G1 X225.72992 Y188.94787 E0.276978
G1 X226.18933 Y189.24622 E0.018171
G1 X233.50713 Y187.28542 E0.251308
G1 X233.21533 Y187.78504 E0.019193
G1 X226.64873 Y189.54456 E0.225510
G1 X227.10814 Y189.84290 E0.018171
G1 X232.91974 Y188.28569 E0.199582
G1 X232.62028 Y188.78737 E0.019381
G1 X227.56755 Y190.14124 E0.173521
G1 X228.02695 Y190.43959 E0.018171
G1 X232.31693 Y189.29009 E0.147326
G1 X232.00961 Y189.79387 E0.019575
G1 X228.48636 Y190.73793 E0.120996
G1 X228.94577 Y191.03627 E0.018171
G1 X231.69827 Y190.29874 E0.094526
G1 X231.38282 Y190.80470 E0.019779
G1 X229.40517 Y191.33461 E0.067916
G1 X229.86458 Y191.63295 E0.018171
G1 X231.06322 Y191.31178 E0.041164
G1 X230.73941 Y191.81998 E0.019989
G1 X230.32399 Y191.93130 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.32158 Y238.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X126.10205 Y239.67842 I-0.32158 J1.89795 E0.100304
G2 X127.67842 Y241.89795 I1.89795 J0.32158 E0.100304
G2 X129.89795 Y240.32158 I0.32158 J-1.89795 E0.100304
G2 X128.32158 Y238.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X133.10194 Y237.31813 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.41473 Y237.63093 E0.014674
G1 X133.44657 Y238.23846 E0.020181
G1 X132.55016 Y237.34205 E0.042053
G1 X131.99573 Y237.36333 E0.018405
G1 X133.47841 Y238.84600 E0.069555
G1 X133.51025 Y239.45354 E0.020181
G1 X131.43863 Y237.38192 E0.097184
G1 X130.87881 Y237.39779 E0.018578
G1 X133.54209 Y240.06108 E0.124940
G1 X133.57393 Y240.66861 E0.020181
G1 X130.31623 Y237.41091 E0.152826
G1 X129.75085 Y237.42123 E0.018758
G1 X133.60577 Y241.27615 E0.180842
G1 X133.63761 Y241.88369 E0.020181
G1 X129.18263 Y237.42871 E0.208992
G1 X128.61153 Y237.43331 E0.018945
G1 X133.66945 Y242.49123 E0.237277
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X127.89444 Y237.86761 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X130.13239 Y240.10556 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X130.04944 Y240.59831 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X126.99289 Y238.11746 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X129.88254 Y241.00711 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X126.64766 Y238.34792 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X129.65208 Y241.35234 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X126.35867 Y238.63463 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X129.36537 Y241.64133 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X126.12581 Y238.97746 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X129.02254 Y241.87419 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X125.95600 Y239.38335 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.61665 Y242.04400 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X125.86885 Y239.87191 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y247.89895 E0.273231
G1 X132.76736 Y247.92181 E0.018354
G1 X122.57985 Y237.73430 E0.477917
G1 X122.55118 Y238.28133 E0.018171
G1 X132.21213 Y247.94227 E0.453215
G1 X131.65440 Y247.96025 E0.018510
G1 X122.52251 Y238.82836 E0.428396
G1 X122.49384 Y239.37539 E0.018171
G1 X131.09422 Y247.97576 E0.403461
G1 X130.53148 Y247.98872 E0.018672
G1 X122.46518 Y239.92242 E0.378407
G1 X122.43651 Y240.46944 E0.018171
G1 X129.96621 Y247.99915 E0.353234
G1 X129.39834 Y248.00697 E0.018839
G1 X122.40784 Y241.01647 E0.327939
G1 X122.37917 Y241.56350 E0.018171
G1 X128.82785 Y248.01218 E0.302521
G1 X128.25470 Y248.01473 E0.019012
G1 X122.35050 Y242.11053 E0.276978
G1 X122.32183 Y242.65756 E0.018171
G1 X127.67884 Y248.01456 E0.251308
G1 X127.10025 Y248.01167 E0.019193
G1 X122.29316 Y243.20459 E0.225510
G1 X122.26450 Y243.75162 E0.018171
G1 X126.51888 Y248.00601 E0.199582
G1 X125.93469 Y247.99750 E0.019381
G1 X122.23583 Y244.29865 E0.173521
G1 X122.20716 Y244.84568 E0.018171
G1 X125.34764 Y247.98615 E0.147326
G1 X124.75769 Y247.97191 E0.019575
G1 X122.17849 Y245.39270 E0.120996
G1 X122.14982 Y245.93973 E0.018171
G1 X124.16479 Y247.95471 E0.094526
G1 X123.56889 Y247.93450 E0.019779
G1 X122.12115 Y246.48676 E0.067916
G1 X122.09248 Y247.03379 E0.018171
G1 X122.96995 Y247.91126 E0.041164
G1 X122.36793 Y247.88493 E0.019989
G1 X122.06382 Y247.58082 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X29.59468 Y181.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X27.37515 Y182.67842 I-0.32158 J1.89795 E0.100304
G2 X28.95153 Y184.89795 I1.89795 J0.32158 E0.100304
G2 X31.17105 Y183.32158 I0.32158 J-1.89795 E0.100304
G2 X29.59468 Y181.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X34.14664 Y186.07747 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X34.03215 Y186.50476 E0.014674
G1 X33.52192 Y186.83610 E0.020181
G1 X33.85003 Y185.61158 E0.042053
G1 X33.55440 Y185.14207 E0.018405
G1 X33.01170 Y187.16744 E0.069555
G1 X32.50148 Y187.49879 E0.020181
G1 X33.25974 Y184.66890 E0.097184
G1 X32.96608 Y184.19202 E0.018578
G1 X31.99126 Y187.83013 E0.124940
G1 X31.48103 Y188.16147 E0.020181
G1 X32.67343 Y183.71137 E0.152826
G1 X32.38181 Y183.22690 E0.018758
G1 X30.97081 Y188.49281 E0.180842
G1 X30.46059 Y188.82416 E0.020181
G1 X32.09122 Y182.73854 E0.208992
G1 X31.80169 Y182.24626 E0.018945
G1 X29.95036 Y189.15550 E0.237277
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X31.06703 Y181.84239 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X30.24788 Y184.89948 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X29.77967 Y185.07402 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X30.39988 Y181.18655 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X29.34219 Y185.13388 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X30.02768 Y181.00280 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.92798 Y185.10691 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X29.63488 Y180.89588 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.53435 Y185.00311 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X29.22155 Y180.86563 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.16127 Y184.82264 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.78513 Y180.92152 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.81127 Y184.55603 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.31846 Y181.09033 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y191.55690 E0.273231
G1 X24.79629 Y191.08957 E0.018354
G1 X28.52518 Y177.17316 E0.477917
G1 X28.03711 Y177.42185 E0.018171
G1 X24.50096 Y190.61894 E0.453215
G1 X24.20653 Y190.14493 E0.018510
G1 X27.54903 Y177.67054 E0.428396
G1 X27.06096 Y177.91922 E0.018171
G1 X23.91300 Y189.66755 E0.403461
G1 X23.62041 Y189.18669 E0.018672
G1 X26.57288 Y178.16791 E0.378407
G1 X26.08481 Y178.41660 E0.018171
G1 X23.32874 Y188.70236 E0.353234
G1 X23.03803 Y188.21449 E0.018839
G1 X25.59673 Y178.66528 E0.327939
G1 X25.10866 Y178.91397 E0.018171
G1 X22.74828 Y187.72302 E0.302521
G1 X22.45949 Y187.22794 E0.019012
G1 X24.62058 Y179.16266 E0.276978
G1 X24.13251 Y179.41134 E0.018171
G1 X22.17171 Y186.72914 E0.251308
G1 X21.88492 Y186.22663 E0.019193
G1 X23.64443 Y179.66003 E0.225510
G1 X23.15636 Y179.90872 E0.018171
G1 X21.59914 Y185.72032 E0.199582
G1 X21.31440 Y185.21014 E0.019381
G1 X22.66828 Y180.15740 E0.173521
G1 X22.18021 Y180.40609 E0.018171
G1 X21.03071 Y184.69606 E0.147326
G1 X20.74808 Y184.17803 E0.019575
G1 X21.69213 Y180.65478 E0.120996
G1 X21.20405 Y180.90346 E0.018171
G1 X20.46652 Y183.65597 E0.094526
G1 X20.18607 Y183.12980 E0.019779
G1 X20.71598 Y181.15215 E0.067916
G1 X20.22790 Y181.40084 E0.018171
G1 X19.90673 Y182.59948 E0.041164
G1 X19.62852 Y182.06495 E0.019989
G1 X19.73983 Y181.64952 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X29.59468 Y67.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X27.37515 Y68.67842 I-0.32158 J1.89795 E0.100304
G2 X28.95153 Y70.89795 I1.89795 J0.32158 E0.100304
G2 X31.17105 Y69.32158 I0.32158 J-1.89795 E0.100304
G2 X29.59468 Y67.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X29.04470 Y74.75934 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X28.61741 Y74.87383 E0.014674
G1 X28.07535 Y74.59764 E0.020181
G1 X29.29988 Y74.26953 E0.042053
G1 X29.55866 Y73.77874 E0.018405
G1 X27.53329 Y74.32144 E0.069555
G1 X26.99123 Y74.04525 E0.020181
G1 X29.82111 Y73.28698 E0.097184
G1 X30.08728 Y72.79422 E0.018578
G1 X26.44916 Y73.76905 E0.124940
G1 X25.90710 Y73.49286 E0.020181
G1 X30.35721 Y72.30046 E0.152826
G1 X30.63096 Y71.80567 E0.018758
G1 X25.36504 Y73.21666 E0.180842
G1 X24.82298 Y72.94047 E0.020181
G1 X30.90859 Y71.30983 E0.208992
G1 X31.19016 Y70.81295 E0.018945
G1 X24.28091 Y72.66427 E0.237277
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X31.17258 Y69.97478 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.11550 Y70.79392 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.73023 Y70.47571 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X31.40698 Y69.06909 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.45966 Y70.12677 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X31.38002 Y68.65488 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.27590 Y69.75457 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X31.27622 Y68.26125 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.16898 Y69.36178 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X31.09574 Y67.88817 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.13874 Y68.94844 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X30.82914 Y67.53817 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.19462 Y68.51203 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X30.44961 Y67.21842 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y69.65795 E0.273231
G1 X20.02893 Y69.16775 E0.018354
G1 X33.94533 Y65.43886 E0.477917
G1 X33.48593 Y65.14052 E0.018171
G1 X20.28883 Y68.67667 E0.453215
G1 X20.55213 Y68.18468 E0.018510
G1 X33.02652 Y64.84218 E0.428396
G1 X32.56711 Y64.54384 E0.018171
G1 X20.81879 Y67.69179 E0.403461
G1 X21.08893 Y67.19797 E0.018672
G1 X32.10771 Y64.24549 E0.378407
G1 X31.64830 Y63.94715 E0.018171
G1 X21.36253 Y66.70322 E0.353234
G1 X21.63969 Y66.20751 E0.018839
G1 X31.18889 Y63.64881 E0.327939
G1 X30.72949 Y63.35047 E0.018171
G1 X21.92043 Y65.71085 E0.302521
G1 X22.20479 Y65.21321 E0.019012
G1 X30.27008 Y63.05213 E0.276978
G1 X29.81067 Y62.75378 E0.018171
G1 X22.49287 Y64.71458 E0.251308
G1 X22.78467 Y64.21496 E0.019193
G1 X29.35127 Y62.45544 E0.225510
G1 X28.89186 Y62.15710 E0.018171
G1 X23.08026 Y63.71431 E0.199582
G1 X23.37972 Y63.21263 E0.019381
G1 X28.43245 Y61.85876 E0.173521
G1 X27.97305 Y61.56041 E0.018171
G1 X23.68307 Y62.70991 E0.147326
G1 X23.99039 Y62.20613 E0.019575
G1 X27.51364 Y61.26207 E0.120996
G1 X27.05423 Y60.96373 E0.018171
G1 X24.30173 Y61.70126 E0.094526
G1 X24.61718 Y61.19530 E0.019779
G1 X26.59483 Y60.66539 E0.067916
G1 X26.13542 Y60.36705 E0.018171
G1 X24.93678 Y60.68822 E0.041164
G1 X25.26059 Y60.18002 E0.019989
G1 X25.67601 Y60.06870 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.32158 Y10.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X126.10205 Y11.67842 I-0.32158 J1.89795 E0.100304
G2 X127.67842 Y13.89795 I1.89795 J0.32158 E0.100304
G2 X129.89795 Y12.32158 I0.32158 J-1.89795 E0.100304
G2 X128.32158 Y10.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X122.89806 Y14.68187 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.58527 Y14.36907 E0.014674
G1 X122.55343 Y13.76154 E0.020181
G1 X123.44984 Y14.65795 E0.042053
G1 X124.00427 Y14.63667 E0.018405
G1 X122.52159 Y13.15400 E0.069555
G1 X122.48975 Y12.54646 E0.020181
G1 X124.56137 Y14.61808 E0.097184
G1 X125.12119 Y14.60221 E0.018578
G1 X122.45791 Y11.93892 E0.124940
G1 X122.42607 Y11.33139 E0.020181
G1 X125.68377 Y14.58909 E0.152826
G1 X126.24915 Y14.57877 E0.018758
G1 X122.39423 Y10.72385 E0.180842
G1 X122.36239 Y10.11631 E0.020181
G1 X126.81737 Y14.57129 E0.208992
G1 X127.38847 Y14.56669 E0.018945
G1 X122.33055 Y9.50877 E0.237277
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.10556 Y14.13239 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X125.86761 Y11.89444 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X125.95056 Y11.40169 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X129.00711 Y13.88254 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X126.11746 Y10.99289 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X129.35234 Y13.65208 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X126.34792 Y10.64766 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X129.64133 Y13.36537 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X126.63463 Y10.35867 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X129.87419 Y13.02254 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X126.97746 Y10.12581 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X130.04400 Y12.61665 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X127.38335 Y9.95600 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X130.13115 Y12.12809 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y4.10105 E0.273231
G1 X123.23264 Y4.07819 E0.018354
G1 X133.42015 Y14.26570 E0.477917
G1 X133.44882 Y13.71867 E0.018171
G1 X123.78787 Y4.05773 E0.453215
G1 X124.34560 Y4.03975 E0.018510
G1 X133.47749 Y13.17164 E0.428396
G1 X133.50616 Y12.62461 E0.018171
G1 X124.90578 Y4.02424 E0.403461
G1 X125.46852 Y4.01128 E0.018672
G1 X133.53482 Y12.07758 E0.378407
G1 X133.56349 Y11.53056 E0.018171
G1 X126.03379 Y4.00085 E0.353234
G1 X126.60166 Y3.99303 E0.018839
G1 X133.59216 Y10.98353 E0.327939
G1 X133.62083 Y10.43650 E0.018171
G1 X127.17215 Y3.98782 E0.302521
G1 X127.74530 Y3.98527 E0.019012
G1 X133.64950 Y9.88947 E0.276978
G1 X133.67817 Y9.34244 E0.018171
G1 X128.32116 Y3.98544 E0.251308
G1 X128.89975 Y3.98833 E0.019193
G1 X133.70684 Y8.79541 E0.225510
G1 X133.73550 Y8.24838 E0.018171
G1 X129.48112 Y3.99399 E0.199582
G1 X130.06531 Y4.00250 E0.019381
G1 X133.76417 Y7.70135 E0.173521
G1 X133.79284 Y7.15432 E0.018171
G1 X130.65236 Y4.01385 E0.147326
G1 X131.24231 Y4.02809 E0.019575
G1 X133.82151 Y6.60730 E0.120996
G1 X133.85018 Y6.06027 E0.018171
G1 X131.83521 Y4.04529 E0.094526
G1 X132.43111 Y4.06550 E0.019779
G1 X133.87885 Y5.51324 E0.067916
G1 X133.90752 Y4.96621 E0.018171
G1 X133.03005 Y4.08874 E0.041164
G1 X133.63207 Y4.11507 E0.019989
G1 X133.93618 Y4.41918 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.04847 Y67.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X224.82895 Y68.67842 I-0.32158 J1.89795 E0.100304
G2 X226.40532 Y70.89795 I1.89795 J0.32158 E0.100304
G2 X228.62485 Y69.32158 I0.32158 J-1.89795 E0.100304
G2 X227.04847 Y67.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X221.85336 Y65.92253 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X221.96785 Y65.49524 E0.014674
G1 X222.47808 Y65.16390 E0.020181
G1 X222.14997 Y66.38842 E0.042053
G1 X222.44560 Y66.85793 E0.018405
G1 X222.98830 Y64.83256 E0.069555
G1 X223.49852 Y64.50121 E0.020181
G1 X222.74026 Y67.33110 E0.097184
G1 X223.03392 Y67.80798 E0.018578
G1 X224.00874 Y64.16987 E0.124940
G1 X224.51897 Y63.83853 E0.020181
G1 X223.32657 Y68.28863 E0.152826
G1 X223.61819 Y68.77310 E0.018758
G1 X225.02919 Y63.50719 E0.180842
G1 X225.53941 Y63.17584 E0.020181
G1 X223.90878 Y69.26146 E0.208992
G1 X224.19831 Y69.75374 E0.018945
G1 X226.04964 Y62.84450 E0.237277
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X224.93297 Y70.15761 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X225.75212 Y67.10052 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X226.22033 Y66.92598 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X225.60012 Y70.81345 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X226.65781 Y66.86612 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X225.97232 Y70.99720 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.07202 Y66.89309 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X226.36512 Y71.10412 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.46565 Y66.99689 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X226.77845 Y71.13437 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.83873 Y67.17736 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.21487 Y71.07848 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.18873 Y67.44397 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.68154 Y70.90967 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y60.44310 E0.273231
G1 X231.20371 Y60.91043 E0.018354
G1 X227.47482 Y74.82684 E0.477917
G1 X227.96289 Y74.57815 E0.018171
G1 X231.49904 Y61.38106 E0.453215
G1 X231.79347 Y61.85507 E0.018510
G1 X228.45097 Y74.32946 E0.428396
G1 X228.93904 Y74.08078 E0.018171
G1 X232.08700 Y62.33245 E0.403461
G1 X232.37959 Y62.81331 E0.018672
G1 X229.42712 Y73.83209 E0.378407
G1 X229.91519 Y73.58340 E0.018171
G1 X232.67126 Y63.29764 E0.353234
G1 X232.96197 Y63.78551 E0.018839
G1 X230.40327 Y73.33472 E0.327939
G1 X230.89134 Y73.08603 E0.018171
G1 X233.25172 Y64.27698 E0.302521
G1 X233.54051 Y64.77206 E0.019012
G1 X231.37942 Y72.83734 E0.276978
G1 X231.86749 Y72.58866 E0.018171
G1 X233.82829 Y65.27086 E0.251308
G1 X234.11508 Y65.77337 E0.019193
G1 X232.35557 Y72.33997 E0.225510
G1 X232.84364 Y72.09128 E0.018171
G1 X234.40086 Y66.27968 E0.199582
G1 X234.68560 Y66.78986 E0.019381
G1 X233.33172 Y71.84260 E0.173521
G1 X233.81979 Y71.59391 E0.018171
G1 X234.96929 Y67.30394 E0.147326
G1 X235.25192 Y67.82197 E0.019575
G1 X234.30787 Y71.34522 E0.120996
G1 X234.79595 Y71.09654 E0.018171
G1 X235.53348 Y68.34403 E0.094526
G1 X235.81393 Y68.87020 E0.019779
G1 X235.28402 Y70.84785 E0.067916
G1 X235.77210 Y70.59916 E0.018171
G1 X236.09327 Y69.40052 E0.041164
G1 X236.37148 Y69.93505 E0.019989
G1 X236.26017 Y70.35048 E0.014266
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X148.41662 Y5.50022 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X248.49978 Y146.41662 I-20.41662 J120.49978 E6.123232
G3 X107.58338 Y246.49978 I-120.49978 J-20.41662 E6.123232
G3 X7.50022 Y105.58338 I20.41662 J-120.49978 E6.123232
G3 X148.41662 Y5.50022 I120.49978 J20.41662 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X148.48201 Y5.11430 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X248.88570 Y146.48201 I-20.48201 J120.88570 E6.142842
G3 X107.51799 Y246.88570 I-120.88570 J-20.48201 E6.142842
G3 X7.11430 Y105.51799 I20.48201 J-120.88570 E6.142842
G3 X148.48201 Y5.11430 I120.88570 J20.48201 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X148.54740 Y4.72839 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X249.27161 Y146.54740 I-20.54740 J121.27161 E6.162452
G3 X107.45260 Y247.27161 I-121.27161 J-20.54740 E6.162452
G3 X6.72839 Y105.45260 I20.54740 J-121.27161 E6.162452
G3 X148.54740 Y4.72839 I121.27161 J20.54740 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X148.61278 Y4.34247 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X249.65753 Y146.61278 I-20.61278 J121.65753 E6.182063
G3 X107.38722 Y247.65753 I-121.65753 J-20.61278 E6.182063
G3 X6.34247 Y105.38722 I20.61278 J-121.65753 E6.182063
G3 X148.61278 Y4.34247 I121.65753 J20.61278 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X148.67817 Y3.95655 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X250.04345 Y146.67817 I-20.67817 J122.04345 E6.201673
G3 X107.32183 Y248.04345 I-122.04345 J-20.67817 E6.201673
G3 X5.95655 Y105.32183 I20.67817 J-122.04345 E6.201673
G3 X148.67817 Y3.95655 I122.04345 J20.67817 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 3.400
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 17/20
M73 L17
M991 S0 P16
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.77182 Y184.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X228.34361 Y181.95507 I-1.04493 J-1.61671 E0.100304
G2 X225.68197 Y181.38329 I-1.61671 J1.04493 E0.100304
G2 X225.11019 Y184.04493 I1.04493 J1.61671 E0.100304
G2 X227.77182 Y184.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X236.26017 Y181.64952 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X236.37148 Y182.06495 E0.014266
G1 X236.09327 Y182.59948 E0.019989
G1 X235.77210 Y181.40084 E0.041164
G1 X235.28402 Y181.15215 E0.018171
G1 X235.81393 Y183.12980 E0.067916
G1 X235.53348 Y183.65597 E0.019779
G1 X234.79595 Y180.90346 E0.094526
G1 X234.30787 Y180.65478 E0.018171
G1 X235.25192 Y184.17803 E0.120996
G1 X234.96929 Y184.69606 E0.019575
G1 X233.81979 Y180.40609 E0.147326
G1 X233.33172 Y180.15740 E0.018171
G1 X234.68560 Y185.21014 E0.173521
G1 X234.40086 Y185.72032 E0.019381
G1 X232.84364 Y179.90872 E0.199582
G1 X232.35557 Y179.66003 E0.018171
G1 X234.11508 Y186.22663 E0.225510
G1 X233.82829 Y186.72914 E0.019193
G1 X231.86749 Y179.41134 E0.251308
G1 X231.37942 Y179.16266 E0.018171
G1 X233.54051 Y187.22794 E0.276978
G1 X233.25172 Y187.72302 E0.019012
G1 X230.89134 Y178.91397 E0.302521
G1 X230.40327 Y178.66528 E0.018171
G1 X232.96197 Y188.21449 E0.327939
G1 X232.67126 Y188.70236 E0.018839
G1 X229.91519 Y178.41660 E0.353234
G1 X229.42712 Y178.16791 E0.018171
G1 X232.37959 Y189.18669 E0.378407
G1 X232.08700 Y189.66755 E0.018672
G1 X228.93904 Y177.91922 E0.403461
G1 X228.45097 Y177.67054 E0.018171
G1 X231.79347 Y190.14493 E0.428396
G1 X231.49904 Y190.61894 E0.018510
G1 X227.96289 Y177.42185 E0.453215
G1 X227.47482 Y177.17316 E0.018171
G1 X231.20371 Y191.08957 E0.477917
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y191.55690 E0.273231
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.18873 Y184.55603 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X226.77845 Y180.86563 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.83873 Y184.82264 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X226.36512 Y180.89588 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.46565 Y185.00311 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.97232 Y181.00280 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.07202 Y185.10691 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.60012 Y181.18655 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X226.65781 Y185.13388 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.25118 Y181.45713 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X224.93297 Y181.84239 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.75212 Y184.89948 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.19831 Y182.24626 E0.237277
G1 X223.90878 Y182.73854 E0.018945
G1 X225.53941 Y188.82416 E0.208992
G1 X225.02919 Y188.49281 E0.020181
G1 X223.61819 Y183.22690 E0.180842
G1 X223.32657 Y183.71137 E0.018758
G1 X224.51897 Y188.16147 E0.152826
G1 X224.00874 Y187.83013 E0.020181
G1 X223.03392 Y184.19202 E0.124940
G1 X222.74026 Y184.66890 E0.018578
G1 X223.49852 Y187.49879 E0.097184
G1 X222.98830 Y187.16744 E0.020181
G1 X222.44560 Y185.14207 E0.069555
G1 X222.14997 Y185.61158 E0.018405
G1 X222.47808 Y186.83610 E0.042053
G1 X221.96785 Y186.50476 E0.020181
G1 X221.85336 Y186.07747 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.04493 Y241.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.61671 Y238.95507 I-1.04493 J-1.61671 E0.100304
G2 X126.95507 Y238.38329 I-1.61671 J1.04493 E0.100304
G2 X126.38329 Y241.04493 I1.04493 J1.61671 E0.100304
G2 X129.04493 Y241.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X133.93618 Y247.58082 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.63207 Y247.88493 E0.014266
G1 X133.03005 Y247.91126 E0.019989
G1 X133.90752 Y247.03379 E0.041164
G1 X133.87885 Y246.48676 E0.018171
G1 X132.43111 Y247.93450 E0.067916
G1 X131.83521 Y247.95471 E0.019779
G1 X133.85018 Y245.93973 E0.094526
G1 X133.82151 Y245.39270 E0.018171
G1 X131.24231 Y247.97191 E0.120996
G1 X130.65236 Y247.98615 E0.019575
G1 X133.79284 Y244.84568 E0.147326
G1 X133.76417 Y244.29865 E0.018171
G1 X130.06531 Y247.99750 E0.173521
G1 X129.48112 Y248.00601 E0.019381
G1 X133.73550 Y243.75162 E0.199582
G1 X133.70684 Y243.20459 E0.018171
G1 X128.89975 Y248.01167 E0.225510
G1 X128.32116 Y248.01456 E0.019193
G1 X133.67817 Y242.65756 E0.251308
G1 X133.64950 Y242.11053 E0.018171
G1 X127.74530 Y248.01473 E0.276978
G1 X127.17215 Y248.01218 E0.019012
G1 X133.62083 Y241.56350 E0.302521
G1 X133.59216 Y241.01647 E0.018171
G1 X126.60166 Y248.00697 E0.327939
G1 X126.03379 Y247.99915 E0.018839
G1 X133.56349 Y240.46944 E0.353234
G1 X133.53482 Y239.92242 E0.018171
G1 X125.46852 Y247.98872 E0.378407
G1 X124.90578 Y247.97576 E0.018672
G1 X133.50616 Y239.37539 E0.403461
G1 X133.47749 Y238.82836 E0.018171
G1 X124.34560 Y247.96025 E0.428396
G1 X123.78787 Y247.94227 E0.018510
G1 X133.44882 Y238.28133 E0.453215
G1 X133.42015 Y237.73430 E0.018171
G1 X123.23264 Y247.92181 E0.477917
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y247.89895 E0.273231
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X127.38335 Y242.04400 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.87419 Y238.97746 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X126.97746 Y241.87419 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.64133 Y238.63463 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X126.63463 Y241.64133 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.35234 Y238.34792 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X126.34792 Y241.35234 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.00711 Y238.11746 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X126.11746 Y241.00711 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X128.59831 Y237.95056 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X128.10556 Y237.86761 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X125.86761 Y240.10556 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X127.38847 Y237.43331 E0.237277
G1 X126.81737 Y237.42871 E0.018945
G1 X122.36239 Y241.88369 E0.208992
G1 X122.39423 Y241.27615 E0.020181
G1 X126.24915 Y237.42123 E0.180842
G1 X125.68377 Y237.41091 E0.018758
G1 X122.42607 Y240.66861 E0.152826
G1 X122.45791 Y240.06108 E0.020181
G1 X125.12119 Y237.39779 E0.124940
G1 X124.56137 Y237.38192 E0.018578
G1 X122.48975 Y239.45354 E0.097184
G1 X122.52159 Y238.84600 E0.020181
G1 X124.00427 Y237.36333 E0.069555
G1 X123.44984 Y237.34205 E0.018405
G1 X122.55343 Y238.23846 E0.042053
G1 X122.58527 Y237.63093 E0.020181
G1 X122.89806 Y237.31813 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.31803 Y184.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X30.88981 Y181.95507 I-1.04493 J-1.61671 E0.100304
G2 X28.22818 Y181.38329 I-1.61671 J1.04493 E0.100304
G2 X27.65639 Y184.04493 I1.04493 J1.61671 E0.100304
G2 X30.31803 Y184.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X25.67601 Y191.93130 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X25.26059 Y191.81998 E0.014266
G1 X24.93678 Y191.31178 E0.019989
G1 X26.13542 Y191.63295 E0.041164
G1 X26.59483 Y191.33461 E0.018171
G1 X24.61718 Y190.80470 E0.067916
G1 X24.30173 Y190.29874 E0.019779
G1 X27.05423 Y191.03627 E0.094526
G1 X27.51364 Y190.73793 E0.018171
G1 X23.99039 Y189.79387 E0.120996
G1 X23.68307 Y189.29009 E0.019575
G1 X27.97305 Y190.43959 E0.147326
G1 X28.43245 Y190.14124 E0.018171
G1 X23.37972 Y188.78737 E0.173521
G1 X23.08026 Y188.28569 E0.019381
G1 X28.89186 Y189.84290 E0.199582
G1 X29.35127 Y189.54456 E0.018171
G1 X22.78467 Y187.78504 E0.225510
G1 X22.49287 Y187.28542 E0.019193
G1 X29.81067 Y189.24622 E0.251308
G1 X30.27008 Y188.94787 E0.018171
G1 X22.20479 Y186.78679 E0.276978
G1 X21.92043 Y186.28915 E0.019012
G1 X30.72949 Y188.64953 E0.302521
G1 X31.18889 Y188.35119 E0.018171
G1 X21.63969 Y185.79249 E0.327939
G1 X21.36253 Y185.29678 E0.018839
G1 X31.64830 Y188.05285 E0.353234
G1 X32.10771 Y187.75451 E0.018171
G1 X21.08893 Y184.80203 E0.378407
G1 X20.81879 Y184.30821 E0.018672
G1 X32.56711 Y187.45616 E0.403461
G1 X33.02652 Y187.15782 E0.018171
G1 X20.55213 Y183.81532 E0.428396
G1 X20.28883 Y183.32333 E0.018510
G1 X33.48593 Y186.85948 E0.453215
G1 X33.94533 Y186.56114 E0.018171
G1 X20.02893 Y182.83225 E0.477917
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y182.34205 E0.273231
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.19462 Y183.48797 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X31.09574 Y184.11183 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.13874 Y183.05156 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X31.27622 Y183.73875 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.16898 Y182.63822 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X31.38002 Y183.34512 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.27590 Y182.24543 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X31.40698 Y182.93091 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.45966 Y181.87323 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X31.34713 Y182.49343 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X31.17258 Y182.02522 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.11550 Y181.20608 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X31.19016 Y181.18705 E0.237277
G1 X30.90859 Y180.69017 E0.018945
G1 X24.82298 Y179.05953 E0.208992
G1 X25.36504 Y178.78334 E0.020181
G1 X30.63096 Y180.19433 E0.180842
G1 X30.35721 Y179.69954 E0.018758
G1 X25.90710 Y178.50714 E0.152826
G1 X26.44916 Y178.23095 E0.020181
G1 X30.08728 Y179.20578 E0.124940
G1 X29.82111 Y178.71302 E0.018578
G1 X26.99123 Y177.95475 E0.097184
G1 X27.53329 Y177.67856 E0.020181
G1 X29.55866 Y178.22126 E0.069555
G1 X29.29988 Y177.73047 E0.018405
G1 X28.07535 Y177.40236 E0.042053
G1 X28.61741 Y177.12617 E0.020181
G1 X29.04470 Y177.24066 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.31803 Y70.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X30.88981 Y67.95507 I-1.04493 J-1.61671 E0.100304
G2 X28.22818 Y67.38329 I-1.61671 J1.04493 E0.100304
G2 X27.65639 Y70.04493 I1.04493 J1.61671 E0.100304
G2 X30.31803 Y70.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X19.73983 Y70.35048 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X19.62852 Y69.93505 E0.014266
G1 X19.90673 Y69.40052 E0.019989
G1 X20.22790 Y70.59916 E0.041164
G1 X20.71598 Y70.84785 E0.018171
G1 X20.18607 Y68.87020 E0.067916
G1 X20.46652 Y68.34403 E0.019779
G1 X21.20405 Y71.09654 E0.094526
G1 X21.69213 Y71.34522 E0.018171
G1 X20.74808 Y67.82197 E0.120996
G1 X21.03071 Y67.30394 E0.019575
G1 X22.18021 Y71.59391 E0.147326
G1 X22.66828 Y71.84260 E0.018171
G1 X21.31440 Y66.78986 E0.173521
G1 X21.59914 Y66.27968 E0.019381
G1 X23.15636 Y72.09128 E0.199582
G1 X23.64443 Y72.33997 E0.018171
G1 X21.88492 Y65.77337 E0.225510
G1 X22.17171 Y65.27086 E0.019193
G1 X24.13251 Y72.58866 E0.251308
G1 X24.62058 Y72.83734 E0.018171
G1 X22.45949 Y64.77206 E0.276978
G1 X22.74828 Y64.27698 E0.019012
G1 X25.10866 Y73.08603 E0.302521
G1 X25.59673 Y73.33472 E0.018171
G1 X23.03803 Y63.78551 E0.327939
G1 X23.32874 Y63.29764 E0.018839
G1 X26.08481 Y73.58340 E0.353234
G1 X26.57288 Y73.83209 E0.018171
G1 X23.62041 Y62.81331 E0.378407
G1 X23.91300 Y62.33245 E0.018672
G1 X27.06096 Y74.08078 E0.403461
G1 X27.54903 Y74.32946 E0.018171
G1 X24.20653 Y61.85507 E0.428396
G1 X24.50096 Y61.38106 E0.018510
G1 X28.03711 Y74.57815 E0.453215
G1 X28.52518 Y74.82684 E0.018171
G1 X24.79629 Y60.91043 E0.477917
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y60.44310 E0.273231
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.81127 Y67.44397 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X29.22155 Y71.13437 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.16127 Y67.17736 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X29.63488 Y71.10412 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.53435 Y66.99689 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.02768 Y70.99720 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.92798 Y66.89309 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.39988 Y70.81345 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X29.34219 Y66.86612 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.74882 Y70.54287 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X31.06703 Y70.15761 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.24788 Y67.10052 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.80169 Y69.75374 E0.237277
G1 X32.09122 Y69.26146 E0.018945
G1 X30.46059 Y63.17584 E0.208992
G1 X30.97081 Y63.50719 E0.020181
G1 X32.38181 Y68.77310 E0.180842
G1 X32.67343 Y68.28863 E0.018758
G1 X31.48103 Y63.83853 E0.152826
G1 X31.99126 Y64.16987 E0.020181
G1 X32.96608 Y67.80798 E0.124940
G1 X33.25974 Y67.33110 E0.018578
G1 X32.50148 Y64.50121 E0.097184
G1 X33.01170 Y64.83256 E0.020181
G1 X33.55440 Y66.85793 E0.069555
G1 X33.85003 Y66.38842 E0.018405
G1 X33.52192 Y65.16390 E0.042053
G1 X34.03215 Y65.49524 E0.020181
G1 X34.14664 Y65.92253 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.04493 Y13.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.61671 Y10.95507 I-1.04493 J-1.61671 E0.100304
G2 X126.95507 Y10.38329 I-1.61671 J1.04493 E0.100304
G2 X126.38329 Y13.04493 I1.04493 J1.61671 E0.100304
G2 X129.04493 Y13.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X122.06382 Y4.41918 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.36793 Y4.11507 E0.014266
G1 X122.96995 Y4.08874 E0.019989
G1 X122.09248 Y4.96621 E0.041164
G1 X122.12115 Y5.51324 E0.018171
G1 X123.56889 Y4.06550 E0.067916
G1 X124.16479 Y4.04529 E0.019779
G1 X122.14982 Y6.06027 E0.094526
G1 X122.17849 Y6.60730 E0.018171
G1 X124.75769 Y4.02809 E0.120996
G1 X125.34764 Y4.01385 E0.019575
G1 X122.20716 Y7.15432 E0.147326
G1 X122.23583 Y7.70135 E0.018171
G1 X125.93469 Y4.00250 E0.173521
G1 X126.51888 Y3.99399 E0.019381
G1 X122.26450 Y8.24838 E0.199582
G1 X122.29316 Y8.79541 E0.018171
G1 X127.10025 Y3.98833 E0.225510
G1 X127.67884 Y3.98544 E0.019193
G1 X122.32183 Y9.34244 E0.251308
G1 X122.35050 Y9.88947 E0.018171
G1 X128.25470 Y3.98527 E0.276978
G1 X128.82785 Y3.98782 E0.019012
G1 X122.37917 Y10.43650 E0.302521
G1 X122.40784 Y10.98353 E0.018171
G1 X129.39834 Y3.99303 E0.327939
G1 X129.96621 Y4.00085 E0.018839
G1 X122.43651 Y11.53056 E0.353234
G1 X122.46518 Y12.07758 E0.018171
G1 X130.53148 Y4.01128 E0.378407
G1 X131.09422 Y4.02424 E0.018672
G1 X122.49384 Y12.62461 E0.403461
G1 X122.52251 Y13.17164 E0.018171
G1 X131.65440 Y4.03975 E0.428396
G1 X132.21213 Y4.05773 E0.018510
G1 X122.55118 Y13.71867 E0.453215
G1 X122.57985 Y14.26570 E0.018171
G1 X132.76736 Y4.07819 E0.477917
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y4.10105 E0.273231
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X128.61665 Y9.95600 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X126.12581 Y13.02254 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.02254 Y10.12581 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X126.35867 Y13.36537 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.36537 Y10.35867 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X126.64766 Y13.65208 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.65208 Y10.64766 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X126.99289 Y13.88254 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.88254 Y10.99289 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X127.40169 Y14.04944 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X127.89444 Y14.13239 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X130.13239 Y11.89444 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X128.61153 Y14.56669 E0.237277
G1 X129.18263 Y14.57129 E0.018945
G1 X133.63761 Y10.11631 E0.208992
G1 X133.60577 Y10.72385 E0.020181
G1 X129.75085 Y14.57877 E0.180842
G1 X130.31623 Y14.58909 E0.018758
G1 X133.57393 Y11.33139 E0.152826
G1 X133.54209 Y11.93892 E0.020181
G1 X130.87881 Y14.60221 E0.124940
G1 X131.43863 Y14.61808 E0.018578
G1 X133.51025 Y12.54646 E0.097184
G1 X133.47841 Y13.15400 E0.020181
G1 X131.99573 Y14.63667 E0.069555
G1 X132.55016 Y14.65795 E0.018405
G1 X133.44657 Y13.76154 E0.042053
G1 X133.41473 Y14.36907 E0.020181
G1 X133.10194 Y14.68187 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.77182 Y70.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X228.34361 Y67.95507 I-1.04493 J-1.61671 E0.100304
G2 X225.68197 Y67.38329 I-1.61671 J1.04493 E0.100304
G2 X225.11019 Y70.04493 I1.04493 J1.61671 E0.100304
G2 X227.77182 Y70.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X230.32399 Y60.06870 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X230.73941 Y60.18002 E0.014266
G1 X231.06322 Y60.68822 E0.019989
G1 X229.86458 Y60.36705 E0.041164
G1 X229.40517 Y60.66539 E0.018171
G1 X231.38282 Y61.19530 E0.067916
G1 X231.69827 Y61.70126 E0.019779
G1 X228.94577 Y60.96373 E0.094526
G1 X228.48636 Y61.26207 E0.018171
G1 X232.00961 Y62.20613 E0.120996
G1 X232.31693 Y62.70991 E0.019575
G1 X228.02695 Y61.56041 E0.147326
G1 X227.56755 Y61.85876 E0.018171
G1 X232.62028 Y63.21263 E0.173521
G1 X232.91974 Y63.71431 E0.019381
G1 X227.10814 Y62.15710 E0.199582
G1 X226.64873 Y62.45544 E0.018171
G1 X233.21533 Y64.21496 E0.225510
G1 X233.50713 Y64.71458 E0.019193
G1 X226.18933 Y62.75378 E0.251308
G1 X225.72992 Y63.05213 E0.018171
G1 X233.79521 Y65.21321 E0.276978
G1 X234.07957 Y65.71085 E0.019012
G1 X225.27051 Y63.35047 E0.302521
G1 X224.81111 Y63.64881 E0.018171
G1 X234.36031 Y66.20751 E0.327939
G1 X234.63747 Y66.70322 E0.018839
G1 X224.35170 Y63.94715 E0.353234
G1 X223.89229 Y64.24549 E0.018171
G1 X234.91107 Y67.19797 E0.378407
G1 X235.18121 Y67.69179 E0.018672
G1 X223.43289 Y64.54384 E0.403461
G1 X222.97348 Y64.84218 E0.018171
G1 X235.44787 Y68.18468 E0.428396
G1 X235.71117 Y68.67667 E0.018510
G1 X222.51407 Y65.14052 E0.453215
G1 X222.05467 Y65.43886 E0.018171
G1 X235.97107 Y69.16775 E0.477917
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y69.65795 E0.273231
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.80538 Y68.51203 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X224.90426 Y67.88817 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.86126 Y68.94844 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X224.72378 Y68.26125 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.83102 Y69.36178 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X224.61998 Y68.65488 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.72410 Y69.75457 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X224.59302 Y69.06909 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.54034 Y70.12677 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X224.65287 Y69.50657 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X224.82742 Y69.97478 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.88450 Y70.79392 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X224.80984 Y70.81295 E0.237277
G1 X225.09141 Y71.30983 E0.018945
G1 X231.17702 Y72.94047 E0.208992
G1 X230.63496 Y73.21666 E0.020181
G1 X225.36904 Y71.80567 E0.180842
G1 X225.64279 Y72.30046 E0.018758
G1 X230.09290 Y73.49286 E0.152826
G1 X229.55084 Y73.76905 E0.020181
G1 X225.91272 Y72.79422 E0.124940
G1 X226.17889 Y73.28698 E0.018578
G1 X229.00877 Y74.04525 E0.097184
G1 X228.46671 Y74.32144 E0.020181
G1 X226.44134 Y73.77874 E0.069555
G1 X226.70012 Y74.26953 E0.018405
G1 X227.92465 Y74.59764 E0.042053
G1 X227.38259 Y74.87383 E0.020181
G1 X226.95530 Y74.75934 E0.014674
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X194.34185 Y228.64402 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X25.35598 Y192.34185 I-66.34185 J-102.64402 E6.123232
G3 X61.65815 Y23.35598 I102.64402 J-66.34185 E6.123232
G3 X230.64402 Y59.65815 I66.34185 J102.64402 E6.123232
G3 X194.34185 Y228.64402 I-102.64402 J66.34185 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X194.55432 Y228.97275 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X25.02725 Y192.55432 I-66.55432 J-102.97275 E6.142842
G3 X61.44568 Y23.02725 I102.97275 J-66.55432 E6.142842
G3 X230.97275 Y59.44568 I66.55432 J102.97275 E6.142842
G3 X194.55432 Y228.97275 I-102.97275 J66.55432 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X194.76679 Y229.30148 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X24.69852 Y192.76679 I-66.76679 J-103.30148 E6.162452
G3 X61.23321 Y22.69852 I103.30148 J-66.76679 E6.162452
G3 X231.30148 Y59.23321 I66.76679 J103.30148 E6.162452
G3 X194.76679 Y229.30148 I-103.30148 J66.76679 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X194.97926 Y229.63021 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X24.36979 Y192.97926 I-66.97926 J-103.63021 E6.182063
G3 X61.02074 Y22.36979 I103.63021 J-66.97926 E6.182063
G3 X231.63021 Y59.02074 I66.97926 J103.63021 E6.182063
G3 X194.97926 Y229.63021 I-103.63021 J66.97926 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X195.19172 Y229.95894 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X24.04106 Y193.19172 I-67.19172 J-103.95894 E6.201673
G3 X60.80828 Y22.04106 I103.95894 J-67.19172 E6.201673
G3 X231.95894 Y58.80828 I67.19172 J103.95894 E6.201673
G3 X195.19172 Y229.95894 I-103.95894 J67.19172 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 3.600
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 18/20
M73 L18
M991 S0 P17
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.86433 Y182.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X226.24062 Y184.86257 I1.86257 J0.48627 E0.100304
G2 X228.58946 Y183.48627 I0.48627 J-1.86257 E0.100304
G2 X227.21317 Y181.13743 I-1.86257 J-0.48627 E0.100304
G2 X224.86433 Y182.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X226.95530 Y177.24066 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X227.38259 Y177.12617 E0.014674
G1 X227.92465 Y177.40236 E0.020181
G1 X226.70012 Y177.73047 E0.042053
G1 X226.44134 Y178.22126 E0.018405
G1 X228.46671 Y177.67856 E0.069555
G1 X229.00877 Y177.95475 E0.020181
G1 X226.17889 Y178.71302 E0.097184
G1 X225.91272 Y179.20578 E0.018578
G1 X229.55084 Y178.23095 E0.124940
G1 X230.09290 Y178.50714 E0.020181
G1 X225.64279 Y179.69954 E0.152826
G1 X225.36904 Y180.19433 E0.018758
G1 X230.63496 Y178.78334 E0.180842
G1 X231.17702 Y179.05953 E0.020181
G1 X225.09141 Y180.69017 E0.208992
G1 X224.80984 Y181.18705 E0.018945
G1 X231.71909 Y179.33573 E0.237277
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.82742 Y182.02522 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X227.88450 Y181.20608 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.26977 Y181.52429 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.59302 Y182.93091 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.54034 Y181.87323 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.61998 Y183.34512 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.72410 Y182.24543 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.72378 Y183.73875 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.83102 Y182.63822 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.90426 Y184.11183 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.86126 Y183.05156 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.17086 Y184.46183 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.80538 Y183.48797 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.55039 Y184.78158 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y182.34205 E0.273231
G1 X235.97107 Y182.83225 E0.018354
G1 X222.05467 Y186.56114 E0.477917
G1 X222.51407 Y186.85948 E0.018171
G1 X235.71117 Y183.32333 E0.453215
G1 X235.44787 Y183.81532 E0.018510
G1 X222.97348 Y187.15782 E0.428396
G1 X223.43289 Y187.45616 E0.018171
G1 X235.18121 Y184.30821 E0.403461
G1 X234.91107 Y184.80203 E0.018672
G1 X223.89229 Y187.75451 E0.378407
G1 X224.35170 Y188.05285 E0.018171
G1 X234.63747 Y185.29678 E0.353234
G1 X234.36031 Y185.79249 E0.018839
G1 X224.81111 Y188.35119 E0.327939
G1 X225.27051 Y188.64953 E0.018171
G1 X234.07957 Y186.28915 E0.302521
G1 X233.79521 Y186.78679 E0.019012
G1 X225.72992 Y188.94787 E0.276978
G1 X226.18933 Y189.24622 E0.018171
G1 X233.50713 Y187.28542 E0.251308
G1 X233.21533 Y187.78504 E0.019193
G1 X226.64873 Y189.54456 E0.225510
G1 X227.10814 Y189.84290 E0.018171
G1 X232.91974 Y188.28569 E0.199582
G1 X232.62028 Y188.78737 E0.019381
G1 X227.56755 Y190.14124 E0.173521
G1 X228.02695 Y190.43959 E0.018171
G1 X232.31693 Y189.29009 E0.147326
G1 X232.00961 Y189.79387 E0.019575
G1 X228.48636 Y190.73793 E0.120996
G1 X228.94577 Y191.03627 E0.018171
G1 X231.69827 Y190.29874 E0.094526
G1 X231.38282 Y190.80470 E0.019779
G1 X229.40517 Y191.33461 E0.067916
G1 X229.86458 Y191.63295 E0.018171
G1 X231.06322 Y191.31178 E0.041164
G1 X230.73941 Y191.81998 E0.019989
G1 X230.32399 Y191.93130 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.13743 Y239.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X127.51373 Y241.86257 I1.86257 J0.48627 E0.100304
G2 X129.86257 Y240.48627 I0.48627 J-1.86257 E0.100304
G2 X128.48627 Y238.13743 I-1.86257 J-0.48627 E0.100304
G2 X126.13743 Y239.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X133.10194 Y237.31813 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.41473 Y237.63093 E0.014674
G1 X133.44657 Y238.23846 E0.020181
G1 X132.55016 Y237.34205 E0.042053
G1 X131.99573 Y237.36333 E0.018405
G1 X133.47841 Y238.84600 E0.069555
G1 X133.51025 Y239.45354 E0.020181
G1 X131.43863 Y237.38192 E0.097184
G1 X130.87881 Y237.39779 E0.018578
G1 X133.54209 Y240.06108 E0.124940
G1 X133.57393 Y240.66861 E0.020181
G1 X130.31623 Y237.41091 E0.152826
G1 X129.75085 Y237.42123 E0.018758
G1 X133.60577 Y241.27615 E0.180842
G1 X133.63761 Y241.88369 E0.020181
G1 X129.18263 Y237.42871 E0.208992
G1 X128.61153 Y237.43331 E0.018945
G1 X133.66945 Y242.49123 E0.237277
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X127.89444 Y237.86761 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X130.13239 Y240.10556 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X130.04944 Y240.59831 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.99289 Y238.11746 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.88254 Y241.00711 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.64766 Y238.34792 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.65208 Y241.35234 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.35867 Y238.63463 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.36537 Y241.64133 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.12581 Y238.97746 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.02254 Y241.87419 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X125.95600 Y239.38335 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X128.61665 Y242.04400 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X125.86885 Y239.87191 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y247.89895 E0.273231
G1 X132.76736 Y247.92181 E0.018354
G1 X122.57985 Y237.73430 E0.477917
G1 X122.55118 Y238.28133 E0.018171
G1 X132.21213 Y247.94227 E0.453215
G1 X131.65440 Y247.96025 E0.018510
G1 X122.52251 Y238.82836 E0.428396
G1 X122.49384 Y239.37539 E0.018171
G1 X131.09422 Y247.97576 E0.403461
G1 X130.53148 Y247.98872 E0.018672
G1 X122.46518 Y239.92242 E0.378407
G1 X122.43651 Y240.46944 E0.018171
G1 X129.96621 Y247.99915 E0.353234
G1 X129.39834 Y248.00697 E0.018839
G1 X122.40784 Y241.01647 E0.327939
G1 X122.37917 Y241.56350 E0.018171
G1 X128.82785 Y248.01218 E0.302521
G1 X128.25470 Y248.01473 E0.019012
G1 X122.35050 Y242.11053 E0.276978
G1 X122.32183 Y242.65756 E0.018171
G1 X127.67884 Y248.01456 E0.251308
G1 X127.10025 Y248.01167 E0.019193
G1 X122.29316 Y243.20459 E0.225510
G1 X122.26450 Y243.75162 E0.018171
G1 X126.51888 Y248.00601 E0.199582
G1 X125.93469 Y247.99750 E0.019381
G1 X122.23583 Y244.29865 E0.173521
G1 X122.20716 Y244.84568 E0.018171
G1 X125.34764 Y247.98615 E0.147326
G1 X124.75769 Y247.97191 E0.019575
G1 X122.17849 Y245.39270 E0.120996
G1 X122.14982 Y245.93973 E0.018171
G1 X124.16479 Y247.95471 E0.094526
G1 X123.56889 Y247.93450 E0.019779
G1 X122.12115 Y246.48676 E0.067916
G1 X122.09248 Y247.03379 E0.018171
G1 X122.96995 Y247.91126 E0.041164
G1 X122.36793 Y247.88493 E0.019989
G1 X122.06382 Y247.58082 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.41054 Y182.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X28.78683 Y184.86257 I1.86257 J0.48627 E0.100304
G2 X31.13567 Y183.48627 I0.48627 J-1.86257 E0.100304
G2 X29.75938 Y181.13743 I-1.86257 J-0.48627 E0.100304
G2 X27.41054 Y182.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X34.14664 Y186.07747 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X34.03215 Y186.50476 E0.014674
G1 X33.52192 Y186.83610 E0.020181
G1 X33.85003 Y185.61158 E0.042053
G1 X33.55440 Y185.14207 E0.018405
G1 X33.01170 Y187.16744 E0.069555
G1 X32.50148 Y187.49879 E0.020181
G1 X33.25974 Y184.66890 E0.097184
G1 X32.96608 Y184.19202 E0.018578
G1 X31.99126 Y187.83013 E0.124940
G1 X31.48103 Y188.16147 E0.020181
G1 X32.67343 Y183.71137 E0.152826
G1 X32.38181 Y183.22690 E0.018758
G1 X30.97081 Y188.49281 E0.180842
G1 X30.46059 Y188.82416 E0.020181
G1 X32.09122 Y182.73854 E0.208992
G1 X31.80169 Y182.24626 E0.018945
G1 X29.95036 Y189.15550 E0.237277
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X31.06703 Y181.84239 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.24788 Y184.89948 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X29.77967 Y185.07402 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.39988 Y181.18655 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X29.34219 Y185.13388 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.02768 Y181.00280 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X28.92798 Y185.10691 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X29.63488 Y180.89588 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X28.53435 Y185.00311 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X29.22155 Y180.86563 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X28.16127 Y184.82264 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X28.78513 Y180.92152 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.81127 Y184.55603 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X28.31846 Y181.09033 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y191.55690 E0.273231
G1 X24.79629 Y191.08957 E0.018354
G1 X28.52518 Y177.17316 E0.477917
G1 X28.03711 Y177.42185 E0.018171
G1 X24.50096 Y190.61894 E0.453215
G1 X24.20653 Y190.14493 E0.018510
G1 X27.54903 Y177.67054 E0.428396
G1 X27.06096 Y177.91922 E0.018171
G1 X23.91300 Y189.66755 E0.403461
G1 X23.62041 Y189.18669 E0.018672
G1 X26.57288 Y178.16791 E0.378407
G1 X26.08481 Y178.41660 E0.018171
G1 X23.32874 Y188.70236 E0.353234
G1 X23.03803 Y188.21449 E0.018839
G1 X25.59673 Y178.66528 E0.327939
G1 X25.10866 Y178.91397 E0.018171
G1 X22.74828 Y187.72302 E0.302521
G1 X22.45949 Y187.22794 E0.019012
G1 X24.62058 Y179.16266 E0.276978
G1 X24.13251 Y179.41134 E0.018171
G1 X22.17171 Y186.72914 E0.251308
G1 X21.88492 Y186.22663 E0.019193
G1 X23.64443 Y179.66003 E0.225510
G1 X23.15636 Y179.90872 E0.018171
G1 X21.59914 Y185.72032 E0.199582
G1 X21.31440 Y185.21014 E0.019381
G1 X22.66828 Y180.15740 E0.173521
G1 X22.18021 Y180.40609 E0.018171
G1 X21.03071 Y184.69606 E0.147326
G1 X20.74808 Y184.17803 E0.019575
G1 X21.69213 Y180.65478 E0.120996
G1 X21.20405 Y180.90346 E0.018171
G1 X20.46652 Y183.65597 E0.094526
G1 X20.18607 Y183.12980 E0.019779
G1 X20.71598 Y181.15215 E0.067916
G1 X20.22790 Y181.40084 E0.018171
G1 X19.90673 Y182.59948 E0.041164
G1 X19.62852 Y182.06495 E0.019989
G1 X19.73983 Y181.64952 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.41054 Y68.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X28.78683 Y70.86257 I1.86257 J0.48627 E0.100304
G2 X31.13567 Y69.48627 I0.48627 J-1.86257 E0.100304
G2 X29.75938 Y67.13743 I-1.86257 J-0.48627 E0.100304
G2 X27.41054 Y68.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X29.04470 Y74.75934 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X28.61741 Y74.87383 E0.014674
G1 X28.07535 Y74.59764 E0.020181
G1 X29.29988 Y74.26953 E0.042053
G1 X29.55866 Y73.77874 E0.018405
G1 X27.53329 Y74.32144 E0.069555
G1 X26.99123 Y74.04525 E0.020181
G1 X29.82111 Y73.28698 E0.097184
G1 X30.08728 Y72.79422 E0.018578
G1 X26.44916 Y73.76905 E0.124940
G1 X25.90710 Y73.49286 E0.020181
G1 X30.35721 Y72.30046 E0.152826
G1 X30.63096 Y71.80567 E0.018758
G1 X25.36504 Y73.21666 E0.180842
G1 X24.82298 Y72.94047 E0.020181
G1 X30.90859 Y71.30983 E0.208992
G1 X31.19016 Y70.81295 E0.018945
G1 X24.28091 Y72.66427 E0.237277
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X31.17258 Y69.97478 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X28.11550 Y70.79392 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.73023 Y70.47571 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X31.40698 Y69.06909 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.45966 Y70.12677 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X31.38002 Y68.65488 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.27590 Y69.75457 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X31.27622 Y68.26125 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.16898 Y69.36178 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X31.09574 Y67.88817 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.13874 Y68.94844 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.82914 Y67.53817 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.19462 Y68.51203 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.44961 Y67.21842 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y69.65795 E0.273231
G1 X20.02893 Y69.16775 E0.018354
G1 X33.94533 Y65.43886 E0.477917
G1 X33.48593 Y65.14052 E0.018171
G1 X20.28883 Y68.67667 E0.453215
G1 X20.55213 Y68.18468 E0.018510
G1 X33.02652 Y64.84218 E0.428396
G1 X32.56711 Y64.54384 E0.018171
G1 X20.81879 Y67.69179 E0.403461
G1 X21.08893 Y67.19797 E0.018672
G1 X32.10771 Y64.24549 E0.378407
G1 X31.64830 Y63.94715 E0.018171
G1 X21.36253 Y66.70322 E0.353234
G1 X21.63969 Y66.20751 E0.018839
G1 X31.18889 Y63.64881 E0.327939
G1 X30.72949 Y63.35047 E0.018171
G1 X21.92043 Y65.71085 E0.302521
G1 X22.20479 Y65.21321 E0.019012
G1 X30.27008 Y63.05213 E0.276978
G1 X29.81067 Y62.75378 E0.018171
G1 X22.49287 Y64.71458 E0.251308
G1 X22.78467 Y64.21496 E0.019193
G1 X29.35127 Y62.45544 E0.225510
G1 X28.89186 Y62.15710 E0.018171
G1 X23.08026 Y63.71431 E0.199582
G1 X23.37972 Y63.21263 E0.019381
G1 X28.43245 Y61.85876 E0.173521
G1 X27.97305 Y61.56041 E0.018171
G1 X23.68307 Y62.70991 E0.147326
G1 X23.99039 Y62.20613 E0.019575
G1 X27.51364 Y61.26207 E0.120996
G1 X27.05423 Y60.96373 E0.018171
G1 X24.30173 Y61.70126 E0.094526
G1 X24.61718 Y61.19530 E0.019779
G1 X26.59483 Y60.66539 E0.067916
G1 X26.13542 Y60.36705 E0.018171
G1 X24.93678 Y60.68822 E0.041164
G1 X25.26059 Y60.18002 E0.019989
G1 X25.67601 Y60.06870 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.13743 Y11.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X127.51373 Y13.86257 I1.86257 J0.48627 E0.100304
G2 X129.86257 Y12.48627 I0.48627 J-1.86257 E0.100304
G2 X128.48627 Y10.13743 I-1.86257 J-0.48627 E0.100304
G2 X126.13743 Y11.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X122.89806 Y14.68187 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.58527 Y14.36907 E0.014674
G1 X122.55343 Y13.76154 E0.020181
G1 X123.44984 Y14.65795 E0.042053
G1 X124.00427 Y14.63667 E0.018405
G1 X122.52159 Y13.15400 E0.069555
G1 X122.48975 Y12.54646 E0.020181
G1 X124.56137 Y14.61808 E0.097184
G1 X125.12119 Y14.60221 E0.018578
G1 X122.45791 Y11.93892 E0.124940
G1 X122.42607 Y11.33139 E0.020181
G1 X125.68377 Y14.58909 E0.152826
G1 X126.24915 Y14.57877 E0.018758
G1 X122.39423 Y10.72385 E0.180842
G1 X122.36239 Y10.11631 E0.020181
G1 X126.81737 Y14.57129 E0.208992
G1 X127.38847 Y14.56669 E0.018945
G1 X122.33055 Y9.50877 E0.237277
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X128.10556 Y14.13239 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X125.86761 Y11.89444 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X125.95056 Y11.40169 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.00711 Y13.88254 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.11746 Y10.99289 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.35234 Y13.65208 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.34792 Y10.64766 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.64133 Y13.36537 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.63463 Y10.35867 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.87419 Y13.02254 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.97746 Y10.12581 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X130.04400 Y12.61665 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X127.38335 Y9.95600 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X130.13115 Y12.12809 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y4.10105 E0.273231
G1 X123.23264 Y4.07819 E0.018354
G1 X133.42015 Y14.26570 E0.477917
G1 X133.44882 Y13.71867 E0.018171
G1 X123.78787 Y4.05773 E0.453215
G1 X124.34560 Y4.03975 E0.018510
G1 X133.47749 Y13.17164 E0.428396
G1 X133.50616 Y12.62461 E0.018171
G1 X124.90578 Y4.02424 E0.403461
G1 X125.46852 Y4.01128 E0.018672
G1 X133.53482 Y12.07758 E0.378407
G1 X133.56349 Y11.53056 E0.018171
G1 X126.03379 Y4.00085 E0.353234
G1 X126.60166 Y3.99303 E0.018839
G1 X133.59216 Y10.98353 E0.327939
G1 X133.62083 Y10.43650 E0.018171
G1 X127.17215 Y3.98782 E0.302521
G1 X127.74530 Y3.98527 E0.019012
G1 X133.64950 Y9.88947 E0.276978
G1 X133.67817 Y9.34244 E0.018171
G1 X128.32116 Y3.98544 E0.251308
G1 X128.89975 Y3.98833 E0.019193
G1 X133.70684 Y8.79541 E0.225510
G1 X133.73550 Y8.24838 E0.018171
G1 X129.48112 Y3.99399 E0.199582
G1 X130.06531 Y4.00250 E0.019381
G1 X133.76417 Y7.70135 E0.173521
G1 X133.79284 Y7.15432 E0.018171
G1 X130.65236 Y4.01385 E0.147326
G1 X131.24231 Y4.02809 E0.019575
G1 X133.82151 Y6.60730 E0.120996
G1 X133.85018 Y6.06027 E0.018171
G1 X131.83521 Y4.04529 E0.094526
G1 X132.43111 Y4.06550 E0.019779
G1 X133.87885 Y5.51324 E0.067916
G1 X133.90752 Y4.96621 E0.018171
G1 X133.03005 Y4.08874 E0.041164
G1 X133.63207 Y4.11507 E0.019989
G1 X133.93618 Y4.41918 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.86433 Y68.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X226.24062 Y70.86257 I1.86257 J0.48627 E0.100304
G2 X228.58946 Y69.48627 I0.48627 J-1.86257 E0.100304
G2 X227.21317 Y67.13743 I-1.86257 J-0.48627 E0.100304
G2 X224.86433 Y68.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X221.85336 Y65.92253 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X221.96785 Y65.49524 E0.014674
G1 X222.47808 Y65.16390 E0.020181
G1 X222.14997 Y66.38842 E0.042053
G1 X222.44560 Y66.85793 E0.018405
G1 X222.98830 Y64.83256 E0.069555
G1 X223.49852 Y64.50121 E0.020181
G1 X222.74026 Y67.33110 E0.097184
G1 X223.03392 Y67.80798 E0.018578
G1 X224.00874 Y64.16987 E0.124940
G1 X224.51897 Y63.83853 E0.020181
G1 X223.32657 Y68.28863 E0.152826
G1 X223.61819 Y68.77310 E0.018758
G1 X225.02919 Y63.50719 E0.180842
G1 X225.53941 Y63.17584 E0.020181
G1 X223.90878 Y69.26146 E0.208992
G1 X224.19831 Y69.75374 E0.018945
G1 X226.04964 Y62.84450 E0.237277
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.93297 Y70.15761 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.75212 Y67.10052 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X226.22033 Y66.92598 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.60012 Y70.81345 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X226.65781 Y66.86612 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.97232 Y70.99720 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X227.07202 Y66.89309 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X226.36512 Y71.10412 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X227.46565 Y66.99689 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X226.77845 Y71.13437 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X227.83873 Y67.17736 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X227.21487 Y71.07848 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.18873 Y67.44397 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X227.68154 Y70.90967 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y60.44310 E0.273231
G1 X231.20371 Y60.91043 E0.018354
G1 X227.47482 Y74.82684 E0.477917
G1 X227.96289 Y74.57815 E0.018171
G1 X231.49904 Y61.38106 E0.453215
G1 X231.79347 Y61.85507 E0.018510
G1 X228.45097 Y74.32946 E0.428396
G1 X228.93904 Y74.08078 E0.018171
G1 X232.08700 Y62.33245 E0.403461
G1 X232.37959 Y62.81331 E0.018672
G1 X229.42712 Y73.83209 E0.378407
G1 X229.91519 Y73.58340 E0.018171
G1 X232.67126 Y63.29764 E0.353234
G1 X232.96197 Y63.78551 E0.018839
G1 X230.40327 Y73.33472 E0.327939
G1 X230.89134 Y73.08603 E0.018171
G1 X233.25172 Y64.27698 E0.302521
G1 X233.54051 Y64.77206 E0.019012
G1 X231.37942 Y72.83734 E0.276978
G1 X231.86749 Y72.58866 E0.018171
G1 X233.82829 Y65.27086 E0.251308
G1 X234.11508 Y65.77337 E0.019193
G1 X232.35557 Y72.33997 E0.225510
G1 X232.84364 Y72.09128 E0.018171
G1 X234.40086 Y66.27968 E0.199582
G1 X234.68560 Y66.78986 E0.019381
G1 X233.33172 Y71.84260 E0.173521
G1 X233.81979 Y71.59391 E0.018171
G1 X234.96929 Y67.30394 E0.147326
G1 X235.25192 Y67.82197 E0.019575
G1 X234.30787 Y71.34522 E0.120996
G1 X234.79595 Y71.09654 E0.018171
G1 X235.53348 Y68.34403 E0.094526
G1 X235.81393 Y68.87020 E0.019779
G1 X235.28402 Y70.84785 E0.067916
G1 X235.77210 Y70.59916 E0.018171
G1 X236.09327 Y69.40052 E0.041164
G1 X236.37148 Y69.93505 E0.019989
G1 X236.26017 Y70.35048 E0.014266
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X9.74654 Y95.12677 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X158.87323 Y7.74654 I118.25346 J30.87323 E6.123232
G3 X246.25346 Y156.87323 I-30.87323 J118.25346 E6.123232
G3 X97.12677 Y244.25346 I-118.25346 J-30.87323 E6.123232
G3 X9.74654 Y95.12677 I30.87323 J-118.25346 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X9.36782 Y95.02790 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X158.97210 Y7.36782 I118.63218 J30.97210 E6.142842
G3 X246.63218 Y156.97210 I-30.97210 J118.63218 E6.142842
G3 X97.02790 Y244.63218 I-118.63218 J-30.97210 E6.142842
G3 X9.36782 Y95.02790 I30.97210 J-118.63218 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X8.98910 Y94.92902 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X159.07098 Y6.98910 I119.01090 J31.07098 E6.162452
G3 X247.01090 Y157.07098 I-31.07098 J119.01090 E6.162452
G3 X96.92902 Y245.01090 I-119.01090 J-31.07098 E6.162452
G3 X8.98910 Y94.92902 I31.07098 J-119.01090 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X8.61038 Y94.83015 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X159.16985 Y6.61038 I119.38962 J31.16985 E6.182063
G3 X247.38962 Y157.16985 I-31.16985 J119.38962 E6.182063
G3 X96.83015 Y245.38962 I-119.38962 J-31.16985 E6.182063
G3 X8.61038 Y94.83015 I31.16985 J-119.38962 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X8.23166 Y94.73127 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X159.26873 Y6.23166 I119.76834 J31.26873 E6.201673
G3 X247.76834 Y157.26873 I-31.26873 J119.76834 E6.201673
G3 X96.73127 Y245.76834 I-119.76834 J-31.26873 E6.201673
G3 X8.23166 Y94.73127 I31.26873 J-119.76834 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 3.800
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 19/20
M73 L19
M991 S0 P18
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.42877 Y182.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X225.82731 Y181.29813 I-1.70187 J0.89958 E0.100304
G2 X225.02502 Y183.89958 I0.89958 J1.70187 E0.100304
G2 X227.62648 Y184.70187 I1.70187 J-0.89958 E0.100304
G2 X228.42877 Y182.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X236.26017 Y181.64952 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X236.37148 Y182.06495 E0.014266
G1 X236.09327 Y182.59948 E0.019989
G1 X235.77210 Y181.40084 E0.041164
G1 X235.28402 Y181.15215 E0.018171
G1 X235.81393 Y183.12980 E0.067916
G1 X235.53348 Y183.65597 E0.019779
G1 X234.79595 Y180.90346 E0.094526
G1 X234.30787 Y180.65478 E0.018171
G1 X235.25192 Y184.17803 E0.120996
G1 X234.96929 Y184.69606 E0.019575
G1 X233.81979 Y180.40609 E0.147326
G1 X233.33172 Y180.15740 E0.018171
G1 X234.68560 Y185.21014 E0.173521
G1 X234.40086 Y185.72032 E0.019381
G1 X232.84364 Y179.90872 E0.199582
G1 X232.35557 Y179.66003 E0.018171
G1 X234.11508 Y186.22663 E0.225510
G1 X233.82829 Y186.72914 E0.019193
G1 X231.86749 Y179.41134 E0.251308
G1 X231.37942 Y179.16266 E0.018171
G1 X233.54051 Y187.22794 E0.276978
G1 X233.25172 Y187.72302 E0.019012
G1 X230.89134 Y178.91397 E0.302521
G1 X230.40327 Y178.66528 E0.018171
G1 X232.96197 Y188.21449 E0.327939
G1 X232.67126 Y188.70236 E0.018839
G1 X229.91519 Y178.41660 E0.353234
G1 X229.42712 Y178.16791 E0.018171
G1 X232.37959 Y189.18669 E0.378407
G1 X232.08700 Y189.66755 E0.018672
G1 X228.93904 Y177.91922 E0.403461
G1 X228.45097 Y177.67054 E0.018171
G1 X231.79347 Y190.14493 E0.428396
G1 X231.49904 Y190.61894 E0.018510
G1 X227.96289 Y177.42185 E0.453215
G1 X227.47482 Y177.17316 E0.018171
G1 X231.20371 Y191.08957 E0.477917
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y191.55690 E0.273231
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.18873 Y184.55603 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X226.77845 Y180.86563 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X227.83873 Y184.82264 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X226.36512 Y180.89588 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X227.46565 Y185.00311 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.97232 Y181.00280 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X227.07202 Y185.10691 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.60012 Y181.18655 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X226.65781 Y185.13388 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.25118 Y181.45713 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.93297 Y181.84239 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.75212 Y184.89948 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.19831 Y182.24626 E0.237277
G1 X223.90878 Y182.73854 E0.018945
G1 X225.53941 Y188.82416 E0.208992
G1 X225.02919 Y188.49281 E0.020181
G1 X223.61819 Y183.22690 E0.180842
G1 X223.32657 Y183.71137 E0.018758
G1 X224.51897 Y188.16147 E0.152826
G1 X224.00874 Y187.83013 E0.020181
G1 X223.03392 Y184.19202 E0.124940
G1 X222.74026 Y184.66890 E0.018578
G1 X223.49852 Y187.49879 E0.097184
G1 X222.98830 Y187.16744 E0.020181
G1 X222.44560 Y185.14207 E0.069555
G1 X222.14997 Y185.61158 E0.018405
G1 X222.47808 Y186.83610 E0.042053
G1 X221.96785 Y186.50476 E0.020181
G1 X221.85336 Y186.07747 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.70187 Y239.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X127.10042 Y238.29813 I-1.70187 J0.89958 E0.100304
G2 X126.29813 Y240.89958 I0.89958 J1.70187 E0.100304
G2 X128.89958 Y241.70187 I1.70187 J-0.89958 E0.100304
G2 X129.70187 Y239.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X133.93618 Y247.58082 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.63207 Y247.88493 E0.014266
G1 X133.03005 Y247.91126 E0.019989
G1 X133.90752 Y247.03379 E0.041164
G1 X133.87885 Y246.48676 E0.018171
G1 X132.43111 Y247.93450 E0.067916
G1 X131.83521 Y247.95471 E0.019779
G1 X133.85018 Y245.93973 E0.094526
G1 X133.82151 Y245.39270 E0.018171
G1 X131.24231 Y247.97191 E0.120996
G1 X130.65236 Y247.98615 E0.019575
G1 X133.79284 Y244.84568 E0.147326
G1 X133.76417 Y244.29865 E0.018171
G1 X130.06531 Y247.99750 E0.173521
G1 X129.48112 Y248.00601 E0.019381
G1 X133.73550 Y243.75162 E0.199582
G1 X133.70684 Y243.20459 E0.018171
G1 X128.89975 Y248.01167 E0.225510
G1 X128.32116 Y248.01456 E0.019193
G1 X133.67817 Y242.65756 E0.251308
G1 X133.64950 Y242.11053 E0.018171
G1 X127.74530 Y248.01473 E0.276978
G1 X127.17215 Y248.01218 E0.019012
G1 X133.62083 Y241.56350 E0.302521
G1 X133.59216 Y241.01647 E0.018171
G1 X126.60166 Y248.00697 E0.327939
G1 X126.03379 Y247.99915 E0.018839
G1 X133.56349 Y240.46944 E0.353234
G1 X133.53482 Y239.92242 E0.018171
G1 X125.46852 Y247.98872 E0.378407
G1 X124.90578 Y247.97576 E0.018672
G1 X133.50616 Y239.37539 E0.403461
G1 X133.47749 Y238.82836 E0.018171
G1 X124.34560 Y247.96025 E0.428396
G1 X123.78787 Y247.94227 E0.018510
G1 X133.44882 Y238.28133 E0.453215
G1 X133.42015 Y237.73430 E0.018171
G1 X123.23264 Y247.92181 E0.477917
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y247.89895 E0.273231
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X127.38335 Y242.04400 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.87419 Y238.97746 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.97746 Y241.87419 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.64133 Y238.63463 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.63463 Y241.64133 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.35234 Y238.34792 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.34792 Y241.35234 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.00711 Y238.11746 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.11746 Y241.00711 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X128.59831 Y237.95056 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X128.10556 Y237.86761 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X125.86761 Y240.10556 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X127.38847 Y237.43331 E0.237277
G1 X126.81737 Y237.42871 E0.018945
G1 X122.36239 Y241.88369 E0.208992
G1 X122.39423 Y241.27615 E0.020181
G1 X126.24915 Y237.42123 E0.180842
G1 X125.68377 Y237.41091 E0.018758
G1 X122.42607 Y240.66861 E0.152826
G1 X122.45791 Y240.06108 E0.020181
G1 X125.12119 Y237.39779 E0.124940
G1 X124.56137 Y237.38192 E0.018578
G1 X122.48975 Y239.45354 E0.097184
G1 X122.52159 Y238.84600 E0.020181
G1 X124.00427 Y237.36333 E0.069555
G1 X123.44984 Y237.34205 E0.018405
G1 X122.55343 Y238.23846 E0.042053
G1 X122.58527 Y237.63093 E0.020181
G1 X122.89806 Y237.31813 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.97498 Y182.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X28.37352 Y181.29813 I-1.70187 J0.89958 E0.100304
G2 X27.57123 Y183.89958 I0.89958 J1.70187 E0.100304
G2 X30.17269 Y184.70187 I1.70187 J-0.89958 E0.100304
G2 X30.97498 Y182.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X25.67601 Y191.93130 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X25.26059 Y191.81998 E0.014266
G1 X24.93678 Y191.31178 E0.019989
G1 X26.13542 Y191.63295 E0.041164
G1 X26.59483 Y191.33461 E0.018171
G1 X24.61718 Y190.80470 E0.067916
G1 X24.30173 Y190.29874 E0.019779
G1 X27.05423 Y191.03627 E0.094526
G1 X27.51364 Y190.73793 E0.018171
G1 X23.99039 Y189.79387 E0.120996
G1 X23.68307 Y189.29009 E0.019575
G1 X27.97305 Y190.43959 E0.147326
G1 X28.43245 Y190.14124 E0.018171
G1 X23.37972 Y188.78737 E0.173521
G1 X23.08026 Y188.28569 E0.019381
G1 X28.89186 Y189.84290 E0.199582
G1 X29.35127 Y189.54456 E0.018171
G1 X22.78467 Y187.78504 E0.225510
G1 X22.49287 Y187.28542 E0.019193
G1 X29.81067 Y189.24622 E0.251308
G1 X30.27008 Y188.94787 E0.018171
G1 X22.20479 Y186.78679 E0.276978
G1 X21.92043 Y186.28915 E0.019012
G1 X30.72949 Y188.64953 E0.302521
G1 X31.18889 Y188.35119 E0.018171
G1 X21.63969 Y185.79249 E0.327939
G1 X21.36253 Y185.29678 E0.018839
G1 X31.64830 Y188.05285 E0.353234
G1 X32.10771 Y187.75451 E0.018171
G1 X21.08893 Y184.80203 E0.378407
G1 X20.81879 Y184.30821 E0.018672
G1 X32.56711 Y187.45616 E0.403461
G1 X33.02652 Y187.15782 E0.018171
G1 X20.55213 Y183.81532 E0.428396
G1 X20.28883 Y183.32333 E0.018510
G1 X33.48593 Y186.85948 E0.453215
G1 X33.94533 Y186.56114 E0.018171
G1 X20.02893 Y182.83225 E0.477917
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y182.34205 E0.273231
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.19462 Y183.48797 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X31.09574 Y184.11183 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.13874 Y183.05156 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X31.27622 Y183.73875 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.16898 Y182.63822 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X31.38002 Y183.34512 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.27590 Y182.24543 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X31.40698 Y182.93091 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.45966 Y181.87323 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X31.34713 Y182.49343 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X31.17258 Y182.02522 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X28.11550 Y181.20608 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X31.19016 Y181.18705 E0.237277
G1 X30.90859 Y180.69017 E0.018945
G1 X24.82298 Y179.05953 E0.208992
G1 X25.36504 Y178.78334 E0.020181
G1 X30.63096 Y180.19433 E0.180842
G1 X30.35721 Y179.69954 E0.018758
G1 X25.90710 Y178.50714 E0.152826
G1 X26.44916 Y178.23095 E0.020181
G1 X30.08728 Y179.20578 E0.124940
G1 X29.82111 Y178.71302 E0.018578
G1 X26.99123 Y177.95475 E0.097184
G1 X27.53329 Y177.67856 E0.020181
G1 X29.55866 Y178.22126 E0.069555
G1 X29.29988 Y177.73047 E0.018405
G1 X28.07535 Y177.40236 E0.042053
G1 X28.61741 Y177.12617 E0.020181
G1 X29.04470 Y177.24066 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.97498 Y68.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X28.37352 Y67.29813 I-1.70187 J0.89958 E0.100304
G2 X27.57123 Y69.89958 I0.89958 J1.70187 E0.100304
G2 X30.17269 Y70.70187 I1.70187 J-0.89958 E0.100304
G2 X30.97498 Y68.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X19.73983 Y70.35048 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X19.62852 Y69.93505 E0.014266
G1 X19.90673 Y69.40052 E0.019989
G1 X20.22790 Y70.59916 E0.041164
G1 X20.71598 Y70.84785 E0.018171
G1 X20.18607 Y68.87020 E0.067916
G1 X20.46652 Y68.34403 E0.019779
G1 X21.20405 Y71.09654 E0.094526
G1 X21.69213 Y71.34522 E0.018171
G1 X20.74808 Y67.82197 E0.120996
G1 X21.03071 Y67.30394 E0.019575
G1 X22.18021 Y71.59391 E0.147326
G1 X22.66828 Y71.84260 E0.018171
G1 X21.31440 Y66.78986 E0.173521
G1 X21.59914 Y66.27968 E0.019381
G1 X23.15636 Y72.09128 E0.199582
G1 X23.64443 Y72.33997 E0.018171
G1 X21.88492 Y65.77337 E0.225510
G1 X22.17171 Y65.27086 E0.019193
G1 X24.13251 Y72.58866 E0.251308
G1 X24.62058 Y72.83734 E0.018171
G1 X22.45949 Y64.77206 E0.276978
G1 X22.74828 Y64.27698 E0.019012
G1 X25.10866 Y73.08603 E0.302521
G1 X25.59673 Y73.33472 E0.018171
G1 X23.03803 Y63.78551 E0.327939
G1 X23.32874 Y63.29764 E0.018839
G1 X26.08481 Y73.58340 E0.353234
G1 X26.57288 Y73.83209 E0.018171
G1 X23.62041 Y62.81331 E0.378407
G1 X23.91300 Y62.33245 E0.018672
G1 X27.06096 Y74.08078 E0.403461
G1 X27.54903 Y74.32946 E0.018171
G1 X24.20653 Y61.85507 E0.428396
G1 X24.50096 Y61.38106 E0.018510
G1 X28.03711 Y74.57815 E0.453215
G1 X28.52518 Y74.82684 E0.018171
G1 X24.79629 Y60.91043 E0.477917
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y60.44310 E0.273231
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.81127 Y67.44397 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X29.22155 Y71.13437 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X28.16127 Y67.17736 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X29.63488 Y71.10412 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X28.53435 Y66.99689 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.02768 Y70.99720 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X28.92798 Y66.89309 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.39988 Y70.81345 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X29.34219 Y66.86612 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.74882 Y70.54287 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X31.06703 Y70.15761 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.24788 Y67.10052 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.80169 Y69.75374 E0.237277
G1 X32.09122 Y69.26146 E0.018945
G1 X30.46059 Y63.17584 E0.208992
G1 X30.97081 Y63.50719 E0.020181
G1 X32.38181 Y68.77310 E0.180842
G1 X32.67343 Y68.28863 E0.018758
G1 X31.48103 Y63.83853 E0.152826
G1 X31.99126 Y64.16987 E0.020181
G1 X32.96608 Y67.80798 E0.124940
G1 X33.25974 Y67.33110 E0.018578
G1 X32.50148 Y64.50121 E0.097184
G1 X33.01170 Y64.83256 E0.020181
G1 X33.55440 Y66.85793 E0.069555
G1 X33.85003 Y66.38842 E0.018405
G1 X33.52192 Y65.16390 E0.042053
G1 X34.03215 Y65.49524 E0.020181
G1 X34.14664 Y65.92253 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.70187 Y11.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X127.10042 Y10.29813 I-1.70187 J0.89958 E0.100304
G2 X126.29813 Y12.89958 I0.89958 J1.70187 E0.100304
G2 X128.89958 Y13.70187 I1.70187 J-0.89958 E0.100304
G2 X129.70187 Y11.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X122.06382 Y4.41918 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.36793 Y4.11507 E0.014266
G1 X122.96995 Y4.08874 E0.019989
G1 X122.09248 Y4.96621 E0.041164
G1 X122.12115 Y5.51324 E0.018171
G1 X123.56889 Y4.06550 E0.067916
G1 X124.16479 Y4.04529 E0.019779
G1 X122.14982 Y6.06027 E0.094526
G1 X122.17849 Y6.60730 E0.018171
G1 X124.75769 Y4.02809 E0.120996
G1 X125.34764 Y4.01385 E0.019575
G1 X122.20716 Y7.15432 E0.147326
G1 X122.23583 Y7.70135 E0.018171
G1 X125.93469 Y4.00250 E0.173521
G1 X126.51888 Y3.99399 E0.019381
G1 X122.26450 Y8.24838 E0.199582
G1 X122.29316 Y8.79541 E0.018171
G1 X127.10025 Y3.98833 E0.225510
G1 X127.67884 Y3.98544 E0.019193
G1 X122.32183 Y9.34244 E0.251308
G1 X122.35050 Y9.88947 E0.018171
G1 X128.25470 Y3.98527 E0.276978
G1 X128.82785 Y3.98782 E0.019012
G1 X122.37917 Y10.43650 E0.302521
G1 X122.40784 Y10.98353 E0.018171
G1 X129.39834 Y3.99303 E0.327939
G1 X129.96621 Y4.00085 E0.018839
G1 X122.43651 Y11.53056 E0.353234
G1 X122.46518 Y12.07758 E0.018171
G1 X130.53148 Y4.01128 E0.378407
G1 X131.09422 Y4.02424 E0.018672
G1 X122.49384 Y12.62461 E0.403461
G1 X122.52251 Y13.17164 E0.018171
G1 X131.65440 Y4.03975 E0.428396
G1 X132.21213 Y4.05773 E0.018510
G1 X122.55118 Y13.71867 E0.453215
G1 X122.57985 Y14.26570 E0.018171
G1 X132.76736 Y4.07819 E0.477917
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y4.10105 E0.273231
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X128.61665 Y9.95600 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.12581 Y13.02254 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.02254 Y10.12581 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.35867 Y13.36537 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.36537 Y10.35867 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.64766 Y13.65208 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.65208 Y10.64766 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.99289 Y13.88254 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.88254 Y10.99289 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X127.40169 Y14.04944 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X127.89444 Y14.13239 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X130.13239 Y11.89444 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X128.61153 Y14.56669 E0.237277
G1 X129.18263 Y14.57129 E0.018945
G1 X133.63761 Y10.11631 E0.208992
G1 X133.60577 Y10.72385 E0.020181
G1 X129.75085 Y14.57877 E0.180842
G1 X130.31623 Y14.58909 E0.018758
G1 X133.57393 Y11.33139 E0.152826
G1 X133.54209 Y11.93892 E0.020181
G1 X130.87881 Y14.60221 E0.124940
G1 X131.43863 Y14.61808 E0.018578
G1 X133.51025 Y12.54646 E0.097184
G1 X133.47841 Y13.15400 E0.020181
G1 X131.99573 Y14.63667 E0.069555
G1 X132.55016 Y14.65795 E0.018405
G1 X133.44657 Y13.76154 E0.042053
G1 X133.41473 Y14.36907 E0.020181
G1 X133.10194 Y14.68187 E0.014674
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.42877 Y68.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X225.82731 Y67.29813 I-1.70187 J0.89958 E0.100304
G2 X225.02502 Y69.89958 I0.89958 J1.70187 E0.100304
G2 X227.62648 Y70.70187 I1.70187 J-0.89958 E0.100304
G2 X228.42877 Y68.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X230.32399 Y60.06870 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X230.73941 Y60.18002 E0.014266
G1 X231.06322 Y60.68822 E0.019989
G1 X229.86458 Y60.36705 E0.041164
G1 X229.40517 Y60.66539 E0.018171
G1 X231.38282 Y61.19530 E0.067916
G1 X231.69827 Y61.70126 E0.019779
G1 X228.94577 Y60.96373 E0.094526
G1 X228.48636 Y61.26207 E0.018171
G1 X232.00961 Y62.20613 E0.120996
G1 X232.31693 Y62.70991 E0.019575
G1 X228.02695 Y61.56041 E0.147326
G1 X227.56755 Y61.85876 E0.018171
G1 X232.62028 Y63.21263 E0.173521
G1 X232.91974 Y63.71431 E0.019381
G1 X227.10814 Y62.15710 E0.199582
G1 X226.64873 Y62.45544 E0.018171
G1 X233.21533 Y64.21496 E0.225510
G1 X233.50713 Y64.71458 E0.019193
G1 X226.18933 Y62.75378 E0.251308
G1 X225.72992 Y63.05213 E0.018171
G1 X233.79521 Y65.21321 E0.276978
G1 X234.07957 Y65.71085 E0.019012
G1 X225.27051 Y63.35047 E0.302521
G1 X224.81111 Y63.64881 E0.018171
G1 X234.36031 Y66.20751 E0.327939
G1 X234.63747 Y66.70322 E0.018839
G1 X224.35170 Y63.94715 E0.353234
G1 X223.89229 Y64.24549 E0.018171
G1 X234.91107 Y67.19797 E0.378407
G1 X235.18121 Y67.69179 E0.018672
G1 X223.43289 Y64.54384 E0.403461
G1 X222.97348 Y64.84218 E0.018171
G1 X235.44787 Y68.18468 E0.428396
G1 X235.71117 Y68.67667 E0.018510
G1 X222.51407 Y65.14052 E0.453215
G1 X222.05467 Y65.43886 E0.018171
G1 X235.97107 Y69.16775 E0.477917
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y69.65795 E0.273231
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.80538 Y68.51203 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.90426 Y67.88817 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.86126 Y68.94844 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.72378 Y68.26125 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.83102 Y69.36178 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.61998 Y68.65488 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.72410 Y69.75457 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.59302 Y69.06909 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.54034 Y70.12677 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.65287 Y69.50657 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.82742 Y69.97478 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X227.88450 Y70.79392 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X224.80984 Y70.81295 E0.237277
G1 X225.09141 Y71.30983 E0.018945
G1 X231.17702 Y72.94047 E0.208992
G1 X230.63496 Y73.21666 E0.020181
G1 X225.36904 Y71.80567 E0.180842
G1 X225.64279 Y72.30046 E0.018758
G1 X230.09290 Y73.49286 E0.152826
G1 X229.55084 Y73.76905 E0.020181
G1 X225.91272 Y72.79422 E0.124940
G1 X226.17889 Y73.28698 E0.018578
G1 X229.00877 Y74.04525 E0.097184
G1 X228.46671 Y74.32144 E0.020181
G1 X226.44134 Y73.77874 E0.069555
G1 X226.70012 Y74.26953 E0.018405
G1 X227.92465 Y74.59764 E0.042053
G1 X227.38259 Y74.87383 E0.020181
G1 X226.95530 Y74.75934 E0.014674
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X236.05098 Y68.88590 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X185.11410 Y234.05098 I-108.05098 J57.11410 E6.123232
G3 X19.94902 Y183.11410 I-57.11410 J-108.05098 E6.123232
G3 X70.88590 Y17.94902 I108.05098 J-57.11410 E6.123232
G3 X236.05098 Y68.88590 I57.11410 J108.05098 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X236.39703 Y68.70298 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X185.29702 Y234.39703 I-108.39703 J57.29702 E6.142842
G3 X19.60297 Y183.29702 I-57.29702 J-108.39703 E6.142842
G3 X70.70298 Y17.60297 I108.39703 J-57.29702 E6.142842
G3 X236.39703 Y68.70298 I57.29702 J108.39703 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X236.74308 Y68.52007 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X185.47993 Y234.74308 I-108.74308 J57.47993 E6.162452
G3 X19.25692 Y183.47993 I-57.47993 J-108.74308 E6.162452
G3 X70.52007 Y17.25692 I108.74308 J-57.47993 E6.162452
G3 X236.74308 Y68.52007 I57.47993 J108.74308 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X237.08913 Y68.33715 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X185.66285 Y235.08913 I-109.08913 J57.66285 E6.182063
G3 X18.91087 Y183.66285 I-57.66285 J-109.08913 E6.182063
G3 X70.33715 Y16.91087 I109.08913 J-57.66285 E6.182063
G3 X237.08913 Y68.33715 I57.66285 J109.08913 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X237.43517 Y68.15424 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X185.84576 Y235.43517 I-109.43517 J57.84576 E6.201673
G3 X18.56483 Y183.84576 I-57.84576 J-109.43517 E6.201673
G3 X70.15424 Y16.56483 I109.43517 J-57.84576 E6.201673
G3 X237.43517 Y68.15424 I57.84576 J109.43517 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; CHANGE_LAYER
; Z_HEIGHT: 4.000
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 20/20
M73 L20
M991 S0 P19
M106 P1 S255
M106 P2 S0
; OBJECT_ID: 1
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.07965 Y184.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F2400
G2 X228.53982 Y183.64725 I0.64725 J-1.81292 E0.100304
G2 X227.37414 Y181.18708 I-1.81292 J-0.64725 E0.100304
G2 X224.91397 Y182.35275 I-0.64725 J1.81292 E0.100304
G2 X226.07965 Y184.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X236.79648 Y181.68710 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X226.99985 Y176.69547 E0.364725
G3 X221.40349 Y186.38865 I-98.99985 J-50.69547 E0.371440
G1 X230.62469 Y192.37697 E0.364725
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.95530 Y177.24066 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X227.38259 Y177.12617 E0.014674
G1 X227.92465 Y177.40236 E0.020181
G1 X226.70012 Y177.73047 E0.042053
G1 X226.44134 Y178.22126 E0.018405
G1 X228.46671 Y177.67856 E0.069555
G1 X229.00877 Y177.95475 E0.020181
G1 X226.17889 Y178.71302 E0.097184
G1 X225.91272 Y179.20578 E0.018578
G1 X229.55084 Y178.23095 E0.124940
G1 X230.09290 Y178.50714 E0.020181
G1 X225.64279 Y179.69954 E0.152826
G1 X225.36904 Y180.19433 E0.018758
G1 X230.63496 Y178.78334 E0.180842
G1 X231.17702 Y179.05953 E0.020181
G1 X225.09141 Y180.69017 E0.208992
G1 X224.80984 Y181.18705 E0.018945
G1 X231.71909 Y179.33573 E0.237277
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.52428 Y181.68501 E0.023380
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.82742 Y182.02522 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.23466 Y182.18405 E0.020356
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X227.88450 Y181.20608 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.80321 Y179.88811 E0.168918
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.94092 Y182.68420 E0.024450
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.26977 Y181.52429 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y180.16431 E0.174303
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.59302 Y182.93091 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.64298 Y183.18547 E0.032626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.54034 Y181.87323 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.88734 Y180.44050 E0.183626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.61998 Y183.34512 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.34078 Y183.68788 E0.043930
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.72410 Y182.24543 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.42940 Y180.71670 E0.195931
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.72378 Y183.73875 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X223.03426 Y184.19146 E0.058022
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.83102 Y182.63822 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X234.97146 Y180.99289 E0.210875
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.90426 Y184.11183 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.72335 Y184.69620 E0.074897
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.86126 Y183.05156 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X235.51352 Y181.26909 E0.228452
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.17086 Y184.46183 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.40796 Y185.20215 E0.094884
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.80538 Y183.48797 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.05559 Y181.54528 E0.248987
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.55039 Y184.78158 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.08800 Y185.70932 E0.118905
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.48101 Y181.85273 E0.269394
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X221.76344 Y186.21773 E0.149825
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.22769 Y182.34205 E0.273231
G1 X235.97107 Y182.83225 E0.018354
G1 X222.05467 Y186.56114 E0.477917
G1 X222.51407 Y186.85948 E0.018171
G1 X235.71117 Y183.32333 E0.453215
G1 X235.44787 Y183.81532 E0.018510
G1 X222.97348 Y187.15782 E0.428396
G1 X223.43289 Y187.45616 E0.018171
G1 X235.18121 Y184.30821 E0.403461
G1 X234.91107 Y184.80203 E0.018672
G1 X223.89229 Y187.75451 E0.378407
G1 X224.35170 Y188.05285 E0.018171
G1 X234.63747 Y185.29678 E0.353234
G1 X234.36031 Y185.79249 E0.018839
G1 X224.81111 Y188.35119 E0.327939
G1 X225.27051 Y188.64953 E0.018171
G1 X234.07957 Y186.28915 E0.302521
G1 X233.79521 Y186.78679 E0.019012
G1 X225.72992 Y188.94787 E0.276978
G1 X226.18933 Y189.24622 E0.018171
G1 X233.50713 Y187.28542 E0.251308
G1 X233.21533 Y187.78504 E0.019193
G1 X226.64873 Y189.54456 E0.225510
G1 X227.10814 Y189.84290 E0.018171
G1 X232.91974 Y188.28569 E0.199582
G1 X232.62028 Y188.78737 E0.019381
G1 X227.56755 Y190.14124 E0.173521
G1 X228.02695 Y190.43959 E0.018171
G1 X232.31693 Y189.29009 E0.147326
G1 X232.00961 Y189.79387 E0.019575
G1 X228.48636 Y190.73793 E0.120996
G1 X228.94577 Y191.03627 E0.018171
G1 X231.69827 Y190.29874 E0.094526
G1 X231.38282 Y190.80470 E0.019779
G1 X229.40517 Y191.33461 E0.067916
G1 X229.86458 Y191.63295 E0.018171
G1 X231.06322 Y191.31178 E0.041164
G1 X230.73941 Y191.81998 E0.019989
G1 X230.32399 Y191.93130 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X127.35275 Y241.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.81292 Y240.64725 I0.64725 J-1.81292 E0.100304
G2 X128.64725 Y238.18708 I-1.81292 J-0.64725 E0.100304
G2 X126.18708 Y239.35275 I-0.64725 J1.81292 E0.100304
G2 X127.35275 Y241.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X134.17180 Y248.06407 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X133.59636 Y237.08412 E0.364725
G3 X122.40364 Y237.08412 I-5.59636 J-111.08412 E0.371440
G1 X121.82820 Y248.06407 E0.364725
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X133.10194 Y237.31813 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X133.41473 Y237.63093 E0.014674
G1 X133.44657 Y238.23846 E0.020181
G1 X132.55016 Y237.34205 E0.042053
G1 X131.99573 Y237.36333 E0.018405
G1 X133.47841 Y238.84600 E0.069555
G1 X133.51025 Y239.45354 E0.020181
G1 X131.43863 Y237.38192 E0.097184
G1 X130.87881 Y237.39779 E0.018578
G1 X133.54209 Y240.06108 E0.124940
G1 X133.57393 Y240.66861 E0.020181
G1 X130.31623 Y237.41091 E0.152826
G1 X129.75085 Y237.42123 E0.018758
G1 X133.60577 Y241.27615 E0.180842
G1 X133.63761 Y241.88369 E0.020181
G1 X129.18263 Y237.42871 E0.208992
G1 X128.61153 Y237.43331 E0.018945
G1 X133.66945 Y242.49123 E0.237277
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.03751 Y237.43498 E0.023380
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X127.89444 Y237.86761 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.46051 Y237.43368 E0.020356
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X130.13239 Y240.10556 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.73313 Y243.70630 E0.168918
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.88051 Y237.42937 E0.024450
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X130.04944 Y240.59831 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y244.31384 E0.174303
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.99289 Y238.11746 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X126.29742 Y237.42199 E0.032626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.88254 Y241.00711 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.79681 Y244.92137 E0.183626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.64766 Y238.34792 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.71122 Y237.41148 E0.043930
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.65208 Y241.35234 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.82865 Y245.52891 E0.195931
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.35867 Y238.63463 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X125.12185 Y237.39781 E0.058022
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.36537 Y241.64133 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.86049 Y246.13645 E0.210875
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.12581 Y238.97746 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.52927 Y237.38093 E0.074897
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.02254 Y241.87419 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.89233 Y246.74399 E0.228452
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X125.95600 Y239.38335 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.93341 Y237.36077 E0.094884
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X128.61665 Y242.04400 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.92417 Y247.35152 E0.248987
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X125.86885 Y239.87191 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.33421 Y237.33726 E0.118905
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.87062 Y247.87367 E0.269394
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.73163 Y237.31039 E0.149825
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.32020 Y247.89895 E0.273231
G1 X132.76736 Y247.92181 E0.018354
G1 X122.57985 Y237.73430 E0.477917
G1 X122.55118 Y238.28133 E0.018171
G1 X132.21213 Y247.94227 E0.453215
G1 X131.65440 Y247.96025 E0.018510
G1 X122.52251 Y238.82836 E0.428396
G1 X122.49384 Y239.37539 E0.018171
G1 X131.09422 Y247.97576 E0.403461
G1 X130.53148 Y247.98872 E0.018672
G1 X122.46518 Y239.92242 E0.378407
G1 X122.43651 Y240.46944 E0.018171
G1 X129.96621 Y247.99915 E0.353234
G1 X129.39834 Y248.00697 E0.018839
G1 X122.40784 Y241.01647 E0.327939
G1 X122.37917 Y241.56350 E0.018171
G1 X128.82785 Y248.01218 E0.302521
G1 X128.25470 Y248.01473 E0.019012
G1 X122.35050 Y242.11053 E0.276978
G1 X122.32183 Y242.65756 E0.018171
G1 X127.67884 Y248.01456 E0.251308
G1 X127.10025 Y248.01167 E0.019193
G1 X122.29316 Y243.20459 E0.225510
G1 X122.26450 Y243.75162 E0.018171
G1 X126.51888 Y248.00601 E0.199582
G1 X125.93469 Y247.99750 E0.019381
G1 X122.23583 Y244.29865 E0.173521
G1 X122.20716 Y244.84568 E0.018171
G1 X125.34764 Y247.98615 E0.147326
G1 X124.75769 Y247.97191 E0.019575
G1 X122.17849 Y245.39270 E0.120996
G1 X122.14982 Y245.93973 E0.018171
G1 X124.16479 Y247.95471 E0.094526
G1 X123.56889 Y247.93450 E0.019779
G1 X122.12115 Y246.48676 E0.067916
G1 X122.09248 Y247.03379 E0.018171
G1 X122.96995 Y247.91126 E0.041164
G1 X122.36793 Y247.88493 E0.019989
G1 X122.06382 Y247.58082 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.62586 Y184.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X31.08603 Y183.64725 I0.64725 J-1.81292 E0.100304
G2 X29.92035 Y181.18708 I-1.81292 J-0.64725 E0.100304
G2 X27.46018 Y182.35275 I-0.64725 J1.81292 E0.100304
G2 X28.62586 Y184.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X25.37531 Y192.37697 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X34.59651 Y186.38865 E0.364725
G3 X29.00015 Y176.69547 I93.40349 J-60.38865 E0.371440
G1 X19.20352 Y181.68710 E0.364725
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X34.14664 Y186.07747 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X34.03215 Y186.50476 E0.014674
G1 X33.52192 Y186.83610 E0.020181
G1 X33.85003 Y185.61158 E0.042053
G1 X33.55440 Y185.14207 E0.018405
G1 X33.01170 Y187.16744 E0.069555
G1 X32.50148 Y187.49879 E0.020181
G1 X33.25974 Y184.66890 E0.097184
G1 X32.96608 Y184.19202 E0.018578
G1 X31.99126 Y187.83013 E0.124940
G1 X31.48103 Y188.16147 E0.020181
G1 X32.67343 Y183.71137 E0.152826
G1 X32.38181 Y183.22690 E0.018758
G1 X30.97081 Y188.49281 E0.180842
G1 X30.46059 Y188.82416 E0.020181
G1 X32.09122 Y182.73854 E0.208992
G1 X31.80169 Y182.24626 E0.018945
G1 X29.95036 Y189.15550 E0.237277
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.51323 Y181.74997 E0.023380
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X31.06703 Y181.84239 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.22585 Y181.24963 E0.020356
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.24788 Y184.89948 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.92992 Y189.81819 E0.168918
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.93958 Y180.74518 E0.024450
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X29.77967 Y185.07402 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y190.14953 E0.174303
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.39988 Y181.18655 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.65444 Y180.23652 E0.032626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X29.34219 Y185.13388 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.90947 Y190.48087 E0.183626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.02768 Y181.00280 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.37044 Y179.72359 E0.043930
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.92798 Y185.10691 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X27.39925 Y190.81221 E0.195931
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X29.63488 Y180.89588 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.08759 Y179.20636 E0.058022
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.53435 Y185.00311 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.88903 Y191.14356 E0.210875
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X29.22155 Y180.86563 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.80592 Y178.68473 E0.074897
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.16127 Y184.82264 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X26.37880 Y191.47490 E0.228452
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.78513 Y180.92152 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.52545 Y178.15861 E0.094884
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.81127 Y184.55603 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.86858 Y191.80624 E0.248987
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.31846 Y181.09033 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.24621 Y177.62794 E0.118905
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.38961 Y192.02094 E0.269394
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.96820 Y177.09265 E0.149825
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.09251 Y191.55690 E0.273231
G1 X24.79629 Y191.08957 E0.018354
G1 X28.52518 Y177.17316 E0.477917
G1 X28.03711 Y177.42185 E0.018171
G1 X24.50096 Y190.61894 E0.453215
G1 X24.20653 Y190.14493 E0.018510
G1 X27.54903 Y177.67054 E0.428396
G1 X27.06096 Y177.91922 E0.018171
G1 X23.91300 Y189.66755 E0.403461
G1 X23.62041 Y189.18669 E0.018672
G1 X26.57288 Y178.16791 E0.378407
G1 X26.08481 Y178.41660 E0.018171
G1 X23.32874 Y188.70236 E0.353234
G1 X23.03803 Y188.21449 E0.018839
G1 X25.59673 Y178.66528 E0.327939
G1 X25.10866 Y178.91397 E0.018171
G1 X22.74828 Y187.72302 E0.302521
G1 X22.45949 Y187.22794 E0.019012
G1 X24.62058 Y179.16266 E0.276978
G1 X24.13251 Y179.41134 E0.018171
G1 X22.17171 Y186.72914 E0.251308
G1 X21.88492 Y186.22663 E0.019193
G1 X23.64443 Y179.66003 E0.225510
G1 X23.15636 Y179.90872 E0.018171
G1 X21.59914 Y185.72032 E0.199582
G1 X21.31440 Y185.21014 E0.019381
G1 X22.66828 Y180.15740 E0.173521
G1 X22.18021 Y180.40609 E0.018171
G1 X21.03071 Y184.69606 E0.147326
G1 X20.74808 Y184.17803 E0.019575
G1 X21.69213 Y180.65478 E0.120996
G1 X21.20405 Y180.90346 E0.018171
G1 X20.46652 Y183.65597 E0.094526
G1 X20.18607 Y183.12980 E0.019779
G1 X20.71598 Y181.15215 E0.067916
G1 X20.22790 Y181.40084 E0.018171
G1 X19.90673 Y182.59948 E0.041164
G1 X19.62852 Y182.06495 E0.019989
G1 X19.73983 Y181.64952 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.62586 Y70.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X31.08603 Y69.64725 I0.64725 J-1.81292 E0.100304
G2 X29.92035 Y67.18708 I-1.81292 J-0.64725 E0.100304
G2 X27.46018 Y68.35275 I-0.64725 J1.81292 E0.100304
G2 X28.62586 Y70.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X19.20352 Y70.31290 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X29.00015 Y75.30453 E0.364725
G3 X34.59651 Y65.61135 I98.99985 J50.69547 E0.371440
G1 X25.37531 Y59.62303 E0.364725
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X29.04470 Y74.75934 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X28.61741 Y74.87383 E0.014674
G1 X28.07535 Y74.59764 E0.020181
G1 X29.29988 Y74.26953 E0.042053
G1 X29.55866 Y73.77874 E0.018405
G1 X27.53329 Y74.32144 E0.069555
G1 X26.99123 Y74.04525 E0.020181
G1 X29.82111 Y73.28698 E0.097184
G1 X30.08728 Y72.79422 E0.018578
G1 X26.44916 Y73.76905 E0.124940
G1 X25.90710 Y73.49286 E0.020181
G1 X30.35721 Y72.30046 E0.152826
G1 X30.63096 Y71.80567 E0.018758
G1 X25.36504 Y73.21666 E0.180842
G1 X24.82298 Y72.94047 E0.020181
G1 X30.90859 Y71.30983 E0.208992
G1 X31.19016 Y70.81295 E0.018945
G1 X24.28091 Y72.66427 E0.237277
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.47572 Y70.31499 E0.023380
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X31.17258 Y69.97478 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.76534 Y69.81595 E0.020356
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.11550 Y70.79392 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.19679 Y72.11189 E0.168918
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.05908 Y69.31580 E0.024450
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.73023 Y70.47571 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y71.83569 E0.174303
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X31.40698 Y69.06909 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.35702 Y68.81453 E0.032626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.45966 Y70.12677 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.11266 Y71.55950 E0.183626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X31.38002 Y68.65488 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.65922 Y68.31212 E0.043930
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.27590 Y69.75457 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.57060 Y71.28330 E0.195931
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X31.27622 Y68.26125 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X32.96574 Y67.80854 E0.058022
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.16898 Y69.36178 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X21.02854 Y71.00711 E0.210875
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X31.09574 Y67.88817 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.27665 Y67.30380 E0.074897
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.13874 Y68.94844 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X20.48648 Y70.73091 E0.228452
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.82914 Y67.53817 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.59204 Y66.79785 E0.094884
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.19462 Y68.51203 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.94441 Y70.45472 E0.248987
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.44961 Y67.21842 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.91200 Y66.29068 E0.118905
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.51899 Y70.14727 E0.269394
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X34.23656 Y65.78227 E0.149825
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.77231 Y69.65795 E0.273231
G1 X20.02893 Y69.16775 E0.018354
G1 X33.94533 Y65.43886 E0.477917
G1 X33.48593 Y65.14052 E0.018171
G1 X20.28883 Y68.67667 E0.453215
G1 X20.55213 Y68.18468 E0.018510
G1 X33.02652 Y64.84218 E0.428396
G1 X32.56711 Y64.54384 E0.018171
G1 X20.81879 Y67.69179 E0.403461
G1 X21.08893 Y67.19797 E0.018672
G1 X32.10771 Y64.24549 E0.378407
G1 X31.64830 Y63.94715 E0.018171
G1 X21.36253 Y66.70322 E0.353234
G1 X21.63969 Y66.20751 E0.018839
G1 X31.18889 Y63.64881 E0.327939
G1 X30.72949 Y63.35047 E0.018171
G1 X21.92043 Y65.71085 E0.302521
G1 X22.20479 Y65.21321 E0.019012
G1 X30.27008 Y63.05213 E0.276978
G1 X29.81067 Y62.75378 E0.018171
G1 X22.49287 Y64.71458 E0.251308
G1 X22.78467 Y64.21496 E0.019193
G1 X29.35127 Y62.45544 E0.225510
G1 X28.89186 Y62.15710 E0.018171
G1 X23.08026 Y63.71431 E0.199582
G1 X23.37972 Y63.21263 E0.019381
G1 X28.43245 Y61.85876 E0.173521
G1 X27.97305 Y61.56041 E0.018171
G1 X23.68307 Y62.70991 E0.147326
G1 X23.99039 Y62.20613 E0.019575
G1 X27.51364 Y61.26207 E0.120996
G1 X27.05423 Y60.96373 E0.018171
G1 X24.30173 Y61.70126 E0.094526
G1 X24.61718 Y61.19530 E0.019779
G1 X26.59483 Y60.66539 E0.067916
G1 X26.13542 Y60.36705 E0.018171
G1 X24.93678 Y60.68822 E0.041164
G1 X25.26059 Y60.18002 E0.019989
G1 X25.67601 Y60.06870 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X127.35275 Y13.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X129.81292 Y12.64725 I0.64725 J-1.81292 E0.100304
G2 X128.64725 Y10.18708 I-1.81292 J-0.64725 E0.100304
G2 X126.18708 Y11.35275 I-0.64725 J1.81292 E0.100304
G2 X127.35275 Y13.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X121.82820 Y3.93593 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X122.40364 Y14.91588 E0.364725
G3 X133.59636 Y14.91588 I5.59636 J111.08412 E0.371440
G1 X134.17180 Y3.93593 E0.364725
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X122.89806 Y14.68187 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X122.58527 Y14.36907 E0.014674
G1 X122.55343 Y13.76154 E0.020181
G1 X123.44984 Y14.65795 E0.042053
G1 X124.00427 Y14.63667 E0.018405
G1 X122.52159 Y13.15400 E0.069555
G1 X122.48975 Y12.54646 E0.020181
G1 X124.56137 Y14.61808 E0.097184
G1 X125.12119 Y14.60221 E0.018578
G1 X122.45791 Y11.93892 E0.124940
G1 X122.42607 Y11.33139 E0.020181
G1 X125.68377 Y14.58909 E0.152826
G1 X126.24915 Y14.57877 E0.018758
G1 X122.39423 Y10.72385 E0.180842
G1 X122.36239 Y10.11631 E0.020181
G1 X126.81737 Y14.57129 E0.208992
G1 X127.38847 Y14.56669 E0.018945
G1 X122.33055 Y9.50877 E0.237277
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.96249 Y14.56502 E0.023380
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X128.10556 Y14.13239 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.53949 Y14.56632 E0.020356
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X125.86761 Y11.89444 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.26687 Y8.29370 E0.168918
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.11949 Y14.57063 E0.024450
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X125.95056 Y11.40169 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y7.68616 E0.174303
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.00711 Y13.88254 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X129.70258 Y14.57801 E0.032626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.11746 Y10.99289 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.20319 Y7.07863 E0.183626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.35234 Y13.65208 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.28878 Y14.58852 E0.043930
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.34792 Y10.64766 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.17135 Y6.47109 E0.195931
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.64133 Y13.36537 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X130.87815 Y14.60219 E0.058022
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.63463 Y10.35867 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.13951 Y5.86355 E0.210875
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.87419 Y13.02254 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.47073 Y14.61907 E0.074897
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.97746 Y10.12581 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.10767 Y5.25601 E0.228452
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X130.04400 Y12.61665 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.06659 Y14.63923 E0.094884
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X127.38335 Y9.95600 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.07583 Y4.64848 E0.248987
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X130.13115 Y12.12809 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.66579 Y14.66274 E0.118905
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.12938 Y4.12633 E0.269394
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.26837 Y14.68961 E0.149825
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.67980 Y4.10105 E0.273231
G1 X123.23264 Y4.07819 E0.018354
G1 X133.42015 Y14.26570 E0.477917
G1 X133.44882 Y13.71867 E0.018171
G1 X123.78787 Y4.05773 E0.453215
G1 X124.34560 Y4.03975 E0.018510
G1 X133.47749 Y13.17164 E0.428396
G1 X133.50616 Y12.62461 E0.018171
G1 X124.90578 Y4.02424 E0.403461
G1 X125.46852 Y4.01128 E0.018672
G1 X133.53482 Y12.07758 E0.378407
G1 X133.56349 Y11.53056 E0.018171
G1 X126.03379 Y4.00085 E0.353234
G1 X126.60166 Y3.99303 E0.018839
G1 X133.59216 Y10.98353 E0.327939
G1 X133.62083 Y10.43650 E0.018171
G1 X127.17215 Y3.98782 E0.302521
G1 X127.74530 Y3.98527 E0.019012
G1 X133.64950 Y9.88947 E0.276978
G1 X133.67817 Y9.34244 E0.018171
G1 X128.32116 Y3.98544 E0.251308
G1 X128.89975 Y3.98833 E0.019193
G1 X133.70684 Y8.79541 E0.225510
G1 X133.73550 Y8.24838 E0.018171
G1 X129.48112 Y3.99399 E0.199582
G1 X130.06531 Y4.00250 E0.019381
G1 X133.76417 Y7.70135 E0.173521
G1 X133.79284 Y7.15432 E0.018171
G1 X130.65236 Y4.01385 E0.147326
G1 X131.24231 Y4.02809 E0.019575
G1 X133.82151 Y6.60730 E0.120996
G1 X133.85018 Y6.06027 E0.018171
G1 X131.83521 Y4.04529 E0.094526
G1 X132.43111 Y4.06550 E0.019779
G1 X133.87885 Y5.51324 E0.067916
G1 X133.90752 Y4.96621 E0.018171
G1 X133.03005 Y4.08874 E0.041164
G1 X133.63207 Y4.11507 E0.019989
G1 X133.93618 Y4.41918 E0.014266
; LOCAL_MOUNTING_PAD_END
; LOCAL_MOUNTING_PAD_START
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.07965 Y70.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
M204 S1000
G1 F2400
G2 X228.53982 Y69.64725 I0.64725 J-1.81292 E0.100304
G2 X227.37414 Y67.18708 I-1.81292 J-0.64725 E0.100304
G2 X224.91397 Y68.35275 I-0.64725 J1.81292 E0.100304
G2 X226.07965 Y70.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X230.62469 Y59.62303 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
G1 X221.40349 Y65.61135 E0.364725
G3 X226.99985 Y75.30453 I-93.40349 J60.38865 E0.371440
G1 X236.79648 Y70.31290 E0.364725
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X221.85336 Y65.92253 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X221.96785 Y65.49524 E0.014674
G1 X222.47808 Y65.16390 E0.020181
G1 X222.14997 Y66.38842 E0.042053
G1 X222.44560 Y66.85793 E0.018405
G1 X222.98830 Y64.83256 E0.069555
G1 X223.49852 Y64.50121 E0.020181
G1 X222.74026 Y67.33110 E0.097184
G1 X223.03392 Y67.80798 E0.018578
G1 X224.00874 Y64.16987 E0.124940
G1 X224.51897 Y63.83853 E0.020181
G1 X223.32657 Y68.28863 E0.152826
G1 X223.61819 Y68.77310 E0.018758
G1 X225.02919 Y63.50719 E0.180842
G1 X225.53941 Y63.17584 E0.020181
G1 X223.90878 Y69.26146 E0.208992
G1 X224.19831 Y69.75374 E0.018945
G1 X226.04964 Y62.84450 E0.237277
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.48677 Y70.25003 E0.023380
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.93297 Y70.15761 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.77415 Y70.75037 E0.020356
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.75212 Y67.10052 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.07008 Y62.18181 E0.168918
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.06042 Y71.25482 E0.024450
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.22033 Y66.92598 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y61.85047 E0.174303
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.60012 Y70.81345 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.34556 Y71.76348 E0.032626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.65781 Y66.86612 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.09053 Y61.51913 E0.183626
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.97232 Y70.99720 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.62956 Y72.27641 E0.043930
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X227.07202 Y66.89309 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X228.60075 Y61.18779 E0.195931
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.36512 Y71.10412 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.91241 Y72.79364 E0.058022
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X227.46565 Y66.99689 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.11097 Y60.85644 E0.210875
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.77845 Y71.13437 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.19408 Y73.31527 E0.074897
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X227.83873 Y67.17736 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X229.62120 Y60.52510 E0.228452
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X227.21487 Y71.07848 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.47455 Y73.84139 E0.094884
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.18873 Y67.44397 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.13142 Y60.19376 E0.248987
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X227.68154 Y70.90967 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.75379 Y74.37206 E0.118905
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.61039 Y59.97906 E0.269394
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.03180 Y74.90735 E0.149825
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.90749 Y60.44310 E0.273231
G1 X231.20371 Y60.91043 E0.018354
G1 X227.47482 Y74.82684 E0.477917
G1 X227.96289 Y74.57815 E0.018171
G1 X231.49904 Y61.38106 E0.453215
G1 X231.79347 Y61.85507 E0.018510
G1 X228.45097 Y74.32946 E0.428396
G1 X228.93904 Y74.08078 E0.018171
G1 X232.08700 Y62.33245 E0.403461
G1 X232.37959 Y62.81331 E0.018672
G1 X229.42712 Y73.83209 E0.378407
G1 X229.91519 Y73.58340 E0.018171
G1 X232.67126 Y63.29764 E0.353234
G1 X232.96197 Y63.78551 E0.018839
G1 X230.40327 Y73.33472 E0.327939
G1 X230.89134 Y73.08603 E0.018171
G1 X233.25172 Y64.27698 E0.302521
G1 X233.54051 Y64.77206 E0.019012
G1 X231.37942 Y72.83734 E0.276978
G1 X231.86749 Y72.58866 E0.018171
G1 X233.82829 Y65.27086 E0.251308
G1 X234.11508 Y65.77337 E0.019193
G1 X232.35557 Y72.33997 E0.225510
G1 X232.84364 Y72.09128 E0.018171
G1 X234.40086 Y66.27968 E0.199582
G1 X234.68560 Y66.78986 E0.019381
G1 X233.33172 Y71.84260 E0.173521
G1 X233.81979 Y71.59391 E0.018171
G1 X234.96929 Y67.30394 E0.147326
G1 X235.25192 Y67.82197 E0.019575
G1 X234.30787 Y71.34522 E0.120996
G1 X234.79595 Y71.09654 E0.018171
G1 X235.53348 Y68.34403 E0.094526
G1 X235.81393 Y68.87020 E0.019779
G1 X235.28402 Y70.84785 E0.067916
G1 X235.77210 Y70.59916 E0.018171
G1 X236.09327 Y69.40052 E0.041164
G1 X236.37148 Y69.93505 E0.019989
G1 X236.26017 Y70.35048 E0.014266
; LOCAL_MOUNTING_PAD_END
; CONCENTRIC_RING_PASS: 5/5
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X86.90659 Y241.10155 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.43434
M204 S1000
G1 F3600
G3 X12.89845 Y84.90659 I41.09341 J-115.10155 E6.123232
G3 X169.09341 Y10.89845 I115.10155 J41.09341 E6.123232
G3 X243.10155 Y167.09341 I-41.09341 J115.10155 E6.123232
G3 X86.90659 Y241.10155 I-115.10155 J-41.09341 E6.123232
; CONCENTRIC_RING_PASS: 4/5
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X86.77498 Y241.47018 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X12.52982 Y84.77498 I41.22502 J-115.47018 E6.142842
G3 X169.22502 Y10.52982 I115.47018 J41.22502 E6.142842
G3 X243.47018 Y167.22502 I-41.22502 J115.47018 E6.142842
G3 X86.77498 Y241.47018 I-115.47018 J-41.22502 E6.142842
; CONCENTRIC_RING_PASS: 3/5
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X86.64338 Y241.83881 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X12.16119 Y84.64338 I41.35662 J-115.83881 E6.162452
G3 X169.35662 Y10.16119 I115.83881 J41.35662 E6.162452
G3 X243.83881 Y167.35662 I-41.35662 J115.83881 E6.162452
G3 X86.64338 Y241.83881 I-115.83881 J-41.35662 E6.162452
; CONCENTRIC_RING_PASS: 2/5
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X86.51177 Y242.20744 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X11.79256 Y84.51177 I41.48823 J-116.20744 E6.182063
G3 X169.48823 Y9.79256 I116.20744 J41.48823 E6.182063
G3 X244.20744 Y167.48823 I-41.48823 J116.20744 E6.182063
G3 X86.51177 Y242.20744 I-116.20744 J-41.48823 E6.182063
; CONCENTRIC_RING_PASS: 1/5
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X86.38016 Y242.57606 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X11.42394 Y84.38016 I41.61984 J-116.57606 E6.201673
G3 X169.61984 Y9.42394 I116.57606 J41.61984 E6.201673
G3 X244.57606 Y167.61984 I-41.61984 J116.57606 E6.201673
G3 X86.38016 Y242.57606 I-116.57606 J-41.61984 E6.201673
; ANALYTIC_ROLLING_SURFACE_END
; HANDCRAFTED_TIRE_BODY_END
M1003 S0
M106 S0
M106 P2 S0
M981 S0 P20000
; MACHINE_END_GCODE_START
; filament end gcode 

;===== date: 20230428 =====================
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z4.5 F900 ; lower z a little
G1 X65 Y245 F12000 ; move to safe pos 
G1 Y265 F3000

G1 X65 Y245 F12000
G1 Y265 F3000
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

G1 X100 F12000 ; wipe
; pull back filament to AMS
M620 S255
G1 X20 Y50 F12000
G1 Y-3
T255
G1 X65 F12000
G1 Y265
G1 X100 F12000 ; wipe
M621 S255
M104 S0 ; turn off hotend

M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S3 ;wait for last picture to be taken
M623; end of "timelapse_record_flag"

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z112 F600
    G1 Z110

M400 P100
M17 R ; restore z current

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power
M73 P100 R0
; EXECUTABLE_BLOCK_END

