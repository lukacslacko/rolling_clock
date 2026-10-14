; HEADER_BLOCK_START
; BambuStudio 02.05.00.66
; Custom analytic path generator; version line above selects the Bambu preview dialect.
; model printing time: 1h 34m 19s; total estimated time: 1h 52m 50s
; total layer number: 20
; total filament length [mm] : 8070.22
; total filament volume [cm^3] : 19.411
; total filament weight [g] : 24.46
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
; bottom_shell_thickness = 0.6
; bottom_surface_density = 100%
; bottom_surface_pattern = concentric
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
; sparse_infill_density = 10%
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
; top_shell_layers = 3
; top_shell_thickness = 0.6
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = concentric
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
; wall_loops = 3
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
; 248 mm OD / 222 mm ID / 4 mm thick; 0.6 mm bottom and top concentric skins around a 2.8 mm zigzag core.
; First layers: radial compensation 0.15 / 0.075 / 0 mm; three full concentric layers on each face, 0.5 mm zigzag core and solid screw seats.
; Requires the same P1S 0.4 / PLA / textured PEI setup as the supplied job.
; Retains source T0 / AMS slot 0 selection. Inspect preview before printing.
M73 P0 R113
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
; CONCENTRIC_SOLID_SKIN
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X234.96946 Y158.70385 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.50000
M204 S1000
G1 F1500
G2 X160.70385 Y19.03054 I-106.96946 J-32.70385 E6.544332
G2 X21.03054 Y93.29615 I-32.70385 J106.96946 E6.544332
G2 X95.29615 Y232.96946 I106.96946 J32.70385 E6.544332
G2 X234.96946 Y158.70385 I32.70385 J-106.96946 E6.544332
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X234.53235 Y158.57021 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G2 X160.57021 Y19.46765 I-106.53235 J-32.57021 E6.517590
G2 X21.46765 Y93.42979 I-32.57021 J106.53235 E6.517590
G2 X95.42979 Y232.53235 I106.53235 J32.57021 E6.517590
G2 X234.53235 Y158.57021 I32.57021 J-106.53235 E6.517590
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X245.32505 Y161.86987 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G3 X92.13013 Y243.32505 I-117.32505 J-35.86987 E7.177881
G3 X10.67495 Y90.13013 I35.86987 J-117.32505 E7.177881
G3 X163.86987 Y8.67495 I117.32505 J35.86987 E7.177881
G3 X245.32505 Y161.86987 I-35.86987 J117.32505 E7.177881
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X245.76216 Y162.00351 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G3 X91.99649 Y243.76216 I-117.76216 J-36.00351 E7.204623
G3 X10.23784 Y89.99649 I36.00351 J-117.76216 E7.204623
G3 X164.00351 Y8.23784 I117.76216 J36.00351 E7.204623
G3 X245.76216 Y162.00351 I-36.00351 J117.76216 E7.204623
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.73514 Y183.61398 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G2 X227.34088 Y180.99176 I-2.00824 J-0.61398 E0.122863
G2 X224.71866 Y182.38602 I-0.61398 J2.00824 E0.122863
G2 X226.11292 Y185.00824 I2.00824 J0.61398 E0.122863
G2 X228.73514 Y183.61398 I0.61398 J-2.00824 E0.122863
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.00824 Y240.61398 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G2 X128.61398 Y237.99176 I-2.00824 J-0.61398 E0.122863
G2 X125.99176 Y239.38602 I-0.61398 J2.00824 E0.122863
G2 X127.38602 Y242.00824 I2.00824 J0.61398 E0.122863
G2 X130.00824 Y240.61398 I0.61398 J-2.00824 E0.122863
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.28134 Y183.61398 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G2 X29.88708 Y180.99176 I-2.00824 J-0.61398 E0.122863
G2 X27.26486 Y182.38602 I-0.61398 J2.00824 E0.122863
G2 X28.65912 Y185.00824 I2.00824 J0.61398 E0.122863
G2 X31.28134 Y183.61398 I0.61398 J-2.00824 E0.122863
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.28134 Y69.61398 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G2 X29.88708 Y66.99176 I-2.00824 J-0.61398 E0.122863
G2 X27.26486 Y68.38602 I-0.61398 J2.00824 E0.122863
G2 X28.65912 Y71.00824 I2.00824 J0.61398 E0.122863
G2 X31.28134 Y69.61398 I0.61398 J-2.00824 E0.122863
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.00824 Y12.61398 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G2 X128.61398 Y9.99176 I-2.00824 J-0.61398 E0.122863
G2 X125.99176 Y11.38602 I-0.61398 J2.00824 E0.122863
G2 X127.38602 Y14.00824 I2.00824 J0.61398 E0.122863
G2 X130.00824 Y12.61398 I0.61398 J-2.00824 E0.122863
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.73514 Y69.61398 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F1500
G2 X227.34088 Y66.99176 I-2.00824 J-0.61398 E0.122863
G2 X224.71866 Y68.38602 I-0.61398 J2.00824 E0.122863
G2 X226.11292 Y71.00824 I2.00824 J0.61398 E0.122863
G2 X228.73514 Y69.61398 I0.61398 J-2.00824 E0.122863
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.38587 Y183.26299 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.49150
M204 S500
G1 F1500
G3 X129.39827 Y238.10411 I-96.38587 J-57.26299 E4.189291
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X126.60173 Y238.10411 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X31.61413 Y183.26299 I1.39827 J-112.10411 E4.189291
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.21586 Y180.84112 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X30.21586 Y71.15888 I97.78414 J-54.84112 E4.189291
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.61413 Y68.73701 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X126.60173 Y13.89589 I96.38587 J57.26299 E4.189291
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.39827 Y13.89589 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X224.38587 Y68.73701 I-1.39827 J112.10411 E4.189291
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.78414 Y71.15888 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X225.78414 Y180.84112 I-97.78414 J54.84112 E4.189291
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.54102 Y183.87834 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X129.85360 Y238.54614 I-96.54102 J-57.87834 E4.173170
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X126.14640 Y238.54614 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X31.45898 Y183.87834 I1.85360 J-112.54614 E4.173170
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X29.60538 Y180.66780 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X29.60538 Y71.33220 I98.39462 J-54.66780 E4.173170
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.45898 Y68.12166 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X126.14640 Y13.45386 I96.54102 J57.87834 E4.173170
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.85360 Y13.45386 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X224.54102 Y68.12166 I-1.85360 J112.54614 E4.173170
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X226.39462 Y71.33220 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X226.39462 Y180.66780 I-98.39462 J54.66780 E4.173170
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X224.78805 Y184.33806 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X130.12822 Y238.98994 I-96.78805 J-58.33806 E4.170261
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.87178 Y238.98994 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X31.21195 Y184.33806 I2.12822 J-112.98994 E4.170261
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X29.08373 Y180.65188 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X29.08373 Y71.34812 I98.91627 J-54.65188 E4.170261
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X31.21195 Y67.66194 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X125.87178 Y13.01006 I96.78805 J58.33806 E4.170261
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.12822 Y13.01006 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X224.78805 Y67.66194 I-2.12822 J112.98994 E4.170261
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X226.91627 Y71.34812 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X226.91627 Y180.65188 I-98.91627 J54.65188 E4.170261
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.09447 Y184.69845 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X130.28712 Y239.43550 I-97.09447 J-58.69845 E4.175814
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.71288 Y239.43550 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X30.90553 Y184.69845 I2.28712 J-113.43550 E4.175814
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X28.61841 Y180.73705 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X28.61841 Y71.26295 I99.38159 J-54.73705 E4.175814
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.90553 Y67.30155 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X125.71288 Y12.56450 I97.09447 J58.69845 E4.175814
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.28712 Y12.56450 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X225.09447 Y67.30155 I-2.28712 J113.43550 E4.175814
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X227.38159 Y71.26295 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X227.38159 Y180.73705 I-99.38159 J54.73705 E4.175814
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.44901 Y184.97903 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X130.35283 Y239.88283 I-97.44901 J-58.97903 E4.188179
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.64717 Y239.88283 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X30.55099 Y184.97903 I2.35283 J-113.88283 E4.188179
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X28.19816 Y180.90380 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X28.19816 Y71.09620 I99.80184 J-54.90380 E4.188179
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.55099 Y67.02097 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X125.64717 Y12.11717 I97.44901 J58.97903 E4.188179
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.35283 Y12.11717 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X225.44901 Y67.02097 I-2.35283 J113.88283 E4.188179
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X227.80184 Y71.09620 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X227.80184 Y180.90380 I-99.80184 J54.90380 E4.188179
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X225.84823 Y185.18575 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X130.33225 Y240.33193 I-97.84823 J-59.18575 E4.206856
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.66775 Y240.33193 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X30.15177 Y185.18575 I2.33225 J-114.33193 E4.206856
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.81952 Y181.14618 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X27.81952 Y70.85382 I100.18048 J-55.14618 E4.206856
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X30.15177 Y66.81425 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X125.66775 Y11.66807 I97.84823 J59.18575 E4.206856
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.33225 Y11.66807 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X225.84823 Y66.81425 I-2.33225 J114.33193 E4.206856
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.18048 Y70.85382 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X228.18048 Y181.14618 I-100.18048 J55.14618 E4.206856
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X226.29386 Y185.31561 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X130.22189 Y240.78279 I-98.29386 J-59.31561 E4.232096
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.77811 Y240.78279 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X29.70614 Y185.31561 I2.22189 J-114.78279 E4.232096
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.48425 Y181.46718 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X27.48425 Y70.53282 I100.51575 J-55.46718 E4.232096
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X29.70614 Y66.68439 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X125.77811 Y11.21721 I98.29386 J59.31561 E4.232096
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.22189 Y11.21721 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X226.29386 Y66.68439 I-2.22189 J114.78279 E4.232096
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.51575 Y70.53282 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X228.51575 Y181.46718 I-100.51575 J55.46718 E4.232096
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X226.79388 Y185.35480 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X130.00582 Y241.23541 I-98.79388 J-59.35480 E4.265066
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X125.99418 Y241.23541 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X29.20612 Y185.35480 I2.00582 J-115.23541 E4.265066
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.20030 Y181.88061 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X27.20030 Y70.11939 I100.79970 J-55.88061 E4.265066
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X29.20612 Y66.64520 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X125.99418 Y10.76459 I98.79388 J59.35480 E4.265066
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X130.00582 Y10.76459 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X226.79388 Y66.64520 I-2.00582 J115.23541 E4.265066
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.79970 Y70.11939 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X228.79970 Y181.88061 I-100.79970 J55.88061 E4.265066
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X227.36961 Y185.26638 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X129.64138 Y241.68980 I-99.36961 J-59.26638 E4.308883
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X126.35862 Y241.68980 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X28.63039 Y185.26638 I1.64138 J-115.68980 E4.308883
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X26.98900 Y182.42342 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X26.98900 Y69.57658 I101.01100 J-56.42342 E4.308883
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X28.63039 Y66.73362 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X126.35862 Y10.31020 I99.36961 J59.26638 E4.308883
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X129.64138 Y10.31020 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X227.36961 Y66.73362 I-1.64138 J115.68980 E4.308883
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X229.01100 Y69.57658 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X229.01100 Y182.42342 I-101.01100 J56.42342 E4.308883
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.09943 Y184.91460 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X128.97182 Y242.14595 I-100.09943 J-58.91460 E4.375006
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X127.02818 Y242.14595 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X27.90057 Y184.91460 I0.97182 J-116.14595 E4.375006
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X26.92874 Y183.23135 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X26.92874 Y68.76865 I101.07126 J-57.23135 E4.375006
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X27.90057 Y67.08540 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X127.02818 Y9.85405 I100.09943 J58.91460 E4.375006
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X128.97182 Y9.85405 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X228.09943 Y67.08540 I-0.97182 J116.14595 E4.375006
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X229.07126 Y68.76865 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X229.07126 Y183.23135 I-101.07126 J57.23135 E4.375006
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X228.97735 Y184.29930 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X69.70070 Y226.97735 I-100.97735 J-58.29930 E6.694837
G3 X27.02265 Y67.70070 I58.29930 J-100.97735 E6.694837
G3 X186.29930 Y25.02265 I100.97735 J58.29930 E6.694837
G3 X228.97735 Y184.29930 I-58.29930 J100.97735 E6.694837
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X229.36582 Y184.52359 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X69.47641 Y227.36582 I-101.36582 J-58.52359 E6.720593
G3 X26.63418 Y67.47641 I58.52359 J-101.36582 E6.720593
G3 X186.52359 Y24.63418 I101.36582 J58.52359 E6.720593
G3 X229.36582 Y184.52359 I-58.52359 J101.36582 E6.720593
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X229.75430 Y184.74787 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X69.25213 Y227.75430 I-101.75430 J-58.74787 E6.746349
G3 X26.24570 Y67.25213 I58.74787 J-101.75430 E6.746349
G3 X186.74787 Y24.24570 I101.75430 J58.74787 E6.746349
G3 X229.75430 Y184.74787 I-58.74787 J101.75430 E6.746349
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X230.14278 Y184.97216 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X69.02784 Y228.14278 I-102.14278 J-58.97216 E6.772106
G3 X25.85722 Y67.02784 I58.97216 J-102.14278 E6.772106
G3 X186.97216 Y23.85722 I102.14278 J58.97216 E6.772106
G3 X230.14278 Y184.97216 I-58.97216 J102.14278 E6.772106
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X230.53126 Y185.19645 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X68.80355 Y228.53126 I-102.53126 J-59.19645 E6.797862
G3 X25.46874 Y66.80355 I59.19645 J-102.53126 E6.797862
G3 X187.19645 Y23.46874 I102.53126 J59.19645 E6.797862
G3 X230.53126 Y185.19645 I-59.19645 J102.53126 E6.797862
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X230.91974 Y185.42074 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X68.57926 Y228.91974 I-102.91974 J-59.42074 E6.823618
G3 X25.08026 Y66.57926 I59.42074 J-102.91974 E6.823618
G3 X187.42074 Y23.08026 I102.91974 J59.42074 E6.823618
G3 X230.91974 Y185.42074 I-59.42074 J102.91974 E6.823618
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X231.30822 Y185.64503 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X68.35497 Y229.30822 I-103.30822 J-59.64503 E6.849375
G3 X24.69178 Y66.35497 I59.64503 J-103.30822 E6.849375
G3 X187.64503 Y22.69178 I103.30822 J59.64503 E6.849375
G3 X231.30822 Y185.64503 I-59.64503 J103.30822 E6.849375
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X231.69670 Y185.86932 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X68.13068 Y229.69670 I-103.69670 J-59.86932 E6.875131
G3 X24.30330 Y66.13068 I59.86932 J-103.69670 E6.875131
G3 X187.86932 Y22.30330 I103.69670 J59.86932 E6.875131
G3 X231.69670 Y185.86932 I-59.86932 J103.69670 E6.875131
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X232.08518 Y186.09360 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X67.90640 Y230.08518 I-104.08518 J-60.09360 E6.900887
G3 X23.91482 Y65.90640 I60.09360 J-104.08518 E6.900887
G3 X188.09360 Y21.91482 I104.08518 J60.09360 E6.900887
G3 X232.08518 Y186.09360 I-60.09360 J104.08518 E6.900887
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X232.47365 Y186.31789 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X67.68211 Y230.47365 I-104.47365 J-60.31789 E6.926643
G3 X23.52635 Y65.68211 I60.31789 J-104.47365 E6.926643
G3 X188.31789 Y21.52635 I104.47365 J60.31789 E6.926643
G3 X232.47365 Y186.31789 I-60.31789 J104.47365 E6.926643
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X232.86213 Y186.54218 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X67.45782 Y230.86213 I-104.86213 J-60.54218 E6.952400
G3 X23.13787 Y65.45782 I60.54218 J-104.86213 E6.952400
G3 X188.54218 Y21.13787 I104.86213 J60.54218 E6.952400
G3 X232.86213 Y186.54218 I-60.54218 J104.86213 E6.952400
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X233.25061 Y186.76647 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X67.23353 Y231.25061 I-105.25061 J-60.76647 E6.978156
G3 X22.74939 Y65.23353 I60.76647 J-105.25061 E6.978156
G3 X188.76647 Y20.74939 I105.25061 J60.76647 E6.978156
G3 X233.25061 Y186.76647 I-60.76647 J105.25061 E6.978156
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X233.63909 Y186.99076 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X67.00924 Y231.63909 I-105.63909 J-60.99076 E7.003912
G3 X22.36091 Y65.00924 I60.99076 J-105.63909 E7.003912
G3 X188.99076 Y20.36091 I105.63909 J60.99076 E7.003912
G3 X233.63909 Y186.99076 I-60.99076 J105.63909 E7.003912
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X234.02757 Y187.21505 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X66.78495 Y232.02757 I-106.02757 J-61.21505 E7.029669
G3 X21.97243 Y64.78495 I61.21505 J-106.02757 E7.029669
G3 X189.21505 Y19.97243 I106.02757 J61.21505 E7.029669
G3 X234.02757 Y187.21505 I-61.21505 J106.02757 E7.029669
G1 E-0.8 F1800
G1 Z0.600 F1200
G1 X246.19927 Y162.13714 F12000
G1 Z0.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.50000
M204 S500
G1 F1500
; ANALYTIC_ROLLING_SURFACE_START
G3 X91.86286 Y244.19927 I-118.19927 J-36.13714 E7.231365
G3 X9.80073 Y89.86286 I36.13714 J-118.19927 E7.231365
G3 X164.13714 Y7.80073 I118.19927 J36.13714 E7.231365
G3 X246.19927 Y162.13714 I-36.13714 J118.19927 E7.231365
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
; CONCENTRIC_SOLID_SKIN
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.16832 Y174.07747 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X176.07747 Y226.83168 I100.83168 J-48.07747 E5.820631
G2 X228.83168 Y77.92253 I-48.07747 J-100.83168 E5.820631
G2 X79.92253 Y25.16832 I-100.83168 J48.07747 E5.820631
G2 X27.16832 Y174.07747 I48.07747 J100.83168 E5.820631
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.53577 Y173.90227 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X175.90227 Y226.46423 I100.46423 J-47.90227 E5.799419
G2 X228.46423 Y78.09773 I-47.90227 J-100.46423 E5.799419
G2 X80.09773 Y25.53577 I-100.46423 J47.90227 E5.799419
G2 X27.53577 Y173.90227 I47.90227 J100.46423 E5.799419
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X17.05080 Y178.90160 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X75.09840 Y15.05080 I110.94920 J-52.90160 E6.404677
G3 X238.94920 Y73.09840 I52.90160 J110.94920 E6.404677
G3 X180.90160 Y236.94920 I-110.94920 J52.90160 E6.404677
G3 X17.05080 Y178.90160 I-52.90160 J-110.94920 E6.404677
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X16.68335 Y179.07680 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X74.92320 Y14.68335 I111.31665 J-53.07680 E6.425888
G3 X239.31665 Y72.92320 I53.07680 J111.31665 E6.425888
G3 X181.07680 Y237.31665 I-111.31665 J53.07680 E6.425888
G3 X16.68335 Y179.07680 I-53.07680 J-111.31665 E6.425888
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.92161 Y183.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X227.58767 Y184.80529 I1.80529 J-0.86078 E0.104212
G2 X228.53218 Y182.13922 I-0.86078 J-1.80529 E0.104212
G2 X225.86612 Y181.19471 I-1.80529 J0.86078 E0.104212
G2 X224.92161 Y183.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.19471 Y240.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X128.86078 Y241.80529 I1.80529 J-0.86078 E0.104212
G2 X129.80529 Y239.13922 I-0.86078 J-1.80529 E0.104212
G2 X127.13922 Y238.19471 I-1.80529 J0.86078 E0.104212
G2 X126.19471 Y240.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.46782 Y183.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X30.13388 Y184.80529 I1.80529 J-0.86078 E0.104212
G2 X31.07839 Y182.13922 I-0.86078 J-1.80529 E0.104212
G2 X28.41233 Y181.19471 I-1.80529 J0.86078 E0.104212
G2 X27.46782 Y183.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.46782 Y69.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X30.13388 Y70.80529 I1.80529 J-0.86078 E0.104212
G2 X31.07839 Y68.13922 I-0.86078 J-1.80529 E0.104212
G2 X28.41233 Y67.19471 I-1.80529 J0.86078 E0.104212
G2 X27.46782 Y69.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.19471 Y12.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X128.86078 Y13.80529 I1.80529 J-0.86078 E0.104212
G2 X129.80529 Y11.13922 I-0.86078 J-1.80529 E0.104212
G2 X127.13922 Y10.19471 I-1.80529 J0.86078 E0.104212
G2 X126.19471 Y12.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.92161 Y69.86078 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X227.58767 Y70.80529 I1.80529 J-0.86078 E0.104212
G2 X228.53218 Y68.13922 I-0.86078 J-1.80529 E0.104212
G2 X225.86612 Y67.19471 I-1.80529 J0.86078 E0.104212
G2 X224.92161 Y69.86078 I0.86078 J1.80529 E0.104212
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.56260 Y182.57109 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.44277
M204 S500
G1 F3600
G3 X128.71070 Y237.91121 I-96.56260 J-56.57109 E3.772248
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X127.28930 Y237.91121 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.43740 Y182.57109 I0.71070 J-111.91121 E3.772248
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.72670 Y181.34012 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.72670 Y70.65988 I97.27330 J-55.34012 E3.772248
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.43740 Y69.42891 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X127.28930 Y14.08879 I96.56260 J56.57109 E3.772248
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X128.71070 Y14.08879 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.56260 Y69.42891 I-0.71070 J111.91121 E3.772248
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.27330 Y70.65988 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.27330 Y181.34012 I-97.27330 J55.34012 E3.772248
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.55259 Y183.37489 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.41182 Y238.30444 I-96.55259 J-57.37489 E3.740200
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.58818 Y238.30444 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.44741 Y183.37489 I1.41182 J-112.30444 E3.740200
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.03559 Y180.92955 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.03559 Y71.07045 I97.96441 J-54.92955 E3.740200
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.44741 Y68.62511 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.58818 Y13.69556 I96.55259 J57.37489 E3.740200
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.41182 Y13.69556 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.55259 Y68.62511 I-1.41182 J112.30444 E3.740200
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.96441 Y71.07045 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.96441 Y180.92955 I-97.96441 J54.92955 E3.740200
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.70924 Y183.89285 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.78206 Y238.69908 I-96.70924 J-57.89285 E3.729713
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.21794 Y238.69908 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.29076 Y183.89285 I1.78206 J-112.69908 E3.729713
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X29.50870 Y180.80623 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.50870 Y71.19377 I98.49130 J-54.80623 E3.729713
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.29076 Y68.10715 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.21794 Y13.30092 I96.70924 J57.89285 E3.729713
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.78206 Y13.30092 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.70924 Y68.10715 I-1.78206 J112.69908 E3.729713
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X226.49130 Y71.19377 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.49130 Y180.80623 I-98.49130 J54.80623 E3.729713
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X224.93710 Y184.29026 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.01229 Y239.09512 I-96.93710 J-58.29026 E3.728351
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X125.98771 Y239.09512 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.06290 Y184.29026 I2.01229 J-113.09512 E3.728351
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X29.05061 Y180.80486 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.05061 Y71.19514 I98.94939 J-54.80486 E3.728351
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X31.06290 Y67.70974 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.98771 Y12.90488 I96.93710 J58.29026 E3.728351
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X130.01229 Y12.90488 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.93710 Y67.70974 I-2.01229 J113.09512 E3.728351
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X226.94939 Y71.19514 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.94939 Y180.80486 I-98.94939 J54.80486 E3.728351
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.21382 Y184.60585 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.14724 Y239.49256 I-97.21382 J-58.60585 E3.733199
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X125.85276 Y239.49256 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.78618 Y184.60585 I2.14724 J-113.49256 E3.733199
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.63894 Y180.88672 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.63894 Y71.11328 I99.36106 J-54.88672 E3.733199
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.78618 Y67.39415 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.85276 Y12.50744 I97.21382 J58.60585 E3.733199
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X130.14724 Y12.50744 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.21382 Y67.39415 I-2.14724 J113.49256 E3.733199
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.36106 Y71.11328 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.36106 Y180.88672 I-99.36106 J54.88672 E3.733199
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.53099 Y184.85417 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.20371 Y239.89140 I-97.53099 J-58.85417 E3.743162
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X125.79629 Y239.89140 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.46901 Y184.85417 I2.20371 J-113.89140 E3.743162
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.26529 Y181.03723 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.26529 Y70.96277 I99.73471 J-55.03723 E3.743162
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.46901 Y67.14583 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.79629 Y12.10860 I97.53099 J58.85417 E3.743162
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X130.20371 Y12.10860 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.53099 Y67.14583 I-2.20371 J113.89140 E3.743162
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.73471 Y70.96277 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.73471 Y181.03723 I-99.73471 J55.03723 E3.743162
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X225.88596 Y185.03984 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.18702 Y240.29165 I-97.88596 J-59.03984 E3.757893
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X125.81298 Y240.29165 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.11404 Y185.03984 I2.18702 J-114.29165 E3.757893
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.92701 Y181.25181 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.92701 Y70.74819 I100.07299 J-55.25181 E3.757893
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X30.11404 Y66.96016 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.81298 Y11.70835 I97.88596 J59.03984 E3.757893
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X130.18702 Y11.70835 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.88596 Y66.96016 I-2.18702 J114.29165 E3.757893
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.07299 Y70.74819 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.07299 Y181.25181 I-100.07299 J55.25181 E3.757893
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X226.28000 Y185.16065 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.09463 Y240.69330 I-98.28000 J-59.16065 E3.777558
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X125.90537 Y240.69330 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.72000 Y185.16065 I2.09463 J-114.69330 E3.777558
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.62537 Y181.53265 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.62537 Y70.46735 I100.37463 J-55.53265 E3.777558
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X29.72000 Y66.83935 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.90537 Y11.30670 I98.28000 J59.16065 E3.777558
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X130.09463 Y11.30670 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.28000 Y66.83935 I-2.09463 J114.69330 E3.777558
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.37463 Y70.46735 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.37463 Y181.53265 I-100.37463 J55.53265 E3.777558
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X226.71900 Y185.20637 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.91472 Y241.09635 I-98.71900 J-59.20637 E3.802927
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.08528 Y241.09635 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.28100 Y185.20637 I1.91472 J-115.09635 E3.802927
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.36628 Y181.88998 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.36628 Y70.11002 I100.63372 J-55.88998 E3.802927
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X29.28100 Y66.79363 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.08528 Y10.90365 I98.71900 J59.20637 E3.802927
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.91472 Y10.90365 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.71900 Y66.79363 I-1.91472 J115.09635 E3.802927
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.63372 Y70.11002 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.63372 Y181.88998 I-100.63372 J55.88998 E3.802927
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.21797 Y185.15104 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.61732 Y241.50081 I-99.21797 J-59.15104 E3.835953
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.38268 Y241.50081 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.78203 Y185.15104 I1.61732 J-115.50081 E3.835953
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.16471 Y182.34976 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.16471 Y69.65024 I100.83529 J-56.34976 E3.835953
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.78203 Y66.84896 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.38268 Y10.49919 I99.21797 J59.15104 E3.835953
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.61732 Y10.49919 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.21797 Y66.84896 I-1.61732 J115.50081 E3.835953
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.83529 Y69.65024 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.83529 Y182.34976 I-100.83529 J56.34976 E3.835953
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X227.82296 Y184.91488 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.11031 Y241.90666 I-99.82296 J-58.91488 E3.882638
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X126.88969 Y241.90666 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.17704 Y184.91488 I1.11031 J-115.90666 E3.882638
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X27.06673 Y182.99178 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.06673 Y69.00822 I100.93327 J-56.99178 E3.882638
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X28.17704 Y67.08512 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.88969 Y10.09334 I99.82296 J58.91488 E3.882638
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X129.11031 Y10.09334 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.82296 Y67.08512 I-1.11031 J115.90666 E3.882638
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.93327 Y69.00822 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.93327 Y182.99178 I-100.93327 J56.99178 E3.882638
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X228.72900 Y184.15592 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.84408 Y226.72900 I-100.72900 J-58.15592 E5.952954
G3 X27.27100 Y67.84408 I58.15592 J-100.72900 E5.952954
G3 X186.15592 Y25.27100 I100.72900 J58.15592 E5.952954
G3 X228.72900 Y184.15592 I-58.15592 J100.72900 E5.952954
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X229.07528 Y184.35584 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.64416 Y227.07528 I-101.07528 J-58.35584 E5.973419
G3 X26.92472 Y67.64416 I58.35584 J-101.07528 E5.973419
G3 X186.35584 Y24.92472 I101.07528 J58.35584 E5.973419
G3 X229.07528 Y184.35584 I-58.35584 J101.07528 E5.973419
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X229.42156 Y184.55577 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.44423 Y227.42156 I-101.42156 J-58.55577 E5.993884
G3 X26.57844 Y67.44423 I58.55577 J-101.42156 E5.993884
G3 X186.55577 Y24.57844 I101.42156 J58.55577 E5.993884
G3 X229.42156 Y184.55577 I-58.55577 J101.42156 E5.993884
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X229.76785 Y184.75569 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.24431 Y227.76785 I-101.76785 J-58.75569 E6.014349
G3 X26.23215 Y67.24431 I58.75569 J-101.76785 E6.014349
G3 X186.75569 Y24.23215 I101.76785 J58.75569 E6.014349
G3 X229.76785 Y184.75569 I-58.75569 J101.76785 E6.014349
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X230.11413 Y184.95562 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.04438 Y228.11413 I-102.11413 J-58.95562 E6.034813
G3 X25.88587 Y67.04438 I58.95562 J-102.11413 E6.034813
G3 X186.95562 Y23.88587 I102.11413 J58.95562 E6.034813
G3 X230.11413 Y184.95562 I-58.95562 J102.11413 E6.034813
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X230.46041 Y185.15554 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.84446 Y228.46041 I-102.46041 J-59.15554 E6.055278
G3 X25.53959 Y66.84446 I59.15554 J-102.46041 E6.055278
G3 X187.15554 Y23.53959 I102.46041 J59.15554 E6.055278
G3 X230.46041 Y185.15554 I-59.15554 J102.46041 E6.055278
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X230.80669 Y185.35547 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.64453 Y228.80669 I-102.80669 J-59.35547 E6.075743
G3 X25.19331 Y66.64453 I59.35547 J-102.80669 E6.075743
G3 X187.35547 Y23.19331 I102.80669 J59.35547 E6.075743
G3 X230.80669 Y185.35547 I-59.35547 J102.80669 E6.075743
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X231.15297 Y185.55540 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.44460 Y229.15297 I-103.15297 J-59.55540 E6.096208
G3 X24.84703 Y66.44460 I59.55540 J-103.15297 E6.096208
G3 X187.55540 Y22.84703 I103.15297 J59.55540 E6.096208
G3 X231.15297 Y185.55540 I-59.55540 J103.15297 E6.096208
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X231.49925 Y185.75532 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.24468 Y229.49925 I-103.49925 J-59.75532 E6.116673
G3 X24.50075 Y66.24468 I59.75532 J-103.49925 E6.116673
G3 X187.75532 Y22.50075 I103.49925 J59.75532 E6.116673
G3 X231.49925 Y185.75532 I-59.75532 J103.49925 E6.116673
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X231.84553 Y185.95525 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.04475 Y229.84553 I-103.84553 J-59.95525 E6.137137
G3 X24.15447 Y66.04475 I59.95525 J-103.84553 E6.137137
G3 X187.95525 Y22.15447 I103.84553 J59.95525 E6.137137
G3 X231.84553 Y185.95525 I-59.95525 J103.84553 E6.137137
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X232.19182 Y186.15517 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.84483 Y230.19182 I-104.19182 J-60.15517 E6.157602
G3 X23.80818 Y65.84483 I60.15517 J-104.19182 E6.157602
G3 X188.15517 Y21.80818 I104.19182 J60.15517 E6.157602
G3 X232.19182 Y186.15517 I-60.15517 J104.19182 E6.157602
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X232.53810 Y186.35510 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.64490 Y230.53810 I-104.53810 J-60.35510 E6.178067
G3 X23.46190 Y65.64490 I60.35510 J-104.53810 E6.178067
G3 X188.35510 Y21.46190 I104.53810 J60.35510 E6.178067
G3 X232.53810 Y186.35510 I-60.35510 J104.53810 E6.178067
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X232.88438 Y186.55502 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.44498 Y230.88438 I-104.88438 J-60.55502 E6.198532
G3 X23.11562 Y65.44498 I60.55502 J-104.88438 E6.198532
G3 X188.55502 Y21.11562 I104.88438 J60.55502 E6.198532
G3 X232.88438 Y186.55502 I-60.55502 J104.88438 E6.198532
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X233.23066 Y186.75495 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.24505 Y231.23066 I-105.23066 J-60.75495 E6.218997
G3 X22.76934 Y65.24505 I60.75495 J-105.23066 E6.218997
G3 X188.75495 Y20.76934 I105.23066 J60.75495 E6.218997
G3 X233.23066 Y186.75495 I-60.75495 J105.23066 E6.218997
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X233.57694 Y186.95488 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.04512 Y231.57694 I-105.57694 J-60.95488 E6.239461
G3 X22.42306 Y65.04512 I60.95488 J-105.57694 E6.239461
G3 X188.95488 Y20.42306 I105.57694 J60.95488 E6.239461
G3 X233.57694 Y186.95488 I-60.95488 J105.57694 E6.239461
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X233.92322 Y187.15480 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X66.84520 Y231.92322 I-105.92322 J-61.15480 E6.259926
G3 X22.07678 Y64.84520 I61.15480 J-105.92322 E6.259926
G3 X189.15480 Y20.07678 I105.92322 J61.15480 E6.259926
G3 X233.92322 Y187.15480 I-61.15480 J105.92322 E6.259926
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X234.26951 Y187.35473 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X66.64527 Y232.26951 I-106.26951 J-61.35473 E6.280391
G3 X21.73049 Y64.64527 I61.35473 J-106.26951 E6.280391
G3 X189.35473 Y19.73049 I106.26951 J61.35473 E6.280391
G3 X234.26951 Y187.35473 I-61.35473 J106.26951 E6.280391
G1 E-0.8 F1800
G1 Z0.800 F1200
G1 X16.32945 Y179.24555 F12000
G1 Z0.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X74.75445 Y14.32945 I111.67055 J-53.24555 E5.971252
G3 X239.67055 Y72.75445 I53.24555 J111.67055 E5.971252
G3 X181.24555 Y237.67055 I-111.67055 J53.24555 E5.971252
G3 X16.32945 Y179.24555 I-53.24555 J-111.67055 E5.971252
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
; CONCENTRIC_SOLID_SKIN
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X169.84616 Y22.50788 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X24.50788 Y84.15384 I-41.84616 J103.49212 E5.816723
G2 X86.15384 Y229.49212 I103.49212 J41.84616 E5.816723
G2 X231.49212 Y167.84616 I41.84616 J-103.49212 E5.816723
G2 X169.84616 Y22.50788 I-103.49212 J-41.84616 E5.816723
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X169.69357 Y22.88527 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X24.88527 Y84.30643 I-41.69357 J103.11473 E5.795511
G2 X86.30643 Y229.11473 I103.11473 J41.69357 E5.795511
G2 X231.11473 Y167.69357 I41.69357 J-103.11473 E5.795511
G2 X169.69357 Y22.88527 I-103.11473 J-41.69357 E5.795511
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X174.10408 Y11.97737 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X242.02263 Y172.10408 I-46.10408 J114.02263 E6.408584
G3 X81.89592 Y240.02263 I-114.02263 J-46.10408 E6.408584
G3 X13.97737 Y79.89592 I46.10408 J-114.02263 E6.408584
G3 X174.10408 Y11.97737 I114.02263 J46.10408 E6.408584
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X174.25668 Y11.59997 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X242.40003 Y172.25668 I-46.25668 J114.40003 E6.429796
G3 X81.74332 Y240.40003 I-114.40003 J-46.25668 E6.429796
G3 X13.59997 Y79.74332 I46.25668 J-114.40003 E6.429796
G3 X174.25668 Y11.59997 I114.40003 J46.25668 E6.429796
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.44850 Y181.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X224.94226 Y182.27840 I-0.72160 J1.78463 E0.100304
G2 X226.00529 Y184.78463 I1.78463 J0.72160 E0.100304
G2 X228.51153 Y183.72160 I0.72160 J-1.78463 E0.100304
G2 X227.44850 Y181.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X128.72160 Y238.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X126.21537 Y239.27840 I-0.72160 J1.78463 E0.100304
G2 X127.27840 Y241.78463 I1.78463 J0.72160 E0.100304
G2 X129.78463 Y240.72160 I0.72160 J-1.78463 E0.100304
G2 X128.72160 Y238.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.99471 Y181.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X27.48847 Y182.27840 I-0.72160 J1.78463 E0.100304
G2 X28.55150 Y184.78463 I1.78463 J0.72160 E0.100304
G2 X31.05774 Y183.72160 I0.72160 J-1.78463 E0.100304
G2 X29.99471 Y181.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.99471 Y67.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X27.48847 Y68.27840 I-0.72160 J1.78463 E0.100304
G2 X28.55150 Y70.78463 I1.78463 J0.72160 E0.100304
G2 X31.05774 Y69.72160 I0.72160 J-1.78463 E0.100304
G2 X29.99471 Y67.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X128.72160 Y10.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X126.21537 Y11.27840 I-0.72160 J1.78463 E0.100304
G2 X127.27840 Y13.78463 I1.78463 J0.72160 E0.100304
G2 X129.78463 Y12.72160 I0.72160 J-1.78463 E0.100304
G2 X128.72160 Y10.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.44850 Y67.21537 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X224.94226 Y68.27840 I-0.72160 J1.78463 E0.100304
G2 X226.00529 Y70.78463 I1.78463 J0.72160 E0.100304
G2 X228.51153 Y69.72160 I0.72160 J-1.78463 E0.100304
G2 X227.44850 Y67.21537 I-1.78463 J-0.72160 E0.100304
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.85727 Y181.92057 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.44813
M204 S500
G1 F3600
G3 X72.07943 Y222.85727 I-96.85727 J-55.92057 E5.800831
G3 X31.14273 Y70.07943 I55.92057 J-96.85727 E5.800831
G3 X183.92057 Y29.14273 I96.85727 J55.92057 E5.800831
G3 X224.85727 Y181.92057 I-55.92057 J96.85727 E5.800831
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.59922 Y183.16498 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.20671 Y238.23987 I-96.59922 J-57.16498 E3.801541
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.79329 Y238.23987 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.40078 Y183.16498 I1.20671 J-112.23987 E3.801541
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.19407 Y181.07489 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.19407 Y70.92511 I97.80593 J-55.07489 E3.801541
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X31.40078 Y68.83502 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.79329 Y13.76013 I96.59922 J57.16498 E3.801541
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.20671 Y13.76013 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.59922 Y68.83502 I-1.20671 J112.23987 E3.801541
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.80593 Y70.92511 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.80593 Y181.07489 I-97.80593 J55.07489 E3.801541
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.72661 Y183.74371 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.64421 Y238.63956 I-96.72661 J-57.74371 E3.786658
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.35579 Y238.63956 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.27339 Y183.74371 I1.64421 J-112.63956 E3.786658
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.62917 Y180.89585 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.62917 Y71.10415 I98.37083 J-54.89585 E3.786658
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X31.27339 Y68.25629 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.35579 Y13.36044 I96.72661 J57.74371 E3.786658
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.64421 Y13.36044 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.72661 Y68.25629 I-1.64421 J112.63956 E3.786658
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X226.37083 Y71.10415 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.37083 Y180.89585 I-98.37083 J54.89585 E3.786658
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X224.94297 Y184.17125 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.90630 Y239.04070 I-96.94297 J-58.17125 E3.783359
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.09370 Y239.04070 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.05703 Y184.17125 I1.90630 J-113.04070 E3.783359
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.15074 Y180.86945 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.15074 Y71.13055 I98.84926 J-54.86945 E3.783359
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X31.05703 Y67.82875 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.09370 Y12.95930 I96.94297 J58.17125 E3.783359
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.90630 Y12.95930 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.94297 Y67.82875 I-1.90630 J113.04070 E3.783359
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X226.84926 Y71.13055 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.84926 Y180.86945 I-98.84926 J54.86945 E3.783359
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.21467 Y184.50579 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.06017 Y239.44327 I-97.21467 J-58.50579 E3.787207
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X125.93983 Y239.44327 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.78533 Y184.50579 I2.06017 J-113.44327 E3.787207
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X28.72516 Y180.93748 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.72516 Y71.06252 I99.27484 J-54.93748 E3.787207
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.78533 Y67.49421 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.93983 Y12.55673 I97.21467 J58.50579 E3.787207
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X130.06017 Y12.55673 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.21467 Y67.49421 I-2.06017 J113.44327 E3.787207
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.27484 Y71.06252 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.27484 Y180.93748 I-99.27484 J54.93748 E3.787207
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.53035 Y184.76706 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.12859 Y239.84729 I-97.53035 J-58.76706 E3.796699
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X125.87141 Y239.84729 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.46965 Y184.76706 I2.12859 J-113.84729 E3.796699
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X28.34106 Y181.08023 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.34106 Y70.91977 I99.65894 J-55.08023 E3.796699
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.46965 Y67.23294 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.87141 Y12.15271 I97.53035 J58.76706 E3.796699
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X130.12859 Y12.15271 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.53035 Y67.23294 I-2.12859 J113.84729 E3.796699
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.65894 Y70.91977 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.65894 Y181.08023 I-99.65894 J55.08023 E3.796699
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X225.88626 Y184.96152 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.11904 Y240.25275 I-97.88626 J-58.96152 E3.811341
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X125.88096 Y240.25275 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.11374 Y184.96152 I2.11904 J-114.25275 E3.811341
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.99470 Y181.29123 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.99470 Y70.70877 I100.00530 J-55.29123 E3.811341
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X30.11374 Y67.03848 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.88096 Y11.74725 I97.88626 J58.96152 E3.811341
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X130.11904 Y11.74725 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.88626 Y67.03848 I-2.11904 J114.25275 E3.811341
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.00530 Y70.70877 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.00530 Y181.29123 I-100.00530 J55.29123 E3.811341
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X226.28339 Y185.08747 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.02956 Y240.65964 I-98.28339 J-59.08747 E3.831263
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X125.97044 Y240.65964 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.71661 Y185.08747 I2.02956 J-114.65964 E3.831263
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.68706 Y181.57217 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.68706 Y70.42783 I100.31294 J-55.57217 E3.831263
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.71661 Y66.91253 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.97044 Y11.34036 I98.28339 J59.08747 E3.831263
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X130.02956 Y11.34036 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.28339 Y66.91253 I-2.02956 J114.65964 E3.831263
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.31294 Y70.42783 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.31294 Y181.57217 I-100.31294 J55.57217 E3.831263
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X226.72799 Y185.13406 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.84761 Y241.06798 I-98.72799 J-59.13406 E3.857292
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.15239 Y241.06798 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.27201 Y185.13406 I1.84761 J-115.06798 E3.857292
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.42440 Y181.93392 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.42440 Y70.06608 I100.57560 J-55.93392 E3.857292
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X29.27201 Y66.86594 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.15239 Y10.93202 I98.72799 J59.13406 E3.857292
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.84761 Y10.93202 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.72799 Y66.86594 I-1.84761 J115.06798 E3.857292
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.57560 Y70.06608 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.57560 Y181.93392 I-100.57560 J55.93392 E3.857292
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.23686 Y185.07224 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.53963 Y241.47776 I-99.23686 J-59.07224 E3.891643
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X126.46037 Y241.47776 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.76314 Y185.07224 I1.53963 J-115.47776 E3.891643
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.22351 Y182.40552 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.22351 Y69.59448 I100.77649 J-56.40552 E3.891643
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X28.76314 Y66.92776 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.46037 Y10.52224 I99.23686 J59.07224 E3.891643
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X129.53963 Y10.52224 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.23686 Y66.92776 I-1.53963 J115.47776 E3.891643
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.77649 Y69.59448 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.77649 Y182.40552 I-100.77649 J56.40552 E3.891643
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X227.86631 Y184.80443 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X128.99298 Y241.88898 I-99.86631 J-58.80443 E3.941757
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X127.00702 Y241.88898 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.13369 Y184.80443 I0.99298 J-115.88898 E3.941757
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X27.14071 Y183.08455 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.14071 Y68.91545 I100.85929 J-57.08455 E3.941757
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X28.13369 Y67.19557 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X127.00702 Y10.11102 I99.86631 J58.80443 E3.941757
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X128.99298 Y10.11102 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.86631 Y67.19557 I-0.99298 J115.88898 E3.941757
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.85929 Y68.91545 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.85929 Y183.08455 I-100.85929 J57.08455 E3.941757
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X228.71740 Y184.14922 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.85078 Y226.71740 I-100.71740 J-58.14922 E6.032016
G3 X27.28260 Y67.85078 I58.14922 J-100.71740 E6.032016
G3 X186.14922 Y25.28260 I100.71740 J58.14922 E6.032016
G3 X228.71740 Y184.14922 I-58.14922 J100.71740 E6.032016
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X229.06832 Y184.35182 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.64818 Y227.06832 I-101.06832 J-58.35182 E6.053033
G3 X26.93168 Y67.64818 I58.35182 J-101.06832 E6.053033
G3 X186.35182 Y24.93168 I101.06832 J58.35182 E6.053033
G3 X229.06832 Y184.35182 I-58.35182 J101.06832 E6.053033
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X229.41924 Y184.55443 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.44557 Y227.41924 I-101.41924 J-58.55443 E6.074050
G3 X26.58076 Y67.44557 I58.55443 J-101.41924 E6.074050
G3 X186.55443 Y24.58076 I101.41924 J58.55443 E6.074050
G3 X229.41924 Y184.55443 I-58.55443 J101.41924 E6.074050
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X229.77017 Y184.75703 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.24297 Y227.77017 I-101.77017 J-58.75703 E6.095067
G3 X26.22983 Y67.24297 I58.75703 J-101.77017 E6.095067
G3 X186.75703 Y24.22983 I101.77017 J58.75703 E6.095067
G3 X229.77017 Y184.75703 I-58.75703 J101.77017 E6.095067
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X230.12109 Y184.95964 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.04036 Y228.12109 I-102.12109 J-58.95964 E6.116084
G3 X25.87891 Y67.04036 I58.95964 J-102.12109 E6.116084
G3 X186.95964 Y23.87891 I102.12109 J58.95964 E6.116084
G3 X230.12109 Y184.95964 I-58.95964 J102.12109 E6.116084
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X230.47201 Y185.16224 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.83776 Y228.47201 I-102.47201 J-59.16224 E6.137100
G3 X25.52799 Y66.83776 I59.16224 J-102.47201 E6.137100
G3 X187.16224 Y23.52799 I102.47201 J59.16224 E6.137100
G3 X230.47201 Y185.16224 I-59.16224 J102.47201 E6.137100
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X230.82293 Y185.36485 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.63515 Y228.82293 I-102.82293 J-59.36485 E6.158117
G3 X25.17707 Y66.63515 I59.36485 J-102.82293 E6.158117
G3 X187.36485 Y23.17707 I102.82293 J59.36485 E6.158117
G3 X230.82293 Y185.36485 I-59.36485 J102.82293 E6.158117
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X231.17385 Y185.56745 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.43255 Y229.17385 I-103.17385 J-59.56745 E6.179134
G3 X24.82615 Y66.43255 I59.56745 J-103.17385 E6.179134
G3 X187.56745 Y22.82615 I103.17385 J59.56745 E6.179134
G3 X231.17385 Y185.56745 I-59.56745 J103.17385 E6.179134
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X231.52477 Y185.77005 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.22995 Y229.52477 I-103.52477 J-59.77005 E6.200151
G3 X24.47523 Y66.22995 I59.77005 J-103.52477 E6.200151
G3 X187.77005 Y22.47523 I103.52477 J59.77005 E6.200151
G3 X231.52477 Y185.77005 I-59.77005 J103.52477 E6.200151
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X231.87569 Y185.97266 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.02734 Y229.87569 I-103.87569 J-59.97266 E6.221168
G3 X24.12431 Y66.02734 I59.97266 J-103.87569 E6.221168
G3 X187.97266 Y22.12431 I103.87569 J59.97266 E6.221168
G3 X231.87569 Y185.97266 I-59.97266 J103.87569 E6.221168
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X232.22661 Y186.17526 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.82474 Y230.22661 I-104.22661 J-60.17526 E6.242185
G3 X23.77339 Y65.82474 I60.17526 J-104.22661 E6.242185
G3 X188.17526 Y21.77339 I104.22661 J60.17526 E6.242185
G3 X232.22661 Y186.17526 I-60.17526 J104.22661 E6.242185
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X232.57753 Y186.37787 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.62213 Y230.57753 I-104.57753 J-60.37787 E6.263201
G3 X23.42247 Y65.62213 I60.37787 J-104.57753 E6.263201
G3 X188.37787 Y21.42247 I104.57753 J60.37787 E6.263201
G3 X232.57753 Y186.37787 I-60.37787 J104.57753 E6.263201
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X232.92845 Y186.58047 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.41953 Y230.92845 I-104.92845 J-60.58047 E6.284218
G3 X23.07155 Y65.41953 I60.58047 J-104.92845 E6.284218
G3 X188.58047 Y21.07155 I104.92845 J60.58047 E6.284218
G3 X232.92845 Y186.58047 I-60.58047 J104.92845 E6.284218
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X233.27937 Y186.78308 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.21692 Y231.27937 I-105.27937 J-60.78308 E6.305235
G3 X22.72063 Y65.21692 I60.78308 J-105.27937 E6.305235
G3 X188.78308 Y20.72063 I105.27937 J60.78308 E6.305235
G3 X233.27937 Y186.78308 I-60.78308 J105.27937 E6.305235
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X233.63030 Y186.98568 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.01432 Y231.63030 I-105.63030 J-60.98568 E6.326252
G3 X22.36970 Y65.01432 I60.98568 J-105.63030 E6.326252
G3 X188.98568 Y20.36970 I105.63030 J60.98568 E6.326252
G3 X233.63030 Y186.98568 I-60.98568 J105.63030 E6.326252
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X233.98122 Y187.18828 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X66.81172 Y231.98122 I-105.98122 J-61.18828 E6.347269
G3 X22.01878 Y64.81172 I61.18828 J-105.98122 E6.347269
G3 X189.18828 Y20.01878 I105.98122 J61.18828 E6.347269
G3 X233.98122 Y187.18828 I-61.18828 J105.98122 E6.347269
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X234.33214 Y187.39089 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X66.60911 Y232.33214 I-106.33214 J-61.39089 E6.368286
G3 X21.66786 Y64.60911 I61.39089 J-106.33214 E6.368286
G3 X189.39089 Y19.66786 I106.33214 J61.39089 E6.368286
G3 X234.33214 Y187.39089 I-61.39089 J106.33214 E6.368286
G1 E-0.8 F1800
G1 Z1.000 F1200
G1 X174.40365 Y11.23648 F12000
G1 Z0.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X242.76352 Y172.40365 I-46.40365 J114.76352 E5.974872
G3 X81.59635 Y240.76352 I-114.76352 J-46.40365 E5.974872
G3 X13.23648 Y79.59635 I46.40365 J-114.76352 E5.974872
G3 X174.40365 Y11.23648 I114.76352 J46.40365 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X167.05187 Y230.57855 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X232.57855 Y86.94813 I-39.05187 J-104.57855 E5.816723
G2 X88.94813 Y21.42145 I-104.57855 J39.05187 E5.816723
G2 X23.42145 Y165.05187 I39.05187 J104.57855 E5.816723
G2 X167.05187 Y230.57855 I104.57855 J-39.05187 E5.816723
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X166.90946 Y230.19719 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X232.19719 Y87.09054 I-38.90946 J-104.19719 E5.795511
G2 X89.09054 Y21.80281 I-104.19719 J38.90946 E5.795511
G2 X23.80281 Y164.90946 I38.90946 J104.19719 E5.795511
G2 X166.90946 Y230.19719 I104.19719 J-38.90946 E5.795511
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X171.02546 Y241.21960 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X12.78040 Y169.02546 I-43.02546 J-115.21960 E6.408584
G3 X84.97454 Y10.78040 I115.21960 J-43.02546 E6.408584
G3 X243.21960 Y82.97454 I43.02546 J115.21960 E6.408584
G3 X171.02546 Y241.21960 I-115.21960 J43.02546 E6.408584
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X171.16787 Y241.60096 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X12.39904 Y169.16787 I-43.16787 J-115.60096 E6.429796
G3 X84.83213 Y10.39904 I115.60096 J-43.16787 E6.429796
G3 X243.60096 Y82.83213 I43.16787 J115.60096 E6.429796
G3 X171.16787 Y241.60096 I-115.60096 J43.16787 E6.429796
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.40031 Y184.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X228.53026 Y182.32658 I-0.67342 J-1.80337 E0.100304
G2 X226.05348 Y181.19663 I-1.80337 J0.67342 E0.100304
G2 X224.92353 Y183.67342 I0.67342 J1.80337 E0.100304
G2 X227.40031 Y184.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.67342 Y241.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.80337 Y239.32658 I-0.67342 J-1.80337 E0.100304
G2 X127.32658 Y238.19663 I-1.80337 J0.67342 E0.100304
G2 X126.19663 Y240.67342 I0.67342 J1.80337 E0.100304
G2 X128.67342 Y241.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X29.94652 Y184.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X31.07647 Y182.32658 I-0.67342 J-1.80337 E0.100304
G2 X28.59969 Y181.19663 I-1.80337 J0.67342 E0.100304
G2 X27.46974 Y183.67342 I0.67342 J1.80337 E0.100304
G2 X29.94652 Y184.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X29.94652 Y70.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X31.07647 Y68.32658 I-0.67342 J-1.80337 E0.100304
G2 X28.59969 Y67.19663 I-1.80337 J0.67342 E0.100304
G2 X27.46974 Y69.67342 I0.67342 J1.80337 E0.100304
G2 X29.94652 Y70.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.67342 Y13.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.80337 Y11.32658 I-0.67342 J-1.80337 E0.100304
G2 X127.32658 Y10.19663 I-1.80337 J0.67342 E0.100304
G2 X126.19663 Y12.67342 I0.67342 J1.80337 E0.100304
G2 X128.67342 Y13.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.40031 Y70.80337 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X228.53026 Y68.32658 I-0.67342 J-1.80337 E0.100304
G2 X226.05348 Y67.19663 I-1.80337 J0.67342 E0.100304
G2 X224.92353 Y69.67342 I0.67342 J1.80337 E0.100304
G2 X227.40031 Y70.80337 I1.80337 J-0.67342 E0.100304
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.92465 Y177.40236 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.23400 Y177.58742 E0.023718
G1 X226.97767 Y178.07755 E0.018348
G1 X228.46671 Y177.67856 E0.051137
G1 X229.00877 Y177.95475 E0.020181
G1 X226.71772 Y178.56864 E0.078679
G1 X226.45411 Y179.06071 E0.018518
G1 X229.55084 Y178.23095 E0.106348
G1 X230.09290 Y178.50714 E0.020181
G1 X226.18677 Y179.55378 E0.134144
G1 X225.91567 Y180.04787 E0.018695
G1 X230.63496 Y178.78334 E0.162070
G1 X231.17702 Y179.05953 E0.020181
G1 X225.64074 Y180.54297 E0.190127
G1 X225.36193 Y181.03912 E0.018879
G1 X231.71909 Y179.33573 E0.218317
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 X232.80321 Y179.88811 E0.020181
G1 X227.88450 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.50160 Y182.53396 E0.005195
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
G1 X224.20666 Y183.03443 E0.013268
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
G1 X223.90753 Y183.53603 E0.024467
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
G1 X223.60414 Y184.03876 E0.038451
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
G1 X223.29643 Y184.54265 E0.055216
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
G1 X222.98428 Y185.04773 E0.075092
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
G1 X222.66767 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y182.09767 E0.304552
G1 X236.97597 Y182.56299 E0.016363
G1 X222.05467 Y186.56114 E0.512428
G1 X222.51407 Y186.85948 E0.018171
G1 X236.72025 Y183.05295 E0.487869
G1 X236.46126 Y183.54378 E0.018409
G1 X222.97348 Y187.15782 E0.463198
G1 X223.43289 Y187.45616 E0.018171
G1 X236.19894 Y184.03551 E0.438412
G1 X235.93326 Y184.52814 E0.018567
G1 X223.89229 Y187.75451 E0.413511
G1 X224.35170 Y188.05285 E0.018171
G1 X235.66417 Y185.02168 E0.388493
G1 X235.39162 Y185.51615 E0.018729
G1 X224.81111 Y188.35119 E0.363356
G1 X225.27051 Y188.64953 E0.018171
G1 X235.11557 Y186.01156 E0.338099
G1 X234.83597 Y186.50791 E0.018898
G1 X225.72992 Y188.94787 E0.312720
G1 X226.18933 Y189.24622 E0.018171
G1 X234.55276 Y187.00524 E0.287217
G1 X234.26594 Y187.50354 E0.019072
G1 X226.64873 Y189.54456 E0.261590
G1 X227.10814 Y189.84290 E0.018171
G1 X233.97538 Y188.00283 E0.235835
G1 X233.68108 Y188.50313 E0.019254
G1 X227.56755 Y190.14124 E0.209951
G1 X228.02695 Y190.43959 E0.018171
G1 X233.38299 Y189.00444 E0.183937
G1 X233.08101 Y189.50680 E0.019443
G1 X228.48636 Y190.73793 E0.157789
G1 X228.94577 Y191.03627 E0.018171
G1 X232.77512 Y190.01020 E0.131508
G1 X232.46526 Y190.51466 E0.019639
G1 X229.40517 Y191.33461 E0.105090
G1 X229.86458 Y191.63295 E0.018171
G1 X232.15136 Y191.02021 E0.078533
G1 X231.83333 Y191.52687 E0.019843
G1 X230.32399 Y191.93130 E0.051834
G1 X230.78339 Y192.22964 E0.018171
G1 X231.51115 Y192.03464 E0.024992
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X133.44657 Y238.23846 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.94098 Y237.73287 E0.023718
G1 X132.38836 Y237.75595 E0.018348
G1 X133.47841 Y238.84600 E0.051137
G1 X133.51025 Y239.45354 E0.020181
G1 X131.83308 Y237.77637 E0.078679
G1 X131.27513 Y237.79412 E0.018518
G1 X133.54209 Y240.06108 E0.106348
G1 X133.57393 Y240.66861 E0.020181
G1 X130.71445 Y237.80913 E0.134144
G1 X130.15101 Y237.82139 E0.018695
G1 X133.60577 Y241.27615 E0.162070
G1 X133.63761 Y241.88369 E0.020181
G1 X129.58477 Y237.83085 E0.190127
G1 X129.01569 Y237.83747 E0.018879
G1 X133.66945 Y242.49123 E0.218317
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 X133.73313 Y243.70630 E0.020181
G1 X130.13239 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.29095 Y237.83982 E0.005195
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
G1 X126.71006 Y237.83463 E0.013268
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
G1 X126.12610 Y237.82637 E0.024467
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
G1 X125.53903 Y237.81499 E0.038451
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
G1 X124.94879 Y237.80045 E0.055216
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
G1 X124.35531 Y237.78267 E0.075092
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
G1 X123.75856 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y248.56660 E0.304552
G1 X133.50300 Y248.65745 E0.016363
G1 X122.57985 Y237.73430 E0.512428
G1 X122.55118 Y238.28133 E0.018171
G1 X132.95082 Y248.68097 E0.487869
G1 X132.39626 Y248.70210 E0.018409
G1 X122.52251 Y238.82836 E0.463198
G1 X122.49384 Y239.37539 E0.018171
G1 X131.83925 Y248.72079 E0.438412
G1 X131.27978 Y248.73702 E0.018567
G1 X122.46518 Y239.92242 E0.413511
G1 X122.43651 Y240.46944 E0.018171
G1 X130.71781 Y248.75075 E0.388493
G1 X130.15331 Y248.76195 E0.018729
G1 X122.40784 Y241.01647 E0.363356
G1 X122.37917 Y241.56350 E0.018171
G1 X129.58625 Y248.77058 E0.338099
G1 X129.01660 Y248.77662 E0.018898
G1 X122.35050 Y242.11053 E0.312720
G1 X122.32183 Y242.65756 E0.018171
G1 X128.44429 Y248.78002 E0.287217
G1 X127.86934 Y248.78077 E0.019072
G1 X122.29316 Y243.20459 E0.261590
G1 X122.26450 Y243.75162 E0.018171
G1 X127.29166 Y248.77878 E0.235835
G1 X126.71124 Y248.77406 E0.019254
G1 X122.23583 Y244.29865 E0.209951
G1 X122.20716 Y244.84568 E0.018171
G1 X126.12805 Y248.76657 E0.183937
G1 X125.54201 Y248.75622 E0.019443
G1 X122.17849 Y245.39270 E0.157789
G1 X122.14982 Y245.93973 E0.018171
G1 X124.95310 Y248.74301 E0.131508
G1 X124.36129 Y248.72690 E0.019639
G1 X122.12115 Y246.48676 E0.105090
G1 X122.09248 Y247.03379 E0.018171
G1 X123.76652 Y248.70783 E0.078533
G1 X123.16873 Y248.68574 E0.019843
G1 X122.06382 Y247.58082 E0.051834
G1 X122.03515 Y248.12785 E0.018171
G1 X122.56790 Y248.66060 E0.024992
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X33.52192 Y186.83610 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.70698 Y186.14545 E0.023718
G1 X33.41069 Y185.67840 E0.018348
G1 X33.01170 Y187.16744 E0.051137
G1 X32.50148 Y187.49879 E0.020181
G1 X33.11536 Y185.20774 E0.078679
G1 X32.82102 Y184.73340 E0.018518
G1 X31.99126 Y187.83013 E0.106348
G1 X31.48103 Y188.16147 E0.020181
G1 X32.52768 Y184.25535 E0.134144
G1 X32.23534 Y183.77352 E0.018695
G1 X30.97081 Y188.49281 E0.162070
G1 X30.46059 Y188.82416 E0.020181
G1 X31.94403 Y183.28788 E0.190127
G1 X31.65376 Y182.79835 E0.018879
G1 X29.95036 Y189.15550 E0.218317
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 X28.92992 Y189.81819 E0.020181
G1 X30.24788 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.78935 Y181.30586 E0.005195
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
G1 X30.50340 Y180.80019 E0.013268
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
G1 X30.21858 Y180.29034 E0.024467
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
G1 X29.93489 Y179.77623 E0.038451
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
G1 X29.65237 Y179.25780 E0.055216
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
G1 X29.37103 Y178.73494 E0.075092
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
G1 X29.09088 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y192.46893 E0.304552
G1 X24.52703 Y192.09447 E0.016363
G1 X28.52518 Y177.17316 E0.512428
G1 X28.03711 Y177.42185 E0.018171
G1 X24.23057 Y191.62803 E0.487869
G1 X23.93499 Y191.15832 E0.018409
G1 X27.54903 Y177.67054 E0.463198
G1 X27.06096 Y177.91922 E0.018171
G1 X23.64030 Y190.68528 E0.438412
G1 X23.34651 Y190.20888 E0.018567
G1 X26.57288 Y178.16791 E0.413511
G1 X26.08481 Y178.41660 E0.018171
G1 X23.05364 Y189.72906 E0.388493
G1 X22.76169 Y189.24579 E0.018729
G1 X25.59673 Y178.66528 E0.363356
G1 X25.10866 Y178.91397 E0.018171
G1 X22.47068 Y188.75902 E0.338099
G1 X22.18062 Y188.26871 E0.018898
G1 X24.62058 Y179.16266 E0.312720
G1 X24.13251 Y179.41134 E0.018171
G1 X21.89153 Y187.77478 E0.287217
G1 X21.60341 Y187.27723 E0.019072
G1 X23.64443 Y179.66003 E0.261590
G1 X23.15636 Y179.90872 E0.018171
G1 X21.31629 Y186.77595 E0.235835
G1 X21.03016 Y186.27094 E0.019254
G1 X22.66828 Y180.15740 E0.209951
G1 X22.18021 Y180.40609 E0.018171
G1 X20.74506 Y185.76213 E0.183937
G1 X20.46100 Y185.24943 E0.019443
G1 X21.69213 Y180.65478 E0.157789
G1 X21.20405 Y180.90346 E0.018171
G1 X20.17798 Y184.73282 E0.131508
G1 X19.89603 Y184.21224 E0.019639
G1 X20.71598 Y181.15215 E0.105090
G1 X20.22790 Y181.40084 E0.018171
G1 X19.61516 Y183.68761 E0.078533
G1 X19.33540 Y183.15887 E0.019843
G1 X19.73983 Y181.64952 E0.051834
G1 X19.25175 Y181.89821 E0.018171
G1 X19.05675 Y182.62596 E0.024992
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.07535 Y74.59764 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.76600 Y74.41258 E0.023718
G1 X29.02233 Y73.92245 E0.018348
G1 X27.53329 Y74.32144 E0.051137
G1 X26.99123 Y74.04525 E0.020181
G1 X29.28228 Y73.43136 E0.078679
G1 X29.54589 Y72.93929 E0.018518
G1 X26.44916 Y73.76905 E0.106348
G1 X25.90710 Y73.49286 E0.020181
G1 X29.81323 Y72.44622 E0.134144
G1 X30.08433 Y71.95213 E0.018695
G1 X25.36504 Y73.21666 E0.162070
G1 X24.82298 Y72.94047 E0.020181
G1 X30.35926 Y71.45703 E0.190127
G1 X30.63807 Y70.96088 E0.018879
G1 X24.28091 Y72.66427 E0.218317
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 X23.19679 Y72.11189 E0.020181
G1 X28.11550 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.49840 Y69.46604 E0.005195
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
G1 X31.79334 Y68.96557 E0.013268
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
G1 X32.09247 Y68.46397 E0.024467
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
G1 X32.39586 Y67.96124 E0.038451
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
G1 X32.70357 Y67.45735 E0.055216
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
G1 X33.01572 Y66.95227 E0.075092
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
G1 X33.33233 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y69.90233 E0.304552
G1 X19.02403 Y69.43701 E0.016363
G1 X33.94533 Y65.43886 E0.512428
G1 X33.48593 Y65.14052 E0.018171
G1 X19.27975 Y68.94705 E0.487869
G1 X19.53874 Y68.45622 E0.018409
G1 X33.02652 Y64.84218 E0.463198
G1 X32.56711 Y64.54384 E0.018171
G1 X19.80106 Y67.96449 E0.438412
G1 X20.06674 Y67.47186 E0.018567
G1 X32.10771 Y64.24549 E0.413511
G1 X31.64830 Y63.94715 E0.018171
G1 X20.33583 Y66.97832 E0.388493
G1 X20.60838 Y66.48385 E0.018729
G1 X31.18889 Y63.64881 E0.363356
G1 X30.72949 Y63.35047 E0.018171
G1 X20.88443 Y65.98844 E0.338099
G1 X21.16403 Y65.49209 E0.018898
G1 X30.27008 Y63.05213 E0.312720
G1 X29.81067 Y62.75378 E0.018171
G1 X21.44724 Y64.99476 E0.287217
G1 X21.73406 Y64.49646 E0.019072
G1 X29.35127 Y62.45544 E0.261590
G1 X28.89186 Y62.15710 E0.018171
G1 X22.02462 Y63.99717 E0.235835
G1 X22.31892 Y63.49687 E0.019254
G1 X28.43245 Y61.85876 E0.209951
G1 X27.97305 Y61.56041 E0.018171
G1 X22.61701 Y62.99556 E0.183937
G1 X22.91899 Y62.49320 E0.019443
G1 X27.51364 Y61.26207 E0.157789
G1 X27.05423 Y60.96373 E0.018171
G1 X23.22488 Y61.98980 E0.131508
G1 X23.53474 Y61.48534 E0.019639
G1 X26.59483 Y60.66539 E0.105090
G1 X26.13542 Y60.36705 E0.018171
G1 X23.84864 Y60.97979 E0.078533
G1 X24.16667 Y60.47313 E0.019843
G1 X25.67601 Y60.06870 E0.051834
G1 X25.21661 Y59.77036 E0.018171
G1 X24.48885 Y59.96536 E0.024992
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X122.55343 Y13.76154 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.05902 Y14.26713 E0.023718
G1 X123.61164 Y14.24405 E0.018348
G1 X122.52159 Y13.15400 E0.051137
G1 X122.48975 Y12.54646 E0.020181
G1 X124.16692 Y14.22363 E0.078679
G1 X124.72487 Y14.20588 E0.018518
G1 X122.45791 Y11.93892 E0.106348
G1 X122.42607 Y11.33139 E0.020181
G1 X125.28555 Y14.19087 E0.134144
G1 X125.84899 Y14.17861 E0.018695
G1 X122.39423 Y10.72385 E0.162070
G1 X122.36239 Y10.11631 E0.020181
G1 X126.41523 Y14.16915 E0.190127
G1 X126.98431 Y14.16253 E0.018879
G1 X122.33055 Y9.50877 E0.218317
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 X122.26687 Y8.29370 E0.020181
G1 X125.86761 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.70905 Y14.16018 E0.005195
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
G1 X129.28994 Y14.16537 E0.013268
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
G1 X129.87390 Y14.17363 E0.024467
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
G1 X130.46097 Y14.18501 E0.038451
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
G1 X131.05121 Y14.19955 E0.055216
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
G1 X131.64469 Y14.21733 E0.075092
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
G1 X132.24144 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y3.43340 E0.304552
G1 X122.49700 Y3.34255 E0.016363
G1 X133.42015 Y14.26570 E0.512428
G1 X133.44882 Y13.71867 E0.018171
G1 X123.04918 Y3.31903 E0.487869
G1 X123.60374 Y3.29790 E0.018409
G1 X133.47749 Y13.17164 E0.463198
G1 X133.50616 Y12.62461 E0.018171
G1 X124.16075 Y3.27921 E0.438412
G1 X124.72022 Y3.26298 E0.018567
G1 X133.53482 Y12.07758 E0.413511
G1 X133.56349 Y11.53056 E0.018171
G1 X125.28219 Y3.24925 E0.388493
G1 X125.84669 Y3.23805 E0.018729
G1 X133.59216 Y10.98353 E0.363356
G1 X133.62083 Y10.43650 E0.018171
G1 X126.41375 Y3.22942 E0.338099
G1 X126.98340 Y3.22338 E0.018898
G1 X133.64950 Y9.88947 E0.312720
G1 X133.67817 Y9.34244 E0.018171
G1 X127.55571 Y3.21998 E0.287217
G1 X128.13066 Y3.21923 E0.019072
G1 X133.70684 Y8.79541 E0.261590
G1 X133.73550 Y8.24838 E0.018171
G1 X128.70834 Y3.22122 E0.235835
G1 X129.28876 Y3.22594 E0.019254
G1 X133.76417 Y7.70135 E0.209951
G1 X133.79284 Y7.15432 E0.018171
G1 X129.87195 Y3.23343 E0.183937
G1 X130.45799 Y3.24378 E0.019443
G1 X133.82151 Y6.60730 E0.157789
G1 X133.85018 Y6.06027 E0.018171
G1 X131.04690 Y3.25699 E0.131508
G1 X131.63871 Y3.27310 E0.019639
G1 X133.87885 Y5.51324 E0.105090
G1 X133.90752 Y4.96621 E0.018171
G1 X132.23348 Y3.29217 E0.078533
G1 X132.83127 Y3.31426 E0.019843
G1 X133.93618 Y4.41918 E0.051834
G1 X133.96485 Y3.87215 E0.018171
G1 X133.43210 Y3.33940 E0.024992
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X222.47808 Y65.16390 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.29302 Y65.85455 E0.023718
G1 X222.58931 Y66.32160 E0.018348
G1 X222.98830 Y64.83256 E0.051137
G1 X223.49852 Y64.50121 E0.020181
G1 X222.88464 Y66.79226 E0.078679
G1 X223.17898 Y67.26660 E0.018518
G1 X224.00874 Y64.16987 E0.106348
G1 X224.51897 Y63.83853 E0.020181
G1 X223.47232 Y67.74465 E0.134144
G1 X223.76466 Y68.22648 E0.018695
G1 X225.02919 Y63.50719 E0.162070
G1 X225.53941 Y63.17584 E0.020181
G1 X224.05597 Y68.71212 E0.190127
G1 X224.34624 Y69.20165 E0.018879
G1 X226.04964 Y62.84450 E0.218317
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 X227.07008 Y62.18181 E0.020181
G1 X225.75212 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.21065 Y70.69414 E0.005195
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
G1 X225.49660 Y71.19981 E0.013268
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
G1 X225.78142 Y71.70966 E0.024467
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
G1 X226.06511 Y72.22377 E0.038451
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
G1 X226.34763 Y72.74220 E0.055216
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
G1 X226.62897 Y73.26506 E0.075092
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
G1 X226.90912 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y59.53107 E0.304552
G1 X231.47297 Y59.90553 E0.016363
G1 X227.47482 Y74.82684 E0.512428
G1 X227.96289 Y74.57815 E0.018171
G1 X231.76943 Y60.37197 E0.487869
G1 X232.06501 Y60.84168 E0.018409
G1 X228.45097 Y74.32946 E0.463198
G1 X228.93904 Y74.08078 E0.018171
G1 X232.35970 Y61.31472 E0.438412
G1 X232.65349 Y61.79112 E0.018567
G1 X229.42712 Y73.83209 E0.413511
G1 X229.91519 Y73.58340 E0.018171
G1 X232.94636 Y62.27094 E0.388493
G1 X233.23831 Y62.75421 E0.018729
G1 X230.40327 Y73.33472 E0.363356
G1 X230.89134 Y73.08603 E0.018171
G1 X233.52932 Y63.24098 E0.338099
G1 X233.81938 Y63.73129 E0.018898
G1 X231.37942 Y72.83734 E0.312720
G1 X231.86749 Y72.58866 E0.018171
G1 X234.10847 Y64.22522 E0.287217
G1 X234.39659 Y64.72277 E0.019072
G1 X232.35557 Y72.33997 E0.261590
G1 X232.84364 Y72.09128 E0.018171
G1 X234.68371 Y65.22405 E0.235835
G1 X234.96984 Y65.72906 E0.019254
G1 X233.33172 Y71.84260 E0.209951
G1 X233.81979 Y71.59391 E0.018171
G1 X235.25494 Y66.23787 E0.183937
G1 X235.53900 Y66.75057 E0.019443
G1 X234.30787 Y71.34522 E0.157789
G1 X234.79595 Y71.09654 E0.018171
G1 X235.82202 Y67.26718 E0.131508
G1 X236.10397 Y67.78776 E0.019639
G1 X235.28402 Y70.84785 E0.105090
G1 X235.77210 Y70.59916 E0.018171
G1 X236.38484 Y68.31239 E0.078533
G1 X236.66460 Y68.84113 E0.019843
G1 X236.26017 Y70.35048 E0.051834
G1 X236.74825 Y70.10179 E0.018171
G1 X236.94325 Y69.37404 E0.024992
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z1.200 F1200
G1 X171.30503 Y241.96826 F12000
G1 Z0.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X12.03174 Y169.30503 I-43.30503 J-115.96826 E5.974872
G3 X84.69497 Y10.03174 I115.96826 J-43.30503 E5.974872
G3 X243.96826 Y82.69497 I43.30503 J115.96826 E5.974872
G3 X171.30503 Y241.96826 I-115.96826 J43.30503 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.56257 Y75.26619 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X77.26619 Y225.43743 I99.43743 J50.73381 E5.816723
G2 X227.43743 Y176.73381 I50.73381 J-99.43743 E5.816723
G2 X178.73381 Y26.56257 I-99.43743 J-50.73381 E5.816723
G2 X28.56257 Y75.26619 I-50.73381 J99.43743 E5.816723
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.92518 Y75.45120 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X77.45120 Y225.07482 I99.07482 J50.54880 E5.795511
G2 X227.07482 Y176.54880 I50.54880 J-99.07482 E5.795511
G2 X178.54880 Y26.92518 I-99.07482 J-50.54880 E5.795511
G2 X28.92518 Y75.45120 I-50.54880 J99.07482 E5.795511
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X18.44464 Y70.10394 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X183.89606 Y16.44464 I109.55536 J55.89606 E6.408584
G3 X237.55536 Y181.89606 I-55.89606 J109.55536 E6.408584
G3 X72.10394 Y235.55536 I-109.55536 J-55.89606 E6.408584
G3 X18.44464 Y70.10394 I55.89606 J-109.55536 E6.408584
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X18.08203 Y69.91893 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X184.08107 Y16.08203 I109.91797 J56.08107 E6.429796
G3 X237.91797 Y182.08107 I-56.08107 J109.91797 E6.429796
G3 X71.91893 Y235.91797 I-109.91797 J-56.08107 E6.429796
G3 X18.08203 Y69.91893 I56.08107 J-109.91797 E6.429796
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.01218 Y182.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X225.85203 Y184.71471 I1.71471 J0.87486 E0.100304
G2 X228.44161 Y183.87486 I0.87486 J-1.71471 E0.100304
G2 X227.60176 Y181.28529 I-1.71471 J-0.87486 E0.100304
G2 X225.01218 Y182.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.28529 Y239.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X127.12514 Y241.71471 I1.71471 J0.87486 E0.100304
G2 X129.71471 Y240.87486 I0.87486 J-1.71471 E0.100304
G2 X128.87486 Y238.28529 I-1.71471 J-0.87486 E0.100304
G2 X126.28529 Y239.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.55839 Y182.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X28.39824 Y184.71471 I1.71471 J0.87486 E0.100304
G2 X30.98782 Y183.87486 I0.87486 J-1.71471 E0.100304
G2 X30.14797 Y181.28529 I-1.71471 J-0.87486 E0.100304
G2 X27.55839 Y182.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.55839 Y68.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X28.39824 Y70.71471 I1.71471 J0.87486 E0.100304
G2 X30.98782 Y69.87486 I0.87486 J-1.71471 E0.100304
G2 X30.14797 Y67.28529 I-1.71471 J-0.87486 E0.100304
G2 X27.55839 Y68.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X126.28529 Y11.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X127.12514 Y13.71471 I1.71471 J0.87486 E0.100304
G2 X129.71471 Y12.87486 I0.87486 J-1.71471 E0.100304
G2 X128.87486 Y10.28529 I-1.71471 J-0.87486 E0.100304
G2 X126.28529 Y11.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.01218 Y68.12514 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X225.85203 Y70.71471 I1.71471 J0.87486 E0.100304
G2 X228.44161 Y69.87486 I0.87486 J-1.71471 E0.100304
G2 X227.60176 Y67.28529 I-1.71471 J-0.87486 E0.100304
G2 X225.01218 Y68.12514 I-0.87486 J1.71471 E0.100304
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X236.94325 Y182.62596 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.74825 Y181.89821 E0.024992
G1 X236.26017 Y181.64952 E0.018171
G1 X236.66460 Y183.15887 E0.051834
G1 X236.38484 Y183.68761 E0.019843
G1 X235.77210 Y181.40084 E0.078533
G1 X235.28402 Y181.15215 E0.018171
G1 X236.10397 Y184.21224 E0.105090
G1 X235.82202 Y184.73282 E0.019639
G1 X234.79595 Y180.90346 E0.131508
G1 X234.30787 Y180.65478 E0.018171
G1 X235.53900 Y185.24943 E0.157789
G1 X235.25494 Y185.76213 E0.019443
G1 X233.81979 Y180.40609 E0.183937
G1 X233.33172 Y180.15740 E0.018171
G1 X234.96984 Y186.27094 E0.209951
G1 X234.68371 Y186.77595 E0.019254
G1 X232.84364 Y179.90872 E0.235835
G1 X232.35557 Y179.66003 E0.018171
G1 X234.39659 Y187.27723 E0.261590
G1 X234.10847 Y187.77478 E0.019072
G1 X231.86749 Y179.41134 E0.287217
G1 X231.37942 Y179.16266 E0.018171
G1 X233.81938 Y188.26871 E0.312720
G1 X233.52932 Y188.75902 E0.018898
G1 X230.89134 Y178.91397 E0.338099
G1 X230.40327 Y178.66528 E0.018171
G1 X233.23831 Y189.24579 E0.363356
G1 X232.94636 Y189.72906 E0.018729
G1 X229.91519 Y178.41660 E0.388493
G1 X229.42712 Y178.16791 E0.018171
G1 X232.65349 Y190.20888 E0.413511
G1 X232.35970 Y190.68528 E0.018567
G1 X228.93904 Y177.91922 E0.438412
G1 X228.45097 Y177.67054 E0.018171
G1 X232.06501 Y191.15832 E0.463198
G1 X231.76943 Y191.62803 E0.018409
G1 X227.96289 Y177.42185 E0.487869
G1 X227.47482 Y177.17316 E0.018171
G1 X231.47297 Y192.09447 E0.512428
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y192.46893 E0.304552
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.90912 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.62897 Y178.73494 E0.075092
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
G1 X226.34763 Y179.25780 E0.055216
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
G1 X226.06511 Y179.77623 E0.038451
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
G1 X225.78142 Y180.29034 E0.024467
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
G1 X225.49660 Y180.80019 E0.013268
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
G1 X225.21065 Y181.30586 E0.005195
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 X227.07008 Y189.81819 E0.020181
G1 X225.75212 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.34624 Y182.79835 E0.218317
G1 X224.05597 Y183.28788 E0.018879
G1 X225.53941 Y188.82416 E0.190127
G1 X225.02919 Y188.49281 E0.020181
G1 X223.76466 Y183.77352 E0.162070
G1 X223.47232 Y184.25535 E0.018695
G1 X224.51897 Y188.16147 E0.134144
G1 X224.00874 Y187.83013 E0.020181
G1 X223.17898 Y184.73340 E0.106348
G1 X222.88464 Y185.20774 E0.018518
G1 X223.49852 Y187.49879 E0.078679
G1 X222.98830 Y187.16744 E0.020181
G1 X222.58931 Y185.67840 E0.051137
G1 X222.29302 Y186.14545 E0.018348
G1 X222.47808 Y186.83610 E0.023718
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X133.43210 Y248.66060 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.96485 Y248.12785 E0.024992
G1 X133.93618 Y247.58082 E0.018171
G1 X132.83127 Y248.68574 E0.051834
G1 X132.23348 Y248.70783 E0.019843
G1 X133.90752 Y247.03379 E0.078533
G1 X133.87885 Y246.48676 E0.018171
G1 X131.63871 Y248.72690 E0.105090
G1 X131.04690 Y248.74301 E0.019639
G1 X133.85018 Y245.93973 E0.131508
G1 X133.82151 Y245.39270 E0.018171
G1 X130.45799 Y248.75622 E0.157789
G1 X129.87195 Y248.76657 E0.019443
G1 X133.79284 Y244.84568 E0.183937
G1 X133.76417 Y244.29865 E0.018171
G1 X129.28876 Y248.77406 E0.209951
G1 X128.70834 Y248.77878 E0.019254
G1 X133.73550 Y243.75162 E0.235835
G1 X133.70684 Y243.20459 E0.018171
G1 X128.13066 Y248.78077 E0.261590
G1 X127.55571 Y248.78002 E0.019072
G1 X133.67817 Y242.65756 E0.287217
G1 X133.64950 Y242.11053 E0.018171
G1 X126.98340 Y248.77662 E0.312720
G1 X126.41375 Y248.77058 E0.018898
G1 X133.62083 Y241.56350 E0.338099
G1 X133.59216 Y241.01647 E0.018171
G1 X125.84669 Y248.76195 E0.363356
G1 X125.28219 Y248.75075 E0.018729
G1 X133.56349 Y240.46944 E0.388493
G1 X133.53482 Y239.92242 E0.018171
G1 X124.72022 Y248.73702 E0.413511
G1 X124.16075 Y248.72079 E0.018567
G1 X133.50616 Y239.37539 E0.438412
G1 X133.47749 Y238.82836 E0.018171
G1 X123.60374 Y248.70210 E0.463198
G1 X123.04918 Y248.68097 E0.018409
G1 X133.44882 Y238.28133 E0.487869
G1 X133.42015 Y237.73430 E0.018171
G1 X122.49700 Y248.65745 E0.512428
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y248.56660 E0.304552
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.24144 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.64469 Y237.78267 E0.075092
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
G1 X131.05121 Y237.80045 E0.055216
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
G1 X130.46097 Y237.81499 E0.038451
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
G1 X129.87390 Y237.82637 E0.024467
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
G1 X129.28994 Y237.83463 E0.013268
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
G1 X128.70905 Y237.83982 E0.005195
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 X122.26687 Y243.70630 E0.020181
G1 X125.86761 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X126.98431 Y237.83747 E0.218317
G1 X126.41523 Y237.83085 E0.018879
G1 X122.36239 Y241.88369 E0.190127
G1 X122.39423 Y241.27615 E0.020181
G1 X125.84899 Y237.82139 E0.162070
G1 X125.28555 Y237.80913 E0.018695
G1 X122.42607 Y240.66861 E0.134144
G1 X122.45791 Y240.06108 E0.020181
G1 X124.72487 Y237.79412 E0.106348
G1 X124.16692 Y237.77637 E0.018518
G1 X122.48975 Y239.45354 E0.078679
G1 X122.52159 Y238.84600 E0.020181
G1 X123.61164 Y237.75595 E0.051137
G1 X123.05902 Y237.73287 E0.018348
G1 X122.55343 Y238.23846 E0.023718
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X24.48885 Y192.03464 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.21661 Y192.22964 E0.024992
G1 X25.67601 Y191.93130 E0.018171
G1 X24.16667 Y191.52687 E0.051834
G1 X23.84864 Y191.02021 E0.019843
G1 X26.13542 Y191.63295 E0.078533
G1 X26.59483 Y191.33461 E0.018171
G1 X23.53474 Y190.51466 E0.105090
G1 X23.22488 Y190.01020 E0.019639
G1 X27.05423 Y191.03627 E0.131508
G1 X27.51364 Y190.73793 E0.018171
G1 X22.91899 Y189.50680 E0.157789
G1 X22.61701 Y189.00444 E0.019443
G1 X27.97305 Y190.43959 E0.183937
G1 X28.43245 Y190.14124 E0.018171
G1 X22.31892 Y188.50313 E0.209951
G1 X22.02462 Y188.00283 E0.019254
G1 X28.89186 Y189.84290 E0.235835
G1 X29.35127 Y189.54456 E0.018171
G1 X21.73406 Y187.50354 E0.261590
G1 X21.44724 Y187.00524 E0.019072
G1 X29.81067 Y189.24622 E0.287217
G1 X30.27008 Y188.94787 E0.018171
G1 X21.16403 Y186.50791 E0.312720
G1 X20.88443 Y186.01156 E0.018898
G1 X30.72949 Y188.64953 E0.338099
G1 X31.18889 Y188.35119 E0.018171
G1 X20.60838 Y185.51615 E0.363356
G1 X20.33583 Y185.02168 E0.018729
G1 X31.64830 Y188.05285 E0.388493
G1 X32.10771 Y187.75451 E0.018171
G1 X20.06674 Y184.52814 E0.413511
G1 X19.80106 Y184.03551 E0.018567
G1 X32.56711 Y187.45616 E0.438412
G1 X33.02652 Y187.15782 E0.018171
G1 X19.53874 Y183.54378 E0.463198
G1 X19.27975 Y183.05295 E0.018409
G1 X33.48593 Y186.85948 E0.487869
G1 X33.94533 Y186.56114 E0.018171
G1 X19.02403 Y182.56299 E0.512428
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y182.09767 E0.304552
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.33233 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.01572 Y185.04773 E0.075092
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
G1 X32.70357 Y184.54265 E0.055216
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
G1 X32.39586 Y184.03876 E0.038451
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
G1 X32.09247 Y183.53603 E0.024467
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
G1 X31.79334 Y183.03443 E0.013268
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
G1 X31.49840 Y182.53396 E0.005195
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 X23.19679 Y179.88811 E0.020181
G1 X28.11550 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X30.63807 Y181.03912 E0.218317
G1 X30.35926 Y180.54297 E0.018879
G1 X24.82298 Y179.05953 E0.190127
G1 X25.36504 Y178.78334 E0.020181
G1 X30.08433 Y180.04787 E0.162070
G1 X29.81323 Y179.55378 E0.018695
G1 X25.90710 Y178.50714 E0.134144
G1 X26.44916 Y178.23095 E0.020181
G1 X29.54589 Y179.06071 E0.106348
G1 X29.28228 Y178.56864 E0.018518
G1 X26.99123 Y177.95475 E0.078679
G1 X27.53329 Y177.67856 E0.020181
G1 X29.02233 Y178.07755 E0.051137
G1 X28.76600 Y177.58742 E0.018348
G1 X28.07535 Y177.40236 E0.023718
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X19.05675 Y69.37404 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.25175 Y70.10179 E0.024992
G1 X19.73983 Y70.35048 E0.018171
G1 X19.33540 Y68.84113 E0.051834
G1 X19.61516 Y68.31239 E0.019843
G1 X20.22790 Y70.59916 E0.078533
G1 X20.71598 Y70.84785 E0.018171
G1 X19.89603 Y67.78776 E0.105090
G1 X20.17798 Y67.26718 E0.019639
G1 X21.20405 Y71.09654 E0.131508
G1 X21.69213 Y71.34522 E0.018171
G1 X20.46100 Y66.75057 E0.157789
G1 X20.74506 Y66.23787 E0.019443
G1 X22.18021 Y71.59391 E0.183937
G1 X22.66828 Y71.84260 E0.018171
G1 X21.03016 Y65.72906 E0.209951
G1 X21.31629 Y65.22405 E0.019254
G1 X23.15636 Y72.09128 E0.235835
G1 X23.64443 Y72.33997 E0.018171
G1 X21.60341 Y64.72277 E0.261590
G1 X21.89153 Y64.22522 E0.019072
G1 X24.13251 Y72.58866 E0.287217
G1 X24.62058 Y72.83734 E0.018171
G1 X22.18062 Y63.73129 E0.312720
G1 X22.47068 Y63.24098 E0.018898
G1 X25.10866 Y73.08603 E0.338099
G1 X25.59673 Y73.33472 E0.018171
G1 X22.76169 Y62.75421 E0.363356
G1 X23.05364 Y62.27094 E0.018729
G1 X26.08481 Y73.58340 E0.388493
G1 X26.57288 Y73.83209 E0.018171
G1 X23.34651 Y61.79112 E0.413511
G1 X23.64030 Y61.31472 E0.018567
G1 X27.06096 Y74.08078 E0.438412
G1 X27.54903 Y74.32946 E0.018171
G1 X23.93499 Y60.84168 E0.463198
G1 X24.23057 Y60.37197 E0.018409
G1 X28.03711 Y74.57815 E0.487869
G1 X28.52518 Y74.82684 E0.018171
G1 X24.52703 Y59.90553 E0.512428
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y59.53107 E0.304552
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.09088 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.37103 Y73.26506 E0.075092
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
G1 X29.65237 Y72.74220 E0.055216
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
G1 X29.93489 Y72.22377 E0.038451
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
G1 X30.21858 Y71.70966 E0.024467
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
G1 X30.50340 Y71.19981 E0.013268
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
G1 X30.78935 Y70.69414 E0.005195
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 X28.92992 Y62.18181 E0.020181
G1 X30.24788 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.65376 Y69.20165 E0.218317
G1 X31.94403 Y68.71212 E0.018879
G1 X30.46059 Y63.17584 E0.190127
G1 X30.97081 Y63.50719 E0.020181
G1 X32.23534 Y68.22648 E0.162070
G1 X32.52768 Y67.74465 E0.018695
G1 X31.48103 Y63.83853 E0.134144
G1 X31.99126 Y64.16987 E0.020181
G1 X32.82102 Y67.26660 E0.106348
G1 X33.11536 Y66.79226 E0.018518
G1 X32.50148 Y64.50121 E0.078679
G1 X33.01170 Y64.83256 E0.020181
G1 X33.41069 Y66.32160 E0.051137
G1 X33.70698 Y65.85455 E0.018348
G1 X33.52192 Y65.16390 E0.023718
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X122.56790 Y3.33940 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.03515 Y3.87215 E0.024992
G1 X122.06382 Y4.41918 E0.018171
G1 X123.16873 Y3.31426 E0.051834
G1 X123.76652 Y3.29217 E0.019843
G1 X122.09248 Y4.96621 E0.078533
G1 X122.12115 Y5.51324 E0.018171
G1 X124.36129 Y3.27310 E0.105090
G1 X124.95310 Y3.25699 E0.019639
G1 X122.14982 Y6.06027 E0.131508
G1 X122.17849 Y6.60730 E0.018171
G1 X125.54201 Y3.24378 E0.157789
G1 X126.12805 Y3.23343 E0.019443
G1 X122.20716 Y7.15432 E0.183937
G1 X122.23583 Y7.70135 E0.018171
G1 X126.71124 Y3.22594 E0.209951
G1 X127.29166 Y3.22122 E0.019254
G1 X122.26450 Y8.24838 E0.235835
G1 X122.29316 Y8.79541 E0.018171
G1 X127.86934 Y3.21923 E0.261590
G1 X128.44429 Y3.21998 E0.019072
G1 X122.32183 Y9.34244 E0.287217
G1 X122.35050 Y9.88947 E0.018171
G1 X129.01660 Y3.22338 E0.312720
G1 X129.58625 Y3.22942 E0.018898
G1 X122.37917 Y10.43650 E0.338099
G1 X122.40784 Y10.98353 E0.018171
G1 X130.15331 Y3.23805 E0.363356
G1 X130.71781 Y3.24925 E0.018729
G1 X122.43651 Y11.53056 E0.388493
G1 X122.46518 Y12.07758 E0.018171
G1 X131.27978 Y3.26298 E0.413511
G1 X131.83925 Y3.27921 E0.018567
G1 X122.49384 Y12.62461 E0.438412
G1 X122.52251 Y13.17164 E0.018171
G1 X132.39626 Y3.29790 E0.463198
G1 X132.95082 Y3.31903 E0.018409
G1 X122.55118 Y13.71867 E0.487869
G1 X122.57985 Y14.26570 E0.018171
G1 X133.50300 Y3.34255 E0.512428
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y3.43340 E0.304552
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.75856 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.35531 Y14.21733 E0.075092
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
G1 X124.94879 Y14.19955 E0.055216
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
G1 X125.53903 Y14.18501 E0.038451
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
G1 X126.12610 Y14.17363 E0.024467
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
G1 X126.71006 Y14.16537 E0.013268
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
G1 X127.29095 Y14.16018 E0.005195
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 X133.73313 Y8.29370 E0.020181
G1 X130.13239 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X129.01569 Y14.16253 E0.218317
G1 X129.58477 Y14.16915 E0.018879
G1 X133.63761 Y10.11631 E0.190127
G1 X133.60577 Y10.72385 E0.020181
G1 X130.15101 Y14.17861 E0.162070
G1 X130.71445 Y14.19087 E0.018695
G1 X133.57393 Y11.33139 E0.134144
G1 X133.54209 Y11.93892 E0.020181
G1 X131.27513 Y14.20588 E0.106348
G1 X131.83308 Y14.22363 E0.018518
G1 X133.51025 Y12.54646 E0.078679
G1 X133.47841 Y13.15400 E0.020181
G1 X132.38836 Y14.24405 E0.051137
G1 X132.94098 Y14.26713 E0.018348
G1 X133.44657 Y13.76154 E0.023718
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X231.51115 Y59.96536 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.78339 Y59.77036 E0.024992
G1 X230.32399 Y60.06870 E0.018171
G1 X231.83333 Y60.47313 E0.051834
G1 X232.15136 Y60.97979 E0.019843
G1 X229.86458 Y60.36705 E0.078533
G1 X229.40517 Y60.66539 E0.018171
G1 X232.46526 Y61.48534 E0.105090
G1 X232.77512 Y61.98980 E0.019639
G1 X228.94577 Y60.96373 E0.131508
G1 X228.48636 Y61.26207 E0.018171
G1 X233.08101 Y62.49320 E0.157789
G1 X233.38299 Y62.99556 E0.019443
G1 X228.02695 Y61.56041 E0.183937
G1 X227.56755 Y61.85876 E0.018171
G1 X233.68108 Y63.49687 E0.209951
G1 X233.97538 Y63.99717 E0.019254
G1 X227.10814 Y62.15710 E0.235835
G1 X226.64873 Y62.45544 E0.018171
G1 X234.26594 Y64.49646 E0.261590
G1 X234.55276 Y64.99476 E0.019072
G1 X226.18933 Y62.75378 E0.287217
G1 X225.72992 Y63.05213 E0.018171
G1 X234.83597 Y65.49209 E0.312720
G1 X235.11557 Y65.98844 E0.018898
G1 X225.27051 Y63.35047 E0.338099
G1 X224.81111 Y63.64881 E0.018171
G1 X235.39162 Y66.48385 E0.363356
G1 X235.66417 Y66.97832 E0.018729
G1 X224.35170 Y63.94715 E0.388493
G1 X223.89229 Y64.24549 E0.018171
G1 X235.93326 Y67.47186 E0.413511
G1 X236.19894 Y67.96449 E0.018567
G1 X223.43289 Y64.54384 E0.438412
G1 X222.97348 Y64.84218 E0.018171
G1 X236.46126 Y68.45622 E0.463198
G1 X236.72025 Y68.94705 E0.018409
G1 X222.51407 Y65.14052 E0.487869
G1 X222.05467 Y65.43886 E0.018171
G1 X236.97597 Y69.43701 E0.512428
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y69.90233 E0.304552
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.66767 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.98428 Y66.95227 E0.075092
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
G1 X223.29643 Y67.45735 E0.055216
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
G1 X223.60414 Y67.96124 E0.038451
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
G1 X223.90753 Y68.46397 E0.024467
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
G1 X224.20666 Y68.96557 E0.013268
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
G1 X224.50160 Y69.46604 E0.005195
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 X232.80321 Y72.11189 E0.020181
G1 X227.88450 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X225.36193 Y70.96088 E0.218317
G1 X225.64074 Y71.45703 E0.018879
G1 X231.17702 Y72.94047 E0.190127
G1 X230.63496 Y73.21666 E0.020181
G1 X225.91567 Y71.95213 E0.162070
G1 X226.18677 Y72.44622 E0.018695
G1 X230.09290 Y73.49286 E0.134144
G1 X229.55084 Y73.76905 E0.020181
G1 X226.45411 Y72.93929 E0.106348
G1 X226.71772 Y73.43136 E0.018518
G1 X229.00877 Y74.04525 E0.078679
G1 X228.46671 Y74.32144 E0.020181
G1 X226.97767 Y73.92245 E0.051137
G1 X227.23400 Y74.41258 E0.018348
G1 X227.92465 Y74.59764 E0.023718
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z1.400 F1200
G1 X17.73278 Y69.74074 F12000
G1 Z1.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X184.25926 Y15.73278 I110.26722 J56.25926 E5.974872
G3 X238.26722 Y182.25926 I-56.25926 J110.26722 E5.974872
G3 X71.74074 Y236.26722 I-110.26722 J-56.25926 E5.974872
G3 X17.73278 Y69.74074 I56.25926 J-110.26722 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X235.59226 Y96.24052 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X98.24052 Y18.40774 I-107.59226 J29.75948 E5.816723
G2 X20.40774 Y155.75948 I29.75948 J107.59226 E5.816723
G2 X157.75948 Y233.59226 I107.59226 J-29.75948 E5.816723
G2 X235.59226 Y96.24052 I-29.75948 J-107.59226 E5.816723
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X235.19991 Y96.34904 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X98.34904 Y18.80009 I-107.19991 J29.65096 E5.795511
G2 X20.80009 Y155.65096 I29.65096 J107.19991 E5.795511
G2 X157.65096 Y233.19991 I107.19991 J-29.65096 E5.795511
G2 X235.19991 Y96.34904 I-29.65096 J-107.19991 E5.795511
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X246.53996 Y93.21244 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X160.78756 Y244.53996 I-118.53996 J32.78756 E6.408584
G3 X9.46004 Y158.78756 I-32.78756 J-118.53996 E6.408584
G3 X95.21244 Y7.46004 I118.53996 J-32.78756 E6.408584
G3 X246.53996 Y93.21244 I32.78756 J118.53996 E6.408584
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X246.93231 Y93.10391 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X160.89609 Y244.93231 I-118.93231 J32.89609 E6.429796
G3 X9.06769 Y158.89609 I-32.89609 J-118.93231 E6.429796
G3 X95.10391 Y7.06769 I118.93231 J-32.89609 E6.429796
G3 X246.93231 Y93.10391 I32.89609 J118.93231 E6.429796
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.58223 Y182.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X226.21372 Y181.14466 I-1.85534 J0.51318 E0.100304
G2 X224.87156 Y183.51318 I0.51318 J1.85534 E0.100304
G2 X227.24007 Y184.85534 I1.85534 J-0.51318 E0.100304
G2 X228.58223 Y182.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.85534 Y239.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X127.48682 Y238.14466 I-1.85534 J0.51318 E0.100304
G2 X126.14466 Y240.51318 I0.51318 J1.85534 E0.100304
G2 X128.51318 Y241.85534 I1.85534 J-0.51318 E0.100304
G2 X129.85534 Y239.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.12844 Y182.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X28.75993 Y181.14466 I-1.85534 J0.51318 E0.100304
G2 X27.41777 Y183.51318 I0.51318 J1.85534 E0.100304
G2 X29.78628 Y184.85534 I1.85534 J-0.51318 E0.100304
G2 X31.12844 Y182.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.12844 Y68.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X28.75993 Y67.14466 I-1.85534 J0.51318 E0.100304
G2 X27.41777 Y69.51318 I0.51318 J1.85534 E0.100304
G2 X29.78628 Y70.85534 I1.85534 J-0.51318 E0.100304
G2 X31.12844 Y68.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X129.85534 Y11.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X127.48682 Y10.14466 I-1.85534 J0.51318 E0.100304
G2 X126.14466 Y12.51318 I0.51318 J1.85534 E0.100304
G2 X128.51318 Y13.85534 I1.85534 J-0.51318 E0.100304
G2 X129.85534 Y11.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.58223 Y68.48682 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X226.21372 Y67.14466 I-1.85534 J0.51318 E0.100304
G2 X224.87156 Y69.51318 I0.51318 J1.85534 E0.100304
G2 X227.24007 Y70.85534 I1.85534 J-0.51318 E0.100304
G2 X228.58223 Y68.48682 I-0.51318 J-1.85534 E0.100304
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.92465 Y177.40236 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.23400 Y177.58742 E0.023718
G1 X226.97767 Y178.07755 E0.018348
G1 X228.46671 Y177.67856 E0.051137
G1 X229.00877 Y177.95475 E0.020181
G1 X226.71772 Y178.56864 E0.078679
G1 X226.45411 Y179.06071 E0.018518
G1 X229.55084 Y178.23095 E0.106348
G1 X230.09290 Y178.50714 E0.020181
G1 X226.18677 Y179.55378 E0.134144
G1 X225.91567 Y180.04787 E0.018695
G1 X230.63496 Y178.78334 E0.162070
G1 X231.17702 Y179.05953 E0.020181
G1 X225.64074 Y180.54297 E0.190127
G1 X225.36193 Y181.03912 E0.018879
G1 X231.71909 Y179.33573 E0.218317
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 X232.80321 Y179.88811 E0.020181
G1 X227.88450 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.50160 Y182.53396 E0.005195
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
G1 X224.20666 Y183.03443 E0.013268
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
G1 X223.90753 Y183.53603 E0.024467
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
G1 X223.60414 Y184.03876 E0.038451
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
G1 X223.29643 Y184.54265 E0.055216
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
G1 X222.98428 Y185.04773 E0.075092
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
G1 X222.66767 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y182.09767 E0.304552
G1 X236.97597 Y182.56299 E0.016363
G1 X222.05467 Y186.56114 E0.512428
G1 X222.51407 Y186.85948 E0.018171
G1 X236.72025 Y183.05295 E0.487869
G1 X236.46126 Y183.54378 E0.018409
G1 X222.97348 Y187.15782 E0.463198
G1 X223.43289 Y187.45616 E0.018171
G1 X236.19894 Y184.03551 E0.438412
G1 X235.93326 Y184.52814 E0.018567
G1 X223.89229 Y187.75451 E0.413511
G1 X224.35170 Y188.05285 E0.018171
G1 X235.66417 Y185.02168 E0.388493
G1 X235.39162 Y185.51615 E0.018729
G1 X224.81111 Y188.35119 E0.363356
G1 X225.27051 Y188.64953 E0.018171
G1 X235.11557 Y186.01156 E0.338099
G1 X234.83597 Y186.50791 E0.018898
G1 X225.72992 Y188.94787 E0.312720
G1 X226.18933 Y189.24622 E0.018171
G1 X234.55276 Y187.00524 E0.287217
G1 X234.26594 Y187.50354 E0.019072
G1 X226.64873 Y189.54456 E0.261590
G1 X227.10814 Y189.84290 E0.018171
G1 X233.97538 Y188.00283 E0.235835
G1 X233.68108 Y188.50313 E0.019254
G1 X227.56755 Y190.14124 E0.209951
G1 X228.02695 Y190.43959 E0.018171
G1 X233.38299 Y189.00444 E0.183937
G1 X233.08101 Y189.50680 E0.019443
G1 X228.48636 Y190.73793 E0.157789
G1 X228.94577 Y191.03627 E0.018171
G1 X232.77512 Y190.01020 E0.131508
G1 X232.46526 Y190.51466 E0.019639
G1 X229.40517 Y191.33461 E0.105090
G1 X229.86458 Y191.63295 E0.018171
G1 X232.15136 Y191.02021 E0.078533
G1 X231.83333 Y191.52687 E0.019843
G1 X230.32399 Y191.93130 E0.051834
G1 X230.78339 Y192.22964 E0.018171
G1 X231.51115 Y192.03464 E0.024992
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X133.44657 Y238.23846 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.94098 Y237.73287 E0.023718
G1 X132.38836 Y237.75595 E0.018348
G1 X133.47841 Y238.84600 E0.051137
G1 X133.51025 Y239.45354 E0.020181
G1 X131.83308 Y237.77637 E0.078679
G1 X131.27513 Y237.79412 E0.018518
G1 X133.54209 Y240.06108 E0.106348
G1 X133.57393 Y240.66861 E0.020181
G1 X130.71445 Y237.80913 E0.134144
G1 X130.15101 Y237.82139 E0.018695
G1 X133.60577 Y241.27615 E0.162070
G1 X133.63761 Y241.88369 E0.020181
G1 X129.58477 Y237.83085 E0.190127
G1 X129.01569 Y237.83747 E0.018879
G1 X133.66945 Y242.49123 E0.218317
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 X133.73313 Y243.70630 E0.020181
G1 X130.13239 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.29095 Y237.83982 E0.005195
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
G1 X126.71006 Y237.83463 E0.013268
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
G1 X126.12610 Y237.82637 E0.024467
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
G1 X125.53903 Y237.81499 E0.038451
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
G1 X124.94879 Y237.80045 E0.055216
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
G1 X124.35531 Y237.78267 E0.075092
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
G1 X123.75856 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y248.56660 E0.304552
G1 X133.50300 Y248.65745 E0.016363
G1 X122.57985 Y237.73430 E0.512428
G1 X122.55118 Y238.28133 E0.018171
G1 X132.95082 Y248.68097 E0.487869
G1 X132.39626 Y248.70210 E0.018409
G1 X122.52251 Y238.82836 E0.463198
G1 X122.49384 Y239.37539 E0.018171
G1 X131.83925 Y248.72079 E0.438412
G1 X131.27978 Y248.73702 E0.018567
G1 X122.46518 Y239.92242 E0.413511
G1 X122.43651 Y240.46944 E0.018171
G1 X130.71781 Y248.75075 E0.388493
G1 X130.15331 Y248.76195 E0.018729
G1 X122.40784 Y241.01647 E0.363356
G1 X122.37917 Y241.56350 E0.018171
G1 X129.58625 Y248.77058 E0.338099
G1 X129.01660 Y248.77662 E0.018898
G1 X122.35050 Y242.11053 E0.312720
G1 X122.32183 Y242.65756 E0.018171
G1 X128.44429 Y248.78002 E0.287217
G1 X127.86934 Y248.78077 E0.019072
G1 X122.29316 Y243.20459 E0.261590
G1 X122.26450 Y243.75162 E0.018171
G1 X127.29166 Y248.77878 E0.235835
G1 X126.71124 Y248.77406 E0.019254
G1 X122.23583 Y244.29865 E0.209951
G1 X122.20716 Y244.84568 E0.018171
G1 X126.12805 Y248.76657 E0.183937
G1 X125.54201 Y248.75622 E0.019443
G1 X122.17849 Y245.39270 E0.157789
G1 X122.14982 Y245.93973 E0.018171
G1 X124.95310 Y248.74301 E0.131508
G1 X124.36129 Y248.72690 E0.019639
G1 X122.12115 Y246.48676 E0.105090
G1 X122.09248 Y247.03379 E0.018171
G1 X123.76652 Y248.70783 E0.078533
G1 X123.16873 Y248.68574 E0.019843
G1 X122.06382 Y247.58082 E0.051834
G1 X122.03515 Y248.12785 E0.018171
G1 X122.56790 Y248.66060 E0.024992
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X33.52192 Y186.83610 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.70698 Y186.14545 E0.023718
G1 X33.41069 Y185.67840 E0.018348
G1 X33.01170 Y187.16744 E0.051137
G1 X32.50148 Y187.49879 E0.020181
G1 X33.11536 Y185.20774 E0.078679
G1 X32.82102 Y184.73340 E0.018518
G1 X31.99126 Y187.83013 E0.106348
G1 X31.48103 Y188.16147 E0.020181
G1 X32.52768 Y184.25535 E0.134144
G1 X32.23534 Y183.77352 E0.018695
G1 X30.97081 Y188.49281 E0.162070
G1 X30.46059 Y188.82416 E0.020181
G1 X31.94403 Y183.28788 E0.190127
G1 X31.65376 Y182.79835 E0.018879
G1 X29.95036 Y189.15550 E0.218317
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 X28.92992 Y189.81819 E0.020181
G1 X30.24788 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.78935 Y181.30586 E0.005195
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
G1 X30.50340 Y180.80019 E0.013268
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
G1 X30.21858 Y180.29034 E0.024467
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
G1 X29.93489 Y179.77623 E0.038451
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
G1 X29.65237 Y179.25780 E0.055216
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
G1 X29.37103 Y178.73494 E0.075092
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
G1 X29.09088 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y192.46893 E0.304552
G1 X24.52703 Y192.09447 E0.016363
G1 X28.52518 Y177.17316 E0.512428
G1 X28.03711 Y177.42185 E0.018171
G1 X24.23057 Y191.62803 E0.487869
G1 X23.93499 Y191.15832 E0.018409
G1 X27.54903 Y177.67054 E0.463198
G1 X27.06096 Y177.91922 E0.018171
G1 X23.64030 Y190.68528 E0.438412
G1 X23.34651 Y190.20888 E0.018567
G1 X26.57288 Y178.16791 E0.413511
G1 X26.08481 Y178.41660 E0.018171
G1 X23.05364 Y189.72906 E0.388493
G1 X22.76169 Y189.24579 E0.018729
G1 X25.59673 Y178.66528 E0.363356
G1 X25.10866 Y178.91397 E0.018171
G1 X22.47068 Y188.75902 E0.338099
G1 X22.18062 Y188.26871 E0.018898
G1 X24.62058 Y179.16266 E0.312720
G1 X24.13251 Y179.41134 E0.018171
G1 X21.89153 Y187.77478 E0.287217
G1 X21.60341 Y187.27723 E0.019072
G1 X23.64443 Y179.66003 E0.261590
G1 X23.15636 Y179.90872 E0.018171
G1 X21.31629 Y186.77595 E0.235835
G1 X21.03016 Y186.27094 E0.019254
G1 X22.66828 Y180.15740 E0.209951
G1 X22.18021 Y180.40609 E0.018171
G1 X20.74506 Y185.76213 E0.183937
G1 X20.46100 Y185.24943 E0.019443
G1 X21.69213 Y180.65478 E0.157789
G1 X21.20405 Y180.90346 E0.018171
G1 X20.17798 Y184.73282 E0.131508
G1 X19.89603 Y184.21224 E0.019639
G1 X20.71598 Y181.15215 E0.105090
G1 X20.22790 Y181.40084 E0.018171
G1 X19.61516 Y183.68761 E0.078533
G1 X19.33540 Y183.15887 E0.019843
G1 X19.73983 Y181.64952 E0.051834
G1 X19.25175 Y181.89821 E0.018171
G1 X19.05675 Y182.62596 E0.024992
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.07535 Y74.59764 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.76600 Y74.41258 E0.023718
G1 X29.02233 Y73.92245 E0.018348
G1 X27.53329 Y74.32144 E0.051137
G1 X26.99123 Y74.04525 E0.020181
G1 X29.28228 Y73.43136 E0.078679
G1 X29.54589 Y72.93929 E0.018518
G1 X26.44916 Y73.76905 E0.106348
G1 X25.90710 Y73.49286 E0.020181
G1 X29.81323 Y72.44622 E0.134144
G1 X30.08433 Y71.95213 E0.018695
G1 X25.36504 Y73.21666 E0.162070
G1 X24.82298 Y72.94047 E0.020181
G1 X30.35926 Y71.45703 E0.190127
G1 X30.63807 Y70.96088 E0.018879
G1 X24.28091 Y72.66427 E0.218317
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 X23.19679 Y72.11189 E0.020181
G1 X28.11550 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.49840 Y69.46604 E0.005195
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
G1 X31.79334 Y68.96557 E0.013268
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
G1 X32.09247 Y68.46397 E0.024467
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
G1 X32.39586 Y67.96124 E0.038451
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
G1 X32.70357 Y67.45735 E0.055216
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
G1 X33.01572 Y66.95227 E0.075092
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
G1 X33.33233 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y69.90233 E0.304552
G1 X19.02403 Y69.43701 E0.016363
G1 X33.94533 Y65.43886 E0.512428
G1 X33.48593 Y65.14052 E0.018171
G1 X19.27975 Y68.94705 E0.487869
G1 X19.53874 Y68.45622 E0.018409
G1 X33.02652 Y64.84218 E0.463198
G1 X32.56711 Y64.54384 E0.018171
G1 X19.80106 Y67.96449 E0.438412
G1 X20.06674 Y67.47186 E0.018567
G1 X32.10771 Y64.24549 E0.413511
G1 X31.64830 Y63.94715 E0.018171
G1 X20.33583 Y66.97832 E0.388493
G1 X20.60838 Y66.48385 E0.018729
G1 X31.18889 Y63.64881 E0.363356
G1 X30.72949 Y63.35047 E0.018171
G1 X20.88443 Y65.98844 E0.338099
G1 X21.16403 Y65.49209 E0.018898
G1 X30.27008 Y63.05213 E0.312720
G1 X29.81067 Y62.75378 E0.018171
G1 X21.44724 Y64.99476 E0.287217
G1 X21.73406 Y64.49646 E0.019072
G1 X29.35127 Y62.45544 E0.261590
G1 X28.89186 Y62.15710 E0.018171
G1 X22.02462 Y63.99717 E0.235835
G1 X22.31892 Y63.49687 E0.019254
G1 X28.43245 Y61.85876 E0.209951
G1 X27.97305 Y61.56041 E0.018171
G1 X22.61701 Y62.99556 E0.183937
G1 X22.91899 Y62.49320 E0.019443
G1 X27.51364 Y61.26207 E0.157789
G1 X27.05423 Y60.96373 E0.018171
G1 X23.22488 Y61.98980 E0.131508
G1 X23.53474 Y61.48534 E0.019639
G1 X26.59483 Y60.66539 E0.105090
G1 X26.13542 Y60.36705 E0.018171
G1 X23.84864 Y60.97979 E0.078533
G1 X24.16667 Y60.47313 E0.019843
G1 X25.67601 Y60.06870 E0.051834
G1 X25.21661 Y59.77036 E0.018171
G1 X24.48885 Y59.96536 E0.024992
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X122.55343 Y13.76154 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.05902 Y14.26713 E0.023718
G1 X123.61164 Y14.24405 E0.018348
G1 X122.52159 Y13.15400 E0.051137
G1 X122.48975 Y12.54646 E0.020181
G1 X124.16692 Y14.22363 E0.078679
G1 X124.72487 Y14.20588 E0.018518
G1 X122.45791 Y11.93892 E0.106348
G1 X122.42607 Y11.33139 E0.020181
G1 X125.28555 Y14.19087 E0.134144
G1 X125.84899 Y14.17861 E0.018695
G1 X122.39423 Y10.72385 E0.162070
G1 X122.36239 Y10.11631 E0.020181
G1 X126.41523 Y14.16915 E0.190127
G1 X126.98431 Y14.16253 E0.018879
G1 X122.33055 Y9.50877 E0.218317
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 X122.26687 Y8.29370 E0.020181
G1 X125.86761 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.70905 Y14.16018 E0.005195
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
G1 X129.28994 Y14.16537 E0.013268
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
G1 X129.87390 Y14.17363 E0.024467
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
G1 X130.46097 Y14.18501 E0.038451
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
G1 X131.05121 Y14.19955 E0.055216
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
G1 X131.64469 Y14.21733 E0.075092
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
G1 X132.24144 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y3.43340 E0.304552
G1 X122.49700 Y3.34255 E0.016363
G1 X133.42015 Y14.26570 E0.512428
G1 X133.44882 Y13.71867 E0.018171
G1 X123.04918 Y3.31903 E0.487869
G1 X123.60374 Y3.29790 E0.018409
G1 X133.47749 Y13.17164 E0.463198
G1 X133.50616 Y12.62461 E0.018171
G1 X124.16075 Y3.27921 E0.438412
G1 X124.72022 Y3.26298 E0.018567
G1 X133.53482 Y12.07758 E0.413511
G1 X133.56349 Y11.53056 E0.018171
G1 X125.28219 Y3.24925 E0.388493
G1 X125.84669 Y3.23805 E0.018729
G1 X133.59216 Y10.98353 E0.363356
G1 X133.62083 Y10.43650 E0.018171
G1 X126.41375 Y3.22942 E0.338099
G1 X126.98340 Y3.22338 E0.018898
G1 X133.64950 Y9.88947 E0.312720
G1 X133.67817 Y9.34244 E0.018171
G1 X127.55571 Y3.21998 E0.287217
G1 X128.13066 Y3.21923 E0.019072
G1 X133.70684 Y8.79541 E0.261590
G1 X133.73550 Y8.24838 E0.018171
G1 X128.70834 Y3.22122 E0.235835
G1 X129.28876 Y3.22594 E0.019254
G1 X133.76417 Y7.70135 E0.209951
G1 X133.79284 Y7.15432 E0.018171
G1 X129.87195 Y3.23343 E0.183937
G1 X130.45799 Y3.24378 E0.019443
G1 X133.82151 Y6.60730 E0.157789
G1 X133.85018 Y6.06027 E0.018171
G1 X131.04690 Y3.25699 E0.131508
G1 X131.63871 Y3.27310 E0.019639
G1 X133.87885 Y5.51324 E0.105090
G1 X133.90752 Y4.96621 E0.018171
G1 X132.23348 Y3.29217 E0.078533
G1 X132.83127 Y3.31426 E0.019843
G1 X133.93618 Y4.41918 E0.051834
G1 X133.96485 Y3.87215 E0.018171
G1 X133.43210 Y3.33940 E0.024992
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X222.47808 Y65.16390 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.29302 Y65.85455 E0.023718
G1 X222.58931 Y66.32160 E0.018348
G1 X222.98830 Y64.83256 E0.051137
G1 X223.49852 Y64.50121 E0.020181
G1 X222.88464 Y66.79226 E0.078679
G1 X223.17898 Y67.26660 E0.018518
G1 X224.00874 Y64.16987 E0.106348
G1 X224.51897 Y63.83853 E0.020181
G1 X223.47232 Y67.74465 E0.134144
G1 X223.76466 Y68.22648 E0.018695
G1 X225.02919 Y63.50719 E0.162070
G1 X225.53941 Y63.17584 E0.020181
G1 X224.05597 Y68.71212 E0.190127
G1 X224.34624 Y69.20165 E0.018879
G1 X226.04964 Y62.84450 E0.218317
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 X227.07008 Y62.18181 E0.020181
G1 X225.75212 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.21065 Y70.69414 E0.005195
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
G1 X225.49660 Y71.19981 E0.013268
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
G1 X225.78142 Y71.70966 E0.024467
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
G1 X226.06511 Y72.22377 E0.038451
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
G1 X226.34763 Y72.74220 E0.055216
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
G1 X226.62897 Y73.26506 E0.075092
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
G1 X226.90912 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y59.53107 E0.304552
G1 X231.47297 Y59.90553 E0.016363
G1 X227.47482 Y74.82684 E0.512428
G1 X227.96289 Y74.57815 E0.018171
G1 X231.76943 Y60.37197 E0.487869
G1 X232.06501 Y60.84168 E0.018409
G1 X228.45097 Y74.32946 E0.463198
G1 X228.93904 Y74.08078 E0.018171
G1 X232.35970 Y61.31472 E0.438412
G1 X232.65349 Y61.79112 E0.018567
G1 X229.42712 Y73.83209 E0.413511
G1 X229.91519 Y73.58340 E0.018171
G1 X232.94636 Y62.27094 E0.388493
G1 X233.23831 Y62.75421 E0.018729
G1 X230.40327 Y73.33472 E0.363356
G1 X230.89134 Y73.08603 E0.018171
G1 X233.52932 Y63.24098 E0.338099
G1 X233.81938 Y63.73129 E0.018898
G1 X231.37942 Y72.83734 E0.312720
G1 X231.86749 Y72.58866 E0.018171
G1 X234.10847 Y64.22522 E0.287217
G1 X234.39659 Y64.72277 E0.019072
G1 X232.35557 Y72.33997 E0.261590
G1 X232.84364 Y72.09128 E0.018171
G1 X234.68371 Y65.22405 E0.235835
G1 X234.96984 Y65.72906 E0.019254
G1 X233.33172 Y71.84260 E0.209951
G1 X233.81979 Y71.59391 E0.018171
G1 X235.25494 Y66.23787 E0.183937
G1 X235.53900 Y66.75057 E0.019443
G1 X234.30787 Y71.34522 E0.157789
G1 X234.79595 Y71.09654 E0.018171
G1 X235.82202 Y67.26718 E0.131508
G1 X236.10397 Y67.78776 E0.019639
G1 X235.28402 Y70.84785 E0.105090
G1 X235.77210 Y70.59916 E0.018171
G1 X236.38484 Y68.31239 E0.078533
G1 X236.66460 Y68.84113 E0.019843
G1 X236.26017 Y70.35048 E0.051834
G1 X236.74825 Y70.10179 E0.018171
G1 X236.94325 Y69.37404 E0.024992
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z1.600 F1200
G1 X247.31020 Y92.99939 F12000
G1 Z1.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X161.00061 Y245.31020 I-119.31020 J33.00061 E5.974872
G3 X8.68980 Y159.00061 I-33.00061 J-119.31020 E5.974872
G3 X94.99939 Y6.68980 I119.31020 J-33.00061 E5.974872
G3 X247.31020 Y92.99939 I33.00061 J119.31020 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X68.76706 Y220.62124 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X222.62124 Y185.23294 I59.23294 J-94.62124 E5.816723
G2 X187.23294 Y31.37876 I-94.62124 J-59.23294 E5.816723
G2 X33.37876 Y66.76706 I-59.23294 J94.62124 E5.816723
G2 X68.76706 Y220.62124 I94.62124 J59.23294 E5.816723
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X68.98306 Y220.27620 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X222.27620 Y185.01694 I59.01694 J-94.27620 E5.795511
G2 X187.01694 Y31.72380 I-94.27620 J-59.01694 E5.795511
G2 X33.72380 Y66.98306 I-59.01694 J94.27620 E5.795511
G2 X68.98306 Y220.27620 I94.27620 J59.01694 E5.795511
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X62.74000 Y230.24912 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X23.75088 Y60.74000 I65.26000 J-104.24912 E6.408584
G3 X193.26000 Y21.75088 I104.24912 J65.26000 E6.408584
G3 X232.24912 Y191.26000 I-65.26000 J104.24912 E6.408584
G3 X62.74000 Y230.24912 I-104.24912 J-65.26000 E6.408584
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X62.52400 Y230.59417 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X23.40583 Y60.52400 I65.47600 J-104.59417 E6.429796
G3 X193.47600 Y21.40583 I104.59417 J65.47600 E6.429796
G3 X232.59417 Y191.47600 I-65.47600 J104.59417 E6.429796
G3 X62.52400 Y230.59417 I-104.59417 J-65.47600 E6.429796
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.70547 Y184.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X228.35856 Y184.02142 I1.02142 J-1.63166 E0.100304
G2 X227.74832 Y181.36834 I-1.63166 J-1.02142 E0.100304
G2 X225.09523 Y181.97858 I-1.02142 J1.63166 E0.100304
G2 X225.70547 Y184.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.97858 Y241.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.63166 Y241.02142 I1.02142 J-1.63166 E0.100304
G2 X129.02142 Y238.36834 I-1.63166 J-1.02142 E0.100304
G2 X126.36834 Y238.97858 I-1.02142 J1.63166 E0.100304
G2 X126.97858 Y241.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.25168 Y184.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X30.90477 Y184.02142 I1.02142 J-1.63166 E0.100304
G2 X30.29453 Y181.36834 I-1.63166 J-1.02142 E0.100304
G2 X27.64144 Y181.97858 I-1.02142 J1.63166 E0.100304
G2 X28.25168 Y184.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.25168 Y70.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X30.90477 Y70.02142 I1.02142 J-1.63166 E0.100304
G2 X30.29453 Y67.36834 I-1.63166 J-1.02142 E0.100304
G2 X27.64144 Y67.97858 I-1.02142 J1.63166 E0.100304
G2 X28.25168 Y70.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X126.97858 Y13.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.63166 Y13.02142 I1.02142 J-1.63166 E0.100304
G2 X129.02142 Y10.36834 I-1.63166 J-1.02142 E0.100304
G2 X126.36834 Y10.97858 I-1.02142 J1.63166 E0.100304
G2 X126.97858 Y13.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.70547 Y70.63166 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X228.35856 Y70.02142 I1.02142 J-1.63166 E0.100304
G2 X227.74832 Y67.36834 I-1.63166 J-1.02142 E0.100304
G2 X225.09523 Y67.97858 I-1.02142 J1.63166 E0.100304
G2 X225.70547 Y70.63166 I1.63166 J1.02142 E0.100304
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X236.94325 Y182.62596 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.74825 Y181.89821 E0.024992
G1 X236.26017 Y181.64952 E0.018171
G1 X236.66460 Y183.15887 E0.051834
G1 X236.38484 Y183.68761 E0.019843
G1 X235.77210 Y181.40084 E0.078533
G1 X235.28402 Y181.15215 E0.018171
G1 X236.10397 Y184.21224 E0.105090
G1 X235.82202 Y184.73282 E0.019639
G1 X234.79595 Y180.90346 E0.131508
G1 X234.30787 Y180.65478 E0.018171
G1 X235.53900 Y185.24943 E0.157789
G1 X235.25494 Y185.76213 E0.019443
G1 X233.81979 Y180.40609 E0.183937
G1 X233.33172 Y180.15740 E0.018171
G1 X234.96984 Y186.27094 E0.209951
G1 X234.68371 Y186.77595 E0.019254
G1 X232.84364 Y179.90872 E0.235835
G1 X232.35557 Y179.66003 E0.018171
G1 X234.39659 Y187.27723 E0.261590
G1 X234.10847 Y187.77478 E0.019072
G1 X231.86749 Y179.41134 E0.287217
G1 X231.37942 Y179.16266 E0.018171
G1 X233.81938 Y188.26871 E0.312720
G1 X233.52932 Y188.75902 E0.018898
G1 X230.89134 Y178.91397 E0.338099
G1 X230.40327 Y178.66528 E0.018171
G1 X233.23831 Y189.24579 E0.363356
G1 X232.94636 Y189.72906 E0.018729
G1 X229.91519 Y178.41660 E0.388493
G1 X229.42712 Y178.16791 E0.018171
G1 X232.65349 Y190.20888 E0.413511
G1 X232.35970 Y190.68528 E0.018567
G1 X228.93904 Y177.91922 E0.438412
G1 X228.45097 Y177.67054 E0.018171
G1 X232.06501 Y191.15832 E0.463198
G1 X231.76943 Y191.62803 E0.018409
G1 X227.96289 Y177.42185 E0.487869
G1 X227.47482 Y177.17316 E0.018171
G1 X231.47297 Y192.09447 E0.512428
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y192.46893 E0.304552
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.90912 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.62897 Y178.73494 E0.075092
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
G1 X226.34763 Y179.25780 E0.055216
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
G1 X226.06511 Y179.77623 E0.038451
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
G1 X225.78142 Y180.29034 E0.024467
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
G1 X225.49660 Y180.80019 E0.013268
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
G1 X225.21065 Y181.30586 E0.005195
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 X227.07008 Y189.81819 E0.020181
G1 X225.75212 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.34624 Y182.79835 E0.218317
G1 X224.05597 Y183.28788 E0.018879
G1 X225.53941 Y188.82416 E0.190127
G1 X225.02919 Y188.49281 E0.020181
G1 X223.76466 Y183.77352 E0.162070
G1 X223.47232 Y184.25535 E0.018695
G1 X224.51897 Y188.16147 E0.134144
G1 X224.00874 Y187.83013 E0.020181
G1 X223.17898 Y184.73340 E0.106348
G1 X222.88464 Y185.20774 E0.018518
G1 X223.49852 Y187.49879 E0.078679
G1 X222.98830 Y187.16744 E0.020181
G1 X222.58931 Y185.67840 E0.051137
G1 X222.29302 Y186.14545 E0.018348
G1 X222.47808 Y186.83610 E0.023718
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X133.43210 Y248.66060 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.96485 Y248.12785 E0.024992
G1 X133.93618 Y247.58082 E0.018171
G1 X132.83127 Y248.68574 E0.051834
G1 X132.23348 Y248.70783 E0.019843
G1 X133.90752 Y247.03379 E0.078533
G1 X133.87885 Y246.48676 E0.018171
G1 X131.63871 Y248.72690 E0.105090
G1 X131.04690 Y248.74301 E0.019639
G1 X133.85018 Y245.93973 E0.131508
G1 X133.82151 Y245.39270 E0.018171
G1 X130.45799 Y248.75622 E0.157789
G1 X129.87195 Y248.76657 E0.019443
G1 X133.79284 Y244.84568 E0.183937
G1 X133.76417 Y244.29865 E0.018171
G1 X129.28876 Y248.77406 E0.209951
G1 X128.70834 Y248.77878 E0.019254
G1 X133.73550 Y243.75162 E0.235835
G1 X133.70684 Y243.20459 E0.018171
G1 X128.13066 Y248.78077 E0.261590
G1 X127.55571 Y248.78002 E0.019072
G1 X133.67817 Y242.65756 E0.287217
G1 X133.64950 Y242.11053 E0.018171
G1 X126.98340 Y248.77662 E0.312720
G1 X126.41375 Y248.77058 E0.018898
G1 X133.62083 Y241.56350 E0.338099
G1 X133.59216 Y241.01647 E0.018171
G1 X125.84669 Y248.76195 E0.363356
G1 X125.28219 Y248.75075 E0.018729
G1 X133.56349 Y240.46944 E0.388493
G1 X133.53482 Y239.92242 E0.018171
G1 X124.72022 Y248.73702 E0.413511
G1 X124.16075 Y248.72079 E0.018567
G1 X133.50616 Y239.37539 E0.438412
G1 X133.47749 Y238.82836 E0.018171
G1 X123.60374 Y248.70210 E0.463198
G1 X123.04918 Y248.68097 E0.018409
G1 X133.44882 Y238.28133 E0.487869
G1 X133.42015 Y237.73430 E0.018171
G1 X122.49700 Y248.65745 E0.512428
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y248.56660 E0.304552
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.24144 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.64469 Y237.78267 E0.075092
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
G1 X131.05121 Y237.80045 E0.055216
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
G1 X130.46097 Y237.81499 E0.038451
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
G1 X129.87390 Y237.82637 E0.024467
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
G1 X129.28994 Y237.83463 E0.013268
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
G1 X128.70905 Y237.83982 E0.005195
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 X122.26687 Y243.70630 E0.020181
G1 X125.86761 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X126.98431 Y237.83747 E0.218317
G1 X126.41523 Y237.83085 E0.018879
G1 X122.36239 Y241.88369 E0.190127
G1 X122.39423 Y241.27615 E0.020181
G1 X125.84899 Y237.82139 E0.162070
G1 X125.28555 Y237.80913 E0.018695
G1 X122.42607 Y240.66861 E0.134144
G1 X122.45791 Y240.06108 E0.020181
G1 X124.72487 Y237.79412 E0.106348
G1 X124.16692 Y237.77637 E0.018518
G1 X122.48975 Y239.45354 E0.078679
G1 X122.52159 Y238.84600 E0.020181
G1 X123.61164 Y237.75595 E0.051137
G1 X123.05902 Y237.73287 E0.018348
G1 X122.55343 Y238.23846 E0.023718
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X24.48885 Y192.03464 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.21661 Y192.22964 E0.024992
G1 X25.67601 Y191.93130 E0.018171
G1 X24.16667 Y191.52687 E0.051834
G1 X23.84864 Y191.02021 E0.019843
G1 X26.13542 Y191.63295 E0.078533
G1 X26.59483 Y191.33461 E0.018171
G1 X23.53474 Y190.51466 E0.105090
G1 X23.22488 Y190.01020 E0.019639
G1 X27.05423 Y191.03627 E0.131508
G1 X27.51364 Y190.73793 E0.018171
G1 X22.91899 Y189.50680 E0.157789
G1 X22.61701 Y189.00444 E0.019443
G1 X27.97305 Y190.43959 E0.183937
G1 X28.43245 Y190.14124 E0.018171
G1 X22.31892 Y188.50313 E0.209951
G1 X22.02462 Y188.00283 E0.019254
G1 X28.89186 Y189.84290 E0.235835
G1 X29.35127 Y189.54456 E0.018171
G1 X21.73406 Y187.50354 E0.261590
G1 X21.44724 Y187.00524 E0.019072
G1 X29.81067 Y189.24622 E0.287217
G1 X30.27008 Y188.94787 E0.018171
G1 X21.16403 Y186.50791 E0.312720
G1 X20.88443 Y186.01156 E0.018898
G1 X30.72949 Y188.64953 E0.338099
G1 X31.18889 Y188.35119 E0.018171
G1 X20.60838 Y185.51615 E0.363356
G1 X20.33583 Y185.02168 E0.018729
G1 X31.64830 Y188.05285 E0.388493
G1 X32.10771 Y187.75451 E0.018171
G1 X20.06674 Y184.52814 E0.413511
G1 X19.80106 Y184.03551 E0.018567
G1 X32.56711 Y187.45616 E0.438412
G1 X33.02652 Y187.15782 E0.018171
G1 X19.53874 Y183.54378 E0.463198
G1 X19.27975 Y183.05295 E0.018409
G1 X33.48593 Y186.85948 E0.487869
G1 X33.94533 Y186.56114 E0.018171
G1 X19.02403 Y182.56299 E0.512428
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y182.09767 E0.304552
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.33233 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.01572 Y185.04773 E0.075092
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
G1 X32.70357 Y184.54265 E0.055216
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
G1 X32.39586 Y184.03876 E0.038451
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
G1 X32.09247 Y183.53603 E0.024467
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
G1 X31.79334 Y183.03443 E0.013268
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
G1 X31.49840 Y182.53396 E0.005195
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 X23.19679 Y179.88811 E0.020181
G1 X28.11550 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X30.63807 Y181.03912 E0.218317
G1 X30.35926 Y180.54297 E0.018879
G1 X24.82298 Y179.05953 E0.190127
G1 X25.36504 Y178.78334 E0.020181
G1 X30.08433 Y180.04787 E0.162070
G1 X29.81323 Y179.55378 E0.018695
G1 X25.90710 Y178.50714 E0.134144
G1 X26.44916 Y178.23095 E0.020181
G1 X29.54589 Y179.06071 E0.106348
G1 X29.28228 Y178.56864 E0.018518
G1 X26.99123 Y177.95475 E0.078679
G1 X27.53329 Y177.67856 E0.020181
G1 X29.02233 Y178.07755 E0.051137
G1 X28.76600 Y177.58742 E0.018348
G1 X28.07535 Y177.40236 E0.023718
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X19.05675 Y69.37404 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.25175 Y70.10179 E0.024992
G1 X19.73983 Y70.35048 E0.018171
G1 X19.33540 Y68.84113 E0.051834
G1 X19.61516 Y68.31239 E0.019843
G1 X20.22790 Y70.59916 E0.078533
G1 X20.71598 Y70.84785 E0.018171
G1 X19.89603 Y67.78776 E0.105090
G1 X20.17798 Y67.26718 E0.019639
G1 X21.20405 Y71.09654 E0.131508
G1 X21.69213 Y71.34522 E0.018171
G1 X20.46100 Y66.75057 E0.157789
G1 X20.74506 Y66.23787 E0.019443
G1 X22.18021 Y71.59391 E0.183937
G1 X22.66828 Y71.84260 E0.018171
G1 X21.03016 Y65.72906 E0.209951
G1 X21.31629 Y65.22405 E0.019254
G1 X23.15636 Y72.09128 E0.235835
G1 X23.64443 Y72.33997 E0.018171
G1 X21.60341 Y64.72277 E0.261590
G1 X21.89153 Y64.22522 E0.019072
G1 X24.13251 Y72.58866 E0.287217
G1 X24.62058 Y72.83734 E0.018171
G1 X22.18062 Y63.73129 E0.312720
G1 X22.47068 Y63.24098 E0.018898
G1 X25.10866 Y73.08603 E0.338099
G1 X25.59673 Y73.33472 E0.018171
G1 X22.76169 Y62.75421 E0.363356
G1 X23.05364 Y62.27094 E0.018729
G1 X26.08481 Y73.58340 E0.388493
G1 X26.57288 Y73.83209 E0.018171
G1 X23.34651 Y61.79112 E0.413511
G1 X23.64030 Y61.31472 E0.018567
G1 X27.06096 Y74.08078 E0.438412
G1 X27.54903 Y74.32946 E0.018171
G1 X23.93499 Y60.84168 E0.463198
G1 X24.23057 Y60.37197 E0.018409
G1 X28.03711 Y74.57815 E0.487869
G1 X28.52518 Y74.82684 E0.018171
G1 X24.52703 Y59.90553 E0.512428
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y59.53107 E0.304552
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.09088 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.37103 Y73.26506 E0.075092
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
G1 X29.65237 Y72.74220 E0.055216
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
G1 X29.93489 Y72.22377 E0.038451
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
G1 X30.21858 Y71.70966 E0.024467
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
G1 X30.50340 Y71.19981 E0.013268
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
G1 X30.78935 Y70.69414 E0.005195
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 X28.92992 Y62.18181 E0.020181
G1 X30.24788 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.65376 Y69.20165 E0.218317
G1 X31.94403 Y68.71212 E0.018879
G1 X30.46059 Y63.17584 E0.190127
G1 X30.97081 Y63.50719 E0.020181
G1 X32.23534 Y68.22648 E0.162070
G1 X32.52768 Y67.74465 E0.018695
G1 X31.48103 Y63.83853 E0.134144
G1 X31.99126 Y64.16987 E0.020181
G1 X32.82102 Y67.26660 E0.106348
G1 X33.11536 Y66.79226 E0.018518
G1 X32.50148 Y64.50121 E0.078679
G1 X33.01170 Y64.83256 E0.020181
G1 X33.41069 Y66.32160 E0.051137
G1 X33.70698 Y65.85455 E0.018348
G1 X33.52192 Y65.16390 E0.023718
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X122.56790 Y3.33940 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.03515 Y3.87215 E0.024992
G1 X122.06382 Y4.41918 E0.018171
G1 X123.16873 Y3.31426 E0.051834
G1 X123.76652 Y3.29217 E0.019843
G1 X122.09248 Y4.96621 E0.078533
G1 X122.12115 Y5.51324 E0.018171
G1 X124.36129 Y3.27310 E0.105090
G1 X124.95310 Y3.25699 E0.019639
G1 X122.14982 Y6.06027 E0.131508
G1 X122.17849 Y6.60730 E0.018171
G1 X125.54201 Y3.24378 E0.157789
G1 X126.12805 Y3.23343 E0.019443
G1 X122.20716 Y7.15432 E0.183937
G1 X122.23583 Y7.70135 E0.018171
G1 X126.71124 Y3.22594 E0.209951
G1 X127.29166 Y3.22122 E0.019254
G1 X122.26450 Y8.24838 E0.235835
G1 X122.29316 Y8.79541 E0.018171
G1 X127.86934 Y3.21923 E0.261590
G1 X128.44429 Y3.21998 E0.019072
G1 X122.32183 Y9.34244 E0.287217
G1 X122.35050 Y9.88947 E0.018171
G1 X129.01660 Y3.22338 E0.312720
G1 X129.58625 Y3.22942 E0.018898
G1 X122.37917 Y10.43650 E0.338099
G1 X122.40784 Y10.98353 E0.018171
G1 X130.15331 Y3.23805 E0.363356
G1 X130.71781 Y3.24925 E0.018729
G1 X122.43651 Y11.53056 E0.388493
G1 X122.46518 Y12.07758 E0.018171
G1 X131.27978 Y3.26298 E0.413511
G1 X131.83925 Y3.27921 E0.018567
G1 X122.49384 Y12.62461 E0.438412
G1 X122.52251 Y13.17164 E0.018171
G1 X132.39626 Y3.29790 E0.463198
G1 X132.95082 Y3.31903 E0.018409
G1 X122.55118 Y13.71867 E0.487869
G1 X122.57985 Y14.26570 E0.018171
G1 X133.50300 Y3.34255 E0.512428
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y3.43340 E0.304552
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.75856 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.35531 Y14.21733 E0.075092
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
G1 X124.94879 Y14.19955 E0.055216
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
G1 X125.53903 Y14.18501 E0.038451
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
G1 X126.12610 Y14.17363 E0.024467
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
G1 X126.71006 Y14.16537 E0.013268
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
G1 X127.29095 Y14.16018 E0.005195
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 X133.73313 Y8.29370 E0.020181
G1 X130.13239 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X129.01569 Y14.16253 E0.218317
G1 X129.58477 Y14.16915 E0.018879
G1 X133.63761 Y10.11631 E0.190127
G1 X133.60577 Y10.72385 E0.020181
G1 X130.15101 Y14.17861 E0.162070
G1 X130.71445 Y14.19087 E0.018695
G1 X133.57393 Y11.33139 E0.134144
G1 X133.54209 Y11.93892 E0.020181
G1 X131.27513 Y14.20588 E0.106348
G1 X131.83308 Y14.22363 E0.018518
G1 X133.51025 Y12.54646 E0.078679
G1 X133.47841 Y13.15400 E0.020181
G1 X132.38836 Y14.24405 E0.051137
G1 X132.94098 Y14.26713 E0.018348
G1 X133.44657 Y13.76154 E0.023718
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X231.51115 Y59.96536 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.78339 Y59.77036 E0.024992
G1 X230.32399 Y60.06870 E0.018171
G1 X231.83333 Y60.47313 E0.051834
G1 X232.15136 Y60.97979 E0.019843
G1 X229.86458 Y60.36705 E0.078533
G1 X229.40517 Y60.66539 E0.018171
G1 X232.46526 Y61.48534 E0.105090
G1 X232.77512 Y61.98980 E0.019639
G1 X228.94577 Y60.96373 E0.131508
G1 X228.48636 Y61.26207 E0.018171
G1 X233.08101 Y62.49320 E0.157789
G1 X233.38299 Y62.99556 E0.019443
G1 X228.02695 Y61.56041 E0.183937
G1 X227.56755 Y61.85876 E0.018171
G1 X233.68108 Y63.49687 E0.209951
G1 X233.97538 Y63.99717 E0.019254
G1 X227.10814 Y62.15710 E0.235835
G1 X226.64873 Y62.45544 E0.018171
G1 X234.26594 Y64.49646 E0.261590
G1 X234.55276 Y64.99476 E0.019072
G1 X226.18933 Y62.75378 E0.287217
G1 X225.72992 Y63.05213 E0.018171
G1 X234.83597 Y65.49209 E0.312720
G1 X235.11557 Y65.98844 E0.018898
G1 X225.27051 Y63.35047 E0.338099
G1 X224.81111 Y63.64881 E0.018171
G1 X235.39162 Y66.48385 E0.363356
G1 X235.66417 Y66.97832 E0.018729
G1 X224.35170 Y63.94715 E0.388493
G1 X223.89229 Y64.24549 E0.018171
G1 X235.93326 Y67.47186 E0.413511
G1 X236.19894 Y67.96449 E0.018567
G1 X223.43289 Y64.54384 E0.438412
G1 X222.97348 Y64.84218 E0.018171
G1 X236.46126 Y68.45622 E0.463198
G1 X236.72025 Y68.94705 E0.018409
G1 X222.51407 Y65.14052 E0.487869
G1 X222.05467 Y65.43886 E0.018171
G1 X236.97597 Y69.43701 E0.512428
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y69.90233 E0.304552
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.66767 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.98428 Y66.95227 E0.075092
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
G1 X223.29643 Y67.45735 E0.055216
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
G1 X223.60414 Y67.96124 E0.038451
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
G1 X223.90753 Y68.46397 E0.024467
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
G1 X224.20666 Y68.96557 E0.013268
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
G1 X224.50160 Y69.46604 E0.005195
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 X232.80321 Y72.11189 E0.020181
G1 X227.88450 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X225.36193 Y70.96088 E0.218317
G1 X225.64074 Y71.45703 E0.018879
G1 X231.17702 Y72.94047 E0.190127
G1 X230.63496 Y73.21666 E0.020181
G1 X225.91567 Y71.95213 E0.162070
G1 X226.18677 Y72.44622 E0.018695
G1 X230.09290 Y73.49286 E0.134144
G1 X229.55084 Y73.76905 E0.020181
G1 X226.45411 Y72.93929 E0.106348
G1 X226.71772 Y73.43136 E0.018518
G1 X229.00877 Y74.04525 E0.078679
G1 X228.46671 Y74.32144 E0.020181
G1 X226.97767 Y73.92245 E0.051137
G1 X227.23400 Y74.41258 E0.018348
G1 X227.92465 Y74.59764 E0.023718
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z1.800 F1200
G1 X62.31596 Y230.92650 F12000
G1 Z1.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X23.07350 Y60.31596 I65.68404 J-104.92650 E5.974872
G3 X193.68404 Y21.07350 I104.92650 J65.68404 E5.974872
G3 X232.92650 Y191.68404 I-65.68404 J104.92650 E5.974872
G3 X62.31596 Y230.92650 I-104.92650 J-65.68404 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X107.76079 Y16.21796 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X18.21796 Y146.23921 I20.23921 J109.78204 E5.816723
G2 X148.23921 Y235.78204 I109.78204 J-20.23921 E5.816723
G2 X237.78204 Y105.76079 I-20.23921 J-109.78204 E5.816723
G2 X107.76079 Y16.21796 I-109.78204 J20.23921 E5.816723
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X107.83460 Y16.61830 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X18.61830 Y146.16540 I20.16540 J109.38170 E5.795511
G2 X148.16540 Y235.38170 I109.38170 J-20.16540 E5.795511
G2 X237.38170 Y105.83460 I-20.16540 J-109.38170 E5.795511
G2 X107.83460 Y16.61830 I-109.38170 J20.16540 E5.795511
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X105.70142 Y5.04745 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X248.95255 Y103.70142 I22.29858 J120.95255 E6.408584
G3 X150.29858 Y246.95255 I-120.95255 J22.29858 E6.408584
G3 X7.04745 Y148.29858 I-22.29858 J-120.95255 E6.408584
G3 X105.70142 Y5.04745 I120.95255 J-22.29858 E6.408584
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X105.62761 Y4.64711 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X249.35289 Y103.62761 I22.37239 J121.35289 E6.429796
G3 X150.37239 Y247.35289 I-121.35289 J22.37239 E6.429796
G3 X6.64711 Y148.37239 I-22.37239 J-121.35289 E6.429796
G3 X105.62761 Y4.64711 I121.35289 J-22.37239 E6.429796
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X226.37789 Y181.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X224.83380 Y183.34901 I0.34901 J1.89310 E0.100304
G2 X227.07590 Y184.89310 I1.89310 J-0.34901 E0.100304
G2 X228.61999 Y182.65099 I-0.34901 J-1.89310 E0.100304
G2 X226.37789 Y181.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.65099 Y238.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X126.10690 Y240.34901 I0.34901 J1.89310 E0.100304
G2 X128.34901 Y241.89310 I1.89310 J-0.34901 E0.100304
G2 X129.89310 Y239.65099 I-0.34901 J-1.89310 E0.100304
G2 X127.65099 Y238.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.92410 Y181.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X27.38001 Y183.34901 I0.34901 J1.89310 E0.100304
G2 X29.62211 Y184.89310 I1.89310 J-0.34901 E0.100304
G2 X31.16620 Y182.65099 I-0.34901 J-1.89310 E0.100304
G2 X28.92410 Y181.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.92410 Y67.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X27.38001 Y69.34901 I0.34901 J1.89310 E0.100304
G2 X29.62211 Y70.89310 I1.89310 J-0.34901 E0.100304
G2 X31.16620 Y68.65099 I-0.34901 J-1.89310 E0.100304
G2 X28.92410 Y67.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.65099 Y10.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X126.10690 Y12.34901 I0.34901 J1.89310 E0.100304
G2 X128.34901 Y13.89310 I1.89310 J-0.34901 E0.100304
G2 X129.89310 Y11.65099 I-0.34901 J-1.89310 E0.100304
G2 X127.65099 Y10.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X226.37789 Y67.10690 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X224.83380 Y69.34901 I0.34901 J1.89310 E0.100304
G2 X227.07590 Y70.89310 I1.89310 J-0.34901 E0.100304
G2 X228.61999 Y68.65099 I-0.34901 J-1.89310 E0.100304
G2 X226.37789 Y67.10690 I-1.89310 J0.34901 E0.100304
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.92465 Y177.40236 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.23400 Y177.58742 E0.023718
G1 X226.97767 Y178.07755 E0.018348
G1 X228.46671 Y177.67856 E0.051137
G1 X229.00877 Y177.95475 E0.020181
G1 X226.71772 Y178.56864 E0.078679
G1 X226.45411 Y179.06071 E0.018518
G1 X229.55084 Y178.23095 E0.106348
G1 X230.09290 Y178.50714 E0.020181
G1 X226.18677 Y179.55378 E0.134144
G1 X225.91567 Y180.04787 E0.018695
G1 X230.63496 Y178.78334 E0.162070
G1 X231.17702 Y179.05953 E0.020181
G1 X225.64074 Y180.54297 E0.190127
G1 X225.36193 Y181.03912 E0.018879
G1 X231.71909 Y179.33573 E0.218317
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 X232.80321 Y179.88811 E0.020181
G1 X227.88450 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.50160 Y182.53396 E0.005195
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
G1 X224.20666 Y183.03443 E0.013268
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
G1 X223.90753 Y183.53603 E0.024467
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
G1 X223.60414 Y184.03876 E0.038451
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
G1 X223.29643 Y184.54265 E0.055216
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
G1 X222.98428 Y185.04773 E0.075092
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
G1 X222.66767 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y182.09767 E0.304552
G1 X236.97597 Y182.56299 E0.016363
G1 X222.05467 Y186.56114 E0.512428
G1 X222.51407 Y186.85948 E0.018171
G1 X236.72025 Y183.05295 E0.487869
G1 X236.46126 Y183.54378 E0.018409
G1 X222.97348 Y187.15782 E0.463198
G1 X223.43289 Y187.45616 E0.018171
G1 X236.19894 Y184.03551 E0.438412
G1 X235.93326 Y184.52814 E0.018567
G1 X223.89229 Y187.75451 E0.413511
G1 X224.35170 Y188.05285 E0.018171
G1 X235.66417 Y185.02168 E0.388493
G1 X235.39162 Y185.51615 E0.018729
G1 X224.81111 Y188.35119 E0.363356
G1 X225.27051 Y188.64953 E0.018171
G1 X235.11557 Y186.01156 E0.338099
G1 X234.83597 Y186.50791 E0.018898
G1 X225.72992 Y188.94787 E0.312720
G1 X226.18933 Y189.24622 E0.018171
G1 X234.55276 Y187.00524 E0.287217
G1 X234.26594 Y187.50354 E0.019072
G1 X226.64873 Y189.54456 E0.261590
G1 X227.10814 Y189.84290 E0.018171
G1 X233.97538 Y188.00283 E0.235835
G1 X233.68108 Y188.50313 E0.019254
G1 X227.56755 Y190.14124 E0.209951
G1 X228.02695 Y190.43959 E0.018171
G1 X233.38299 Y189.00444 E0.183937
G1 X233.08101 Y189.50680 E0.019443
G1 X228.48636 Y190.73793 E0.157789
G1 X228.94577 Y191.03627 E0.018171
G1 X232.77512 Y190.01020 E0.131508
G1 X232.46526 Y190.51466 E0.019639
G1 X229.40517 Y191.33461 E0.105090
G1 X229.86458 Y191.63295 E0.018171
G1 X232.15136 Y191.02021 E0.078533
G1 X231.83333 Y191.52687 E0.019843
G1 X230.32399 Y191.93130 E0.051834
G1 X230.78339 Y192.22964 E0.018171
G1 X231.51115 Y192.03464 E0.024992
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X133.44657 Y238.23846 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.94098 Y237.73287 E0.023718
G1 X132.38836 Y237.75595 E0.018348
G1 X133.47841 Y238.84600 E0.051137
G1 X133.51025 Y239.45354 E0.020181
G1 X131.83308 Y237.77637 E0.078679
G1 X131.27513 Y237.79412 E0.018518
G1 X133.54209 Y240.06108 E0.106348
G1 X133.57393 Y240.66861 E0.020181
G1 X130.71445 Y237.80913 E0.134144
G1 X130.15101 Y237.82139 E0.018695
G1 X133.60577 Y241.27615 E0.162070
G1 X133.63761 Y241.88369 E0.020181
G1 X129.58477 Y237.83085 E0.190127
G1 X129.01569 Y237.83747 E0.018879
G1 X133.66945 Y242.49123 E0.218317
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 X133.73313 Y243.70630 E0.020181
G1 X130.13239 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.29095 Y237.83982 E0.005195
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
G1 X126.71006 Y237.83463 E0.013268
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
G1 X126.12610 Y237.82637 E0.024467
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
G1 X125.53903 Y237.81499 E0.038451
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
G1 X124.94879 Y237.80045 E0.055216
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
G1 X124.35531 Y237.78267 E0.075092
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
G1 X123.75856 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y248.56660 E0.304552
G1 X133.50300 Y248.65745 E0.016363
G1 X122.57985 Y237.73430 E0.512428
G1 X122.55118 Y238.28133 E0.018171
G1 X132.95082 Y248.68097 E0.487869
G1 X132.39626 Y248.70210 E0.018409
G1 X122.52251 Y238.82836 E0.463198
G1 X122.49384 Y239.37539 E0.018171
G1 X131.83925 Y248.72079 E0.438412
G1 X131.27978 Y248.73702 E0.018567
G1 X122.46518 Y239.92242 E0.413511
G1 X122.43651 Y240.46944 E0.018171
G1 X130.71781 Y248.75075 E0.388493
G1 X130.15331 Y248.76195 E0.018729
G1 X122.40784 Y241.01647 E0.363356
G1 X122.37917 Y241.56350 E0.018171
G1 X129.58625 Y248.77058 E0.338099
G1 X129.01660 Y248.77662 E0.018898
G1 X122.35050 Y242.11053 E0.312720
G1 X122.32183 Y242.65756 E0.018171
G1 X128.44429 Y248.78002 E0.287217
G1 X127.86934 Y248.78077 E0.019072
G1 X122.29316 Y243.20459 E0.261590
G1 X122.26450 Y243.75162 E0.018171
G1 X127.29166 Y248.77878 E0.235835
G1 X126.71124 Y248.77406 E0.019254
G1 X122.23583 Y244.29865 E0.209951
G1 X122.20716 Y244.84568 E0.018171
G1 X126.12805 Y248.76657 E0.183937
G1 X125.54201 Y248.75622 E0.019443
G1 X122.17849 Y245.39270 E0.157789
G1 X122.14982 Y245.93973 E0.018171
G1 X124.95310 Y248.74301 E0.131508
G1 X124.36129 Y248.72690 E0.019639
G1 X122.12115 Y246.48676 E0.105090
G1 X122.09248 Y247.03379 E0.018171
G1 X123.76652 Y248.70783 E0.078533
G1 X123.16873 Y248.68574 E0.019843
G1 X122.06382 Y247.58082 E0.051834
G1 X122.03515 Y248.12785 E0.018171
G1 X122.56790 Y248.66060 E0.024992
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X33.52192 Y186.83610 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.70698 Y186.14545 E0.023718
G1 X33.41069 Y185.67840 E0.018348
G1 X33.01170 Y187.16744 E0.051137
G1 X32.50148 Y187.49879 E0.020181
G1 X33.11536 Y185.20774 E0.078679
G1 X32.82102 Y184.73340 E0.018518
G1 X31.99126 Y187.83013 E0.106348
G1 X31.48103 Y188.16147 E0.020181
G1 X32.52768 Y184.25535 E0.134144
G1 X32.23534 Y183.77352 E0.018695
G1 X30.97081 Y188.49281 E0.162070
G1 X30.46059 Y188.82416 E0.020181
G1 X31.94403 Y183.28788 E0.190127
G1 X31.65376 Y182.79835 E0.018879
G1 X29.95036 Y189.15550 E0.218317
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 X28.92992 Y189.81819 E0.020181
G1 X30.24788 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.78935 Y181.30586 E0.005195
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
G1 X30.50340 Y180.80019 E0.013268
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
G1 X30.21858 Y180.29034 E0.024467
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
G1 X29.93489 Y179.77623 E0.038451
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
G1 X29.65237 Y179.25780 E0.055216
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
G1 X29.37103 Y178.73494 E0.075092
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
G1 X29.09088 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y192.46893 E0.304552
G1 X24.52703 Y192.09447 E0.016363
G1 X28.52518 Y177.17316 E0.512428
G1 X28.03711 Y177.42185 E0.018171
G1 X24.23057 Y191.62803 E0.487869
G1 X23.93499 Y191.15832 E0.018409
G1 X27.54903 Y177.67054 E0.463198
G1 X27.06096 Y177.91922 E0.018171
G1 X23.64030 Y190.68528 E0.438412
G1 X23.34651 Y190.20888 E0.018567
G1 X26.57288 Y178.16791 E0.413511
G1 X26.08481 Y178.41660 E0.018171
G1 X23.05364 Y189.72906 E0.388493
G1 X22.76169 Y189.24579 E0.018729
G1 X25.59673 Y178.66528 E0.363356
G1 X25.10866 Y178.91397 E0.018171
G1 X22.47068 Y188.75902 E0.338099
G1 X22.18062 Y188.26871 E0.018898
G1 X24.62058 Y179.16266 E0.312720
G1 X24.13251 Y179.41134 E0.018171
G1 X21.89153 Y187.77478 E0.287217
G1 X21.60341 Y187.27723 E0.019072
G1 X23.64443 Y179.66003 E0.261590
G1 X23.15636 Y179.90872 E0.018171
G1 X21.31629 Y186.77595 E0.235835
G1 X21.03016 Y186.27094 E0.019254
G1 X22.66828 Y180.15740 E0.209951
G1 X22.18021 Y180.40609 E0.018171
G1 X20.74506 Y185.76213 E0.183937
G1 X20.46100 Y185.24943 E0.019443
G1 X21.69213 Y180.65478 E0.157789
G1 X21.20405 Y180.90346 E0.018171
G1 X20.17798 Y184.73282 E0.131508
G1 X19.89603 Y184.21224 E0.019639
G1 X20.71598 Y181.15215 E0.105090
G1 X20.22790 Y181.40084 E0.018171
G1 X19.61516 Y183.68761 E0.078533
G1 X19.33540 Y183.15887 E0.019843
G1 X19.73983 Y181.64952 E0.051834
G1 X19.25175 Y181.89821 E0.018171
G1 X19.05675 Y182.62596 E0.024992
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.07535 Y74.59764 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.76600 Y74.41258 E0.023718
G1 X29.02233 Y73.92245 E0.018348
G1 X27.53329 Y74.32144 E0.051137
G1 X26.99123 Y74.04525 E0.020181
G1 X29.28228 Y73.43136 E0.078679
G1 X29.54589 Y72.93929 E0.018518
G1 X26.44916 Y73.76905 E0.106348
G1 X25.90710 Y73.49286 E0.020181
G1 X29.81323 Y72.44622 E0.134144
G1 X30.08433 Y71.95213 E0.018695
G1 X25.36504 Y73.21666 E0.162070
G1 X24.82298 Y72.94047 E0.020181
G1 X30.35926 Y71.45703 E0.190127
G1 X30.63807 Y70.96088 E0.018879
G1 X24.28091 Y72.66427 E0.218317
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 X23.19679 Y72.11189 E0.020181
G1 X28.11550 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.49840 Y69.46604 E0.005195
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
G1 X31.79334 Y68.96557 E0.013268
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
G1 X32.09247 Y68.46397 E0.024467
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
G1 X32.39586 Y67.96124 E0.038451
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
G1 X32.70357 Y67.45735 E0.055216
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
G1 X33.01572 Y66.95227 E0.075092
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
G1 X33.33233 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y69.90233 E0.304552
G1 X19.02403 Y69.43701 E0.016363
G1 X33.94533 Y65.43886 E0.512428
G1 X33.48593 Y65.14052 E0.018171
G1 X19.27975 Y68.94705 E0.487869
G1 X19.53874 Y68.45622 E0.018409
G1 X33.02652 Y64.84218 E0.463198
G1 X32.56711 Y64.54384 E0.018171
G1 X19.80106 Y67.96449 E0.438412
G1 X20.06674 Y67.47186 E0.018567
G1 X32.10771 Y64.24549 E0.413511
G1 X31.64830 Y63.94715 E0.018171
G1 X20.33583 Y66.97832 E0.388493
G1 X20.60838 Y66.48385 E0.018729
G1 X31.18889 Y63.64881 E0.363356
G1 X30.72949 Y63.35047 E0.018171
G1 X20.88443 Y65.98844 E0.338099
G1 X21.16403 Y65.49209 E0.018898
G1 X30.27008 Y63.05213 E0.312720
G1 X29.81067 Y62.75378 E0.018171
G1 X21.44724 Y64.99476 E0.287217
G1 X21.73406 Y64.49646 E0.019072
G1 X29.35127 Y62.45544 E0.261590
G1 X28.89186 Y62.15710 E0.018171
G1 X22.02462 Y63.99717 E0.235835
G1 X22.31892 Y63.49687 E0.019254
G1 X28.43245 Y61.85876 E0.209951
G1 X27.97305 Y61.56041 E0.018171
G1 X22.61701 Y62.99556 E0.183937
G1 X22.91899 Y62.49320 E0.019443
G1 X27.51364 Y61.26207 E0.157789
G1 X27.05423 Y60.96373 E0.018171
G1 X23.22488 Y61.98980 E0.131508
G1 X23.53474 Y61.48534 E0.019639
G1 X26.59483 Y60.66539 E0.105090
G1 X26.13542 Y60.36705 E0.018171
G1 X23.84864 Y60.97979 E0.078533
G1 X24.16667 Y60.47313 E0.019843
G1 X25.67601 Y60.06870 E0.051834
G1 X25.21661 Y59.77036 E0.018171
G1 X24.48885 Y59.96536 E0.024992
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X122.55343 Y13.76154 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.05902 Y14.26713 E0.023718
G1 X123.61164 Y14.24405 E0.018348
G1 X122.52159 Y13.15400 E0.051137
G1 X122.48975 Y12.54646 E0.020181
G1 X124.16692 Y14.22363 E0.078679
G1 X124.72487 Y14.20588 E0.018518
G1 X122.45791 Y11.93892 E0.106348
G1 X122.42607 Y11.33139 E0.020181
G1 X125.28555 Y14.19087 E0.134144
G1 X125.84899 Y14.17861 E0.018695
G1 X122.39423 Y10.72385 E0.162070
G1 X122.36239 Y10.11631 E0.020181
G1 X126.41523 Y14.16915 E0.190127
G1 X126.98431 Y14.16253 E0.018879
G1 X122.33055 Y9.50877 E0.218317
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 X122.26687 Y8.29370 E0.020181
G1 X125.86761 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.70905 Y14.16018 E0.005195
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
G1 X129.28994 Y14.16537 E0.013268
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
G1 X129.87390 Y14.17363 E0.024467
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
G1 X130.46097 Y14.18501 E0.038451
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
G1 X131.05121 Y14.19955 E0.055216
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
G1 X131.64469 Y14.21733 E0.075092
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
G1 X132.24144 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y3.43340 E0.304552
G1 X122.49700 Y3.34255 E0.016363
G1 X133.42015 Y14.26570 E0.512428
G1 X133.44882 Y13.71867 E0.018171
G1 X123.04918 Y3.31903 E0.487869
G1 X123.60374 Y3.29790 E0.018409
G1 X133.47749 Y13.17164 E0.463198
G1 X133.50616 Y12.62461 E0.018171
G1 X124.16075 Y3.27921 E0.438412
G1 X124.72022 Y3.26298 E0.018567
G1 X133.53482 Y12.07758 E0.413511
G1 X133.56349 Y11.53056 E0.018171
G1 X125.28219 Y3.24925 E0.388493
G1 X125.84669 Y3.23805 E0.018729
G1 X133.59216 Y10.98353 E0.363356
G1 X133.62083 Y10.43650 E0.018171
G1 X126.41375 Y3.22942 E0.338099
G1 X126.98340 Y3.22338 E0.018898
G1 X133.64950 Y9.88947 E0.312720
G1 X133.67817 Y9.34244 E0.018171
G1 X127.55571 Y3.21998 E0.287217
G1 X128.13066 Y3.21923 E0.019072
G1 X133.70684 Y8.79541 E0.261590
G1 X133.73550 Y8.24838 E0.018171
G1 X128.70834 Y3.22122 E0.235835
G1 X129.28876 Y3.22594 E0.019254
G1 X133.76417 Y7.70135 E0.209951
G1 X133.79284 Y7.15432 E0.018171
G1 X129.87195 Y3.23343 E0.183937
G1 X130.45799 Y3.24378 E0.019443
G1 X133.82151 Y6.60730 E0.157789
G1 X133.85018 Y6.06027 E0.018171
G1 X131.04690 Y3.25699 E0.131508
G1 X131.63871 Y3.27310 E0.019639
G1 X133.87885 Y5.51324 E0.105090
G1 X133.90752 Y4.96621 E0.018171
G1 X132.23348 Y3.29217 E0.078533
G1 X132.83127 Y3.31426 E0.019843
G1 X133.93618 Y4.41918 E0.051834
G1 X133.96485 Y3.87215 E0.018171
G1 X133.43210 Y3.33940 E0.024992
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X222.47808 Y65.16390 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.29302 Y65.85455 E0.023718
G1 X222.58931 Y66.32160 E0.018348
G1 X222.98830 Y64.83256 E0.051137
G1 X223.49852 Y64.50121 E0.020181
G1 X222.88464 Y66.79226 E0.078679
G1 X223.17898 Y67.26660 E0.018518
G1 X224.00874 Y64.16987 E0.106348
G1 X224.51897 Y63.83853 E0.020181
G1 X223.47232 Y67.74465 E0.134144
G1 X223.76466 Y68.22648 E0.018695
G1 X225.02919 Y63.50719 E0.162070
G1 X225.53941 Y63.17584 E0.020181
G1 X224.05597 Y68.71212 E0.190127
G1 X224.34624 Y69.20165 E0.018879
G1 X226.04964 Y62.84450 E0.218317
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 X227.07008 Y62.18181 E0.020181
G1 X225.75212 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.21065 Y70.69414 E0.005195
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
G1 X225.49660 Y71.19981 E0.013268
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
G1 X225.78142 Y71.70966 E0.024467
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
G1 X226.06511 Y72.22377 E0.038451
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
G1 X226.34763 Y72.74220 E0.055216
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
G1 X226.62897 Y73.26506 E0.075092
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
G1 X226.90912 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y59.53107 E0.304552
G1 X231.47297 Y59.90553 E0.016363
G1 X227.47482 Y74.82684 E0.512428
G1 X227.96289 Y74.57815 E0.018171
G1 X231.76943 Y60.37197 E0.487869
G1 X232.06501 Y60.84168 E0.018409
G1 X228.45097 Y74.32946 E0.463198
G1 X228.93904 Y74.08078 E0.018171
G1 X232.35970 Y61.31472 E0.438412
G1 X232.65349 Y61.79112 E0.018567
G1 X229.42712 Y73.83209 E0.413511
G1 X229.91519 Y73.58340 E0.018171
G1 X232.94636 Y62.27094 E0.388493
G1 X233.23831 Y62.75421 E0.018729
G1 X230.40327 Y73.33472 E0.363356
G1 X230.89134 Y73.08603 E0.018171
G1 X233.52932 Y63.24098 E0.338099
G1 X233.81938 Y63.73129 E0.018898
G1 X231.37942 Y72.83734 E0.312720
G1 X231.86749 Y72.58866 E0.018171
G1 X234.10847 Y64.22522 E0.287217
G1 X234.39659 Y64.72277 E0.019072
G1 X232.35557 Y72.33997 E0.261590
G1 X232.84364 Y72.09128 E0.018171
G1 X234.68371 Y65.22405 E0.235835
G1 X234.96984 Y65.72906 E0.019254
G1 X233.33172 Y71.84260 E0.209951
G1 X233.81979 Y71.59391 E0.018171
G1 X235.25494 Y66.23787 E0.183937
G1 X235.53900 Y66.75057 E0.019443
G1 X234.30787 Y71.34522 E0.157789
G1 X234.79595 Y71.09654 E0.018171
G1 X235.82202 Y67.26718 E0.131508
G1 X236.10397 Y67.78776 E0.019639
G1 X235.28402 Y70.84785 E0.105090
G1 X235.77210 Y70.59916 E0.018171
G1 X236.38484 Y68.31239 E0.078533
G1 X236.66460 Y68.84113 E0.019843
G1 X236.26017 Y70.35048 E0.051834
G1 X236.74825 Y70.10179 E0.018171
G1 X236.94325 Y69.37404 E0.024992
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z2.000 F1200
G1 X105.55653 Y4.26153 F12000
G1 Z1.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X249.73847 Y103.55653 I22.44347 J121.73847 E5.974872
G3 X150.44347 Y247.73847 I-121.73847 J22.44347 E5.974872
G3 X6.26153 Y148.44347 I-22.44347 J-121.73847 E5.974872
G3 X105.55653 Y4.26153 I121.73847 J-22.44347 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X217.08046 Y193.27847 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X195.27847 Y36.91954 I-89.08046 J-67.27847 E5.816723
G2 X38.91954 Y58.72153 I-67.27847 J89.08046 E5.816723
G2 X60.72153 Y215.08046 I89.08046 J67.27847 E5.816723
G2 X217.08046 Y193.27847 I67.27847 J-89.08046 E5.816723
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X216.75562 Y193.03313 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X195.03313 Y37.24438 I-88.75562 J-67.03313 E5.795511
G2 X39.24438 Y58.96687 I-67.03313 J88.75562 E5.795511
G2 X60.96687 Y214.75562 I88.75562 J67.03313 E5.795511
G2 X216.75562 Y193.03313 I67.03313 J-88.75562 E5.795511
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.14456 Y200.12417 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X53.87583 Y224.14456 I-98.14456 J-74.12417 E6.408584
G3 X29.85544 Y51.87583 I74.12417 J-98.14456 E6.408584
G3 X202.12417 Y27.85544 I98.14456 J74.12417 E6.408584
G3 X226.14456 Y200.12417 I-74.12417 J98.14456 E6.408584
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.46940 Y200.36951 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X53.63049 Y224.46940 I-98.46940 J-74.36951 E6.429796
G3 X29.53060 Y51.63049 I74.36951 J-98.46940 E6.429796
G3 X202.36951 Y27.53060 I98.46940 J74.36951 E6.429796
G3 X226.46940 Y200.36951 I-74.36951 J98.46940 E6.429796
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.26301 Y184.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X227.88706 Y181.46388 I-1.53612 J-1.16016 E0.100304
G2 X225.19078 Y181.83984 I-1.16016 J1.53612 E0.100304
G2 X225.56674 Y184.53612 I1.53612 J1.16016 E0.100304
G2 X228.26301 Y184.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.53612 Y241.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.16016 Y238.46388 I-1.53612 J-1.16016 E0.100304
G2 X126.46388 Y238.83984 I-1.16016 J1.53612 E0.100304
G2 X126.83984 Y241.53612 I1.53612 J1.16016 E0.100304
G2 X129.53612 Y241.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.80922 Y184.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X30.43326 Y181.46388 I-1.53612 J-1.16016 E0.100304
G2 X27.73699 Y181.83984 I-1.16016 J1.53612 E0.100304
G2 X28.11294 Y184.53612 I1.53612 J1.16016 E0.100304
G2 X30.80922 Y184.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.80922 Y70.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X30.43326 Y67.46388 I-1.53612 J-1.16016 E0.100304
G2 X27.73699 Y67.83984 I-1.16016 J1.53612 E0.100304
G2 X28.11294 Y70.53612 I1.53612 J1.16016 E0.100304
G2 X30.80922 Y70.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X129.53612 Y13.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.16016 Y10.46388 I-1.53612 J-1.16016 E0.100304
G2 X126.46388 Y10.83984 I-1.16016 J1.53612 E0.100304
G2 X126.83984 Y13.53612 I1.53612 J1.16016 E0.100304
G2 X129.53612 Y13.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.26301 Y70.16016 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X227.88706 Y67.46388 I-1.53612 J-1.16016 E0.100304
G2 X225.19078 Y67.83984 I-1.16016 J1.53612 E0.100304
G2 X225.56674 Y70.53612 I1.53612 J1.16016 E0.100304
G2 X228.26301 Y70.16016 I1.16016 J-1.53612 E0.100304
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X236.94325 Y182.62596 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.74825 Y181.89821 E0.024992
G1 X236.26017 Y181.64952 E0.018171
G1 X236.66460 Y183.15887 E0.051834
G1 X236.38484 Y183.68761 E0.019843
G1 X235.77210 Y181.40084 E0.078533
G1 X235.28402 Y181.15215 E0.018171
G1 X236.10397 Y184.21224 E0.105090
G1 X235.82202 Y184.73282 E0.019639
G1 X234.79595 Y180.90346 E0.131508
G1 X234.30787 Y180.65478 E0.018171
G1 X235.53900 Y185.24943 E0.157789
G1 X235.25494 Y185.76213 E0.019443
G1 X233.81979 Y180.40609 E0.183937
G1 X233.33172 Y180.15740 E0.018171
G1 X234.96984 Y186.27094 E0.209951
G1 X234.68371 Y186.77595 E0.019254
G1 X232.84364 Y179.90872 E0.235835
G1 X232.35557 Y179.66003 E0.018171
G1 X234.39659 Y187.27723 E0.261590
G1 X234.10847 Y187.77478 E0.019072
G1 X231.86749 Y179.41134 E0.287217
G1 X231.37942 Y179.16266 E0.018171
G1 X233.81938 Y188.26871 E0.312720
G1 X233.52932 Y188.75902 E0.018898
G1 X230.89134 Y178.91397 E0.338099
G1 X230.40327 Y178.66528 E0.018171
G1 X233.23831 Y189.24579 E0.363356
G1 X232.94636 Y189.72906 E0.018729
G1 X229.91519 Y178.41660 E0.388493
G1 X229.42712 Y178.16791 E0.018171
G1 X232.65349 Y190.20888 E0.413511
G1 X232.35970 Y190.68528 E0.018567
G1 X228.93904 Y177.91922 E0.438412
G1 X228.45097 Y177.67054 E0.018171
G1 X232.06501 Y191.15832 E0.463198
G1 X231.76943 Y191.62803 E0.018409
G1 X227.96289 Y177.42185 E0.487869
G1 X227.47482 Y177.17316 E0.018171
G1 X231.47297 Y192.09447 E0.512428
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y192.46893 E0.304552
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.90912 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.62897 Y178.73494 E0.075092
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
G1 X226.34763 Y179.25780 E0.055216
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
G1 X226.06511 Y179.77623 E0.038451
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
G1 X225.78142 Y180.29034 E0.024467
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
G1 X225.49660 Y180.80019 E0.013268
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
G1 X225.21065 Y181.30586 E0.005195
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 X227.07008 Y189.81819 E0.020181
G1 X225.75212 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.34624 Y182.79835 E0.218317
G1 X224.05597 Y183.28788 E0.018879
G1 X225.53941 Y188.82416 E0.190127
G1 X225.02919 Y188.49281 E0.020181
G1 X223.76466 Y183.77352 E0.162070
G1 X223.47232 Y184.25535 E0.018695
G1 X224.51897 Y188.16147 E0.134144
G1 X224.00874 Y187.83013 E0.020181
G1 X223.17898 Y184.73340 E0.106348
G1 X222.88464 Y185.20774 E0.018518
G1 X223.49852 Y187.49879 E0.078679
G1 X222.98830 Y187.16744 E0.020181
G1 X222.58931 Y185.67840 E0.051137
G1 X222.29302 Y186.14545 E0.018348
G1 X222.47808 Y186.83610 E0.023718
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X133.43210 Y248.66060 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.96485 Y248.12785 E0.024992
G1 X133.93618 Y247.58082 E0.018171
G1 X132.83127 Y248.68574 E0.051834
G1 X132.23348 Y248.70783 E0.019843
G1 X133.90752 Y247.03379 E0.078533
G1 X133.87885 Y246.48676 E0.018171
G1 X131.63871 Y248.72690 E0.105090
G1 X131.04690 Y248.74301 E0.019639
G1 X133.85018 Y245.93973 E0.131508
G1 X133.82151 Y245.39270 E0.018171
G1 X130.45799 Y248.75622 E0.157789
G1 X129.87195 Y248.76657 E0.019443
G1 X133.79284 Y244.84568 E0.183937
G1 X133.76417 Y244.29865 E0.018171
G1 X129.28876 Y248.77406 E0.209951
G1 X128.70834 Y248.77878 E0.019254
G1 X133.73550 Y243.75162 E0.235835
G1 X133.70684 Y243.20459 E0.018171
G1 X128.13066 Y248.78077 E0.261590
G1 X127.55571 Y248.78002 E0.019072
G1 X133.67817 Y242.65756 E0.287217
G1 X133.64950 Y242.11053 E0.018171
G1 X126.98340 Y248.77662 E0.312720
G1 X126.41375 Y248.77058 E0.018898
G1 X133.62083 Y241.56350 E0.338099
G1 X133.59216 Y241.01647 E0.018171
G1 X125.84669 Y248.76195 E0.363356
G1 X125.28219 Y248.75075 E0.018729
G1 X133.56349 Y240.46944 E0.388493
G1 X133.53482 Y239.92242 E0.018171
G1 X124.72022 Y248.73702 E0.413511
G1 X124.16075 Y248.72079 E0.018567
G1 X133.50616 Y239.37539 E0.438412
G1 X133.47749 Y238.82836 E0.018171
G1 X123.60374 Y248.70210 E0.463198
G1 X123.04918 Y248.68097 E0.018409
G1 X133.44882 Y238.28133 E0.487869
G1 X133.42015 Y237.73430 E0.018171
G1 X122.49700 Y248.65745 E0.512428
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y248.56660 E0.304552
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.24144 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.64469 Y237.78267 E0.075092
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
G1 X131.05121 Y237.80045 E0.055216
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
G1 X130.46097 Y237.81499 E0.038451
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
G1 X129.87390 Y237.82637 E0.024467
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
G1 X129.28994 Y237.83463 E0.013268
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
G1 X128.70905 Y237.83982 E0.005195
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 X122.26687 Y243.70630 E0.020181
G1 X125.86761 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X126.98431 Y237.83747 E0.218317
G1 X126.41523 Y237.83085 E0.018879
G1 X122.36239 Y241.88369 E0.190127
G1 X122.39423 Y241.27615 E0.020181
G1 X125.84899 Y237.82139 E0.162070
G1 X125.28555 Y237.80913 E0.018695
G1 X122.42607 Y240.66861 E0.134144
G1 X122.45791 Y240.06108 E0.020181
G1 X124.72487 Y237.79412 E0.106348
G1 X124.16692 Y237.77637 E0.018518
G1 X122.48975 Y239.45354 E0.078679
G1 X122.52159 Y238.84600 E0.020181
G1 X123.61164 Y237.75595 E0.051137
G1 X123.05902 Y237.73287 E0.018348
G1 X122.55343 Y238.23846 E0.023718
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X24.48885 Y192.03464 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.21661 Y192.22964 E0.024992
G1 X25.67601 Y191.93130 E0.018171
G1 X24.16667 Y191.52687 E0.051834
G1 X23.84864 Y191.02021 E0.019843
G1 X26.13542 Y191.63295 E0.078533
G1 X26.59483 Y191.33461 E0.018171
G1 X23.53474 Y190.51466 E0.105090
G1 X23.22488 Y190.01020 E0.019639
G1 X27.05423 Y191.03627 E0.131508
G1 X27.51364 Y190.73793 E0.018171
G1 X22.91899 Y189.50680 E0.157789
G1 X22.61701 Y189.00444 E0.019443
G1 X27.97305 Y190.43959 E0.183937
G1 X28.43245 Y190.14124 E0.018171
G1 X22.31892 Y188.50313 E0.209951
G1 X22.02462 Y188.00283 E0.019254
G1 X28.89186 Y189.84290 E0.235835
G1 X29.35127 Y189.54456 E0.018171
G1 X21.73406 Y187.50354 E0.261590
G1 X21.44724 Y187.00524 E0.019072
G1 X29.81067 Y189.24622 E0.287217
G1 X30.27008 Y188.94787 E0.018171
G1 X21.16403 Y186.50791 E0.312720
G1 X20.88443 Y186.01156 E0.018898
G1 X30.72949 Y188.64953 E0.338099
G1 X31.18889 Y188.35119 E0.018171
G1 X20.60838 Y185.51615 E0.363356
G1 X20.33583 Y185.02168 E0.018729
G1 X31.64830 Y188.05285 E0.388493
G1 X32.10771 Y187.75451 E0.018171
G1 X20.06674 Y184.52814 E0.413511
G1 X19.80106 Y184.03551 E0.018567
G1 X32.56711 Y187.45616 E0.438412
G1 X33.02652 Y187.15782 E0.018171
G1 X19.53874 Y183.54378 E0.463198
G1 X19.27975 Y183.05295 E0.018409
G1 X33.48593 Y186.85948 E0.487869
G1 X33.94533 Y186.56114 E0.018171
G1 X19.02403 Y182.56299 E0.512428
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y182.09767 E0.304552
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.33233 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.01572 Y185.04773 E0.075092
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
G1 X32.70357 Y184.54265 E0.055216
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
G1 X32.39586 Y184.03876 E0.038451
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
G1 X32.09247 Y183.53603 E0.024467
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
G1 X31.79334 Y183.03443 E0.013268
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
G1 X31.49840 Y182.53396 E0.005195
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 X23.19679 Y179.88811 E0.020181
G1 X28.11550 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X30.63807 Y181.03912 E0.218317
G1 X30.35926 Y180.54297 E0.018879
G1 X24.82298 Y179.05953 E0.190127
G1 X25.36504 Y178.78334 E0.020181
G1 X30.08433 Y180.04787 E0.162070
G1 X29.81323 Y179.55378 E0.018695
G1 X25.90710 Y178.50714 E0.134144
G1 X26.44916 Y178.23095 E0.020181
G1 X29.54589 Y179.06071 E0.106348
G1 X29.28228 Y178.56864 E0.018518
G1 X26.99123 Y177.95475 E0.078679
G1 X27.53329 Y177.67856 E0.020181
G1 X29.02233 Y178.07755 E0.051137
G1 X28.76600 Y177.58742 E0.018348
G1 X28.07535 Y177.40236 E0.023718
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X19.05675 Y69.37404 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.25175 Y70.10179 E0.024992
G1 X19.73983 Y70.35048 E0.018171
G1 X19.33540 Y68.84113 E0.051834
G1 X19.61516 Y68.31239 E0.019843
G1 X20.22790 Y70.59916 E0.078533
G1 X20.71598 Y70.84785 E0.018171
G1 X19.89603 Y67.78776 E0.105090
G1 X20.17798 Y67.26718 E0.019639
G1 X21.20405 Y71.09654 E0.131508
G1 X21.69213 Y71.34522 E0.018171
G1 X20.46100 Y66.75057 E0.157789
G1 X20.74506 Y66.23787 E0.019443
G1 X22.18021 Y71.59391 E0.183937
G1 X22.66828 Y71.84260 E0.018171
G1 X21.03016 Y65.72906 E0.209951
G1 X21.31629 Y65.22405 E0.019254
G1 X23.15636 Y72.09128 E0.235835
G1 X23.64443 Y72.33997 E0.018171
G1 X21.60341 Y64.72277 E0.261590
G1 X21.89153 Y64.22522 E0.019072
G1 X24.13251 Y72.58866 E0.287217
G1 X24.62058 Y72.83734 E0.018171
G1 X22.18062 Y63.73129 E0.312720
G1 X22.47068 Y63.24098 E0.018898
G1 X25.10866 Y73.08603 E0.338099
G1 X25.59673 Y73.33472 E0.018171
G1 X22.76169 Y62.75421 E0.363356
G1 X23.05364 Y62.27094 E0.018729
G1 X26.08481 Y73.58340 E0.388493
G1 X26.57288 Y73.83209 E0.018171
G1 X23.34651 Y61.79112 E0.413511
G1 X23.64030 Y61.31472 E0.018567
G1 X27.06096 Y74.08078 E0.438412
G1 X27.54903 Y74.32946 E0.018171
G1 X23.93499 Y60.84168 E0.463198
G1 X24.23057 Y60.37197 E0.018409
G1 X28.03711 Y74.57815 E0.487869
G1 X28.52518 Y74.82684 E0.018171
G1 X24.52703 Y59.90553 E0.512428
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y59.53107 E0.304552
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.09088 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.37103 Y73.26506 E0.075092
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
G1 X29.65237 Y72.74220 E0.055216
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
G1 X29.93489 Y72.22377 E0.038451
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
G1 X30.21858 Y71.70966 E0.024467
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
G1 X30.50340 Y71.19981 E0.013268
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
G1 X30.78935 Y70.69414 E0.005195
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 X28.92992 Y62.18181 E0.020181
G1 X30.24788 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.65376 Y69.20165 E0.218317
G1 X31.94403 Y68.71212 E0.018879
G1 X30.46059 Y63.17584 E0.190127
G1 X30.97081 Y63.50719 E0.020181
G1 X32.23534 Y68.22648 E0.162070
G1 X32.52768 Y67.74465 E0.018695
G1 X31.48103 Y63.83853 E0.134144
G1 X31.99126 Y64.16987 E0.020181
G1 X32.82102 Y67.26660 E0.106348
G1 X33.11536 Y66.79226 E0.018518
G1 X32.50148 Y64.50121 E0.078679
G1 X33.01170 Y64.83256 E0.020181
G1 X33.41069 Y66.32160 E0.051137
G1 X33.70698 Y65.85455 E0.018348
G1 X33.52192 Y65.16390 E0.023718
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X122.56790 Y3.33940 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.03515 Y3.87215 E0.024992
G1 X122.06382 Y4.41918 E0.018171
G1 X123.16873 Y3.31426 E0.051834
G1 X123.76652 Y3.29217 E0.019843
G1 X122.09248 Y4.96621 E0.078533
G1 X122.12115 Y5.51324 E0.018171
G1 X124.36129 Y3.27310 E0.105090
G1 X124.95310 Y3.25699 E0.019639
G1 X122.14982 Y6.06027 E0.131508
G1 X122.17849 Y6.60730 E0.018171
G1 X125.54201 Y3.24378 E0.157789
G1 X126.12805 Y3.23343 E0.019443
G1 X122.20716 Y7.15432 E0.183937
G1 X122.23583 Y7.70135 E0.018171
G1 X126.71124 Y3.22594 E0.209951
G1 X127.29166 Y3.22122 E0.019254
G1 X122.26450 Y8.24838 E0.235835
G1 X122.29316 Y8.79541 E0.018171
G1 X127.86934 Y3.21923 E0.261590
G1 X128.44429 Y3.21998 E0.019072
G1 X122.32183 Y9.34244 E0.287217
G1 X122.35050 Y9.88947 E0.018171
G1 X129.01660 Y3.22338 E0.312720
G1 X129.58625 Y3.22942 E0.018898
G1 X122.37917 Y10.43650 E0.338099
G1 X122.40784 Y10.98353 E0.018171
G1 X130.15331 Y3.23805 E0.363356
G1 X130.71781 Y3.24925 E0.018729
G1 X122.43651 Y11.53056 E0.388493
G1 X122.46518 Y12.07758 E0.018171
G1 X131.27978 Y3.26298 E0.413511
G1 X131.83925 Y3.27921 E0.018567
G1 X122.49384 Y12.62461 E0.438412
G1 X122.52251 Y13.17164 E0.018171
G1 X132.39626 Y3.29790 E0.463198
G1 X132.95082 Y3.31903 E0.018409
G1 X122.55118 Y13.71867 E0.487869
G1 X122.57985 Y14.26570 E0.018171
G1 X133.50300 Y3.34255 E0.512428
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y3.43340 E0.304552
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.75856 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.35531 Y14.21733 E0.075092
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
G1 X124.94879 Y14.19955 E0.055216
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
G1 X125.53903 Y14.18501 E0.038451
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
G1 X126.12610 Y14.17363 E0.024467
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
G1 X126.71006 Y14.16537 E0.013268
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
G1 X127.29095 Y14.16018 E0.005195
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 X133.73313 Y8.29370 E0.020181
G1 X130.13239 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X129.01569 Y14.16253 E0.218317
G1 X129.58477 Y14.16915 E0.018879
G1 X133.63761 Y10.11631 E0.190127
G1 X133.60577 Y10.72385 E0.020181
G1 X130.15101 Y14.17861 E0.162070
G1 X130.71445 Y14.19087 E0.018695
G1 X133.57393 Y11.33139 E0.134144
G1 X133.54209 Y11.93892 E0.020181
G1 X131.27513 Y14.20588 E0.106348
G1 X131.83308 Y14.22363 E0.018518
G1 X133.51025 Y12.54646 E0.078679
G1 X133.47841 Y13.15400 E0.020181
G1 X132.38836 Y14.24405 E0.051137
G1 X132.94098 Y14.26713 E0.018348
G1 X133.44657 Y13.76154 E0.023718
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X231.51115 Y59.96536 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.78339 Y59.77036 E0.024992
G1 X230.32399 Y60.06870 E0.018171
G1 X231.83333 Y60.47313 E0.051834
G1 X232.15136 Y60.97979 E0.019843
G1 X229.86458 Y60.36705 E0.078533
G1 X229.40517 Y60.66539 E0.018171
G1 X232.46526 Y61.48534 E0.105090
G1 X232.77512 Y61.98980 E0.019639
G1 X228.94577 Y60.96373 E0.131508
G1 X228.48636 Y61.26207 E0.018171
G1 X233.08101 Y62.49320 E0.157789
G1 X233.38299 Y62.99556 E0.019443
G1 X228.02695 Y61.56041 E0.183937
G1 X227.56755 Y61.85876 E0.018171
G1 X233.68108 Y63.49687 E0.209951
G1 X233.97538 Y63.99717 E0.019254
G1 X227.10814 Y62.15710 E0.235835
G1 X226.64873 Y62.45544 E0.018171
G1 X234.26594 Y64.49646 E0.261590
G1 X234.55276 Y64.99476 E0.019072
G1 X226.18933 Y62.75378 E0.287217
G1 X225.72992 Y63.05213 E0.018171
G1 X234.83597 Y65.49209 E0.312720
G1 X235.11557 Y65.98844 E0.018898
G1 X225.27051 Y63.35047 E0.338099
G1 X224.81111 Y63.64881 E0.018171
G1 X235.39162 Y66.48385 E0.363356
G1 X235.66417 Y66.97832 E0.018729
G1 X224.35170 Y63.94715 E0.388493
G1 X223.89229 Y64.24549 E0.018171
G1 X235.93326 Y67.47186 E0.413511
G1 X236.19894 Y67.96449 E0.018567
G1 X223.43289 Y64.54384 E0.438412
G1 X222.97348 Y64.84218 E0.018171
G1 X236.46126 Y68.45622 E0.463198
G1 X236.72025 Y68.94705 E0.018409
G1 X222.51407 Y65.14052 E0.487869
G1 X222.05467 Y65.43886 E0.018171
G1 X236.97597 Y69.43701 E0.512428
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y69.90233 E0.304552
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.66767 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.98428 Y66.95227 E0.075092
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
G1 X223.29643 Y67.45735 E0.055216
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
G1 X223.60414 Y67.96124 E0.038451
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
G1 X223.90753 Y68.46397 E0.024467
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
G1 X224.20666 Y68.96557 E0.013268
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
G1 X224.50160 Y69.46604 E0.005195
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 X232.80321 Y72.11189 E0.020181
G1 X227.88450 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X225.36193 Y70.96088 E0.218317
G1 X225.64074 Y71.45703 E0.018879
G1 X231.17702 Y72.94047 E0.190127
G1 X230.63496 Y73.21666 E0.020181
G1 X225.91567 Y71.95213 E0.162070
G1 X226.18677 Y72.44622 E0.018695
G1 X230.09290 Y73.49286 E0.134144
G1 X229.55084 Y73.76905 E0.020181
G1 X226.45411 Y72.93929 E0.106348
G1 X226.71772 Y73.43136 E0.018518
G1 X229.00877 Y74.04525 E0.078679
G1 X228.46671 Y74.32144 E0.020181
G1 X226.97767 Y73.92245 E0.051137
G1 X227.23400 Y74.41258 E0.018348
G1 X227.92465 Y74.59764 E0.023718
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z2.200 F1200
G1 X226.78227 Y200.60581 F12000
G1 Z1.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X53.39419 Y224.78227 I-98.78227 J-74.60581 E5.974872
G3 X29.21773 Y51.39419 I74.60581 J-98.78227 E5.974872
G3 X202.60581 Y27.21773 I98.78227 J74.60581 E5.974872
G3 X226.78227 Y200.60581 I-74.60581 J98.78227 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X16.86889 Y136.56394 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X138.56394 Y237.13111 I111.13111 J-10.56394 E5.816723
G2 X239.13111 Y115.43606 I-10.56394 J-111.13111 E5.816723
G2 X117.43606 Y14.86889 I-111.13111 J10.56394 E5.816723
G2 X16.86889 Y136.56394 I10.56394 J111.13111 E5.816723
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X17.27414 Y136.52541 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X138.52541 Y236.72586 I110.72586 J-10.52541 E5.795511
G2 X238.72586 Y115.47459 I-10.52541 J-110.72586 E5.795511
G2 X117.47459 Y15.27414 I-110.72586 J10.52541 E5.795511
G2 X17.27414 Y136.52541 I10.52541 J110.72586 E5.795511
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X5.56110 Y137.63884 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X116.36116 Y3.56110 I122.43890 J-11.63884 E6.408584
G3 X250.43890 Y114.36116 I11.63884 J122.43890 E6.408584
G3 X139.63884 Y248.43890 I-122.43890 J11.63884 E6.408584
G3 X5.56110 Y137.63884 I-11.63884 J-122.43890 E6.408584
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X5.15585 Y137.67736 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X116.32264 Y3.15585 I122.84415 J-11.67736 E6.429796
G3 X250.84415 Y114.32264 I11.67736 J122.84415 E6.429796
G3 X139.67736 Y248.84415 I-122.84415 J11.67736 E6.429796
G3 X5.15585 Y137.67736 I-11.67736 J-122.84415 E6.429796
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.81053 Y183.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X226.90906 Y184.91636 I1.91636 J-0.18217 E0.100304
G2 X228.64326 Y182.81783 I-0.18217 J-1.91636 E0.100304
G2 X226.54473 Y181.08364 I-1.91636 J0.18217 E0.100304
G2 X224.81053 Y183.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.08364 Y240.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X128.18217 Y241.91636 I1.91636 J-0.18217 E0.100304
G2 X129.91636 Y239.81783 I-0.18217 J-1.91636 E0.100304
G2 X127.81783 Y238.08364 I-1.91636 J0.18217 E0.100304
G2 X126.08364 Y240.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.35674 Y183.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X29.45527 Y184.91636 I1.91636 J-0.18217 E0.100304
G2 X31.18947 Y182.81783 I-0.18217 J-1.91636 E0.100304
G2 X29.09094 Y181.08364 I-1.91636 J0.18217 E0.100304
G2 X27.35674 Y183.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.35674 Y69.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X29.45527 Y70.91636 I1.91636 J-0.18217 E0.100304
G2 X31.18947 Y68.81783 I-0.18217 J-1.91636 E0.100304
G2 X29.09094 Y67.08364 I-1.91636 J0.18217 E0.100304
G2 X27.35674 Y69.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X126.08364 Y12.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X128.18217 Y13.91636 I1.91636 J-0.18217 E0.100304
G2 X129.91636 Y11.81783 I-0.18217 J-1.91636 E0.100304
G2 X127.81783 Y10.08364 I-1.91636 J0.18217 E0.100304
G2 X126.08364 Y12.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.81053 Y69.18217 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X226.90906 Y70.91636 I1.91636 J-0.18217 E0.100304
G2 X228.64326 Y68.81783 I-0.18217 J-1.91636 E0.100304
G2 X226.54473 Y67.08364 I-1.91636 J0.18217 E0.100304
G2 X224.81053 Y69.18217 I0.18217 J1.91636 E0.100304
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.92465 Y177.40236 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.23400 Y177.58742 E0.023718
G1 X226.97767 Y178.07755 E0.018348
G1 X228.46671 Y177.67856 E0.051137
G1 X229.00877 Y177.95475 E0.020181
G1 X226.71772 Y178.56864 E0.078679
G1 X226.45411 Y179.06071 E0.018518
G1 X229.55084 Y178.23095 E0.106348
G1 X230.09290 Y178.50714 E0.020181
G1 X226.18677 Y179.55378 E0.134144
G1 X225.91567 Y180.04787 E0.018695
G1 X230.63496 Y178.78334 E0.162070
G1 X231.17702 Y179.05953 E0.020181
G1 X225.64074 Y180.54297 E0.190127
G1 X225.36193 Y181.03912 E0.018879
G1 X231.71909 Y179.33573 E0.218317
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 X232.80321 Y179.88811 E0.020181
G1 X227.88450 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.50160 Y182.53396 E0.005195
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
G1 X224.20666 Y183.03443 E0.013268
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
G1 X223.90753 Y183.53603 E0.024467
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
G1 X223.60414 Y184.03876 E0.038451
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
G1 X223.29643 Y184.54265 E0.055216
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
G1 X222.98428 Y185.04773 E0.075092
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
G1 X222.66767 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y182.09767 E0.304552
G1 X236.97597 Y182.56299 E0.016363
G1 X222.05467 Y186.56114 E0.512428
G1 X222.51407 Y186.85948 E0.018171
G1 X236.72025 Y183.05295 E0.487869
G1 X236.46126 Y183.54378 E0.018409
G1 X222.97348 Y187.15782 E0.463198
G1 X223.43289 Y187.45616 E0.018171
G1 X236.19894 Y184.03551 E0.438412
G1 X235.93326 Y184.52814 E0.018567
G1 X223.89229 Y187.75451 E0.413511
G1 X224.35170 Y188.05285 E0.018171
G1 X235.66417 Y185.02168 E0.388493
G1 X235.39162 Y185.51615 E0.018729
G1 X224.81111 Y188.35119 E0.363356
G1 X225.27051 Y188.64953 E0.018171
G1 X235.11557 Y186.01156 E0.338099
G1 X234.83597 Y186.50791 E0.018898
G1 X225.72992 Y188.94787 E0.312720
G1 X226.18933 Y189.24622 E0.018171
G1 X234.55276 Y187.00524 E0.287217
G1 X234.26594 Y187.50354 E0.019072
G1 X226.64873 Y189.54456 E0.261590
G1 X227.10814 Y189.84290 E0.018171
G1 X233.97538 Y188.00283 E0.235835
G1 X233.68108 Y188.50313 E0.019254
G1 X227.56755 Y190.14124 E0.209951
G1 X228.02695 Y190.43959 E0.018171
G1 X233.38299 Y189.00444 E0.183937
G1 X233.08101 Y189.50680 E0.019443
G1 X228.48636 Y190.73793 E0.157789
G1 X228.94577 Y191.03627 E0.018171
G1 X232.77512 Y190.01020 E0.131508
G1 X232.46526 Y190.51466 E0.019639
G1 X229.40517 Y191.33461 E0.105090
G1 X229.86458 Y191.63295 E0.018171
G1 X232.15136 Y191.02021 E0.078533
G1 X231.83333 Y191.52687 E0.019843
G1 X230.32399 Y191.93130 E0.051834
G1 X230.78339 Y192.22964 E0.018171
G1 X231.51115 Y192.03464 E0.024992
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X133.44657 Y238.23846 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.94098 Y237.73287 E0.023718
G1 X132.38836 Y237.75595 E0.018348
G1 X133.47841 Y238.84600 E0.051137
G1 X133.51025 Y239.45354 E0.020181
G1 X131.83308 Y237.77637 E0.078679
G1 X131.27513 Y237.79412 E0.018518
G1 X133.54209 Y240.06108 E0.106348
G1 X133.57393 Y240.66861 E0.020181
G1 X130.71445 Y237.80913 E0.134144
G1 X130.15101 Y237.82139 E0.018695
G1 X133.60577 Y241.27615 E0.162070
G1 X133.63761 Y241.88369 E0.020181
G1 X129.58477 Y237.83085 E0.190127
G1 X129.01569 Y237.83747 E0.018879
G1 X133.66945 Y242.49123 E0.218317
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 X133.73313 Y243.70630 E0.020181
G1 X130.13239 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.29095 Y237.83982 E0.005195
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
G1 X126.71006 Y237.83463 E0.013268
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
G1 X126.12610 Y237.82637 E0.024467
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
G1 X125.53903 Y237.81499 E0.038451
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
G1 X124.94879 Y237.80045 E0.055216
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
G1 X124.35531 Y237.78267 E0.075092
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
G1 X123.75856 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y248.56660 E0.304552
G1 X133.50300 Y248.65745 E0.016363
G1 X122.57985 Y237.73430 E0.512428
G1 X122.55118 Y238.28133 E0.018171
G1 X132.95082 Y248.68097 E0.487869
G1 X132.39626 Y248.70210 E0.018409
G1 X122.52251 Y238.82836 E0.463198
G1 X122.49384 Y239.37539 E0.018171
G1 X131.83925 Y248.72079 E0.438412
G1 X131.27978 Y248.73702 E0.018567
G1 X122.46518 Y239.92242 E0.413511
G1 X122.43651 Y240.46944 E0.018171
G1 X130.71781 Y248.75075 E0.388493
G1 X130.15331 Y248.76195 E0.018729
G1 X122.40784 Y241.01647 E0.363356
G1 X122.37917 Y241.56350 E0.018171
G1 X129.58625 Y248.77058 E0.338099
G1 X129.01660 Y248.77662 E0.018898
G1 X122.35050 Y242.11053 E0.312720
G1 X122.32183 Y242.65756 E0.018171
G1 X128.44429 Y248.78002 E0.287217
G1 X127.86934 Y248.78077 E0.019072
G1 X122.29316 Y243.20459 E0.261590
G1 X122.26450 Y243.75162 E0.018171
G1 X127.29166 Y248.77878 E0.235835
G1 X126.71124 Y248.77406 E0.019254
G1 X122.23583 Y244.29865 E0.209951
G1 X122.20716 Y244.84568 E0.018171
G1 X126.12805 Y248.76657 E0.183937
G1 X125.54201 Y248.75622 E0.019443
G1 X122.17849 Y245.39270 E0.157789
G1 X122.14982 Y245.93973 E0.018171
G1 X124.95310 Y248.74301 E0.131508
G1 X124.36129 Y248.72690 E0.019639
G1 X122.12115 Y246.48676 E0.105090
G1 X122.09248 Y247.03379 E0.018171
G1 X123.76652 Y248.70783 E0.078533
G1 X123.16873 Y248.68574 E0.019843
G1 X122.06382 Y247.58082 E0.051834
G1 X122.03515 Y248.12785 E0.018171
G1 X122.56790 Y248.66060 E0.024992
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X33.52192 Y186.83610 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.70698 Y186.14545 E0.023718
G1 X33.41069 Y185.67840 E0.018348
G1 X33.01170 Y187.16744 E0.051137
G1 X32.50148 Y187.49879 E0.020181
G1 X33.11536 Y185.20774 E0.078679
G1 X32.82102 Y184.73340 E0.018518
G1 X31.99126 Y187.83013 E0.106348
G1 X31.48103 Y188.16147 E0.020181
G1 X32.52768 Y184.25535 E0.134144
G1 X32.23534 Y183.77352 E0.018695
G1 X30.97081 Y188.49281 E0.162070
G1 X30.46059 Y188.82416 E0.020181
G1 X31.94403 Y183.28788 E0.190127
G1 X31.65376 Y182.79835 E0.018879
G1 X29.95036 Y189.15550 E0.218317
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 X28.92992 Y189.81819 E0.020181
G1 X30.24788 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.78935 Y181.30586 E0.005195
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
G1 X30.50340 Y180.80019 E0.013268
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
G1 X30.21858 Y180.29034 E0.024467
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
G1 X29.93489 Y179.77623 E0.038451
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
G1 X29.65237 Y179.25780 E0.055216
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
G1 X29.37103 Y178.73494 E0.075092
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
G1 X29.09088 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y192.46893 E0.304552
G1 X24.52703 Y192.09447 E0.016363
G1 X28.52518 Y177.17316 E0.512428
G1 X28.03711 Y177.42185 E0.018171
G1 X24.23057 Y191.62803 E0.487869
G1 X23.93499 Y191.15832 E0.018409
G1 X27.54903 Y177.67054 E0.463198
G1 X27.06096 Y177.91922 E0.018171
G1 X23.64030 Y190.68528 E0.438412
G1 X23.34651 Y190.20888 E0.018567
G1 X26.57288 Y178.16791 E0.413511
G1 X26.08481 Y178.41660 E0.018171
G1 X23.05364 Y189.72906 E0.388493
G1 X22.76169 Y189.24579 E0.018729
G1 X25.59673 Y178.66528 E0.363356
G1 X25.10866 Y178.91397 E0.018171
G1 X22.47068 Y188.75902 E0.338099
G1 X22.18062 Y188.26871 E0.018898
G1 X24.62058 Y179.16266 E0.312720
G1 X24.13251 Y179.41134 E0.018171
G1 X21.89153 Y187.77478 E0.287217
G1 X21.60341 Y187.27723 E0.019072
G1 X23.64443 Y179.66003 E0.261590
G1 X23.15636 Y179.90872 E0.018171
G1 X21.31629 Y186.77595 E0.235835
G1 X21.03016 Y186.27094 E0.019254
G1 X22.66828 Y180.15740 E0.209951
G1 X22.18021 Y180.40609 E0.018171
G1 X20.74506 Y185.76213 E0.183937
G1 X20.46100 Y185.24943 E0.019443
G1 X21.69213 Y180.65478 E0.157789
G1 X21.20405 Y180.90346 E0.018171
G1 X20.17798 Y184.73282 E0.131508
G1 X19.89603 Y184.21224 E0.019639
G1 X20.71598 Y181.15215 E0.105090
G1 X20.22790 Y181.40084 E0.018171
G1 X19.61516 Y183.68761 E0.078533
G1 X19.33540 Y183.15887 E0.019843
G1 X19.73983 Y181.64952 E0.051834
G1 X19.25175 Y181.89821 E0.018171
G1 X19.05675 Y182.62596 E0.024992
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.07535 Y74.59764 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.76600 Y74.41258 E0.023718
G1 X29.02233 Y73.92245 E0.018348
G1 X27.53329 Y74.32144 E0.051137
G1 X26.99123 Y74.04525 E0.020181
G1 X29.28228 Y73.43136 E0.078679
G1 X29.54589 Y72.93929 E0.018518
G1 X26.44916 Y73.76905 E0.106348
G1 X25.90710 Y73.49286 E0.020181
G1 X29.81323 Y72.44622 E0.134144
G1 X30.08433 Y71.95213 E0.018695
G1 X25.36504 Y73.21666 E0.162070
G1 X24.82298 Y72.94047 E0.020181
G1 X30.35926 Y71.45703 E0.190127
G1 X30.63807 Y70.96088 E0.018879
G1 X24.28091 Y72.66427 E0.218317
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 X23.19679 Y72.11189 E0.020181
G1 X28.11550 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.49840 Y69.46604 E0.005195
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
G1 X31.79334 Y68.96557 E0.013268
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
G1 X32.09247 Y68.46397 E0.024467
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
G1 X32.39586 Y67.96124 E0.038451
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
G1 X32.70357 Y67.45735 E0.055216
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
G1 X33.01572 Y66.95227 E0.075092
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
G1 X33.33233 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y69.90233 E0.304552
G1 X19.02403 Y69.43701 E0.016363
G1 X33.94533 Y65.43886 E0.512428
G1 X33.48593 Y65.14052 E0.018171
G1 X19.27975 Y68.94705 E0.487869
G1 X19.53874 Y68.45622 E0.018409
G1 X33.02652 Y64.84218 E0.463198
G1 X32.56711 Y64.54384 E0.018171
G1 X19.80106 Y67.96449 E0.438412
G1 X20.06674 Y67.47186 E0.018567
G1 X32.10771 Y64.24549 E0.413511
G1 X31.64830 Y63.94715 E0.018171
G1 X20.33583 Y66.97832 E0.388493
G1 X20.60838 Y66.48385 E0.018729
G1 X31.18889 Y63.64881 E0.363356
G1 X30.72949 Y63.35047 E0.018171
G1 X20.88443 Y65.98844 E0.338099
G1 X21.16403 Y65.49209 E0.018898
G1 X30.27008 Y63.05213 E0.312720
G1 X29.81067 Y62.75378 E0.018171
G1 X21.44724 Y64.99476 E0.287217
G1 X21.73406 Y64.49646 E0.019072
G1 X29.35127 Y62.45544 E0.261590
G1 X28.89186 Y62.15710 E0.018171
G1 X22.02462 Y63.99717 E0.235835
G1 X22.31892 Y63.49687 E0.019254
G1 X28.43245 Y61.85876 E0.209951
G1 X27.97305 Y61.56041 E0.018171
G1 X22.61701 Y62.99556 E0.183937
G1 X22.91899 Y62.49320 E0.019443
G1 X27.51364 Y61.26207 E0.157789
G1 X27.05423 Y60.96373 E0.018171
G1 X23.22488 Y61.98980 E0.131508
G1 X23.53474 Y61.48534 E0.019639
G1 X26.59483 Y60.66539 E0.105090
G1 X26.13542 Y60.36705 E0.018171
G1 X23.84864 Y60.97979 E0.078533
G1 X24.16667 Y60.47313 E0.019843
G1 X25.67601 Y60.06870 E0.051834
G1 X25.21661 Y59.77036 E0.018171
G1 X24.48885 Y59.96536 E0.024992
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X122.55343 Y13.76154 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.05902 Y14.26713 E0.023718
G1 X123.61164 Y14.24405 E0.018348
G1 X122.52159 Y13.15400 E0.051137
G1 X122.48975 Y12.54646 E0.020181
G1 X124.16692 Y14.22363 E0.078679
G1 X124.72487 Y14.20588 E0.018518
G1 X122.45791 Y11.93892 E0.106348
G1 X122.42607 Y11.33139 E0.020181
G1 X125.28555 Y14.19087 E0.134144
G1 X125.84899 Y14.17861 E0.018695
G1 X122.39423 Y10.72385 E0.162070
G1 X122.36239 Y10.11631 E0.020181
G1 X126.41523 Y14.16915 E0.190127
G1 X126.98431 Y14.16253 E0.018879
G1 X122.33055 Y9.50877 E0.218317
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 X122.26687 Y8.29370 E0.020181
G1 X125.86761 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.70905 Y14.16018 E0.005195
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
G1 X129.28994 Y14.16537 E0.013268
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
G1 X129.87390 Y14.17363 E0.024467
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
G1 X130.46097 Y14.18501 E0.038451
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
G1 X131.05121 Y14.19955 E0.055216
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
G1 X131.64469 Y14.21733 E0.075092
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
G1 X132.24144 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y3.43340 E0.304552
G1 X122.49700 Y3.34255 E0.016363
G1 X133.42015 Y14.26570 E0.512428
G1 X133.44882 Y13.71867 E0.018171
G1 X123.04918 Y3.31903 E0.487869
G1 X123.60374 Y3.29790 E0.018409
G1 X133.47749 Y13.17164 E0.463198
G1 X133.50616 Y12.62461 E0.018171
G1 X124.16075 Y3.27921 E0.438412
G1 X124.72022 Y3.26298 E0.018567
G1 X133.53482 Y12.07758 E0.413511
G1 X133.56349 Y11.53056 E0.018171
G1 X125.28219 Y3.24925 E0.388493
G1 X125.84669 Y3.23805 E0.018729
G1 X133.59216 Y10.98353 E0.363356
G1 X133.62083 Y10.43650 E0.018171
G1 X126.41375 Y3.22942 E0.338099
G1 X126.98340 Y3.22338 E0.018898
G1 X133.64950 Y9.88947 E0.312720
G1 X133.67817 Y9.34244 E0.018171
G1 X127.55571 Y3.21998 E0.287217
G1 X128.13066 Y3.21923 E0.019072
G1 X133.70684 Y8.79541 E0.261590
G1 X133.73550 Y8.24838 E0.018171
G1 X128.70834 Y3.22122 E0.235835
G1 X129.28876 Y3.22594 E0.019254
G1 X133.76417 Y7.70135 E0.209951
G1 X133.79284 Y7.15432 E0.018171
G1 X129.87195 Y3.23343 E0.183937
G1 X130.45799 Y3.24378 E0.019443
G1 X133.82151 Y6.60730 E0.157789
G1 X133.85018 Y6.06027 E0.018171
G1 X131.04690 Y3.25699 E0.131508
G1 X131.63871 Y3.27310 E0.019639
G1 X133.87885 Y5.51324 E0.105090
G1 X133.90752 Y4.96621 E0.018171
G1 X132.23348 Y3.29217 E0.078533
G1 X132.83127 Y3.31426 E0.019843
G1 X133.93618 Y4.41918 E0.051834
G1 X133.96485 Y3.87215 E0.018171
G1 X133.43210 Y3.33940 E0.024992
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X222.47808 Y65.16390 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.29302 Y65.85455 E0.023718
G1 X222.58931 Y66.32160 E0.018348
G1 X222.98830 Y64.83256 E0.051137
G1 X223.49852 Y64.50121 E0.020181
G1 X222.88464 Y66.79226 E0.078679
G1 X223.17898 Y67.26660 E0.018518
G1 X224.00874 Y64.16987 E0.106348
G1 X224.51897 Y63.83853 E0.020181
G1 X223.47232 Y67.74465 E0.134144
G1 X223.76466 Y68.22648 E0.018695
G1 X225.02919 Y63.50719 E0.162070
G1 X225.53941 Y63.17584 E0.020181
G1 X224.05597 Y68.71212 E0.190127
G1 X224.34624 Y69.20165 E0.018879
G1 X226.04964 Y62.84450 E0.218317
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 X227.07008 Y62.18181 E0.020181
G1 X225.75212 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.21065 Y70.69414 E0.005195
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
G1 X225.49660 Y71.19981 E0.013268
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
G1 X225.78142 Y71.70966 E0.024467
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
G1 X226.06511 Y72.22377 E0.038451
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
G1 X226.34763 Y72.74220 E0.055216
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
G1 X226.62897 Y73.26506 E0.075092
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
G1 X226.90912 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y59.53107 E0.304552
G1 X231.47297 Y59.90553 E0.016363
G1 X227.47482 Y74.82684 E0.512428
G1 X227.96289 Y74.57815 E0.018171
G1 X231.76943 Y60.37197 E0.487869
G1 X232.06501 Y60.84168 E0.018409
G1 X228.45097 Y74.32946 E0.463198
G1 X228.93904 Y74.08078 E0.018171
G1 X232.35970 Y61.31472 E0.438412
G1 X232.65349 Y61.79112 E0.018567
G1 X229.42712 Y73.83209 E0.413511
G1 X229.91519 Y73.58340 E0.018171
G1 X232.94636 Y62.27094 E0.388493
G1 X233.23831 Y62.75421 E0.018729
G1 X230.40327 Y73.33472 E0.363356
G1 X230.89134 Y73.08603 E0.018171
G1 X233.52932 Y63.24098 E0.338099
G1 X233.81938 Y63.73129 E0.018898
G1 X231.37942 Y72.83734 E0.312720
G1 X231.86749 Y72.58866 E0.018171
G1 X234.10847 Y64.22522 E0.287217
G1 X234.39659 Y64.72277 E0.019072
G1 X232.35557 Y72.33997 E0.261590
G1 X232.84364 Y72.09128 E0.018171
G1 X234.68371 Y65.22405 E0.235835
G1 X234.96984 Y65.72906 E0.019254
G1 X233.33172 Y71.84260 E0.209951
G1 X233.81979 Y71.59391 E0.018171
G1 X235.25494 Y66.23787 E0.183937
G1 X235.53900 Y66.75057 E0.019443
G1 X234.30787 Y71.34522 E0.157789
G1 X234.79595 Y71.09654 E0.018171
G1 X235.82202 Y67.26718 E0.131508
G1 X236.10397 Y67.78776 E0.019639
G1 X235.28402 Y70.84785 E0.105090
G1 X235.77210 Y70.59916 E0.018171
G1 X236.38484 Y68.31239 E0.078533
G1 X236.66460 Y68.84113 E0.019843
G1 X236.26017 Y70.35048 E0.051834
G1 X236.74825 Y70.10179 E0.018171
G1 X236.94325 Y69.37404 E0.024992
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z2.400 F1200
G1 X4.76553 Y137.71446 F12000
G1 Z2.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X116.28554 Y2.76553 I123.23447 J-11.71446 E5.974872
G3 X251.23447 Y114.28554 I11.71446 J123.23447 E5.974872
G3 X139.71446 Y249.23447 I-123.23447 J11.71446 E5.974872
G3 X4.76553 Y137.71446 I-11.71446 J-123.23447 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X202.80879 Y43.14249 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X45.14249 Y51.19121 I-74.80879 J82.85751 E5.816723
G2 X53.19121 Y208.85751 I82.85751 J74.80879 E5.816723
G2 X210.85751 Y200.80879 I74.80879 J-82.85751 E5.816723
G2 X202.80879 Y43.14249 I-82.85751 J-74.80879 E5.816723
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X202.53599 Y43.44464 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X45.44464 Y51.46401 I-74.53599 J82.55536 E5.795511
G2 X53.46401 Y208.55536 I82.55536 J74.53599 E5.795511
G2 X210.55536 Y200.53599 I74.53599 J-82.55536 E5.795511
G2 X202.53599 Y43.44464 I-82.55536 J-74.53599 E5.795511
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X210.42071 Y34.71160 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X219.28840 Y208.42071 I-82.42071 J91.28840 E6.408584
G3 X45.57929 Y217.28840 I-91.28840 J-82.42071 E6.408584
G3 X36.71160 Y43.57929 I82.42071 J-91.28840 E6.408584
G3 X210.42071 Y34.71160 I91.28840 J82.42071 E6.408584
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X210.69351 Y34.40945 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X219.59055 Y208.69351 I-82.69351 J91.59055 E6.429796
G3 X45.30649 Y217.59055 I-91.59055 J-82.69351 E6.429796
G3 X36.40945 Y43.30649 I82.69351 J-91.59055 E6.429796
G3 X210.69351 Y34.40945 I91.59055 J82.69351 E6.429796
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.01691 Y181.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X225.29809 Y181.70999 I-1.29001 J1.42881 E0.100304
G2 X225.43688 Y184.42881 I1.42881 J1.29001 E0.100304
G2 X228.15570 Y184.29001 I1.29001 J-1.42881 E0.100304
G2 X228.01691 Y181.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.29001 Y238.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X126.57119 Y238.70999 I-1.29001 J1.42881 E0.100304
G2 X126.70999 Y241.42881 I1.42881 J1.29001 E0.100304
G2 X129.42881 Y241.29001 I1.29001 J-1.42881 E0.100304
G2 X129.29001 Y238.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.56312 Y181.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X27.84430 Y181.70999 I-1.29001 J1.42881 E0.100304
G2 X27.98309 Y184.42881 I1.42881 J1.29001 E0.100304
G2 X30.70191 Y184.29001 I1.29001 J-1.42881 E0.100304
G2 X30.56312 Y181.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.56312 Y67.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X27.84430 Y67.70999 I-1.29001 J1.42881 E0.100304
G2 X27.98309 Y70.42881 I1.42881 J1.29001 E0.100304
G2 X30.70191 Y70.29001 I1.29001 J-1.42881 E0.100304
G2 X30.56312 Y67.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X129.29001 Y10.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X126.57119 Y10.70999 I-1.29001 J1.42881 E0.100304
G2 X126.70999 Y13.42881 I1.42881 J1.29001 E0.100304
G2 X129.42881 Y13.29001 I1.29001 J-1.42881 E0.100304
G2 X129.29001 Y10.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.01691 Y67.57119 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X225.29809 Y67.70999 I-1.29001 J1.42881 E0.100304
G2 X225.43688 Y70.42881 I1.42881 J1.29001 E0.100304
G2 X228.15570 Y70.29001 I1.29001 J-1.42881 E0.100304
G2 X228.01691 Y67.57119 I-1.42881 J-1.29001 E0.100304
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X236.94325 Y182.62596 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.74825 Y181.89821 E0.024992
G1 X236.26017 Y181.64952 E0.018171
G1 X236.66460 Y183.15887 E0.051834
G1 X236.38484 Y183.68761 E0.019843
G1 X235.77210 Y181.40084 E0.078533
G1 X235.28402 Y181.15215 E0.018171
G1 X236.10397 Y184.21224 E0.105090
G1 X235.82202 Y184.73282 E0.019639
G1 X234.79595 Y180.90346 E0.131508
G1 X234.30787 Y180.65478 E0.018171
G1 X235.53900 Y185.24943 E0.157789
G1 X235.25494 Y185.76213 E0.019443
G1 X233.81979 Y180.40609 E0.183937
G1 X233.33172 Y180.15740 E0.018171
G1 X234.96984 Y186.27094 E0.209951
G1 X234.68371 Y186.77595 E0.019254
G1 X232.84364 Y179.90872 E0.235835
G1 X232.35557 Y179.66003 E0.018171
G1 X234.39659 Y187.27723 E0.261590
G1 X234.10847 Y187.77478 E0.019072
G1 X231.86749 Y179.41134 E0.287217
G1 X231.37942 Y179.16266 E0.018171
G1 X233.81938 Y188.26871 E0.312720
G1 X233.52932 Y188.75902 E0.018898
G1 X230.89134 Y178.91397 E0.338099
G1 X230.40327 Y178.66528 E0.018171
G1 X233.23831 Y189.24579 E0.363356
G1 X232.94636 Y189.72906 E0.018729
G1 X229.91519 Y178.41660 E0.388493
G1 X229.42712 Y178.16791 E0.018171
G1 X232.65349 Y190.20888 E0.413511
G1 X232.35970 Y190.68528 E0.018567
G1 X228.93904 Y177.91922 E0.438412
G1 X228.45097 Y177.67054 E0.018171
G1 X232.06501 Y191.15832 E0.463198
G1 X231.76943 Y191.62803 E0.018409
G1 X227.96289 Y177.42185 E0.487869
G1 X227.47482 Y177.17316 E0.018171
G1 X231.47297 Y192.09447 E0.512428
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y192.46893 E0.304552
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.90912 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.62897 Y178.73494 E0.075092
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
G1 X226.34763 Y179.25780 E0.055216
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
G1 X226.06511 Y179.77623 E0.038451
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
G1 X225.78142 Y180.29034 E0.024467
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
G1 X225.49660 Y180.80019 E0.013268
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
G1 X225.21065 Y181.30586 E0.005195
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 X227.07008 Y189.81819 E0.020181
G1 X225.75212 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.34624 Y182.79835 E0.218317
G1 X224.05597 Y183.28788 E0.018879
G1 X225.53941 Y188.82416 E0.190127
G1 X225.02919 Y188.49281 E0.020181
G1 X223.76466 Y183.77352 E0.162070
G1 X223.47232 Y184.25535 E0.018695
G1 X224.51897 Y188.16147 E0.134144
G1 X224.00874 Y187.83013 E0.020181
G1 X223.17898 Y184.73340 E0.106348
G1 X222.88464 Y185.20774 E0.018518
G1 X223.49852 Y187.49879 E0.078679
G1 X222.98830 Y187.16744 E0.020181
G1 X222.58931 Y185.67840 E0.051137
G1 X222.29302 Y186.14545 E0.018348
G1 X222.47808 Y186.83610 E0.023718
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X133.43210 Y248.66060 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.96485 Y248.12785 E0.024992
G1 X133.93618 Y247.58082 E0.018171
G1 X132.83127 Y248.68574 E0.051834
G1 X132.23348 Y248.70783 E0.019843
G1 X133.90752 Y247.03379 E0.078533
G1 X133.87885 Y246.48676 E0.018171
G1 X131.63871 Y248.72690 E0.105090
G1 X131.04690 Y248.74301 E0.019639
G1 X133.85018 Y245.93973 E0.131508
G1 X133.82151 Y245.39270 E0.018171
G1 X130.45799 Y248.75622 E0.157789
G1 X129.87195 Y248.76657 E0.019443
G1 X133.79284 Y244.84568 E0.183937
G1 X133.76417 Y244.29865 E0.018171
G1 X129.28876 Y248.77406 E0.209951
G1 X128.70834 Y248.77878 E0.019254
G1 X133.73550 Y243.75162 E0.235835
G1 X133.70684 Y243.20459 E0.018171
G1 X128.13066 Y248.78077 E0.261590
G1 X127.55571 Y248.78002 E0.019072
G1 X133.67817 Y242.65756 E0.287217
G1 X133.64950 Y242.11053 E0.018171
G1 X126.98340 Y248.77662 E0.312720
G1 X126.41375 Y248.77058 E0.018898
G1 X133.62083 Y241.56350 E0.338099
G1 X133.59216 Y241.01647 E0.018171
G1 X125.84669 Y248.76195 E0.363356
G1 X125.28219 Y248.75075 E0.018729
G1 X133.56349 Y240.46944 E0.388493
G1 X133.53482 Y239.92242 E0.018171
G1 X124.72022 Y248.73702 E0.413511
G1 X124.16075 Y248.72079 E0.018567
G1 X133.50616 Y239.37539 E0.438412
G1 X133.47749 Y238.82836 E0.018171
G1 X123.60374 Y248.70210 E0.463198
G1 X123.04918 Y248.68097 E0.018409
G1 X133.44882 Y238.28133 E0.487869
G1 X133.42015 Y237.73430 E0.018171
G1 X122.49700 Y248.65745 E0.512428
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y248.56660 E0.304552
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.24144 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.64469 Y237.78267 E0.075092
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
G1 X131.05121 Y237.80045 E0.055216
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
G1 X130.46097 Y237.81499 E0.038451
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
G1 X129.87390 Y237.82637 E0.024467
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
G1 X129.28994 Y237.83463 E0.013268
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
G1 X128.70905 Y237.83982 E0.005195
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 X122.26687 Y243.70630 E0.020181
G1 X125.86761 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X126.98431 Y237.83747 E0.218317
G1 X126.41523 Y237.83085 E0.018879
G1 X122.36239 Y241.88369 E0.190127
G1 X122.39423 Y241.27615 E0.020181
G1 X125.84899 Y237.82139 E0.162070
G1 X125.28555 Y237.80913 E0.018695
G1 X122.42607 Y240.66861 E0.134144
G1 X122.45791 Y240.06108 E0.020181
G1 X124.72487 Y237.79412 E0.106348
G1 X124.16692 Y237.77637 E0.018518
G1 X122.48975 Y239.45354 E0.078679
G1 X122.52159 Y238.84600 E0.020181
G1 X123.61164 Y237.75595 E0.051137
G1 X123.05902 Y237.73287 E0.018348
G1 X122.55343 Y238.23846 E0.023718
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X24.48885 Y192.03464 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.21661 Y192.22964 E0.024992
G1 X25.67601 Y191.93130 E0.018171
G1 X24.16667 Y191.52687 E0.051834
G1 X23.84864 Y191.02021 E0.019843
G1 X26.13542 Y191.63295 E0.078533
G1 X26.59483 Y191.33461 E0.018171
G1 X23.53474 Y190.51466 E0.105090
G1 X23.22488 Y190.01020 E0.019639
G1 X27.05423 Y191.03627 E0.131508
G1 X27.51364 Y190.73793 E0.018171
G1 X22.91899 Y189.50680 E0.157789
G1 X22.61701 Y189.00444 E0.019443
G1 X27.97305 Y190.43959 E0.183937
G1 X28.43245 Y190.14124 E0.018171
G1 X22.31892 Y188.50313 E0.209951
G1 X22.02462 Y188.00283 E0.019254
G1 X28.89186 Y189.84290 E0.235835
G1 X29.35127 Y189.54456 E0.018171
G1 X21.73406 Y187.50354 E0.261590
G1 X21.44724 Y187.00524 E0.019072
G1 X29.81067 Y189.24622 E0.287217
G1 X30.27008 Y188.94787 E0.018171
G1 X21.16403 Y186.50791 E0.312720
G1 X20.88443 Y186.01156 E0.018898
G1 X30.72949 Y188.64953 E0.338099
G1 X31.18889 Y188.35119 E0.018171
G1 X20.60838 Y185.51615 E0.363356
G1 X20.33583 Y185.02168 E0.018729
G1 X31.64830 Y188.05285 E0.388493
G1 X32.10771 Y187.75451 E0.018171
G1 X20.06674 Y184.52814 E0.413511
G1 X19.80106 Y184.03551 E0.018567
G1 X32.56711 Y187.45616 E0.438412
G1 X33.02652 Y187.15782 E0.018171
G1 X19.53874 Y183.54378 E0.463198
G1 X19.27975 Y183.05295 E0.018409
G1 X33.48593 Y186.85948 E0.487869
G1 X33.94533 Y186.56114 E0.018171
G1 X19.02403 Y182.56299 E0.512428
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y182.09767 E0.304552
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.33233 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.01572 Y185.04773 E0.075092
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
G1 X32.70357 Y184.54265 E0.055216
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
G1 X32.39586 Y184.03876 E0.038451
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
G1 X32.09247 Y183.53603 E0.024467
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
G1 X31.79334 Y183.03443 E0.013268
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
G1 X31.49840 Y182.53396 E0.005195
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 X23.19679 Y179.88811 E0.020181
G1 X28.11550 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X30.63807 Y181.03912 E0.218317
G1 X30.35926 Y180.54297 E0.018879
G1 X24.82298 Y179.05953 E0.190127
G1 X25.36504 Y178.78334 E0.020181
G1 X30.08433 Y180.04787 E0.162070
G1 X29.81323 Y179.55378 E0.018695
G1 X25.90710 Y178.50714 E0.134144
G1 X26.44916 Y178.23095 E0.020181
G1 X29.54589 Y179.06071 E0.106348
G1 X29.28228 Y178.56864 E0.018518
G1 X26.99123 Y177.95475 E0.078679
G1 X27.53329 Y177.67856 E0.020181
G1 X29.02233 Y178.07755 E0.051137
G1 X28.76600 Y177.58742 E0.018348
G1 X28.07535 Y177.40236 E0.023718
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X19.05675 Y69.37404 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.25175 Y70.10179 E0.024992
G1 X19.73983 Y70.35048 E0.018171
G1 X19.33540 Y68.84113 E0.051834
G1 X19.61516 Y68.31239 E0.019843
G1 X20.22790 Y70.59916 E0.078533
G1 X20.71598 Y70.84785 E0.018171
G1 X19.89603 Y67.78776 E0.105090
G1 X20.17798 Y67.26718 E0.019639
G1 X21.20405 Y71.09654 E0.131508
G1 X21.69213 Y71.34522 E0.018171
G1 X20.46100 Y66.75057 E0.157789
G1 X20.74506 Y66.23787 E0.019443
G1 X22.18021 Y71.59391 E0.183937
G1 X22.66828 Y71.84260 E0.018171
G1 X21.03016 Y65.72906 E0.209951
G1 X21.31629 Y65.22405 E0.019254
G1 X23.15636 Y72.09128 E0.235835
G1 X23.64443 Y72.33997 E0.018171
G1 X21.60341 Y64.72277 E0.261590
G1 X21.89153 Y64.22522 E0.019072
G1 X24.13251 Y72.58866 E0.287217
G1 X24.62058 Y72.83734 E0.018171
G1 X22.18062 Y63.73129 E0.312720
G1 X22.47068 Y63.24098 E0.018898
G1 X25.10866 Y73.08603 E0.338099
G1 X25.59673 Y73.33472 E0.018171
G1 X22.76169 Y62.75421 E0.363356
G1 X23.05364 Y62.27094 E0.018729
G1 X26.08481 Y73.58340 E0.388493
G1 X26.57288 Y73.83209 E0.018171
G1 X23.34651 Y61.79112 E0.413511
G1 X23.64030 Y61.31472 E0.018567
G1 X27.06096 Y74.08078 E0.438412
G1 X27.54903 Y74.32946 E0.018171
G1 X23.93499 Y60.84168 E0.463198
G1 X24.23057 Y60.37197 E0.018409
G1 X28.03711 Y74.57815 E0.487869
G1 X28.52518 Y74.82684 E0.018171
G1 X24.52703 Y59.90553 E0.512428
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y59.53107 E0.304552
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.09088 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.37103 Y73.26506 E0.075092
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
G1 X29.65237 Y72.74220 E0.055216
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
G1 X29.93489 Y72.22377 E0.038451
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
G1 X30.21858 Y71.70966 E0.024467
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
G1 X30.50340 Y71.19981 E0.013268
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
G1 X30.78935 Y70.69414 E0.005195
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 X28.92992 Y62.18181 E0.020181
G1 X30.24788 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.65376 Y69.20165 E0.218317
G1 X31.94403 Y68.71212 E0.018879
G1 X30.46059 Y63.17584 E0.190127
G1 X30.97081 Y63.50719 E0.020181
G1 X32.23534 Y68.22648 E0.162070
G1 X32.52768 Y67.74465 E0.018695
G1 X31.48103 Y63.83853 E0.134144
G1 X31.99126 Y64.16987 E0.020181
G1 X32.82102 Y67.26660 E0.106348
G1 X33.11536 Y66.79226 E0.018518
G1 X32.50148 Y64.50121 E0.078679
G1 X33.01170 Y64.83256 E0.020181
G1 X33.41069 Y66.32160 E0.051137
G1 X33.70698 Y65.85455 E0.018348
G1 X33.52192 Y65.16390 E0.023718
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X122.56790 Y3.33940 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.03515 Y3.87215 E0.024992
G1 X122.06382 Y4.41918 E0.018171
G1 X123.16873 Y3.31426 E0.051834
G1 X123.76652 Y3.29217 E0.019843
G1 X122.09248 Y4.96621 E0.078533
G1 X122.12115 Y5.51324 E0.018171
G1 X124.36129 Y3.27310 E0.105090
G1 X124.95310 Y3.25699 E0.019639
G1 X122.14982 Y6.06027 E0.131508
G1 X122.17849 Y6.60730 E0.018171
G1 X125.54201 Y3.24378 E0.157789
G1 X126.12805 Y3.23343 E0.019443
G1 X122.20716 Y7.15432 E0.183937
G1 X122.23583 Y7.70135 E0.018171
G1 X126.71124 Y3.22594 E0.209951
G1 X127.29166 Y3.22122 E0.019254
G1 X122.26450 Y8.24838 E0.235835
G1 X122.29316 Y8.79541 E0.018171
G1 X127.86934 Y3.21923 E0.261590
G1 X128.44429 Y3.21998 E0.019072
G1 X122.32183 Y9.34244 E0.287217
G1 X122.35050 Y9.88947 E0.018171
G1 X129.01660 Y3.22338 E0.312720
G1 X129.58625 Y3.22942 E0.018898
G1 X122.37917 Y10.43650 E0.338099
G1 X122.40784 Y10.98353 E0.018171
G1 X130.15331 Y3.23805 E0.363356
G1 X130.71781 Y3.24925 E0.018729
G1 X122.43651 Y11.53056 E0.388493
G1 X122.46518 Y12.07758 E0.018171
G1 X131.27978 Y3.26298 E0.413511
G1 X131.83925 Y3.27921 E0.018567
G1 X122.49384 Y12.62461 E0.438412
G1 X122.52251 Y13.17164 E0.018171
G1 X132.39626 Y3.29790 E0.463198
G1 X132.95082 Y3.31903 E0.018409
G1 X122.55118 Y13.71867 E0.487869
G1 X122.57985 Y14.26570 E0.018171
G1 X133.50300 Y3.34255 E0.512428
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y3.43340 E0.304552
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.75856 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.35531 Y14.21733 E0.075092
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
G1 X124.94879 Y14.19955 E0.055216
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
G1 X125.53903 Y14.18501 E0.038451
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
G1 X126.12610 Y14.17363 E0.024467
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
G1 X126.71006 Y14.16537 E0.013268
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
G1 X127.29095 Y14.16018 E0.005195
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 X133.73313 Y8.29370 E0.020181
G1 X130.13239 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X129.01569 Y14.16253 E0.218317
G1 X129.58477 Y14.16915 E0.018879
G1 X133.63761 Y10.11631 E0.190127
G1 X133.60577 Y10.72385 E0.020181
G1 X130.15101 Y14.17861 E0.162070
G1 X130.71445 Y14.19087 E0.018695
G1 X133.57393 Y11.33139 E0.134144
G1 X133.54209 Y11.93892 E0.020181
G1 X131.27513 Y14.20588 E0.106348
G1 X131.83308 Y14.22363 E0.018518
G1 X133.51025 Y12.54646 E0.078679
G1 X133.47841 Y13.15400 E0.020181
G1 X132.38836 Y14.24405 E0.051137
G1 X132.94098 Y14.26713 E0.018348
G1 X133.44657 Y13.76154 E0.023718
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X231.51115 Y59.96536 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.78339 Y59.77036 E0.024992
G1 X230.32399 Y60.06870 E0.018171
G1 X231.83333 Y60.47313 E0.051834
G1 X232.15136 Y60.97979 E0.019843
G1 X229.86458 Y60.36705 E0.078533
G1 X229.40517 Y60.66539 E0.018171
G1 X232.46526 Y61.48534 E0.105090
G1 X232.77512 Y61.98980 E0.019639
G1 X228.94577 Y60.96373 E0.131508
G1 X228.48636 Y61.26207 E0.018171
G1 X233.08101 Y62.49320 E0.157789
G1 X233.38299 Y62.99556 E0.019443
G1 X228.02695 Y61.56041 E0.183937
G1 X227.56755 Y61.85876 E0.018171
G1 X233.68108 Y63.49687 E0.209951
G1 X233.97538 Y63.99717 E0.019254
G1 X227.10814 Y62.15710 E0.235835
G1 X226.64873 Y62.45544 E0.018171
G1 X234.26594 Y64.49646 E0.261590
G1 X234.55276 Y64.99476 E0.019072
G1 X226.18933 Y62.75378 E0.287217
G1 X225.72992 Y63.05213 E0.018171
G1 X234.83597 Y65.49209 E0.312720
G1 X235.11557 Y65.98844 E0.018898
G1 X225.27051 Y63.35047 E0.338099
G1 X224.81111 Y63.64881 E0.018171
G1 X235.39162 Y66.48385 E0.363356
G1 X235.66417 Y66.97832 E0.018729
G1 X224.35170 Y63.94715 E0.388493
G1 X223.89229 Y64.24549 E0.018171
G1 X235.93326 Y67.47186 E0.413511
G1 X236.19894 Y67.96449 E0.018567
G1 X223.43289 Y64.54384 E0.438412
G1 X222.97348 Y64.84218 E0.018171
G1 X236.46126 Y68.45622 E0.463198
G1 X236.72025 Y68.94705 E0.018409
G1 X222.51407 Y65.14052 E0.487869
G1 X222.05467 Y65.43886 E0.018171
G1 X236.97597 Y69.43701 E0.512428
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y69.90233 E0.304552
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.66767 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.98428 Y66.95227 E0.075092
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
G1 X223.29643 Y67.45735 E0.055216
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
G1 X223.60414 Y67.96124 E0.038451
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
G1 X223.90753 Y68.46397 E0.024467
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
G1 X224.20666 Y68.96557 E0.013268
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
G1 X224.50160 Y69.46604 E0.005195
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 X232.80321 Y72.11189 E0.020181
G1 X227.88450 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X225.36193 Y70.96088 E0.218317
G1 X225.64074 Y71.45703 E0.018879
G1 X231.17702 Y72.94047 E0.190127
G1 X230.63496 Y73.21666 E0.020181
G1 X225.91567 Y71.95213 E0.162070
G1 X226.18677 Y72.44622 E0.018695
G1 X230.09290 Y73.49286 E0.134144
G1 X229.55084 Y73.76905 E0.020181
G1 X226.45411 Y72.93929 E0.106348
G1 X226.71772 Y73.43136 E0.018518
G1 X229.00877 Y74.04525 E0.078679
G1 X228.46671 Y74.32144 E0.020181
G1 X226.97767 Y73.92245 E0.051137
G1 X227.23400 Y74.41258 E0.018348
G1 X227.92465 Y74.59764 E0.023718
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z2.600 F1200
G1 X210.95626 Y34.11843 F12000
G1 Z2.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X219.88157 Y208.95626 I-82.95626 J91.88157 E5.974872
G3 X45.04374 Y217.88157 I-91.88157 J-82.95626 E5.974872
G3 X36.11843 Y43.04374 I82.95626 J-91.88157 E5.974872
G3 X210.95626 Y34.11843 I91.88157 J82.95626 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.80777 Y237.62916 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X239.62916 Y125.19223 I-0.80777 J-111.62916 E5.816723
G2 X127.19223 Y14.37084 I-111.62916 J0.80777 E5.816723
G2 X16.37084 Y126.80777 I0.80777 J111.62916 E5.816723
G2 X128.80777 Y237.62916 I111.62916 J-0.80777 E5.816723
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.80482 Y237.22209 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X239.22209 Y125.19518 I-0.80482 J-111.22209 E5.795511
G2 X127.19518 Y14.77791 I-111.22209 J0.80482 E5.795511
G2 X16.77791 Y126.80482 I0.80482 J111.22209 E5.795511
G2 X128.80482 Y237.22209 I111.22209 J-0.80482 E5.795511
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.88996 Y248.98762 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X5.01238 Y126.88996 I-0.88996 J-122.98762 E6.408584
G3 X127.11004 Y3.01238 I122.98762 J-0.88996 E6.408584
G3 X250.98762 Y125.11004 I0.88996 J122.98762 E6.408584
G3 X128.88996 Y248.98762 I-122.98762 J0.88996 E6.408584
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.89291 Y249.39469 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X4.60531 Y126.89291 I-0.89291 J-123.39469 E6.429796
G3 X127.10709 Y2.60531 I123.39469 J-0.89291 E6.429796
G3 X251.39469 Y125.10709 I0.89291 J123.39469 E6.429796
G3 X128.89291 Y249.39469 I-123.39469 J0.89291 E6.429796
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X226.74083 Y184.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X228.65185 Y182.98607 I-0.01393 J-1.92495 E0.100304
G2 X226.71297 Y181.07505 I-1.92495 J0.01393 E0.100304
G2 X224.80195 Y183.01393 I0.01393 J1.92495 E0.100304
G2 X226.74083 Y184.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.01393 Y241.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.92495 Y239.98607 I-0.01393 J-1.92495 E0.100304
G2 X127.98607 Y238.07505 I-1.92495 J0.01393 E0.100304
G2 X126.07505 Y240.01393 I0.01393 J1.92495 E0.100304
G2 X128.01393 Y241.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X29.28703 Y184.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X31.19805 Y182.98607 I-0.01393 J-1.92495 E0.100304
G2 X29.25917 Y181.07505 I-1.92495 J0.01393 E0.100304
G2 X27.34815 Y183.01393 I0.01393 J1.92495 E0.100304
G2 X29.28703 Y184.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X29.28703 Y70.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X31.19805 Y68.98607 I-0.01393 J-1.92495 E0.100304
G2 X29.25917 Y67.07505 I-1.92495 J0.01393 E0.100304
G2 X27.34815 Y69.01393 I0.01393 J1.92495 E0.100304
G2 X29.28703 Y70.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.01393 Y13.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.92495 Y11.98607 I-0.01393 J-1.92495 E0.100304
G2 X127.98607 Y10.07505 I-1.92495 J0.01393 E0.100304
G2 X126.07505 Y12.01393 I0.01393 J1.92495 E0.100304
G2 X128.01393 Y13.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X226.74083 Y70.92495 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X228.65185 Y68.98607 I-0.01393 J-1.92495 E0.100304
G2 X226.71297 Y67.07505 I-1.92495 J0.01393 E0.100304
G2 X224.80195 Y69.01393 I0.01393 J1.92495 E0.100304
G2 X226.74083 Y70.92495 I1.92495 J-0.01393 E0.100304
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.92465 Y177.40236 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.23400 Y177.58742 E0.023718
G1 X226.97767 Y178.07755 E0.018348
G1 X228.46671 Y177.67856 E0.051137
G1 X229.00877 Y177.95475 E0.020181
G1 X226.71772 Y178.56864 E0.078679
G1 X226.45411 Y179.06071 E0.018518
G1 X229.55084 Y178.23095 E0.106348
G1 X230.09290 Y178.50714 E0.020181
G1 X226.18677 Y179.55378 E0.134144
G1 X225.91567 Y180.04787 E0.018695
G1 X230.63496 Y178.78334 E0.162070
G1 X231.17702 Y179.05953 E0.020181
G1 X225.64074 Y180.54297 E0.190127
G1 X225.36193 Y181.03912 E0.018879
G1 X231.71909 Y179.33573 E0.218317
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 X232.80321 Y179.88811 E0.020181
G1 X227.88450 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.50160 Y182.53396 E0.005195
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
G1 X224.20666 Y183.03443 E0.013268
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
G1 X223.90753 Y183.53603 E0.024467
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
G1 X223.60414 Y184.03876 E0.038451
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
G1 X223.29643 Y184.54265 E0.055216
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
G1 X222.98428 Y185.04773 E0.075092
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
G1 X222.66767 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y182.09767 E0.304552
G1 X236.97597 Y182.56299 E0.016363
G1 X222.05467 Y186.56114 E0.512428
G1 X222.51407 Y186.85948 E0.018171
G1 X236.72025 Y183.05295 E0.487869
G1 X236.46126 Y183.54378 E0.018409
G1 X222.97348 Y187.15782 E0.463198
G1 X223.43289 Y187.45616 E0.018171
G1 X236.19894 Y184.03551 E0.438412
G1 X235.93326 Y184.52814 E0.018567
G1 X223.89229 Y187.75451 E0.413511
G1 X224.35170 Y188.05285 E0.018171
G1 X235.66417 Y185.02168 E0.388493
G1 X235.39162 Y185.51615 E0.018729
G1 X224.81111 Y188.35119 E0.363356
G1 X225.27051 Y188.64953 E0.018171
G1 X235.11557 Y186.01156 E0.338099
G1 X234.83597 Y186.50791 E0.018898
G1 X225.72992 Y188.94787 E0.312720
G1 X226.18933 Y189.24622 E0.018171
G1 X234.55276 Y187.00524 E0.287217
G1 X234.26594 Y187.50354 E0.019072
G1 X226.64873 Y189.54456 E0.261590
G1 X227.10814 Y189.84290 E0.018171
G1 X233.97538 Y188.00283 E0.235835
G1 X233.68108 Y188.50313 E0.019254
G1 X227.56755 Y190.14124 E0.209951
G1 X228.02695 Y190.43959 E0.018171
G1 X233.38299 Y189.00444 E0.183937
G1 X233.08101 Y189.50680 E0.019443
G1 X228.48636 Y190.73793 E0.157789
G1 X228.94577 Y191.03627 E0.018171
G1 X232.77512 Y190.01020 E0.131508
G1 X232.46526 Y190.51466 E0.019639
G1 X229.40517 Y191.33461 E0.105090
G1 X229.86458 Y191.63295 E0.018171
G1 X232.15136 Y191.02021 E0.078533
G1 X231.83333 Y191.52687 E0.019843
G1 X230.32399 Y191.93130 E0.051834
G1 X230.78339 Y192.22964 E0.018171
G1 X231.51115 Y192.03464 E0.024992
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X133.44657 Y238.23846 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.94098 Y237.73287 E0.023718
G1 X132.38836 Y237.75595 E0.018348
G1 X133.47841 Y238.84600 E0.051137
G1 X133.51025 Y239.45354 E0.020181
G1 X131.83308 Y237.77637 E0.078679
G1 X131.27513 Y237.79412 E0.018518
G1 X133.54209 Y240.06108 E0.106348
G1 X133.57393 Y240.66861 E0.020181
G1 X130.71445 Y237.80913 E0.134144
G1 X130.15101 Y237.82139 E0.018695
G1 X133.60577 Y241.27615 E0.162070
G1 X133.63761 Y241.88369 E0.020181
G1 X129.58477 Y237.83085 E0.190127
G1 X129.01569 Y237.83747 E0.018879
G1 X133.66945 Y242.49123 E0.218317
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 X133.73313 Y243.70630 E0.020181
G1 X130.13239 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.29095 Y237.83982 E0.005195
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
G1 X126.71006 Y237.83463 E0.013268
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
G1 X126.12610 Y237.82637 E0.024467
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
G1 X125.53903 Y237.81499 E0.038451
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
G1 X124.94879 Y237.80045 E0.055216
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
G1 X124.35531 Y237.78267 E0.075092
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
G1 X123.75856 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y248.56660 E0.304552
G1 X133.50300 Y248.65745 E0.016363
G1 X122.57985 Y237.73430 E0.512428
G1 X122.55118 Y238.28133 E0.018171
G1 X132.95082 Y248.68097 E0.487869
G1 X132.39626 Y248.70210 E0.018409
G1 X122.52251 Y238.82836 E0.463198
G1 X122.49384 Y239.37539 E0.018171
G1 X131.83925 Y248.72079 E0.438412
G1 X131.27978 Y248.73702 E0.018567
G1 X122.46518 Y239.92242 E0.413511
G1 X122.43651 Y240.46944 E0.018171
G1 X130.71781 Y248.75075 E0.388493
G1 X130.15331 Y248.76195 E0.018729
G1 X122.40784 Y241.01647 E0.363356
G1 X122.37917 Y241.56350 E0.018171
G1 X129.58625 Y248.77058 E0.338099
G1 X129.01660 Y248.77662 E0.018898
G1 X122.35050 Y242.11053 E0.312720
G1 X122.32183 Y242.65756 E0.018171
G1 X128.44429 Y248.78002 E0.287217
G1 X127.86934 Y248.78077 E0.019072
G1 X122.29316 Y243.20459 E0.261590
G1 X122.26450 Y243.75162 E0.018171
G1 X127.29166 Y248.77878 E0.235835
G1 X126.71124 Y248.77406 E0.019254
G1 X122.23583 Y244.29865 E0.209951
G1 X122.20716 Y244.84568 E0.018171
G1 X126.12805 Y248.76657 E0.183937
G1 X125.54201 Y248.75622 E0.019443
G1 X122.17849 Y245.39270 E0.157789
G1 X122.14982 Y245.93973 E0.018171
G1 X124.95310 Y248.74301 E0.131508
G1 X124.36129 Y248.72690 E0.019639
G1 X122.12115 Y246.48676 E0.105090
G1 X122.09248 Y247.03379 E0.018171
G1 X123.76652 Y248.70783 E0.078533
G1 X123.16873 Y248.68574 E0.019843
G1 X122.06382 Y247.58082 E0.051834
G1 X122.03515 Y248.12785 E0.018171
G1 X122.56790 Y248.66060 E0.024992
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X33.52192 Y186.83610 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.70698 Y186.14545 E0.023718
G1 X33.41069 Y185.67840 E0.018348
G1 X33.01170 Y187.16744 E0.051137
G1 X32.50148 Y187.49879 E0.020181
G1 X33.11536 Y185.20774 E0.078679
G1 X32.82102 Y184.73340 E0.018518
G1 X31.99126 Y187.83013 E0.106348
G1 X31.48103 Y188.16147 E0.020181
G1 X32.52768 Y184.25535 E0.134144
G1 X32.23534 Y183.77352 E0.018695
G1 X30.97081 Y188.49281 E0.162070
G1 X30.46059 Y188.82416 E0.020181
G1 X31.94403 Y183.28788 E0.190127
G1 X31.65376 Y182.79835 E0.018879
G1 X29.95036 Y189.15550 E0.218317
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 X28.92992 Y189.81819 E0.020181
G1 X30.24788 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.78935 Y181.30586 E0.005195
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
G1 X30.50340 Y180.80019 E0.013268
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
G1 X30.21858 Y180.29034 E0.024467
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
G1 X29.93489 Y179.77623 E0.038451
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
G1 X29.65237 Y179.25780 E0.055216
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
G1 X29.37103 Y178.73494 E0.075092
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
G1 X29.09088 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y192.46893 E0.304552
G1 X24.52703 Y192.09447 E0.016363
G1 X28.52518 Y177.17316 E0.512428
G1 X28.03711 Y177.42185 E0.018171
G1 X24.23057 Y191.62803 E0.487869
G1 X23.93499 Y191.15832 E0.018409
G1 X27.54903 Y177.67054 E0.463198
G1 X27.06096 Y177.91922 E0.018171
G1 X23.64030 Y190.68528 E0.438412
G1 X23.34651 Y190.20888 E0.018567
G1 X26.57288 Y178.16791 E0.413511
G1 X26.08481 Y178.41660 E0.018171
G1 X23.05364 Y189.72906 E0.388493
G1 X22.76169 Y189.24579 E0.018729
G1 X25.59673 Y178.66528 E0.363356
G1 X25.10866 Y178.91397 E0.018171
G1 X22.47068 Y188.75902 E0.338099
G1 X22.18062 Y188.26871 E0.018898
G1 X24.62058 Y179.16266 E0.312720
G1 X24.13251 Y179.41134 E0.018171
G1 X21.89153 Y187.77478 E0.287217
G1 X21.60341 Y187.27723 E0.019072
G1 X23.64443 Y179.66003 E0.261590
G1 X23.15636 Y179.90872 E0.018171
G1 X21.31629 Y186.77595 E0.235835
G1 X21.03016 Y186.27094 E0.019254
G1 X22.66828 Y180.15740 E0.209951
G1 X22.18021 Y180.40609 E0.018171
G1 X20.74506 Y185.76213 E0.183937
G1 X20.46100 Y185.24943 E0.019443
G1 X21.69213 Y180.65478 E0.157789
G1 X21.20405 Y180.90346 E0.018171
G1 X20.17798 Y184.73282 E0.131508
G1 X19.89603 Y184.21224 E0.019639
G1 X20.71598 Y181.15215 E0.105090
G1 X20.22790 Y181.40084 E0.018171
G1 X19.61516 Y183.68761 E0.078533
G1 X19.33540 Y183.15887 E0.019843
G1 X19.73983 Y181.64952 E0.051834
G1 X19.25175 Y181.89821 E0.018171
G1 X19.05675 Y182.62596 E0.024992
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.07535 Y74.59764 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.76600 Y74.41258 E0.023718
G1 X29.02233 Y73.92245 E0.018348
G1 X27.53329 Y74.32144 E0.051137
G1 X26.99123 Y74.04525 E0.020181
G1 X29.28228 Y73.43136 E0.078679
G1 X29.54589 Y72.93929 E0.018518
G1 X26.44916 Y73.76905 E0.106348
G1 X25.90710 Y73.49286 E0.020181
G1 X29.81323 Y72.44622 E0.134144
G1 X30.08433 Y71.95213 E0.018695
G1 X25.36504 Y73.21666 E0.162070
G1 X24.82298 Y72.94047 E0.020181
G1 X30.35926 Y71.45703 E0.190127
G1 X30.63807 Y70.96088 E0.018879
G1 X24.28091 Y72.66427 E0.218317
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 X23.19679 Y72.11189 E0.020181
G1 X28.11550 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.49840 Y69.46604 E0.005195
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
G1 X31.79334 Y68.96557 E0.013268
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
G1 X32.09247 Y68.46397 E0.024467
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
G1 X32.39586 Y67.96124 E0.038451
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
G1 X32.70357 Y67.45735 E0.055216
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
G1 X33.01572 Y66.95227 E0.075092
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
G1 X33.33233 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y69.90233 E0.304552
G1 X19.02403 Y69.43701 E0.016363
G1 X33.94533 Y65.43886 E0.512428
G1 X33.48593 Y65.14052 E0.018171
G1 X19.27975 Y68.94705 E0.487869
G1 X19.53874 Y68.45622 E0.018409
G1 X33.02652 Y64.84218 E0.463198
G1 X32.56711 Y64.54384 E0.018171
G1 X19.80106 Y67.96449 E0.438412
G1 X20.06674 Y67.47186 E0.018567
G1 X32.10771 Y64.24549 E0.413511
G1 X31.64830 Y63.94715 E0.018171
G1 X20.33583 Y66.97832 E0.388493
G1 X20.60838 Y66.48385 E0.018729
G1 X31.18889 Y63.64881 E0.363356
G1 X30.72949 Y63.35047 E0.018171
G1 X20.88443 Y65.98844 E0.338099
G1 X21.16403 Y65.49209 E0.018898
G1 X30.27008 Y63.05213 E0.312720
G1 X29.81067 Y62.75378 E0.018171
G1 X21.44724 Y64.99476 E0.287217
G1 X21.73406 Y64.49646 E0.019072
G1 X29.35127 Y62.45544 E0.261590
G1 X28.89186 Y62.15710 E0.018171
G1 X22.02462 Y63.99717 E0.235835
G1 X22.31892 Y63.49687 E0.019254
G1 X28.43245 Y61.85876 E0.209951
G1 X27.97305 Y61.56041 E0.018171
G1 X22.61701 Y62.99556 E0.183937
G1 X22.91899 Y62.49320 E0.019443
G1 X27.51364 Y61.26207 E0.157789
G1 X27.05423 Y60.96373 E0.018171
G1 X23.22488 Y61.98980 E0.131508
G1 X23.53474 Y61.48534 E0.019639
G1 X26.59483 Y60.66539 E0.105090
G1 X26.13542 Y60.36705 E0.018171
G1 X23.84864 Y60.97979 E0.078533
G1 X24.16667 Y60.47313 E0.019843
G1 X25.67601 Y60.06870 E0.051834
G1 X25.21661 Y59.77036 E0.018171
G1 X24.48885 Y59.96536 E0.024992
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X122.55343 Y13.76154 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.05902 Y14.26713 E0.023718
G1 X123.61164 Y14.24405 E0.018348
G1 X122.52159 Y13.15400 E0.051137
G1 X122.48975 Y12.54646 E0.020181
G1 X124.16692 Y14.22363 E0.078679
G1 X124.72487 Y14.20588 E0.018518
G1 X122.45791 Y11.93892 E0.106348
G1 X122.42607 Y11.33139 E0.020181
G1 X125.28555 Y14.19087 E0.134144
G1 X125.84899 Y14.17861 E0.018695
G1 X122.39423 Y10.72385 E0.162070
G1 X122.36239 Y10.11631 E0.020181
G1 X126.41523 Y14.16915 E0.190127
G1 X126.98431 Y14.16253 E0.018879
G1 X122.33055 Y9.50877 E0.218317
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 X122.26687 Y8.29370 E0.020181
G1 X125.86761 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.70905 Y14.16018 E0.005195
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
G1 X129.28994 Y14.16537 E0.013268
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
G1 X129.87390 Y14.17363 E0.024467
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
G1 X130.46097 Y14.18501 E0.038451
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
G1 X131.05121 Y14.19955 E0.055216
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
G1 X131.64469 Y14.21733 E0.075092
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
G1 X132.24144 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y3.43340 E0.304552
G1 X122.49700 Y3.34255 E0.016363
G1 X133.42015 Y14.26570 E0.512428
G1 X133.44882 Y13.71867 E0.018171
G1 X123.04918 Y3.31903 E0.487869
G1 X123.60374 Y3.29790 E0.018409
G1 X133.47749 Y13.17164 E0.463198
G1 X133.50616 Y12.62461 E0.018171
G1 X124.16075 Y3.27921 E0.438412
G1 X124.72022 Y3.26298 E0.018567
G1 X133.53482 Y12.07758 E0.413511
G1 X133.56349 Y11.53056 E0.018171
G1 X125.28219 Y3.24925 E0.388493
G1 X125.84669 Y3.23805 E0.018729
G1 X133.59216 Y10.98353 E0.363356
G1 X133.62083 Y10.43650 E0.018171
G1 X126.41375 Y3.22942 E0.338099
G1 X126.98340 Y3.22338 E0.018898
G1 X133.64950 Y9.88947 E0.312720
G1 X133.67817 Y9.34244 E0.018171
G1 X127.55571 Y3.21998 E0.287217
G1 X128.13066 Y3.21923 E0.019072
G1 X133.70684 Y8.79541 E0.261590
G1 X133.73550 Y8.24838 E0.018171
G1 X128.70834 Y3.22122 E0.235835
G1 X129.28876 Y3.22594 E0.019254
G1 X133.76417 Y7.70135 E0.209951
G1 X133.79284 Y7.15432 E0.018171
G1 X129.87195 Y3.23343 E0.183937
G1 X130.45799 Y3.24378 E0.019443
G1 X133.82151 Y6.60730 E0.157789
G1 X133.85018 Y6.06027 E0.018171
G1 X131.04690 Y3.25699 E0.131508
G1 X131.63871 Y3.27310 E0.019639
G1 X133.87885 Y5.51324 E0.105090
G1 X133.90752 Y4.96621 E0.018171
G1 X132.23348 Y3.29217 E0.078533
G1 X132.83127 Y3.31426 E0.019843
G1 X133.93618 Y4.41918 E0.051834
G1 X133.96485 Y3.87215 E0.018171
G1 X133.43210 Y3.33940 E0.024992
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X222.47808 Y65.16390 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.29302 Y65.85455 E0.023718
G1 X222.58931 Y66.32160 E0.018348
G1 X222.98830 Y64.83256 E0.051137
G1 X223.49852 Y64.50121 E0.020181
G1 X222.88464 Y66.79226 E0.078679
G1 X223.17898 Y67.26660 E0.018518
G1 X224.00874 Y64.16987 E0.106348
G1 X224.51897 Y63.83853 E0.020181
G1 X223.47232 Y67.74465 E0.134144
G1 X223.76466 Y68.22648 E0.018695
G1 X225.02919 Y63.50719 E0.162070
G1 X225.53941 Y63.17584 E0.020181
G1 X224.05597 Y68.71212 E0.190127
G1 X224.34624 Y69.20165 E0.018879
G1 X226.04964 Y62.84450 E0.218317
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 X227.07008 Y62.18181 E0.020181
G1 X225.75212 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.21065 Y70.69414 E0.005195
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
G1 X225.49660 Y71.19981 E0.013268
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
G1 X225.78142 Y71.70966 E0.024467
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
G1 X226.06511 Y72.22377 E0.038451
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
G1 X226.34763 Y72.74220 E0.055216
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
G1 X226.62897 Y73.26506 E0.075092
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
G1 X226.90912 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y59.53107 E0.304552
G1 X231.47297 Y59.90553 E0.016363
G1 X227.47482 Y74.82684 E0.512428
G1 X227.96289 Y74.57815 E0.018171
G1 X231.76943 Y60.37197 E0.487869
G1 X232.06501 Y60.84168 E0.018409
G1 X228.45097 Y74.32946 E0.463198
G1 X228.93904 Y74.08078 E0.018171
G1 X232.35970 Y61.31472 E0.438412
G1 X232.65349 Y61.79112 E0.018567
G1 X229.42712 Y73.83209 E0.413511
G1 X229.91519 Y73.58340 E0.018171
G1 X232.94636 Y62.27094 E0.388493
G1 X233.23831 Y62.75421 E0.018729
G1 X230.40327 Y73.33472 E0.363356
G1 X230.89134 Y73.08603 E0.018171
G1 X233.52932 Y63.24098 E0.338099
G1 X233.81938 Y63.73129 E0.018898
G1 X231.37942 Y72.83734 E0.312720
G1 X231.86749 Y72.58866 E0.018171
G1 X234.10847 Y64.22522 E0.287217
G1 X234.39659 Y64.72277 E0.019072
G1 X232.35557 Y72.33997 E0.261590
G1 X232.84364 Y72.09128 E0.018171
G1 X234.68371 Y65.22405 E0.235835
G1 X234.96984 Y65.72906 E0.019254
G1 X233.33172 Y71.84260 E0.209951
G1 X233.81979 Y71.59391 E0.018171
G1 X235.25494 Y66.23787 E0.183937
G1 X235.53900 Y66.75057 E0.019443
G1 X234.30787 Y71.34522 E0.157789
G1 X234.79595 Y71.09654 E0.018171
G1 X235.82202 Y67.26718 E0.131508
G1 X236.10397 Y67.78776 E0.019639
G1 X235.28402 Y70.84785 E0.105090
G1 X235.77210 Y70.59916 E0.018171
G1 X236.38484 Y68.31239 E0.078533
G1 X236.66460 Y68.84113 E0.019843
G1 X236.26017 Y70.35048 E0.051834
G1 X236.74825 Y70.10179 E0.018171
G1 X236.94325 Y69.37404 E0.024992
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z2.800 F1200
G1 X128.89574 Y249.78676 F12000
G1 Z2.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X4.21324 Y126.89574 I-0.89574 J-123.78676 E5.974872
G3 X127.10426 Y2.21324 I123.78676 J-0.89574 E5.974872
G3 X251.78676 Y125.10426 I0.89574 J123.78676 E5.974872
G3 X128.89574 Y249.78676 I-123.78676 J0.89574 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X51.99996 Y44.23377 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X46.23377 Y202.00004 I76.00004 J81.76623 E5.816723
G2 X204.00004 Y207.76623 I81.76623 J-76.00004 E5.816723
G2 X209.76623 Y49.99996 I-76.00004 J-81.76623 E5.816723
G2 X51.99996 Y44.23377 I-81.76623 J76.00004 E5.816723
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X52.27711 Y44.53194 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X46.53194 Y201.72289 I75.72289 J81.46806 E5.795511
G2 X203.72289 Y207.46806 I81.46806 J-75.72289 E5.795511
G2 X209.46806 Y50.27711 I-75.72289 J-81.46806 E5.795511
G2 X52.27711 Y44.53194 I-81.46806 J75.72289 E5.795511
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X44.26683 Y35.91392 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X218.08608 Y42.26683 I83.73317 J90.08608 E6.408584
G3 X211.73317 Y216.08608 I-90.08608 J83.73317 E6.408584
G3 X37.91392 Y209.73317 I-83.73317 J-90.08608 E6.408584
G3 X44.26683 Y35.91392 I90.08608 J-83.73317 E6.408584
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X43.98968 Y35.61575 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X218.38425 Y41.98968 I84.01032 J90.38425 E6.429796
G3 X212.01032 Y216.38425 I-90.38425 J84.01032 E6.429796
G3 X37.61575 Y210.01032 I-84.01032 J-90.38425 E6.429796
G3 X43.98968 Y35.61575 I90.38425 J-84.01032 E6.429796
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.41634 Y181.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X225.31691 Y184.31056 I1.31056 J1.40999 E0.100304
G2 X228.03745 Y184.40999 I1.40999 J-1.31056 E0.100304
G2 X228.13688 Y181.68944 I-1.31056 J-1.40999 E0.100304
G2 X225.41634 Y181.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.68944 Y238.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X126.59001 Y241.31056 I1.31056 J1.40999 E0.100304
G2 X129.31056 Y241.40999 I1.40999 J-1.31056 E0.100304
G2 X129.40999 Y238.68944 I-1.31056 J-1.40999 E0.100304
G2 X126.68944 Y238.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.96255 Y181.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X27.86312 Y184.31056 I1.31056 J1.40999 E0.100304
G2 X30.58366 Y184.40999 I1.40999 J-1.31056 E0.100304
G2 X30.68309 Y181.68944 I-1.31056 J-1.40999 E0.100304
G2 X27.96255 Y181.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.96255 Y67.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X27.86312 Y70.31056 I1.31056 J1.40999 E0.100304
G2 X30.58366 Y70.40999 I1.40999 J-1.31056 E0.100304
G2 X30.68309 Y67.68944 I-1.31056 J-1.40999 E0.100304
G2 X27.96255 Y67.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X126.68944 Y10.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X126.59001 Y13.31056 I1.31056 J1.40999 E0.100304
G2 X129.31056 Y13.40999 I1.40999 J-1.31056 E0.100304
G2 X129.40999 Y10.68944 I-1.31056 J-1.40999 E0.100304
G2 X126.68944 Y10.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.41634 Y67.59001 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X225.31691 Y70.31056 I1.31056 J1.40999 E0.100304
G2 X228.03745 Y70.40999 I1.40999 J-1.31056 E0.100304
G2 X228.13688 Y67.68944 I-1.31056 J-1.40999 E0.100304
G2 X225.41634 Y67.59001 I-1.40999 J1.31056 E0.100304
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X236.94325 Y182.62596 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.74825 Y181.89821 E0.024992
G1 X236.26017 Y181.64952 E0.018171
G1 X236.66460 Y183.15887 E0.051834
G1 X236.38484 Y183.68761 E0.019843
G1 X235.77210 Y181.40084 E0.078533
G1 X235.28402 Y181.15215 E0.018171
G1 X236.10397 Y184.21224 E0.105090
G1 X235.82202 Y184.73282 E0.019639
G1 X234.79595 Y180.90346 E0.131508
G1 X234.30787 Y180.65478 E0.018171
G1 X235.53900 Y185.24943 E0.157789
G1 X235.25494 Y185.76213 E0.019443
G1 X233.81979 Y180.40609 E0.183937
G1 X233.33172 Y180.15740 E0.018171
G1 X234.96984 Y186.27094 E0.209951
G1 X234.68371 Y186.77595 E0.019254
G1 X232.84364 Y179.90872 E0.235835
G1 X232.35557 Y179.66003 E0.018171
G1 X234.39659 Y187.27723 E0.261590
G1 X234.10847 Y187.77478 E0.019072
G1 X231.86749 Y179.41134 E0.287217
G1 X231.37942 Y179.16266 E0.018171
G1 X233.81938 Y188.26871 E0.312720
G1 X233.52932 Y188.75902 E0.018898
G1 X230.89134 Y178.91397 E0.338099
G1 X230.40327 Y178.66528 E0.018171
G1 X233.23831 Y189.24579 E0.363356
G1 X232.94636 Y189.72906 E0.018729
G1 X229.91519 Y178.41660 E0.388493
G1 X229.42712 Y178.16791 E0.018171
G1 X232.65349 Y190.20888 E0.413511
G1 X232.35970 Y190.68528 E0.018567
G1 X228.93904 Y177.91922 E0.438412
G1 X228.45097 Y177.67054 E0.018171
G1 X232.06501 Y191.15832 E0.463198
G1 X231.76943 Y191.62803 E0.018409
G1 X227.96289 Y177.42185 E0.487869
G1 X227.47482 Y177.17316 E0.018171
G1 X231.47297 Y192.09447 E0.512428
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y192.46893 E0.304552
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.90912 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.62897 Y178.73494 E0.075092
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
G1 X226.34763 Y179.25780 E0.055216
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
G1 X226.06511 Y179.77623 E0.038451
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
G1 X225.78142 Y180.29034 E0.024467
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
G1 X225.49660 Y180.80019 E0.013268
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
G1 X225.21065 Y181.30586 E0.005195
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 X227.07008 Y189.81819 E0.020181
G1 X225.75212 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.34624 Y182.79835 E0.218317
G1 X224.05597 Y183.28788 E0.018879
G1 X225.53941 Y188.82416 E0.190127
G1 X225.02919 Y188.49281 E0.020181
G1 X223.76466 Y183.77352 E0.162070
G1 X223.47232 Y184.25535 E0.018695
G1 X224.51897 Y188.16147 E0.134144
G1 X224.00874 Y187.83013 E0.020181
G1 X223.17898 Y184.73340 E0.106348
G1 X222.88464 Y185.20774 E0.018518
G1 X223.49852 Y187.49879 E0.078679
G1 X222.98830 Y187.16744 E0.020181
G1 X222.58931 Y185.67840 E0.051137
G1 X222.29302 Y186.14545 E0.018348
G1 X222.47808 Y186.83610 E0.023718
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X133.43210 Y248.66060 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.96485 Y248.12785 E0.024992
G1 X133.93618 Y247.58082 E0.018171
G1 X132.83127 Y248.68574 E0.051834
G1 X132.23348 Y248.70783 E0.019843
G1 X133.90752 Y247.03379 E0.078533
G1 X133.87885 Y246.48676 E0.018171
G1 X131.63871 Y248.72690 E0.105090
G1 X131.04690 Y248.74301 E0.019639
G1 X133.85018 Y245.93973 E0.131508
G1 X133.82151 Y245.39270 E0.018171
G1 X130.45799 Y248.75622 E0.157789
G1 X129.87195 Y248.76657 E0.019443
G1 X133.79284 Y244.84568 E0.183937
G1 X133.76417 Y244.29865 E0.018171
G1 X129.28876 Y248.77406 E0.209951
G1 X128.70834 Y248.77878 E0.019254
G1 X133.73550 Y243.75162 E0.235835
G1 X133.70684 Y243.20459 E0.018171
G1 X128.13066 Y248.78077 E0.261590
G1 X127.55571 Y248.78002 E0.019072
G1 X133.67817 Y242.65756 E0.287217
G1 X133.64950 Y242.11053 E0.018171
G1 X126.98340 Y248.77662 E0.312720
G1 X126.41375 Y248.77058 E0.018898
G1 X133.62083 Y241.56350 E0.338099
G1 X133.59216 Y241.01647 E0.018171
G1 X125.84669 Y248.76195 E0.363356
G1 X125.28219 Y248.75075 E0.018729
G1 X133.56349 Y240.46944 E0.388493
G1 X133.53482 Y239.92242 E0.018171
G1 X124.72022 Y248.73702 E0.413511
G1 X124.16075 Y248.72079 E0.018567
G1 X133.50616 Y239.37539 E0.438412
G1 X133.47749 Y238.82836 E0.018171
G1 X123.60374 Y248.70210 E0.463198
G1 X123.04918 Y248.68097 E0.018409
G1 X133.44882 Y238.28133 E0.487869
G1 X133.42015 Y237.73430 E0.018171
G1 X122.49700 Y248.65745 E0.512428
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y248.56660 E0.304552
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.24144 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.64469 Y237.78267 E0.075092
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
G1 X131.05121 Y237.80045 E0.055216
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
G1 X130.46097 Y237.81499 E0.038451
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
G1 X129.87390 Y237.82637 E0.024467
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
G1 X129.28994 Y237.83463 E0.013268
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
G1 X128.70905 Y237.83982 E0.005195
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 X122.26687 Y243.70630 E0.020181
G1 X125.86761 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X126.98431 Y237.83747 E0.218317
G1 X126.41523 Y237.83085 E0.018879
G1 X122.36239 Y241.88369 E0.190127
G1 X122.39423 Y241.27615 E0.020181
G1 X125.84899 Y237.82139 E0.162070
G1 X125.28555 Y237.80913 E0.018695
G1 X122.42607 Y240.66861 E0.134144
G1 X122.45791 Y240.06108 E0.020181
G1 X124.72487 Y237.79412 E0.106348
G1 X124.16692 Y237.77637 E0.018518
G1 X122.48975 Y239.45354 E0.078679
G1 X122.52159 Y238.84600 E0.020181
G1 X123.61164 Y237.75595 E0.051137
G1 X123.05902 Y237.73287 E0.018348
G1 X122.55343 Y238.23846 E0.023718
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X24.48885 Y192.03464 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.21661 Y192.22964 E0.024992
G1 X25.67601 Y191.93130 E0.018171
G1 X24.16667 Y191.52687 E0.051834
G1 X23.84864 Y191.02021 E0.019843
G1 X26.13542 Y191.63295 E0.078533
G1 X26.59483 Y191.33461 E0.018171
G1 X23.53474 Y190.51466 E0.105090
G1 X23.22488 Y190.01020 E0.019639
G1 X27.05423 Y191.03627 E0.131508
G1 X27.51364 Y190.73793 E0.018171
G1 X22.91899 Y189.50680 E0.157789
G1 X22.61701 Y189.00444 E0.019443
G1 X27.97305 Y190.43959 E0.183937
G1 X28.43245 Y190.14124 E0.018171
G1 X22.31892 Y188.50313 E0.209951
G1 X22.02462 Y188.00283 E0.019254
G1 X28.89186 Y189.84290 E0.235835
G1 X29.35127 Y189.54456 E0.018171
G1 X21.73406 Y187.50354 E0.261590
G1 X21.44724 Y187.00524 E0.019072
G1 X29.81067 Y189.24622 E0.287217
G1 X30.27008 Y188.94787 E0.018171
G1 X21.16403 Y186.50791 E0.312720
G1 X20.88443 Y186.01156 E0.018898
G1 X30.72949 Y188.64953 E0.338099
G1 X31.18889 Y188.35119 E0.018171
G1 X20.60838 Y185.51615 E0.363356
G1 X20.33583 Y185.02168 E0.018729
G1 X31.64830 Y188.05285 E0.388493
G1 X32.10771 Y187.75451 E0.018171
G1 X20.06674 Y184.52814 E0.413511
G1 X19.80106 Y184.03551 E0.018567
G1 X32.56711 Y187.45616 E0.438412
G1 X33.02652 Y187.15782 E0.018171
G1 X19.53874 Y183.54378 E0.463198
G1 X19.27975 Y183.05295 E0.018409
G1 X33.48593 Y186.85948 E0.487869
G1 X33.94533 Y186.56114 E0.018171
G1 X19.02403 Y182.56299 E0.512428
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y182.09767 E0.304552
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.33233 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.01572 Y185.04773 E0.075092
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
G1 X32.70357 Y184.54265 E0.055216
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
G1 X32.39586 Y184.03876 E0.038451
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
G1 X32.09247 Y183.53603 E0.024467
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
G1 X31.79334 Y183.03443 E0.013268
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
G1 X31.49840 Y182.53396 E0.005195
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 X23.19679 Y179.88811 E0.020181
G1 X28.11550 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X30.63807 Y181.03912 E0.218317
G1 X30.35926 Y180.54297 E0.018879
G1 X24.82298 Y179.05953 E0.190127
G1 X25.36504 Y178.78334 E0.020181
G1 X30.08433 Y180.04787 E0.162070
G1 X29.81323 Y179.55378 E0.018695
G1 X25.90710 Y178.50714 E0.134144
G1 X26.44916 Y178.23095 E0.020181
G1 X29.54589 Y179.06071 E0.106348
G1 X29.28228 Y178.56864 E0.018518
G1 X26.99123 Y177.95475 E0.078679
G1 X27.53329 Y177.67856 E0.020181
G1 X29.02233 Y178.07755 E0.051137
G1 X28.76600 Y177.58742 E0.018348
G1 X28.07535 Y177.40236 E0.023718
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X19.05675 Y69.37404 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.25175 Y70.10179 E0.024992
G1 X19.73983 Y70.35048 E0.018171
G1 X19.33540 Y68.84113 E0.051834
G1 X19.61516 Y68.31239 E0.019843
G1 X20.22790 Y70.59916 E0.078533
G1 X20.71598 Y70.84785 E0.018171
G1 X19.89603 Y67.78776 E0.105090
G1 X20.17798 Y67.26718 E0.019639
G1 X21.20405 Y71.09654 E0.131508
G1 X21.69213 Y71.34522 E0.018171
G1 X20.46100 Y66.75057 E0.157789
G1 X20.74506 Y66.23787 E0.019443
G1 X22.18021 Y71.59391 E0.183937
G1 X22.66828 Y71.84260 E0.018171
G1 X21.03016 Y65.72906 E0.209951
G1 X21.31629 Y65.22405 E0.019254
G1 X23.15636 Y72.09128 E0.235835
G1 X23.64443 Y72.33997 E0.018171
G1 X21.60341 Y64.72277 E0.261590
G1 X21.89153 Y64.22522 E0.019072
G1 X24.13251 Y72.58866 E0.287217
G1 X24.62058 Y72.83734 E0.018171
G1 X22.18062 Y63.73129 E0.312720
G1 X22.47068 Y63.24098 E0.018898
G1 X25.10866 Y73.08603 E0.338099
G1 X25.59673 Y73.33472 E0.018171
G1 X22.76169 Y62.75421 E0.363356
G1 X23.05364 Y62.27094 E0.018729
G1 X26.08481 Y73.58340 E0.388493
G1 X26.57288 Y73.83209 E0.018171
G1 X23.34651 Y61.79112 E0.413511
G1 X23.64030 Y61.31472 E0.018567
G1 X27.06096 Y74.08078 E0.438412
G1 X27.54903 Y74.32946 E0.018171
G1 X23.93499 Y60.84168 E0.463198
G1 X24.23057 Y60.37197 E0.018409
G1 X28.03711 Y74.57815 E0.487869
G1 X28.52518 Y74.82684 E0.018171
G1 X24.52703 Y59.90553 E0.512428
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y59.53107 E0.304552
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.09088 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.37103 Y73.26506 E0.075092
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
G1 X29.65237 Y72.74220 E0.055216
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
G1 X29.93489 Y72.22377 E0.038451
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
G1 X30.21858 Y71.70966 E0.024467
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
G1 X30.50340 Y71.19981 E0.013268
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
G1 X30.78935 Y70.69414 E0.005195
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 X28.92992 Y62.18181 E0.020181
G1 X30.24788 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.65376 Y69.20165 E0.218317
G1 X31.94403 Y68.71212 E0.018879
G1 X30.46059 Y63.17584 E0.190127
G1 X30.97081 Y63.50719 E0.020181
G1 X32.23534 Y68.22648 E0.162070
G1 X32.52768 Y67.74465 E0.018695
G1 X31.48103 Y63.83853 E0.134144
G1 X31.99126 Y64.16987 E0.020181
G1 X32.82102 Y67.26660 E0.106348
G1 X33.11536 Y66.79226 E0.018518
G1 X32.50148 Y64.50121 E0.078679
G1 X33.01170 Y64.83256 E0.020181
G1 X33.41069 Y66.32160 E0.051137
G1 X33.70698 Y65.85455 E0.018348
G1 X33.52192 Y65.16390 E0.023718
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X122.56790 Y3.33940 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.03515 Y3.87215 E0.024992
G1 X122.06382 Y4.41918 E0.018171
G1 X123.16873 Y3.31426 E0.051834
G1 X123.76652 Y3.29217 E0.019843
G1 X122.09248 Y4.96621 E0.078533
G1 X122.12115 Y5.51324 E0.018171
G1 X124.36129 Y3.27310 E0.105090
G1 X124.95310 Y3.25699 E0.019639
G1 X122.14982 Y6.06027 E0.131508
G1 X122.17849 Y6.60730 E0.018171
G1 X125.54201 Y3.24378 E0.157789
G1 X126.12805 Y3.23343 E0.019443
G1 X122.20716 Y7.15432 E0.183937
G1 X122.23583 Y7.70135 E0.018171
G1 X126.71124 Y3.22594 E0.209951
G1 X127.29166 Y3.22122 E0.019254
G1 X122.26450 Y8.24838 E0.235835
G1 X122.29316 Y8.79541 E0.018171
G1 X127.86934 Y3.21923 E0.261590
G1 X128.44429 Y3.21998 E0.019072
G1 X122.32183 Y9.34244 E0.287217
G1 X122.35050 Y9.88947 E0.018171
G1 X129.01660 Y3.22338 E0.312720
G1 X129.58625 Y3.22942 E0.018898
G1 X122.37917 Y10.43650 E0.338099
G1 X122.40784 Y10.98353 E0.018171
G1 X130.15331 Y3.23805 E0.363356
G1 X130.71781 Y3.24925 E0.018729
G1 X122.43651 Y11.53056 E0.388493
G1 X122.46518 Y12.07758 E0.018171
G1 X131.27978 Y3.26298 E0.413511
G1 X131.83925 Y3.27921 E0.018567
G1 X122.49384 Y12.62461 E0.438412
G1 X122.52251 Y13.17164 E0.018171
G1 X132.39626 Y3.29790 E0.463198
G1 X132.95082 Y3.31903 E0.018409
G1 X122.55118 Y13.71867 E0.487869
G1 X122.57985 Y14.26570 E0.018171
G1 X133.50300 Y3.34255 E0.512428
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y3.43340 E0.304552
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.75856 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.35531 Y14.21733 E0.075092
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
G1 X124.94879 Y14.19955 E0.055216
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
G1 X125.53903 Y14.18501 E0.038451
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
G1 X126.12610 Y14.17363 E0.024467
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
G1 X126.71006 Y14.16537 E0.013268
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
G1 X127.29095 Y14.16018 E0.005195
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 X133.73313 Y8.29370 E0.020181
G1 X130.13239 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X129.01569 Y14.16253 E0.218317
G1 X129.58477 Y14.16915 E0.018879
G1 X133.63761 Y10.11631 E0.190127
G1 X133.60577 Y10.72385 E0.020181
G1 X130.15101 Y14.17861 E0.162070
G1 X130.71445 Y14.19087 E0.018695
G1 X133.57393 Y11.33139 E0.134144
G1 X133.54209 Y11.93892 E0.020181
G1 X131.27513 Y14.20588 E0.106348
G1 X131.83308 Y14.22363 E0.018518
G1 X133.51025 Y12.54646 E0.078679
G1 X133.47841 Y13.15400 E0.020181
G1 X132.38836 Y14.24405 E0.051137
G1 X132.94098 Y14.26713 E0.018348
G1 X133.44657 Y13.76154 E0.023718
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X231.51115 Y59.96536 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.78339 Y59.77036 E0.024992
G1 X230.32399 Y60.06870 E0.018171
G1 X231.83333 Y60.47313 E0.051834
G1 X232.15136 Y60.97979 E0.019843
G1 X229.86458 Y60.36705 E0.078533
G1 X229.40517 Y60.66539 E0.018171
G1 X232.46526 Y61.48534 E0.105090
G1 X232.77512 Y61.98980 E0.019639
G1 X228.94577 Y60.96373 E0.131508
G1 X228.48636 Y61.26207 E0.018171
G1 X233.08101 Y62.49320 E0.157789
G1 X233.38299 Y62.99556 E0.019443
G1 X228.02695 Y61.56041 E0.183937
G1 X227.56755 Y61.85876 E0.018171
G1 X233.68108 Y63.49687 E0.209951
G1 X233.97538 Y63.99717 E0.019254
G1 X227.10814 Y62.15710 E0.235835
G1 X226.64873 Y62.45544 E0.018171
G1 X234.26594 Y64.49646 E0.261590
G1 X234.55276 Y64.99476 E0.019072
G1 X226.18933 Y62.75378 E0.287217
G1 X225.72992 Y63.05213 E0.018171
G1 X234.83597 Y65.49209 E0.312720
G1 X235.11557 Y65.98844 E0.018898
G1 X225.27051 Y63.35047 E0.338099
G1 X224.81111 Y63.64881 E0.018171
G1 X235.39162 Y66.48385 E0.363356
G1 X235.66417 Y66.97832 E0.018729
G1 X224.35170 Y63.94715 E0.388493
G1 X223.89229 Y64.24549 E0.018171
G1 X235.93326 Y67.47186 E0.413511
G1 X236.19894 Y67.96449 E0.018567
G1 X223.43289 Y64.54384 E0.438412
G1 X222.97348 Y64.84218 E0.018171
G1 X236.46126 Y68.45622 E0.463198
G1 X236.72025 Y68.94705 E0.018409
G1 X222.51407 Y65.14052 E0.487869
G1 X222.05467 Y65.43886 E0.018171
G1 X236.97597 Y69.43701 E0.512428
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y69.90233 E0.304552
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.66767 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.98428 Y66.95227 E0.075092
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
G1 X223.29643 Y67.45735 E0.055216
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
G1 X223.60414 Y67.96124 E0.038451
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
G1 X223.90753 Y68.46397 E0.024467
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
G1 X224.20666 Y68.96557 E0.013268
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
G1 X224.50160 Y69.46604 E0.005195
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 X232.80321 Y72.11189 E0.020181
G1 X227.88450 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X225.36193 Y70.96088 E0.218317
G1 X225.64074 Y71.45703 E0.018879
G1 X231.17702 Y72.94047 E0.190127
G1 X230.63496 Y73.21666 E0.020181
G1 X225.91567 Y71.95213 E0.162070
G1 X226.18677 Y72.44622 E0.018695
G1 X230.09290 Y73.49286 E0.134144
G1 X229.55084 Y73.76905 E0.020181
G1 X226.45411 Y72.93929 E0.106348
G1 X226.71772 Y73.43136 E0.018518
G1 X229.00877 Y74.04525 E0.078679
G1 X228.46671 Y74.32144 E0.020181
G1 X226.97767 Y73.92245 E0.051137
G1 X227.23400 Y74.41258 E0.018348
G1 X227.92465 Y74.59764 E0.023718
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z3.000 F1200
G1 X43.72275 Y35.32856 F12000
G1 Z2.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X218.67144 Y41.72275 I84.27725 J90.67144 E5.974872
G3 X212.27725 Y216.67144 I-90.67144 J84.27725 E5.974872
G3 X37.32856 Y210.27725 I-84.27725 J-90.67144 E5.974872
G3 X43.72275 Y35.32856 I90.67144 J-84.27725 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X239.27235 Y134.95458 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X136.95458 Y14.72765 I-111.27235 J-8.95458 E5.816723
G2 X16.72765 Y117.04542 I-8.95458 J111.27235 E5.816723
G2 X119.04542 Y237.27235 I111.27235 J8.95458 E5.816723
G2 X239.27235 Y134.95458 I8.95458 J-111.27235 E5.816723
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X238.86659 Y134.92193 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X136.92193 Y15.13341 I-110.86659 J-8.92193 E5.795511
G2 X17.13341 Y117.07807 I-8.92193 J110.86659 E5.795511
G2 X119.07807 Y236.86659 I110.86659 J8.92193 E5.795511
G2 X238.86659 Y134.92193 I8.92193 J-110.86659 E5.795511
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X250.59451 Y135.86573 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X118.13427 Y248.59451 I-122.59451 J-9.86573 E6.408584
G3 X5.40549 Y116.13427 I9.86573 J-122.59451 E6.408584
G3 X137.86573 Y3.40549 I122.59451 J9.86573 E6.408584
G3 X250.59451 Y135.86573 I-9.86573 J122.59451 E6.408584
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X251.00028 Y135.89838 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X118.10162 Y249.00028 I-123.00028 J-9.89838 E6.429796
G3 X4.99972 Y116.10162 I9.89838 J-123.00028 E6.429796
G3 X137.89838 Y2.99972 I123.00028 J9.89838 E6.429796
G3 X251.00028 Y135.89838 I-9.89838 J123.00028 E6.429796
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.64569 Y183.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X226.88131 Y181.08120 I-1.91880 J-0.15441 E0.100304
G2 X224.80810 Y182.84559 I-0.15441 J1.91880 E0.100304
G2 X226.57248 Y184.91880 I1.91880 J0.15441 E0.100304
G2 X228.64569 Y183.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.91880 Y240.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X128.15441 Y238.08120 I-1.91880 J-0.15441 E0.100304
G2 X126.08120 Y239.84559 I-0.15441 J1.91880 E0.100304
G2 X127.84559 Y241.91880 I1.91880 J0.15441 E0.100304
G2 X129.91880 Y240.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.19190 Y183.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X29.42752 Y181.08120 I-1.91880 J-0.15441 E0.100304
G2 X27.35431 Y182.84559 I-0.15441 J1.91880 E0.100304
G2 X29.11869 Y184.91880 I1.91880 J0.15441 E0.100304
G2 X31.19190 Y183.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.19190 Y69.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X29.42752 Y67.08120 I-1.91880 J-0.15441 E0.100304
G2 X27.35431 Y68.84559 I-0.15441 J1.91880 E0.100304
G2 X29.11869 Y70.91880 I1.91880 J0.15441 E0.100304
G2 X31.19190 Y69.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X129.91880 Y12.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X128.15441 Y10.08120 I-1.91880 J-0.15441 E0.100304
G2 X126.08120 Y11.84559 I-0.15441 J1.91880 E0.100304
G2 X127.84559 Y13.91880 I1.91880 J0.15441 E0.100304
G2 X129.91880 Y12.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.64569 Y69.15441 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X226.88131 Y67.08120 I-1.91880 J-0.15441 E0.100304
G2 X224.80810 Y68.84559 I-0.15441 J1.91880 E0.100304
G2 X226.57248 Y70.91880 I1.91880 J0.15441 E0.100304
G2 X228.64569 Y69.15441 I0.15441 J-1.91880 E0.100304
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.92465 Y177.40236 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.23400 Y177.58742 E0.023718
G1 X226.97767 Y178.07755 E0.018348
G1 X228.46671 Y177.67856 E0.051137
G1 X229.00877 Y177.95475 E0.020181
G1 X226.71772 Y178.56864 E0.078679
G1 X226.45411 Y179.06071 E0.018518
G1 X229.55084 Y178.23095 E0.106348
G1 X230.09290 Y178.50714 E0.020181
G1 X226.18677 Y179.55378 E0.134144
G1 X225.91567 Y180.04787 E0.018695
G1 X230.63496 Y178.78334 E0.162070
G1 X231.17702 Y179.05953 E0.020181
G1 X225.64074 Y180.54297 E0.190127
G1 X225.36193 Y181.03912 E0.018879
G1 X231.71909 Y179.33573 E0.218317
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 X232.80321 Y179.88811 E0.020181
G1 X227.88450 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.50160 Y182.53396 E0.005195
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
G1 X224.20666 Y183.03443 E0.013268
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
G1 X223.90753 Y183.53603 E0.024467
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
G1 X223.60414 Y184.03876 E0.038451
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
G1 X223.29643 Y184.54265 E0.055216
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
G1 X222.98428 Y185.04773 E0.075092
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
G1 X222.66767 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y182.09767 E0.304552
G1 X236.97597 Y182.56299 E0.016363
G1 X222.05467 Y186.56114 E0.512428
G1 X222.51407 Y186.85948 E0.018171
G1 X236.72025 Y183.05295 E0.487869
G1 X236.46126 Y183.54378 E0.018409
G1 X222.97348 Y187.15782 E0.463198
G1 X223.43289 Y187.45616 E0.018171
G1 X236.19894 Y184.03551 E0.438412
G1 X235.93326 Y184.52814 E0.018567
G1 X223.89229 Y187.75451 E0.413511
G1 X224.35170 Y188.05285 E0.018171
G1 X235.66417 Y185.02168 E0.388493
G1 X235.39162 Y185.51615 E0.018729
G1 X224.81111 Y188.35119 E0.363356
G1 X225.27051 Y188.64953 E0.018171
G1 X235.11557 Y186.01156 E0.338099
G1 X234.83597 Y186.50791 E0.018898
G1 X225.72992 Y188.94787 E0.312720
G1 X226.18933 Y189.24622 E0.018171
G1 X234.55276 Y187.00524 E0.287217
G1 X234.26594 Y187.50354 E0.019072
G1 X226.64873 Y189.54456 E0.261590
G1 X227.10814 Y189.84290 E0.018171
G1 X233.97538 Y188.00283 E0.235835
G1 X233.68108 Y188.50313 E0.019254
G1 X227.56755 Y190.14124 E0.209951
G1 X228.02695 Y190.43959 E0.018171
G1 X233.38299 Y189.00444 E0.183937
G1 X233.08101 Y189.50680 E0.019443
G1 X228.48636 Y190.73793 E0.157789
G1 X228.94577 Y191.03627 E0.018171
G1 X232.77512 Y190.01020 E0.131508
G1 X232.46526 Y190.51466 E0.019639
G1 X229.40517 Y191.33461 E0.105090
G1 X229.86458 Y191.63295 E0.018171
G1 X232.15136 Y191.02021 E0.078533
G1 X231.83333 Y191.52687 E0.019843
G1 X230.32399 Y191.93130 E0.051834
G1 X230.78339 Y192.22964 E0.018171
G1 X231.51115 Y192.03464 E0.024992
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X133.44657 Y238.23846 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.94098 Y237.73287 E0.023718
G1 X132.38836 Y237.75595 E0.018348
G1 X133.47841 Y238.84600 E0.051137
G1 X133.51025 Y239.45354 E0.020181
G1 X131.83308 Y237.77637 E0.078679
G1 X131.27513 Y237.79412 E0.018518
G1 X133.54209 Y240.06108 E0.106348
G1 X133.57393 Y240.66861 E0.020181
G1 X130.71445 Y237.80913 E0.134144
G1 X130.15101 Y237.82139 E0.018695
G1 X133.60577 Y241.27615 E0.162070
G1 X133.63761 Y241.88369 E0.020181
G1 X129.58477 Y237.83085 E0.190127
G1 X129.01569 Y237.83747 E0.018879
G1 X133.66945 Y242.49123 E0.218317
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 X133.73313 Y243.70630 E0.020181
G1 X130.13239 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.29095 Y237.83982 E0.005195
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
G1 X126.71006 Y237.83463 E0.013268
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
G1 X126.12610 Y237.82637 E0.024467
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
G1 X125.53903 Y237.81499 E0.038451
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
G1 X124.94879 Y237.80045 E0.055216
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
G1 X124.35531 Y237.78267 E0.075092
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
G1 X123.75856 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y248.56660 E0.304552
G1 X133.50300 Y248.65745 E0.016363
G1 X122.57985 Y237.73430 E0.512428
G1 X122.55118 Y238.28133 E0.018171
G1 X132.95082 Y248.68097 E0.487869
G1 X132.39626 Y248.70210 E0.018409
G1 X122.52251 Y238.82836 E0.463198
G1 X122.49384 Y239.37539 E0.018171
G1 X131.83925 Y248.72079 E0.438412
G1 X131.27978 Y248.73702 E0.018567
G1 X122.46518 Y239.92242 E0.413511
G1 X122.43651 Y240.46944 E0.018171
G1 X130.71781 Y248.75075 E0.388493
G1 X130.15331 Y248.76195 E0.018729
G1 X122.40784 Y241.01647 E0.363356
G1 X122.37917 Y241.56350 E0.018171
G1 X129.58625 Y248.77058 E0.338099
G1 X129.01660 Y248.77662 E0.018898
G1 X122.35050 Y242.11053 E0.312720
G1 X122.32183 Y242.65756 E0.018171
G1 X128.44429 Y248.78002 E0.287217
G1 X127.86934 Y248.78077 E0.019072
G1 X122.29316 Y243.20459 E0.261590
G1 X122.26450 Y243.75162 E0.018171
G1 X127.29166 Y248.77878 E0.235835
G1 X126.71124 Y248.77406 E0.019254
G1 X122.23583 Y244.29865 E0.209951
G1 X122.20716 Y244.84568 E0.018171
G1 X126.12805 Y248.76657 E0.183937
G1 X125.54201 Y248.75622 E0.019443
G1 X122.17849 Y245.39270 E0.157789
G1 X122.14982 Y245.93973 E0.018171
G1 X124.95310 Y248.74301 E0.131508
G1 X124.36129 Y248.72690 E0.019639
G1 X122.12115 Y246.48676 E0.105090
G1 X122.09248 Y247.03379 E0.018171
G1 X123.76652 Y248.70783 E0.078533
G1 X123.16873 Y248.68574 E0.019843
G1 X122.06382 Y247.58082 E0.051834
G1 X122.03515 Y248.12785 E0.018171
G1 X122.56790 Y248.66060 E0.024992
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X33.52192 Y186.83610 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.70698 Y186.14545 E0.023718
G1 X33.41069 Y185.67840 E0.018348
G1 X33.01170 Y187.16744 E0.051137
G1 X32.50148 Y187.49879 E0.020181
G1 X33.11536 Y185.20774 E0.078679
G1 X32.82102 Y184.73340 E0.018518
G1 X31.99126 Y187.83013 E0.106348
G1 X31.48103 Y188.16147 E0.020181
G1 X32.52768 Y184.25535 E0.134144
G1 X32.23534 Y183.77352 E0.018695
G1 X30.97081 Y188.49281 E0.162070
G1 X30.46059 Y188.82416 E0.020181
G1 X31.94403 Y183.28788 E0.190127
G1 X31.65376 Y182.79835 E0.018879
G1 X29.95036 Y189.15550 E0.218317
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 X28.92992 Y189.81819 E0.020181
G1 X30.24788 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.78935 Y181.30586 E0.005195
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
G1 X30.50340 Y180.80019 E0.013268
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
G1 X30.21858 Y180.29034 E0.024467
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
G1 X29.93489 Y179.77623 E0.038451
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
G1 X29.65237 Y179.25780 E0.055216
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
G1 X29.37103 Y178.73494 E0.075092
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
G1 X29.09088 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y192.46893 E0.304552
G1 X24.52703 Y192.09447 E0.016363
G1 X28.52518 Y177.17316 E0.512428
G1 X28.03711 Y177.42185 E0.018171
G1 X24.23057 Y191.62803 E0.487869
G1 X23.93499 Y191.15832 E0.018409
G1 X27.54903 Y177.67054 E0.463198
G1 X27.06096 Y177.91922 E0.018171
G1 X23.64030 Y190.68528 E0.438412
G1 X23.34651 Y190.20888 E0.018567
G1 X26.57288 Y178.16791 E0.413511
G1 X26.08481 Y178.41660 E0.018171
G1 X23.05364 Y189.72906 E0.388493
G1 X22.76169 Y189.24579 E0.018729
G1 X25.59673 Y178.66528 E0.363356
G1 X25.10866 Y178.91397 E0.018171
G1 X22.47068 Y188.75902 E0.338099
G1 X22.18062 Y188.26871 E0.018898
G1 X24.62058 Y179.16266 E0.312720
G1 X24.13251 Y179.41134 E0.018171
G1 X21.89153 Y187.77478 E0.287217
G1 X21.60341 Y187.27723 E0.019072
G1 X23.64443 Y179.66003 E0.261590
G1 X23.15636 Y179.90872 E0.018171
G1 X21.31629 Y186.77595 E0.235835
G1 X21.03016 Y186.27094 E0.019254
G1 X22.66828 Y180.15740 E0.209951
G1 X22.18021 Y180.40609 E0.018171
G1 X20.74506 Y185.76213 E0.183937
G1 X20.46100 Y185.24943 E0.019443
G1 X21.69213 Y180.65478 E0.157789
G1 X21.20405 Y180.90346 E0.018171
G1 X20.17798 Y184.73282 E0.131508
G1 X19.89603 Y184.21224 E0.019639
G1 X20.71598 Y181.15215 E0.105090
G1 X20.22790 Y181.40084 E0.018171
G1 X19.61516 Y183.68761 E0.078533
G1 X19.33540 Y183.15887 E0.019843
G1 X19.73983 Y181.64952 E0.051834
G1 X19.25175 Y181.89821 E0.018171
G1 X19.05675 Y182.62596 E0.024992
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.07535 Y74.59764 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.76600 Y74.41258 E0.023718
G1 X29.02233 Y73.92245 E0.018348
G1 X27.53329 Y74.32144 E0.051137
G1 X26.99123 Y74.04525 E0.020181
G1 X29.28228 Y73.43136 E0.078679
G1 X29.54589 Y72.93929 E0.018518
G1 X26.44916 Y73.76905 E0.106348
G1 X25.90710 Y73.49286 E0.020181
G1 X29.81323 Y72.44622 E0.134144
G1 X30.08433 Y71.95213 E0.018695
G1 X25.36504 Y73.21666 E0.162070
G1 X24.82298 Y72.94047 E0.020181
G1 X30.35926 Y71.45703 E0.190127
G1 X30.63807 Y70.96088 E0.018879
G1 X24.28091 Y72.66427 E0.218317
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 X23.19679 Y72.11189 E0.020181
G1 X28.11550 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.49840 Y69.46604 E0.005195
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
G1 X31.79334 Y68.96557 E0.013268
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
G1 X32.09247 Y68.46397 E0.024467
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
G1 X32.39586 Y67.96124 E0.038451
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
G1 X32.70357 Y67.45735 E0.055216
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
G1 X33.01572 Y66.95227 E0.075092
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
G1 X33.33233 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y69.90233 E0.304552
G1 X19.02403 Y69.43701 E0.016363
G1 X33.94533 Y65.43886 E0.512428
G1 X33.48593 Y65.14052 E0.018171
G1 X19.27975 Y68.94705 E0.487869
G1 X19.53874 Y68.45622 E0.018409
G1 X33.02652 Y64.84218 E0.463198
G1 X32.56711 Y64.54384 E0.018171
G1 X19.80106 Y67.96449 E0.438412
G1 X20.06674 Y67.47186 E0.018567
G1 X32.10771 Y64.24549 E0.413511
G1 X31.64830 Y63.94715 E0.018171
G1 X20.33583 Y66.97832 E0.388493
G1 X20.60838 Y66.48385 E0.018729
G1 X31.18889 Y63.64881 E0.363356
G1 X30.72949 Y63.35047 E0.018171
G1 X20.88443 Y65.98844 E0.338099
G1 X21.16403 Y65.49209 E0.018898
G1 X30.27008 Y63.05213 E0.312720
G1 X29.81067 Y62.75378 E0.018171
G1 X21.44724 Y64.99476 E0.287217
G1 X21.73406 Y64.49646 E0.019072
G1 X29.35127 Y62.45544 E0.261590
G1 X28.89186 Y62.15710 E0.018171
G1 X22.02462 Y63.99717 E0.235835
G1 X22.31892 Y63.49687 E0.019254
G1 X28.43245 Y61.85876 E0.209951
G1 X27.97305 Y61.56041 E0.018171
G1 X22.61701 Y62.99556 E0.183937
G1 X22.91899 Y62.49320 E0.019443
G1 X27.51364 Y61.26207 E0.157789
G1 X27.05423 Y60.96373 E0.018171
G1 X23.22488 Y61.98980 E0.131508
G1 X23.53474 Y61.48534 E0.019639
G1 X26.59483 Y60.66539 E0.105090
G1 X26.13542 Y60.36705 E0.018171
G1 X23.84864 Y60.97979 E0.078533
G1 X24.16667 Y60.47313 E0.019843
G1 X25.67601 Y60.06870 E0.051834
G1 X25.21661 Y59.77036 E0.018171
G1 X24.48885 Y59.96536 E0.024992
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X122.55343 Y13.76154 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.05902 Y14.26713 E0.023718
G1 X123.61164 Y14.24405 E0.018348
G1 X122.52159 Y13.15400 E0.051137
G1 X122.48975 Y12.54646 E0.020181
G1 X124.16692 Y14.22363 E0.078679
G1 X124.72487 Y14.20588 E0.018518
G1 X122.45791 Y11.93892 E0.106348
G1 X122.42607 Y11.33139 E0.020181
G1 X125.28555 Y14.19087 E0.134144
G1 X125.84899 Y14.17861 E0.018695
G1 X122.39423 Y10.72385 E0.162070
G1 X122.36239 Y10.11631 E0.020181
G1 X126.41523 Y14.16915 E0.190127
G1 X126.98431 Y14.16253 E0.018879
G1 X122.33055 Y9.50877 E0.218317
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 X122.26687 Y8.29370 E0.020181
G1 X125.86761 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.70905 Y14.16018 E0.005195
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
G1 X129.28994 Y14.16537 E0.013268
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
G1 X129.87390 Y14.17363 E0.024467
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
G1 X130.46097 Y14.18501 E0.038451
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
G1 X131.05121 Y14.19955 E0.055216
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
G1 X131.64469 Y14.21733 E0.075092
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
G1 X132.24144 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y3.43340 E0.304552
G1 X122.49700 Y3.34255 E0.016363
G1 X133.42015 Y14.26570 E0.512428
G1 X133.44882 Y13.71867 E0.018171
G1 X123.04918 Y3.31903 E0.487869
G1 X123.60374 Y3.29790 E0.018409
G1 X133.47749 Y13.17164 E0.463198
G1 X133.50616 Y12.62461 E0.018171
G1 X124.16075 Y3.27921 E0.438412
G1 X124.72022 Y3.26298 E0.018567
G1 X133.53482 Y12.07758 E0.413511
G1 X133.56349 Y11.53056 E0.018171
G1 X125.28219 Y3.24925 E0.388493
G1 X125.84669 Y3.23805 E0.018729
G1 X133.59216 Y10.98353 E0.363356
G1 X133.62083 Y10.43650 E0.018171
G1 X126.41375 Y3.22942 E0.338099
G1 X126.98340 Y3.22338 E0.018898
G1 X133.64950 Y9.88947 E0.312720
G1 X133.67817 Y9.34244 E0.018171
G1 X127.55571 Y3.21998 E0.287217
G1 X128.13066 Y3.21923 E0.019072
G1 X133.70684 Y8.79541 E0.261590
G1 X133.73550 Y8.24838 E0.018171
G1 X128.70834 Y3.22122 E0.235835
G1 X129.28876 Y3.22594 E0.019254
G1 X133.76417 Y7.70135 E0.209951
G1 X133.79284 Y7.15432 E0.018171
G1 X129.87195 Y3.23343 E0.183937
G1 X130.45799 Y3.24378 E0.019443
G1 X133.82151 Y6.60730 E0.157789
G1 X133.85018 Y6.06027 E0.018171
G1 X131.04690 Y3.25699 E0.131508
G1 X131.63871 Y3.27310 E0.019639
G1 X133.87885 Y5.51324 E0.105090
G1 X133.90752 Y4.96621 E0.018171
G1 X132.23348 Y3.29217 E0.078533
G1 X132.83127 Y3.31426 E0.019843
G1 X133.93618 Y4.41918 E0.051834
G1 X133.96485 Y3.87215 E0.018171
G1 X133.43210 Y3.33940 E0.024992
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X222.47808 Y65.16390 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.29302 Y65.85455 E0.023718
G1 X222.58931 Y66.32160 E0.018348
G1 X222.98830 Y64.83256 E0.051137
G1 X223.49852 Y64.50121 E0.020181
G1 X222.88464 Y66.79226 E0.078679
G1 X223.17898 Y67.26660 E0.018518
G1 X224.00874 Y64.16987 E0.106348
G1 X224.51897 Y63.83853 E0.020181
G1 X223.47232 Y67.74465 E0.134144
G1 X223.76466 Y68.22648 E0.018695
G1 X225.02919 Y63.50719 E0.162070
G1 X225.53941 Y63.17584 E0.020181
G1 X224.05597 Y68.71212 E0.190127
G1 X224.34624 Y69.20165 E0.018879
G1 X226.04964 Y62.84450 E0.218317
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 X227.07008 Y62.18181 E0.020181
G1 X225.75212 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.21065 Y70.69414 E0.005195
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
G1 X225.49660 Y71.19981 E0.013268
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
G1 X225.78142 Y71.70966 E0.024467
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
G1 X226.06511 Y72.22377 E0.038451
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
G1 X226.34763 Y72.74220 E0.055216
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
G1 X226.62897 Y73.26506 E0.075092
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
G1 X226.90912 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y59.53107 E0.304552
G1 X231.47297 Y59.90553 E0.016363
G1 X227.47482 Y74.82684 E0.512428
G1 X227.96289 Y74.57815 E0.018171
G1 X231.76943 Y60.37197 E0.487869
G1 X232.06501 Y60.84168 E0.018409
G1 X228.45097 Y74.32946 E0.463198
G1 X228.93904 Y74.08078 E0.018171
G1 X232.35970 Y61.31472 E0.438412
G1 X232.65349 Y61.79112 E0.018567
G1 X229.42712 Y73.83209 E0.413511
G1 X229.91519 Y73.58340 E0.018171
G1 X232.94636 Y62.27094 E0.388493
G1 X233.23831 Y62.75421 E0.018729
G1 X230.40327 Y73.33472 E0.363356
G1 X230.89134 Y73.08603 E0.018171
G1 X233.52932 Y63.24098 E0.338099
G1 X233.81938 Y63.73129 E0.018898
G1 X231.37942 Y72.83734 E0.312720
G1 X231.86749 Y72.58866 E0.018171
G1 X234.10847 Y64.22522 E0.287217
G1 X234.39659 Y64.72277 E0.019072
G1 X232.35557 Y72.33997 E0.261590
G1 X232.84364 Y72.09128 E0.018171
G1 X234.68371 Y65.22405 E0.235835
G1 X234.96984 Y65.72906 E0.019254
G1 X233.33172 Y71.84260 E0.209951
G1 X233.81979 Y71.59391 E0.018171
G1 X235.25494 Y66.23787 E0.183937
G1 X235.53900 Y66.75057 E0.019443
G1 X234.30787 Y71.34522 E0.157789
G1 X234.79595 Y71.09654 E0.018171
G1 X235.82202 Y67.26718 E0.131508
G1 X236.10397 Y67.78776 E0.019639
G1 X235.28402 Y70.84785 E0.105090
G1 X235.77210 Y70.59916 E0.018171
G1 X236.38484 Y68.31239 E0.078533
G1 X236.66460 Y68.84113 E0.019843
G1 X236.26017 Y70.35048 E0.051834
G1 X236.74825 Y70.10179 E0.018171
G1 X236.94325 Y69.37404 E0.024992
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z3.200 F1200
G1 X251.39110 Y135.92983 F12000
G1 Z2.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X118.07017 Y249.39110 I-123.39110 J-9.92983 E5.974872
G3 X4.60890 Y116.07017 I9.92983 J-123.39110 E5.974872
G3 X137.92983 Y2.60890 I123.39110 J9.92983 E5.974872
G3 X251.39110 Y135.92983 I-9.92983 J123.39110 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X39.90250 Y194.56056 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X196.56056 Y214.09750 I88.09750 J-68.56056 E5.816723
G2 X216.09750 Y57.43944 I-68.56056 J-88.09750 E5.816723
G2 X59.43944 Y37.90250 I-88.09750 J68.56056 E5.816723
G2 X39.90250 Y194.56056 I68.56056 J88.09750 E5.816723
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X40.22375 Y194.31055 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X196.31055 Y213.77625 I87.77625 J-68.31055 E5.795511
G2 X215.77625 Y57.68945 I-68.31055 J-87.77625 E5.795511
G2 X59.68945 Y38.22375 I-87.77625 J68.31055 E5.795511
G2 X40.22375 Y194.31055 I68.31055 J87.77625 E5.795511
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.93842 Y201.53672 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X52.46328 Y28.93842 I97.06158 J-75.53672 E6.408584
G3 X225.06158 Y50.46328 I75.53672 J97.06158 E6.408584
G3 X203.53672 Y223.06158 I-97.06158 J75.53672 E6.408584
G3 X30.93842 Y201.53672 I-75.53672 J-97.06158 E6.408584
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.61716 Y201.78674 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X52.21326 Y28.61716 I97.38284 J-75.78674 E6.429796
G3 X225.38284 Y50.21326 I75.78674 J97.38284 E6.429796
G3 X203.78674 Y223.38284 I-97.38284 J75.78674 E6.429796
G3 X30.61716 Y201.78674 I-75.78674 J-97.38284 E6.429796
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.20773 Y184.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X227.90916 Y184.51917 I1.51917 J-1.18227 E0.100304
G2 X228.24606 Y181.81773 I-1.18227 J-1.51917 E0.100304
G2 X225.54463 Y181.48083 I-1.51917 J1.18227 E0.100304
G2 X225.20773 Y184.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.48083 Y241.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.18227 Y241.51917 I1.51917 J-1.18227 E0.100304
G2 X129.51917 Y238.81773 I-1.18227 J-1.51917 E0.100304
G2 X126.81773 Y238.48083 I-1.51917 J1.18227 E0.100304
G2 X126.48083 Y241.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.75394 Y184.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X30.45537 Y184.51917 I1.51917 J-1.18227 E0.100304
G2 X30.79227 Y181.81773 I-1.18227 J-1.51917 E0.100304
G2 X28.09084 Y181.48083 I-1.51917 J1.18227 E0.100304
G2 X27.75394 Y184.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.75394 Y70.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X30.45537 Y70.51917 I1.51917 J-1.18227 E0.100304
G2 X30.79227 Y67.81773 I-1.18227 J-1.51917 E0.100304
G2 X28.09084 Y67.48083 I-1.51917 J1.18227 E0.100304
G2 X27.75394 Y70.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X126.48083 Y13.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.18227 Y13.51917 I1.51917 J-1.18227 E0.100304
G2 X129.51917 Y10.81773 I-1.18227 J-1.51917 E0.100304
G2 X126.81773 Y10.48083 I-1.51917 J1.18227 E0.100304
G2 X126.48083 Y13.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.20773 Y70.18227 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X227.90916 Y70.51917 I1.51917 J-1.18227 E0.100304
G2 X228.24606 Y67.81773 I-1.18227 J-1.51917 E0.100304
G2 X225.54463 Y67.48083 I-1.51917 J1.18227 E0.100304
G2 X225.20773 Y70.18227 I1.18227 J1.51917 E0.100304
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X236.94325 Y182.62596 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.74825 Y181.89821 E0.024992
G1 X236.26017 Y181.64952 E0.018171
G1 X236.66460 Y183.15887 E0.051834
G1 X236.38484 Y183.68761 E0.019843
G1 X235.77210 Y181.40084 E0.078533
G1 X235.28402 Y181.15215 E0.018171
G1 X236.10397 Y184.21224 E0.105090
G1 X235.82202 Y184.73282 E0.019639
G1 X234.79595 Y180.90346 E0.131508
G1 X234.30787 Y180.65478 E0.018171
G1 X235.53900 Y185.24943 E0.157789
G1 X235.25494 Y185.76213 E0.019443
G1 X233.81979 Y180.40609 E0.183937
G1 X233.33172 Y180.15740 E0.018171
G1 X234.96984 Y186.27094 E0.209951
G1 X234.68371 Y186.77595 E0.019254
G1 X232.84364 Y179.90872 E0.235835
G1 X232.35557 Y179.66003 E0.018171
G1 X234.39659 Y187.27723 E0.261590
G1 X234.10847 Y187.77478 E0.019072
G1 X231.86749 Y179.41134 E0.287217
G1 X231.37942 Y179.16266 E0.018171
G1 X233.81938 Y188.26871 E0.312720
G1 X233.52932 Y188.75902 E0.018898
G1 X230.89134 Y178.91397 E0.338099
G1 X230.40327 Y178.66528 E0.018171
G1 X233.23831 Y189.24579 E0.363356
G1 X232.94636 Y189.72906 E0.018729
G1 X229.91519 Y178.41660 E0.388493
G1 X229.42712 Y178.16791 E0.018171
G1 X232.65349 Y190.20888 E0.413511
G1 X232.35970 Y190.68528 E0.018567
G1 X228.93904 Y177.91922 E0.438412
G1 X228.45097 Y177.67054 E0.018171
G1 X232.06501 Y191.15832 E0.463198
G1 X231.76943 Y191.62803 E0.018409
G1 X227.96289 Y177.42185 E0.487869
G1 X227.47482 Y177.17316 E0.018171
G1 X231.47297 Y192.09447 E0.512428
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y192.46893 E0.304552
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.90912 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.62897 Y178.73494 E0.075092
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
G1 X226.34763 Y179.25780 E0.055216
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
G1 X226.06511 Y179.77623 E0.038451
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
G1 X225.78142 Y180.29034 E0.024467
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
G1 X225.49660 Y180.80019 E0.013268
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
G1 X225.21065 Y181.30586 E0.005195
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 X227.07008 Y189.81819 E0.020181
G1 X225.75212 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.34624 Y182.79835 E0.218317
G1 X224.05597 Y183.28788 E0.018879
G1 X225.53941 Y188.82416 E0.190127
G1 X225.02919 Y188.49281 E0.020181
G1 X223.76466 Y183.77352 E0.162070
G1 X223.47232 Y184.25535 E0.018695
G1 X224.51897 Y188.16147 E0.134144
G1 X224.00874 Y187.83013 E0.020181
G1 X223.17898 Y184.73340 E0.106348
G1 X222.88464 Y185.20774 E0.018518
G1 X223.49852 Y187.49879 E0.078679
G1 X222.98830 Y187.16744 E0.020181
G1 X222.58931 Y185.67840 E0.051137
G1 X222.29302 Y186.14545 E0.018348
G1 X222.47808 Y186.83610 E0.023718
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X133.43210 Y248.66060 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.96485 Y248.12785 E0.024992
G1 X133.93618 Y247.58082 E0.018171
G1 X132.83127 Y248.68574 E0.051834
G1 X132.23348 Y248.70783 E0.019843
G1 X133.90752 Y247.03379 E0.078533
G1 X133.87885 Y246.48676 E0.018171
G1 X131.63871 Y248.72690 E0.105090
G1 X131.04690 Y248.74301 E0.019639
G1 X133.85018 Y245.93973 E0.131508
G1 X133.82151 Y245.39270 E0.018171
G1 X130.45799 Y248.75622 E0.157789
G1 X129.87195 Y248.76657 E0.019443
G1 X133.79284 Y244.84568 E0.183937
G1 X133.76417 Y244.29865 E0.018171
G1 X129.28876 Y248.77406 E0.209951
G1 X128.70834 Y248.77878 E0.019254
G1 X133.73550 Y243.75162 E0.235835
G1 X133.70684 Y243.20459 E0.018171
G1 X128.13066 Y248.78077 E0.261590
G1 X127.55571 Y248.78002 E0.019072
G1 X133.67817 Y242.65756 E0.287217
G1 X133.64950 Y242.11053 E0.018171
G1 X126.98340 Y248.77662 E0.312720
G1 X126.41375 Y248.77058 E0.018898
G1 X133.62083 Y241.56350 E0.338099
G1 X133.59216 Y241.01647 E0.018171
G1 X125.84669 Y248.76195 E0.363356
G1 X125.28219 Y248.75075 E0.018729
G1 X133.56349 Y240.46944 E0.388493
G1 X133.53482 Y239.92242 E0.018171
G1 X124.72022 Y248.73702 E0.413511
G1 X124.16075 Y248.72079 E0.018567
G1 X133.50616 Y239.37539 E0.438412
G1 X133.47749 Y238.82836 E0.018171
G1 X123.60374 Y248.70210 E0.463198
G1 X123.04918 Y248.68097 E0.018409
G1 X133.44882 Y238.28133 E0.487869
G1 X133.42015 Y237.73430 E0.018171
G1 X122.49700 Y248.65745 E0.512428
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y248.56660 E0.304552
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.24144 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.64469 Y237.78267 E0.075092
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
G1 X131.05121 Y237.80045 E0.055216
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
G1 X130.46097 Y237.81499 E0.038451
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
G1 X129.87390 Y237.82637 E0.024467
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
G1 X129.28994 Y237.83463 E0.013268
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
G1 X128.70905 Y237.83982 E0.005195
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 X122.26687 Y243.70630 E0.020181
G1 X125.86761 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X126.98431 Y237.83747 E0.218317
G1 X126.41523 Y237.83085 E0.018879
G1 X122.36239 Y241.88369 E0.190127
G1 X122.39423 Y241.27615 E0.020181
G1 X125.84899 Y237.82139 E0.162070
G1 X125.28555 Y237.80913 E0.018695
G1 X122.42607 Y240.66861 E0.134144
G1 X122.45791 Y240.06108 E0.020181
G1 X124.72487 Y237.79412 E0.106348
G1 X124.16692 Y237.77637 E0.018518
G1 X122.48975 Y239.45354 E0.078679
G1 X122.52159 Y238.84600 E0.020181
G1 X123.61164 Y237.75595 E0.051137
G1 X123.05902 Y237.73287 E0.018348
G1 X122.55343 Y238.23846 E0.023718
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X24.48885 Y192.03464 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.21661 Y192.22964 E0.024992
G1 X25.67601 Y191.93130 E0.018171
G1 X24.16667 Y191.52687 E0.051834
G1 X23.84864 Y191.02021 E0.019843
G1 X26.13542 Y191.63295 E0.078533
G1 X26.59483 Y191.33461 E0.018171
G1 X23.53474 Y190.51466 E0.105090
G1 X23.22488 Y190.01020 E0.019639
G1 X27.05423 Y191.03627 E0.131508
G1 X27.51364 Y190.73793 E0.018171
G1 X22.91899 Y189.50680 E0.157789
G1 X22.61701 Y189.00444 E0.019443
G1 X27.97305 Y190.43959 E0.183937
G1 X28.43245 Y190.14124 E0.018171
G1 X22.31892 Y188.50313 E0.209951
G1 X22.02462 Y188.00283 E0.019254
G1 X28.89186 Y189.84290 E0.235835
G1 X29.35127 Y189.54456 E0.018171
G1 X21.73406 Y187.50354 E0.261590
G1 X21.44724 Y187.00524 E0.019072
G1 X29.81067 Y189.24622 E0.287217
G1 X30.27008 Y188.94787 E0.018171
G1 X21.16403 Y186.50791 E0.312720
G1 X20.88443 Y186.01156 E0.018898
G1 X30.72949 Y188.64953 E0.338099
G1 X31.18889 Y188.35119 E0.018171
G1 X20.60838 Y185.51615 E0.363356
G1 X20.33583 Y185.02168 E0.018729
G1 X31.64830 Y188.05285 E0.388493
G1 X32.10771 Y187.75451 E0.018171
G1 X20.06674 Y184.52814 E0.413511
G1 X19.80106 Y184.03551 E0.018567
G1 X32.56711 Y187.45616 E0.438412
G1 X33.02652 Y187.15782 E0.018171
G1 X19.53874 Y183.54378 E0.463198
G1 X19.27975 Y183.05295 E0.018409
G1 X33.48593 Y186.85948 E0.487869
G1 X33.94533 Y186.56114 E0.018171
G1 X19.02403 Y182.56299 E0.512428
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y182.09767 E0.304552
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.33233 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.01572 Y185.04773 E0.075092
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
G1 X32.70357 Y184.54265 E0.055216
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
G1 X32.39586 Y184.03876 E0.038451
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
G1 X32.09247 Y183.53603 E0.024467
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
G1 X31.79334 Y183.03443 E0.013268
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
G1 X31.49840 Y182.53396 E0.005195
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 X23.19679 Y179.88811 E0.020181
G1 X28.11550 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X30.63807 Y181.03912 E0.218317
G1 X30.35926 Y180.54297 E0.018879
G1 X24.82298 Y179.05953 E0.190127
G1 X25.36504 Y178.78334 E0.020181
G1 X30.08433 Y180.04787 E0.162070
G1 X29.81323 Y179.55378 E0.018695
G1 X25.90710 Y178.50714 E0.134144
G1 X26.44916 Y178.23095 E0.020181
G1 X29.54589 Y179.06071 E0.106348
G1 X29.28228 Y178.56864 E0.018518
G1 X26.99123 Y177.95475 E0.078679
G1 X27.53329 Y177.67856 E0.020181
G1 X29.02233 Y178.07755 E0.051137
G1 X28.76600 Y177.58742 E0.018348
G1 X28.07535 Y177.40236 E0.023718
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X19.05675 Y69.37404 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.25175 Y70.10179 E0.024992
G1 X19.73983 Y70.35048 E0.018171
G1 X19.33540 Y68.84113 E0.051834
G1 X19.61516 Y68.31239 E0.019843
G1 X20.22790 Y70.59916 E0.078533
G1 X20.71598 Y70.84785 E0.018171
G1 X19.89603 Y67.78776 E0.105090
G1 X20.17798 Y67.26718 E0.019639
G1 X21.20405 Y71.09654 E0.131508
G1 X21.69213 Y71.34522 E0.018171
G1 X20.46100 Y66.75057 E0.157789
G1 X20.74506 Y66.23787 E0.019443
G1 X22.18021 Y71.59391 E0.183937
G1 X22.66828 Y71.84260 E0.018171
G1 X21.03016 Y65.72906 E0.209951
G1 X21.31629 Y65.22405 E0.019254
G1 X23.15636 Y72.09128 E0.235835
G1 X23.64443 Y72.33997 E0.018171
G1 X21.60341 Y64.72277 E0.261590
G1 X21.89153 Y64.22522 E0.019072
G1 X24.13251 Y72.58866 E0.287217
G1 X24.62058 Y72.83734 E0.018171
G1 X22.18062 Y63.73129 E0.312720
G1 X22.47068 Y63.24098 E0.018898
G1 X25.10866 Y73.08603 E0.338099
G1 X25.59673 Y73.33472 E0.018171
G1 X22.76169 Y62.75421 E0.363356
G1 X23.05364 Y62.27094 E0.018729
G1 X26.08481 Y73.58340 E0.388493
G1 X26.57288 Y73.83209 E0.018171
G1 X23.34651 Y61.79112 E0.413511
G1 X23.64030 Y61.31472 E0.018567
G1 X27.06096 Y74.08078 E0.438412
G1 X27.54903 Y74.32946 E0.018171
G1 X23.93499 Y60.84168 E0.463198
G1 X24.23057 Y60.37197 E0.018409
G1 X28.03711 Y74.57815 E0.487869
G1 X28.52518 Y74.82684 E0.018171
G1 X24.52703 Y59.90553 E0.512428
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y59.53107 E0.304552
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.09088 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.37103 Y73.26506 E0.075092
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
G1 X29.65237 Y72.74220 E0.055216
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
G1 X29.93489 Y72.22377 E0.038451
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
G1 X30.21858 Y71.70966 E0.024467
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
G1 X30.50340 Y71.19981 E0.013268
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
G1 X30.78935 Y70.69414 E0.005195
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 X28.92992 Y62.18181 E0.020181
G1 X30.24788 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.65376 Y69.20165 E0.218317
G1 X31.94403 Y68.71212 E0.018879
G1 X30.46059 Y63.17584 E0.190127
G1 X30.97081 Y63.50719 E0.020181
G1 X32.23534 Y68.22648 E0.162070
G1 X32.52768 Y67.74465 E0.018695
G1 X31.48103 Y63.83853 E0.134144
G1 X31.99126 Y64.16987 E0.020181
G1 X32.82102 Y67.26660 E0.106348
G1 X33.11536 Y66.79226 E0.018518
G1 X32.50148 Y64.50121 E0.078679
G1 X33.01170 Y64.83256 E0.020181
G1 X33.41069 Y66.32160 E0.051137
G1 X33.70698 Y65.85455 E0.018348
G1 X33.52192 Y65.16390 E0.023718
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X122.56790 Y3.33940 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.03515 Y3.87215 E0.024992
G1 X122.06382 Y4.41918 E0.018171
G1 X123.16873 Y3.31426 E0.051834
G1 X123.76652 Y3.29217 E0.019843
G1 X122.09248 Y4.96621 E0.078533
G1 X122.12115 Y5.51324 E0.018171
G1 X124.36129 Y3.27310 E0.105090
G1 X124.95310 Y3.25699 E0.019639
G1 X122.14982 Y6.06027 E0.131508
G1 X122.17849 Y6.60730 E0.018171
G1 X125.54201 Y3.24378 E0.157789
G1 X126.12805 Y3.23343 E0.019443
G1 X122.20716 Y7.15432 E0.183937
G1 X122.23583 Y7.70135 E0.018171
G1 X126.71124 Y3.22594 E0.209951
G1 X127.29166 Y3.22122 E0.019254
G1 X122.26450 Y8.24838 E0.235835
G1 X122.29316 Y8.79541 E0.018171
G1 X127.86934 Y3.21923 E0.261590
G1 X128.44429 Y3.21998 E0.019072
G1 X122.32183 Y9.34244 E0.287217
G1 X122.35050 Y9.88947 E0.018171
G1 X129.01660 Y3.22338 E0.312720
G1 X129.58625 Y3.22942 E0.018898
G1 X122.37917 Y10.43650 E0.338099
G1 X122.40784 Y10.98353 E0.018171
G1 X130.15331 Y3.23805 E0.363356
G1 X130.71781 Y3.24925 E0.018729
G1 X122.43651 Y11.53056 E0.388493
G1 X122.46518 Y12.07758 E0.018171
G1 X131.27978 Y3.26298 E0.413511
G1 X131.83925 Y3.27921 E0.018567
G1 X122.49384 Y12.62461 E0.438412
G1 X122.52251 Y13.17164 E0.018171
G1 X132.39626 Y3.29790 E0.463198
G1 X132.95082 Y3.31903 E0.018409
G1 X122.55118 Y13.71867 E0.487869
G1 X122.57985 Y14.26570 E0.018171
G1 X133.50300 Y3.34255 E0.512428
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y3.43340 E0.304552
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.75856 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.35531 Y14.21733 E0.075092
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
G1 X124.94879 Y14.19955 E0.055216
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
G1 X125.53903 Y14.18501 E0.038451
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
G1 X126.12610 Y14.17363 E0.024467
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
G1 X126.71006 Y14.16537 E0.013268
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
G1 X127.29095 Y14.16018 E0.005195
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 X133.73313 Y8.29370 E0.020181
G1 X130.13239 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X129.01569 Y14.16253 E0.218317
G1 X129.58477 Y14.16915 E0.018879
G1 X133.63761 Y10.11631 E0.190127
G1 X133.60577 Y10.72385 E0.020181
G1 X130.15101 Y14.17861 E0.162070
G1 X130.71445 Y14.19087 E0.018695
G1 X133.57393 Y11.33139 E0.134144
G1 X133.54209 Y11.93892 E0.020181
G1 X131.27513 Y14.20588 E0.106348
G1 X131.83308 Y14.22363 E0.018518
G1 X133.51025 Y12.54646 E0.078679
G1 X133.47841 Y13.15400 E0.020181
G1 X132.38836 Y14.24405 E0.051137
G1 X132.94098 Y14.26713 E0.018348
G1 X133.44657 Y13.76154 E0.023718
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X231.51115 Y59.96536 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.78339 Y59.77036 E0.024992
G1 X230.32399 Y60.06870 E0.018171
G1 X231.83333 Y60.47313 E0.051834
G1 X232.15136 Y60.97979 E0.019843
G1 X229.86458 Y60.36705 E0.078533
G1 X229.40517 Y60.66539 E0.018171
G1 X232.46526 Y61.48534 E0.105090
G1 X232.77512 Y61.98980 E0.019639
G1 X228.94577 Y60.96373 E0.131508
G1 X228.48636 Y61.26207 E0.018171
G1 X233.08101 Y62.49320 E0.157789
G1 X233.38299 Y62.99556 E0.019443
G1 X228.02695 Y61.56041 E0.183937
G1 X227.56755 Y61.85876 E0.018171
G1 X233.68108 Y63.49687 E0.209951
G1 X233.97538 Y63.99717 E0.019254
G1 X227.10814 Y62.15710 E0.235835
G1 X226.64873 Y62.45544 E0.018171
G1 X234.26594 Y64.49646 E0.261590
G1 X234.55276 Y64.99476 E0.019072
G1 X226.18933 Y62.75378 E0.287217
G1 X225.72992 Y63.05213 E0.018171
G1 X234.83597 Y65.49209 E0.312720
G1 X235.11557 Y65.98844 E0.018898
G1 X225.27051 Y63.35047 E0.338099
G1 X224.81111 Y63.64881 E0.018171
G1 X235.39162 Y66.48385 E0.363356
G1 X235.66417 Y66.97832 E0.018729
G1 X224.35170 Y63.94715 E0.388493
G1 X223.89229 Y64.24549 E0.018171
G1 X235.93326 Y67.47186 E0.413511
G1 X236.19894 Y67.96449 E0.018567
G1 X223.43289 Y64.54384 E0.438412
G1 X222.97348 Y64.84218 E0.018171
G1 X236.46126 Y68.45622 E0.463198
G1 X236.72025 Y68.94705 E0.018409
G1 X222.51407 Y65.14052 E0.487869
G1 X222.05467 Y65.43886 E0.018171
G1 X236.97597 Y69.43701 E0.512428
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y69.90233 E0.304552
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.66767 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.98428 Y66.95227 E0.075092
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
G1 X223.29643 Y67.45735 E0.055216
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
G1 X223.60414 Y67.96124 E0.038451
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
G1 X223.90753 Y68.46397 E0.024467
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
G1 X224.20666 Y68.96557 E0.013268
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
G1 X224.50160 Y69.46604 E0.005195
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 X232.80321 Y72.11189 E0.020181
G1 X227.88450 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X225.36193 Y70.96088 E0.218317
G1 X225.64074 Y71.45703 E0.018879
G1 X231.17702 Y72.94047 E0.190127
G1 X230.63496 Y73.21666 E0.020181
G1 X225.91567 Y71.95213 E0.162070
G1 X226.18677 Y72.44622 E0.018695
G1 X230.09290 Y73.49286 E0.134144
G1 X229.55084 Y73.76905 E0.020181
G1 X226.45411 Y72.93929 E0.106348
G1 X226.71772 Y73.43136 E0.018518
G1 X229.00877 Y74.04525 E0.078679
G1 X228.46671 Y74.32144 E0.020181
G1 X226.97767 Y73.92245 E0.051137
G1 X227.23400 Y74.41258 E0.018348
G1 X227.92465 Y74.59764 E0.023718
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z3.400 F1200
G1 X30.30774 Y202.02754 F12000
G1 Z3.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X51.97246 Y28.30774 I97.69226 J-76.02754 E5.974872
G3 X225.69226 Y49.97246 I76.02754 J97.69226 E5.974872
G3 X204.02754 Y223.69226 I-97.69226 J76.02754 E5.974872
G3 X30.30774 Y202.02754 I-76.02754 J-97.69226 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X146.64836 Y15.93656 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X17.93656 Y107.35164 I-18.64836 J110.06344 E5.816723
G2 X109.35164 Y236.06344 I110.06344 J18.64836 E5.816723
G2 X238.06344 Y144.64836 I18.64836 J-110.06344 E5.816723
G2 X146.64836 Y15.93656 I-110.06344 J-18.64836 E5.816723
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X146.58036 Y16.33792 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X18.33792 Y107.41964 I-18.58036 J109.66208 E5.795511
G2 X109.41964 Y235.66208 I109.66208 J18.58036 E5.795511
G2 X237.66208 Y144.58036 I18.58036 J-109.66208 E5.795511
G2 X146.58036 Y16.33792 I-109.66208 J-18.58036 E5.795511
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X148.54587 Y4.73742 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X249.26258 Y146.54587 I-20.54587 J121.26258 E6.408584
G3 X107.45413 Y247.26258 I-121.26258 J-20.54587 E6.408584
G3 X6.73742 Y105.45413 I20.54587 J-121.26258 E6.408584
G3 X148.54587 Y4.73742 I121.26258 J20.54587 E6.408584
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X148.61387 Y4.33606 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X249.66394 Y146.61387 I-20.61387 J121.66394 E6.429796
G3 X107.38613 Y247.66394 I-121.66394 J-20.61387 E6.429796
G3 X6.33606 Y105.38613 I20.61387 J-121.66394 E6.429796
G3 X148.61387 Y4.33606 I121.66394 J20.61387 E6.429796
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.04847 Y181.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X224.82895 Y182.67842 I-0.32158 J1.89795 E0.100304
G2 X226.40532 Y184.89795 I1.89795 J0.32158 E0.100304
G2 X228.62485 Y183.32158 I0.32158 J-1.89795 E0.100304
G2 X227.04847 Y181.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.32158 Y238.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X126.10205 Y239.67842 I-0.32158 J1.89795 E0.100304
G2 X127.67842 Y241.89795 I1.89795 J0.32158 E0.100304
G2 X129.89795 Y240.32158 I0.32158 J-1.89795 E0.100304
G2 X128.32158 Y238.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X29.59468 Y181.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X27.37515 Y182.67842 I-0.32158 J1.89795 E0.100304
G2 X28.95153 Y184.89795 I1.89795 J0.32158 E0.100304
G2 X31.17105 Y183.32158 I0.32158 J-1.89795 E0.100304
G2 X29.59468 Y181.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X29.59468 Y67.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X27.37515 Y68.67842 I-0.32158 J1.89795 E0.100304
G2 X28.95153 Y70.89795 I1.89795 J0.32158 E0.100304
G2 X31.17105 Y69.32158 I0.32158 J-1.89795 E0.100304
G2 X29.59468 Y67.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.32158 Y10.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X126.10205 Y11.67842 I-0.32158 J1.89795 E0.100304
G2 X127.67842 Y13.89795 I1.89795 J0.32158 E0.100304
G2 X129.89795 Y12.32158 I0.32158 J-1.89795 E0.100304
G2 X128.32158 Y10.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.04847 Y67.10205 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X224.82895 Y68.67842 I-0.32158 J1.89795 E0.100304
G2 X226.40532 Y70.89795 I1.89795 J0.32158 E0.100304
G2 X228.62485 Y69.32158 I0.32158 J-1.89795 E0.100304
G2 X227.04847 Y67.10205 I-1.89795 J-0.32158 E0.100304
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.92465 Y177.40236 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.23400 Y177.58742 E0.023718
G1 X226.97767 Y178.07755 E0.018348
G1 X228.46671 Y177.67856 E0.051137
G1 X229.00877 Y177.95475 E0.020181
G1 X226.71772 Y178.56864 E0.078679
G1 X226.45411 Y179.06071 E0.018518
G1 X229.55084 Y178.23095 E0.106348
G1 X230.09290 Y178.50714 E0.020181
G1 X226.18677 Y179.55378 E0.134144
G1 X225.91567 Y180.04787 E0.018695
G1 X230.63496 Y178.78334 E0.162070
G1 X231.17702 Y179.05953 E0.020181
G1 X225.64074 Y180.54297 E0.190127
G1 X225.36193 Y181.03912 E0.018879
G1 X231.71909 Y179.33573 E0.218317
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X225.20507 Y181.50259 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.29613 Y180.94229 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y179.61192 E0.170509
G1 X232.80321 Y179.88811 E0.020181
G1 X227.88450 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X224.65287 Y182.49343 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.50160 Y182.53396 E0.005195
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
G1 X224.20666 Y183.03443 E0.013268
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
G1 X223.90753 Y183.53603 E0.024467
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
G1 X223.60414 Y184.03876 E0.038451
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
G1 X223.29643 Y184.54265 E0.055216
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
G1 X222.98428 Y185.04773 E0.075092
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
G1 X222.66767 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.63657 Y183.95464 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X226.12617 Y185.04874 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.27151 Y184.47390 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y182.09767 E0.304552
G1 X236.97597 Y182.56299 E0.016363
G1 X222.05467 Y186.56114 E0.512428
G1 X222.51407 Y186.85948 E0.018171
G1 X236.72025 Y183.05295 E0.487869
G1 X236.46126 Y183.54378 E0.018409
G1 X222.97348 Y187.15782 E0.463198
G1 X223.43289 Y187.45616 E0.018171
G1 X236.19894 Y184.03551 E0.438412
G1 X235.93326 Y184.52814 E0.018567
G1 X223.89229 Y187.75451 E0.413511
G1 X224.35170 Y188.05285 E0.018171
G1 X235.66417 Y185.02168 E0.388493
G1 X235.39162 Y185.51615 E0.018729
G1 X224.81111 Y188.35119 E0.363356
G1 X225.27051 Y188.64953 E0.018171
G1 X235.11557 Y186.01156 E0.338099
G1 X234.83597 Y186.50791 E0.018898
G1 X225.72992 Y188.94787 E0.312720
G1 X226.18933 Y189.24622 E0.018171
G1 X234.55276 Y187.00524 E0.287217
G1 X234.26594 Y187.50354 E0.019072
G1 X226.64873 Y189.54456 E0.261590
G1 X227.10814 Y189.84290 E0.018171
G1 X233.97538 Y188.00283 E0.235835
G1 X233.68108 Y188.50313 E0.019254
G1 X227.56755 Y190.14124 E0.209951
G1 X228.02695 Y190.43959 E0.018171
G1 X233.38299 Y189.00444 E0.183937
G1 X233.08101 Y189.50680 E0.019443
G1 X228.48636 Y190.73793 E0.157789
G1 X228.94577 Y191.03627 E0.018171
G1 X232.77512 Y190.01020 E0.131508
G1 X232.46526 Y190.51466 E0.019639
G1 X229.40517 Y191.33461 E0.105090
G1 X229.86458 Y191.63295 E0.018171
G1 X232.15136 Y191.02021 E0.078533
G1 X231.83333 Y191.52687 E0.019843
G1 X230.32399 Y191.93130 E0.051834
G1 X230.78339 Y192.22964 E0.018171
G1 X231.51115 Y192.03464 E0.024992
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X133.44657 Y238.23846 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.94098 Y237.73287 E0.023718
G1 X132.38836 Y237.75595 E0.018348
G1 X133.47841 Y238.84600 E0.051137
G1 X133.51025 Y239.45354 E0.020181
G1 X131.83308 Y237.77637 E0.078679
G1 X131.27513 Y237.79412 E0.018518
G1 X133.54209 Y240.06108 E0.106348
G1 X133.57393 Y240.66861 E0.020181
G1 X130.71445 Y237.80913 E0.134144
G1 X130.15101 Y237.82139 E0.018695
G1 X133.60577 Y241.27615 E0.162070
G1 X133.63761 Y241.88369 E0.020181
G1 X129.58477 Y237.83085 E0.190127
G1 X129.01569 Y237.83747 E0.018879
G1 X133.66945 Y242.49123 E0.218317
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.53588 Y237.93336 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X130.06664 Y239.46412 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y243.09876 E0.170509
G1 X133.73313 Y243.70630 E0.020181
G1 X130.13239 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X127.40169 Y237.95056 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.29095 Y237.83982 E0.005195
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
G1 X126.71006 Y237.83463 E0.013268
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
G1 X126.12610 Y237.82637 E0.024467
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
G1 X125.53903 Y237.81499 E0.038451
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
G1 X124.94879 Y237.80045 E0.055216
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
G1 X124.35531 Y237.78267 E0.075092
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
G1 X123.75856 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.12809 Y242.13115 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X125.92538 Y240.50413 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X127.49587 Y242.07462 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y248.56660 E0.304552
G1 X133.50300 Y248.65745 E0.016363
G1 X122.57985 Y237.73430 E0.512428
G1 X122.55118 Y238.28133 E0.018171
G1 X132.95082 Y248.68097 E0.487869
G1 X132.39626 Y248.70210 E0.018409
G1 X122.52251 Y238.82836 E0.463198
G1 X122.49384 Y239.37539 E0.018171
G1 X131.83925 Y248.72079 E0.438412
G1 X131.27978 Y248.73702 E0.018567
G1 X122.46518 Y239.92242 E0.413511
G1 X122.43651 Y240.46944 E0.018171
G1 X130.71781 Y248.75075 E0.388493
G1 X130.15331 Y248.76195 E0.018729
G1 X122.40784 Y241.01647 E0.363356
G1 X122.37917 Y241.56350 E0.018171
G1 X129.58625 Y248.77058 E0.338099
G1 X129.01660 Y248.77662 E0.018898
G1 X122.35050 Y242.11053 E0.312720
G1 X122.32183 Y242.65756 E0.018171
G1 X128.44429 Y248.78002 E0.287217
G1 X127.86934 Y248.78077 E0.019072
G1 X122.29316 Y243.20459 E0.261590
G1 X122.26450 Y243.75162 E0.018171
G1 X127.29166 Y248.77878 E0.235835
G1 X126.71124 Y248.77406 E0.019254
G1 X122.23583 Y244.29865 E0.209951
G1 X122.20716 Y244.84568 E0.018171
G1 X126.12805 Y248.76657 E0.183937
G1 X125.54201 Y248.75622 E0.019443
G1 X122.17849 Y245.39270 E0.157789
G1 X122.14982 Y245.93973 E0.018171
G1 X124.95310 Y248.74301 E0.131508
G1 X124.36129 Y248.72690 E0.019639
G1 X122.12115 Y246.48676 E0.105090
G1 X122.09248 Y247.03379 E0.018171
G1 X123.76652 Y248.70783 E0.078533
G1 X123.16873 Y248.68574 E0.019843
G1 X122.06382 Y247.58082 E0.051834
G1 X122.03515 Y248.12785 E0.018171
G1 X122.56790 Y248.66060 E0.024992
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X33.52192 Y186.83610 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.70698 Y186.14545 E0.023718
G1 X33.41069 Y185.67840 E0.018348
G1 X33.01170 Y187.16744 E0.051137
G1 X32.50148 Y187.49879 E0.020181
G1 X33.11536 Y185.20774 E0.078679
G1 X32.82102 Y184.73340 E0.018518
G1 X31.99126 Y187.83013 E0.106348
G1 X31.48103 Y188.16147 E0.020181
G1 X32.52768 Y184.25535 E0.134144
G1 X32.23534 Y183.77352 E0.018695
G1 X30.97081 Y188.49281 E0.162070
G1 X30.46059 Y188.82416 E0.020181
G1 X31.94403 Y183.28788 E0.190127
G1 X31.65376 Y182.79835 E0.018879
G1 X29.95036 Y189.15550 E0.218317
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X31.33081 Y182.43077 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X30.77051 Y184.52182 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y189.48684 E0.170509
G1 X28.92992 Y189.81819 E0.020181
G1 X30.24788 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X30.74882 Y181.45713 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.78935 Y181.30586 E0.005195
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
G1 X30.50340 Y180.80019 E0.013268
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
G1 X30.21858 Y180.29034 E0.024467
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
G1 X29.93489 Y179.77623 E0.038451
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
G1 X29.65237 Y179.25780 E0.055216
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
G1 X29.37103 Y178.73494 E0.075092
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
G1 X29.09088 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.49152 Y184.17651 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.79920 Y181.45539 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.22436 Y183.60072 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y192.46893 E0.304552
G1 X24.52703 Y192.09447 E0.016363
G1 X28.52518 Y177.17316 E0.512428
G1 X28.03711 Y177.42185 E0.018171
G1 X24.23057 Y191.62803 E0.487869
G1 X23.93499 Y191.15832 E0.018409
G1 X27.54903 Y177.67054 E0.463198
G1 X27.06096 Y177.91922 E0.018171
G1 X23.64030 Y190.68528 E0.438412
G1 X23.34651 Y190.20888 E0.018567
G1 X26.57288 Y178.16791 E0.413511
G1 X26.08481 Y178.41660 E0.018171
G1 X23.05364 Y189.72906 E0.388493
G1 X22.76169 Y189.24579 E0.018729
G1 X25.59673 Y178.66528 E0.363356
G1 X25.10866 Y178.91397 E0.018171
G1 X22.47068 Y188.75902 E0.338099
G1 X22.18062 Y188.26871 E0.018898
G1 X24.62058 Y179.16266 E0.312720
G1 X24.13251 Y179.41134 E0.018171
G1 X21.89153 Y187.77478 E0.287217
G1 X21.60341 Y187.27723 E0.019072
G1 X23.64443 Y179.66003 E0.261590
G1 X23.15636 Y179.90872 E0.018171
G1 X21.31629 Y186.77595 E0.235835
G1 X21.03016 Y186.27094 E0.019254
G1 X22.66828 Y180.15740 E0.209951
G1 X22.18021 Y180.40609 E0.018171
G1 X20.74506 Y185.76213 E0.183937
G1 X20.46100 Y185.24943 E0.019443
G1 X21.69213 Y180.65478 E0.157789
G1 X21.20405 Y180.90346 E0.018171
G1 X20.17798 Y184.73282 E0.131508
G1 X19.89603 Y184.21224 E0.019639
G1 X20.71598 Y181.15215 E0.105090
G1 X20.22790 Y181.40084 E0.018171
G1 X19.61516 Y183.68761 E0.078533
G1 X19.33540 Y183.15887 E0.019843
G1 X19.73983 Y181.64952 E0.051834
G1 X19.25175 Y181.89821 E0.018171
G1 X19.05675 Y182.62596 E0.024992
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.07535 Y74.59764 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.76600 Y74.41258 E0.023718
G1 X29.02233 Y73.92245 E0.018348
G1 X27.53329 Y74.32144 E0.051137
G1 X26.99123 Y74.04525 E0.020181
G1 X29.28228 Y73.43136 E0.078679
G1 X29.54589 Y72.93929 E0.018518
G1 X26.44916 Y73.76905 E0.106348
G1 X25.90710 Y73.49286 E0.020181
G1 X29.81323 Y72.44622 E0.134144
G1 X30.08433 Y71.95213 E0.018695
G1 X25.36504 Y73.21666 E0.162070
G1 X24.82298 Y72.94047 E0.020181
G1 X30.35926 Y71.45703 E0.190127
G1 X30.63807 Y70.96088 E0.018879
G1 X24.28091 Y72.66427 E0.218317
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X30.79493 Y70.49741 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.70387 Y71.05771 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y72.38808 E0.170509
G1 X23.19679 Y72.11189 E0.020181
G1 X28.11550 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X31.34713 Y69.50657 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.49840 Y69.46604 E0.005195
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
G1 X31.79334 Y68.96557 E0.013268
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
G1 X32.09247 Y68.46397 E0.024467
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
G1 X32.39586 Y67.96124 E0.038451
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
G1 X32.70357 Y67.45735 E0.055216
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
G1 X33.01572 Y66.95227 E0.075092
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
G1 X33.33233 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.36343 Y68.04536 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X29.87383 Y66.95126 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X27.72849 Y67.52610 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y69.90233 E0.304552
G1 X19.02403 Y69.43701 E0.016363
G1 X33.94533 Y65.43886 E0.512428
G1 X33.48593 Y65.14052 E0.018171
G1 X19.27975 Y68.94705 E0.487869
G1 X19.53874 Y68.45622 E0.018409
G1 X33.02652 Y64.84218 E0.463198
G1 X32.56711 Y64.54384 E0.018171
G1 X19.80106 Y67.96449 E0.438412
G1 X20.06674 Y67.47186 E0.018567
G1 X32.10771 Y64.24549 E0.413511
G1 X31.64830 Y63.94715 E0.018171
G1 X20.33583 Y66.97832 E0.388493
G1 X20.60838 Y66.48385 E0.018729
G1 X31.18889 Y63.64881 E0.363356
G1 X30.72949 Y63.35047 E0.018171
G1 X20.88443 Y65.98844 E0.338099
G1 X21.16403 Y65.49209 E0.018898
G1 X30.27008 Y63.05213 E0.312720
G1 X29.81067 Y62.75378 E0.018171
G1 X21.44724 Y64.99476 E0.287217
G1 X21.73406 Y64.49646 E0.019072
G1 X29.35127 Y62.45544 E0.261590
G1 X28.89186 Y62.15710 E0.018171
G1 X22.02462 Y63.99717 E0.235835
G1 X22.31892 Y63.49687 E0.019254
G1 X28.43245 Y61.85876 E0.209951
G1 X27.97305 Y61.56041 E0.018171
G1 X22.61701 Y62.99556 E0.183937
G1 X22.91899 Y62.49320 E0.019443
G1 X27.51364 Y61.26207 E0.157789
G1 X27.05423 Y60.96373 E0.018171
G1 X23.22488 Y61.98980 E0.131508
G1 X23.53474 Y61.48534 E0.019639
G1 X26.59483 Y60.66539 E0.105090
G1 X26.13542 Y60.36705 E0.018171
G1 X23.84864 Y60.97979 E0.078533
G1 X24.16667 Y60.47313 E0.019843
G1 X25.67601 Y60.06870 E0.051834
G1 X25.21661 Y59.77036 E0.018171
G1 X24.48885 Y59.96536 E0.024992
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X122.55343 Y13.76154 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.05902 Y14.26713 E0.023718
G1 X123.61164 Y14.24405 E0.018348
G1 X122.52159 Y13.15400 E0.051137
G1 X122.48975 Y12.54646 E0.020181
G1 X124.16692 Y14.22363 E0.078679
G1 X124.72487 Y14.20588 E0.018518
G1 X122.45791 Y11.93892 E0.106348
G1 X122.42607 Y11.33139 E0.020181
G1 X125.28555 Y14.19087 E0.134144
G1 X125.84899 Y14.17861 E0.018695
G1 X122.39423 Y10.72385 E0.162070
G1 X122.36239 Y10.11631 E0.020181
G1 X126.41523 Y14.16915 E0.190127
G1 X126.98431 Y14.16253 E0.018879
G1 X122.33055 Y9.50877 E0.218317
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X127.46412 Y14.06664 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X125.93336 Y12.53588 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y8.90124 E0.170509
G1 X122.26687 Y8.29370 E0.020181
G1 X125.86761 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.59831 Y14.04944 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.70905 Y14.16018 E0.005195
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
G1 X129.28994 Y14.16537 E0.013268
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
G1 X129.87390 Y14.17363 E0.024467
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
G1 X130.46097 Y14.18501 E0.038451
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
G1 X131.05121 Y14.19955 E0.055216
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
G1 X131.64469 Y14.21733 E0.075092
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
G1 X132.24144 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X127.87191 Y9.86885 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X130.07462 Y11.49587 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X128.50413 Y9.92538 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y3.43340 E0.304552
G1 X122.49700 Y3.34255 E0.016363
G1 X133.42015 Y14.26570 E0.512428
G1 X133.44882 Y13.71867 E0.018171
G1 X123.04918 Y3.31903 E0.487869
G1 X123.60374 Y3.29790 E0.018409
G1 X133.47749 Y13.17164 E0.463198
G1 X133.50616 Y12.62461 E0.018171
G1 X124.16075 Y3.27921 E0.438412
G1 X124.72022 Y3.26298 E0.018567
G1 X133.53482 Y12.07758 E0.413511
G1 X133.56349 Y11.53056 E0.018171
G1 X125.28219 Y3.24925 E0.388493
G1 X125.84669 Y3.23805 E0.018729
G1 X133.59216 Y10.98353 E0.363356
G1 X133.62083 Y10.43650 E0.018171
G1 X126.41375 Y3.22942 E0.338099
G1 X126.98340 Y3.22338 E0.018898
G1 X133.64950 Y9.88947 E0.312720
G1 X133.67817 Y9.34244 E0.018171
G1 X127.55571 Y3.21998 E0.287217
G1 X128.13066 Y3.21923 E0.019072
G1 X133.70684 Y8.79541 E0.261590
G1 X133.73550 Y8.24838 E0.018171
G1 X128.70834 Y3.22122 E0.235835
G1 X129.28876 Y3.22594 E0.019254
G1 X133.76417 Y7.70135 E0.209951
G1 X133.79284 Y7.15432 E0.018171
G1 X129.87195 Y3.23343 E0.183937
G1 X130.45799 Y3.24378 E0.019443
G1 X133.82151 Y6.60730 E0.157789
G1 X133.85018 Y6.06027 E0.018171
G1 X131.04690 Y3.25699 E0.131508
G1 X131.63871 Y3.27310 E0.019639
G1 X133.87885 Y5.51324 E0.105090
G1 X133.90752 Y4.96621 E0.018171
G1 X132.23348 Y3.29217 E0.078533
G1 X132.83127 Y3.31426 E0.019843
G1 X133.93618 Y4.41918 E0.051834
G1 X133.96485 Y3.87215 E0.018171
G1 X133.43210 Y3.33940 E0.024992
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X222.47808 Y65.16390 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.29302 Y65.85455 E0.023718
G1 X222.58931 Y66.32160 E0.018348
G1 X222.98830 Y64.83256 E0.051137
G1 X223.49852 Y64.50121 E0.020181
G1 X222.88464 Y66.79226 E0.078679
G1 X223.17898 Y67.26660 E0.018518
G1 X224.00874 Y64.16987 E0.106348
G1 X224.51897 Y63.83853 E0.020181
G1 X223.47232 Y67.74465 E0.134144
G1 X223.76466 Y68.22648 E0.018695
G1 X225.02919 Y63.50719 E0.162070
G1 X225.53941 Y63.17584 E0.020181
G1 X224.05597 Y68.71212 E0.190127
G1 X224.34624 Y69.20165 E0.018879
G1 X226.04964 Y62.84450 E0.218317
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X224.66919 Y69.56923 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X225.22949 Y67.47818 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y62.51316 E0.170509
G1 X227.07008 Y62.18181 E0.020181
G1 X225.75212 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X225.25118 Y70.54287 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.21065 Y70.69414 E0.005195
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
G1 X225.49660 Y71.19981 E0.013268
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
G1 X225.78142 Y71.70966 E0.024467
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
G1 X226.06511 Y72.22377 E0.038451
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
G1 X226.34763 Y72.74220 E0.055216
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
G1 X226.62897 Y73.26506 E0.075092
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
G1 X226.90912 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.50848 Y67.82349 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.20080 Y70.54461 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X228.77564 Y68.39928 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y59.53107 E0.304552
G1 X231.47297 Y59.90553 E0.016363
G1 X227.47482 Y74.82684 E0.512428
G1 X227.96289 Y74.57815 E0.018171
G1 X231.76943 Y60.37197 E0.487869
G1 X232.06501 Y60.84168 E0.018409
G1 X228.45097 Y74.32946 E0.463198
G1 X228.93904 Y74.08078 E0.018171
G1 X232.35970 Y61.31472 E0.438412
G1 X232.65349 Y61.79112 E0.018567
G1 X229.42712 Y73.83209 E0.413511
G1 X229.91519 Y73.58340 E0.018171
G1 X232.94636 Y62.27094 E0.388493
G1 X233.23831 Y62.75421 E0.018729
G1 X230.40327 Y73.33472 E0.363356
G1 X230.89134 Y73.08603 E0.018171
G1 X233.52932 Y63.24098 E0.338099
G1 X233.81938 Y63.73129 E0.018898
G1 X231.37942 Y72.83734 E0.312720
G1 X231.86749 Y72.58866 E0.018171
G1 X234.10847 Y64.22522 E0.287217
G1 X234.39659 Y64.72277 E0.019072
G1 X232.35557 Y72.33997 E0.261590
G1 X232.84364 Y72.09128 E0.018171
G1 X234.68371 Y65.22405 E0.235835
G1 X234.96984 Y65.72906 E0.019254
G1 X233.33172 Y71.84260 E0.209951
G1 X233.81979 Y71.59391 E0.018171
G1 X235.25494 Y66.23787 E0.183937
G1 X235.53900 Y66.75057 E0.019443
G1 X234.30787 Y71.34522 E0.157789
G1 X234.79595 Y71.09654 E0.018171
G1 X235.82202 Y67.26718 E0.131508
G1 X236.10397 Y67.78776 E0.019639
G1 X235.28402 Y70.84785 E0.105090
G1 X235.77210 Y70.59916 E0.018171
G1 X236.38484 Y68.31239 E0.078533
G1 X236.66460 Y68.84113 E0.019843
G1 X236.26017 Y70.35048 E0.051834
G1 X236.74825 Y70.10179 E0.018171
G1 X236.94325 Y69.37404 E0.024992
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z3.600 F1200
G1 X148.67937 Y3.94949 F12000
G1 Z3.200 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X250.05051 Y146.67937 I-20.67937 J122.05051 E5.974872
G3 X107.32063 Y248.05051 I-122.05051 J-20.67937 E5.974872
G3 X5.94949 Y105.32063 I20.67937 J-122.05051 E5.974872
G3 X148.67937 Y3.94949 I122.05051 J20.67937 E5.974872
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
; ZIGZAG_CORE
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X188.59606 Y219.75414 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X221.75414 Y65.40394 I-60.59606 J-93.75414 E5.816723
G2 X67.40394 Y32.24586 I-93.75414 J60.59606 E5.816723
G2 X34.24586 Y186.59606 I60.59606 J93.75414 E5.816723
G2 X188.59606 Y219.75414 I93.75414 J-60.59606 E5.816723
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X188.37509 Y219.41225 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X221.41225 Y65.62491 I-60.37509 J-93.41225 E5.795511
G2 X67.62491 Y32.58775 I-93.41225 J60.37509 E5.795511
G2 X34.58775 Y186.37509 I60.37509 J93.41225 E5.795511
G2 X188.37509 Y219.41225 I93.41225 J-60.37509 E5.795511
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X194.76182 Y229.29379 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X24.70621 Y192.76182 I-66.76182 J-103.29379 E6.408584
G3 X61.23818 Y22.70621 I103.29379 J-66.76182 E6.408584
G3 X231.29379 Y59.23818 I66.76182 J103.29379 E6.408584
G3 X194.76182 Y229.29379 I-103.29379 J66.76182 E6.408584
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X194.98279 Y229.63567 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X24.36433 Y192.98279 I-66.98279 J-103.63567 E6.429796
G3 X61.01721 Y22.36433 I103.63567 J-66.98279 E6.429796
G3 X231.63567 Y59.01721 I66.98279 J103.63567 E6.429796
G3 X194.98279 Y229.63567 I-103.63567 J66.98279 E6.429796
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.77182 Y184.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X228.34361 Y181.95507 I-1.04493 J-1.61671 E0.100304
G2 X225.68197 Y181.38329 I-1.61671 J1.04493 E0.100304
G2 X225.11019 Y184.04493 I1.04493 J1.61671 E0.100304
G2 X227.77182 Y184.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.04493 Y241.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.61671 Y238.95507 I-1.04493 J-1.61671 E0.100304
G2 X126.95507 Y238.38329 I-1.61671 J1.04493 E0.100304
G2 X126.38329 Y241.04493 I1.04493 J1.61671 E0.100304
G2 X129.04493 Y241.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.31803 Y184.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X30.88981 Y181.95507 I-1.04493 J-1.61671 E0.100304
G2 X28.22818 Y181.38329 I-1.61671 J1.04493 E0.100304
G2 X27.65639 Y184.04493 I1.04493 J1.61671 E0.100304
G2 X30.31803 Y184.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.31803 Y70.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X30.88981 Y67.95507 I-1.04493 J-1.61671 E0.100304
G2 X28.22818 Y67.38329 I-1.61671 J1.04493 E0.100304
G2 X27.65639 Y70.04493 I1.04493 J1.61671 E0.100304
G2 X30.31803 Y70.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X129.04493 Y13.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.61671 Y10.95507 I-1.04493 J-1.61671 E0.100304
G2 X126.95507 Y10.38329 I-1.61671 J1.04493 E0.100304
G2 X126.38329 Y13.04493 I1.04493 J1.61671 E0.100304
G2 X129.04493 Y13.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.77182 Y70.61671 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X228.34361 Y67.95507 I-1.04493 J-1.61671 E0.100304
G2 X225.68197 Y67.38329 I-1.61671 J1.04493 E0.100304
G2 X225.11019 Y70.04493 I1.04493 J1.61671 E0.100304
G2 X227.77182 Y70.61671 I1.61671 J-1.04493 E0.100304
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.54967 Y176.97562 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
M204 S1000
G1 F3600
G1 X237.29620 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X221.92101 Y186.72474 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X236.94325 Y182.62596 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.74825 Y181.89821 E0.024992
G1 X236.26017 Y181.64952 E0.018171
G1 X236.66460 Y183.15887 E0.051834
G1 X236.38484 Y183.68761 E0.019843
G1 X235.77210 Y181.40084 E0.078533
G1 X235.28402 Y181.15215 E0.018171
G1 X236.10397 Y184.21224 E0.105090
G1 X235.82202 Y184.73282 E0.019639
G1 X234.79595 Y180.90346 E0.131508
G1 X234.30787 Y180.65478 E0.018171
G1 X235.53900 Y185.24943 E0.157789
G1 X235.25494 Y185.76213 E0.019443
G1 X233.81979 Y180.40609 E0.183937
G1 X233.33172 Y180.15740 E0.018171
G1 X234.96984 Y186.27094 E0.209951
G1 X234.68371 Y186.77595 E0.019254
G1 X232.84364 Y179.90872 E0.235835
G1 X232.35557 Y179.66003 E0.018171
G1 X234.39659 Y187.27723 E0.261590
G1 X234.10847 Y187.77478 E0.019072
G1 X231.86749 Y179.41134 E0.287217
G1 X231.37942 Y179.16266 E0.018171
G1 X233.81938 Y188.26871 E0.312720
G1 X233.52932 Y188.75902 E0.018898
G1 X230.89134 Y178.91397 E0.338099
G1 X230.40327 Y178.66528 E0.018171
G1 X233.23831 Y189.24579 E0.363356
G1 X232.94636 Y189.72906 E0.018729
G1 X229.91519 Y178.41660 E0.388493
G1 X229.42712 Y178.16791 E0.018171
G1 X232.65349 Y190.20888 E0.413511
G1 X232.35970 Y190.68528 E0.018567
G1 X228.93904 Y177.91922 E0.438412
G1 X228.45097 Y177.67054 E0.018171
G1 X232.06501 Y191.15832 E0.463198
G1 X231.76943 Y191.62803 E0.018409
G1 X227.96289 Y177.42185 E0.487869
G1 X227.47482 Y177.17316 E0.018171
G1 X231.47297 Y192.09447 E0.512428
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.20080 Y181.45539 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.18804 Y177.67574 E0.129801
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.77564 Y183.60072 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.15186 Y192.46893 E0.304552
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.68154 Y181.09033 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.90912 Y178.20761 E0.098998
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.50848 Y184.17651 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.64164 Y192.13758 E0.273399
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.21487 Y180.92152 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.62897 Y178.73494 E0.075092
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
G1 X226.34763 Y179.25780 E0.055216
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
G1 X226.06511 Y179.77623 E0.038451
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
G1 X225.78142 Y180.29034 E0.024467
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
G1 X225.49660 Y180.80019 E0.013268
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
G1 X225.21065 Y181.30586 E0.005195
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X226.22033 Y185.07402 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X227.58030 Y190.14953 E0.174303
G1 X227.07008 Y189.81819 E0.020181
G1 X225.75212 Y184.89948 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X224.66919 Y182.43077 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X224.63546 Y182.30487 E0.004323
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.22949 Y184.52182 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X226.55986 Y189.48684 E0.170509
G1 X226.04964 Y189.15550 E0.020181
G1 X224.34624 Y182.79835 E0.218317
G1 X224.05597 Y183.28788 E0.018879
G1 X225.53941 Y188.82416 E0.190127
G1 X225.02919 Y188.49281 E0.020181
G1 X223.76466 Y183.77352 E0.162070
G1 X223.47232 Y184.25535 E0.018695
G1 X224.51897 Y188.16147 E0.134144
G1 X224.00874 Y187.83013 E0.020181
G1 X223.17898 Y184.73340 E0.106348
G1 X222.88464 Y185.20774 E0.018518
G1 X223.49852 Y187.49879 E0.078679
G1 X222.98830 Y187.16744 E0.020181
G1 X222.58931 Y185.67840 E0.051137
G1 X222.29302 Y186.14545 E0.018348
G1 X222.47808 Y186.83610 E0.023718
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X133.62866 Y237.70035 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X122.37134 Y237.70035 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y248.62414 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X133.43210 Y248.66060 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.96485 Y248.12785 E0.024992
G1 X133.93618 Y247.58082 E0.018171
G1 X132.83127 Y248.68574 E0.051834
G1 X132.23348 Y248.70783 E0.019843
G1 X133.90752 Y247.03379 E0.078533
G1 X133.87885 Y246.48676 E0.018171
G1 X131.63871 Y248.72690 E0.105090
G1 X131.04690 Y248.74301 E0.019639
G1 X133.85018 Y245.93973 E0.131508
G1 X133.82151 Y245.39270 E0.018171
G1 X130.45799 Y248.75622 E0.157789
G1 X129.87195 Y248.76657 E0.019443
G1 X133.79284 Y244.84568 E0.183937
G1 X133.76417 Y244.29865 E0.018171
G1 X129.28876 Y248.77406 E0.209951
G1 X128.70834 Y248.77878 E0.019254
G1 X133.73550 Y243.75162 E0.235835
G1 X133.70684 Y243.20459 E0.018171
G1 X128.13066 Y248.78077 E0.261590
G1 X127.55571 Y248.78002 E0.019072
G1 X133.67817 Y242.65756 E0.287217
G1 X133.64950 Y242.11053 E0.018171
G1 X126.98340 Y248.77662 E0.312720
G1 X126.41375 Y248.77058 E0.018898
G1 X133.62083 Y241.56350 E0.338099
G1 X133.59216 Y241.01647 E0.018171
G1 X125.84669 Y248.76195 E0.363356
G1 X125.28219 Y248.75075 E0.018729
G1 X133.56349 Y240.46944 E0.388493
G1 X133.53482 Y239.92242 E0.018171
G1 X124.72022 Y248.73702 E0.413511
G1 X124.16075 Y248.72079 E0.018567
G1 X133.50616 Y239.37539 E0.438412
G1 X133.47749 Y238.82836 E0.018171
G1 X123.60374 Y248.70210 E0.463198
G1 X123.04918 Y248.68097 E0.018409
G1 X133.44882 Y238.28133 E0.487869
G1 X133.42015 Y237.73430 E0.018171
G1 X122.49700 Y248.65745 E0.512428
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X130.07462 Y240.50413 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.84152 Y237.73723 E0.129801
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X128.50413 Y242.07462 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.01215 Y248.56660 E0.304552
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X130.13115 Y239.87191 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X132.24144 Y237.76161 E0.098998
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X127.87191 Y242.13115 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.04399 Y247.95906 E0.273399
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X130.04400 Y239.38335 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X131.64469 Y237.78267 E0.075092
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
G1 X131.05121 Y237.80045 E0.055216
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
G1 X130.46097 Y237.81499 E0.038451
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
G1 X129.87390 Y237.82637 E0.024467
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
G1 X129.28994 Y237.83463 E0.013268
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
G1 X128.70905 Y237.83982 E0.005195
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X125.95056 Y240.59831 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.23503 Y244.31384 E0.174303
G1 X122.26687 Y243.70630 E0.020181
G1 X125.86761 Y240.10556 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X127.46412 Y237.93336 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X127.55628 Y237.84120 E0.004323
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X125.93336 Y239.46412 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.29871 Y243.09876 E0.170509
G1 X122.33055 Y242.49123 E0.020181
G1 X126.98431 Y237.83747 E0.218317
G1 X126.41523 Y237.83085 E0.018879
G1 X122.36239 Y241.88369 E0.190127
G1 X122.39423 Y241.27615 E0.020181
G1 X125.84899 Y237.82139 E0.162070
G1 X125.28555 Y237.80913 E0.018695
G1 X122.42607 Y240.66861 E0.134144
G1 X122.45791 Y240.06108 E0.020181
G1 X124.72487 Y237.79412 E0.106348
G1 X124.16692 Y237.77637 E0.018518
G1 X122.48975 Y239.45354 E0.078679
G1 X122.52159 Y238.84600 E0.020181
G1 X123.61164 Y237.75595 E0.051137
G1 X123.05902 Y237.73287 E0.018348
G1 X122.55343 Y238.23846 E0.023718
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X34.07899 Y186.72474 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y192.68243 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.45033 Y176.97562 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y181.94172 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X24.48885 Y192.03464 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.21661 Y192.22964 E0.024992
G1 X25.67601 Y191.93130 E0.018171
G1 X24.16667 Y191.52687 E0.051834
G1 X23.84864 Y191.02021 E0.019843
G1 X26.13542 Y191.63295 E0.078533
G1 X26.59483 Y191.33461 E0.018171
G1 X23.53474 Y190.51466 E0.105090
G1 X23.22488 Y190.01020 E0.019639
G1 X27.05423 Y191.03627 E0.131508
G1 X27.51364 Y190.73793 E0.018171
G1 X22.91899 Y189.50680 E0.157789
G1 X22.61701 Y189.00444 E0.019443
G1 X27.97305 Y190.43959 E0.183937
G1 X28.43245 Y190.14124 E0.018171
G1 X22.31892 Y188.50313 E0.209951
G1 X22.02462 Y188.00283 E0.019254
G1 X28.89186 Y189.84290 E0.235835
G1 X29.35127 Y189.54456 E0.018171
G1 X21.73406 Y187.50354 E0.261590
G1 X21.44724 Y187.00524 E0.019072
G1 X29.81067 Y189.24622 E0.287217
G1 X30.27008 Y188.94787 E0.018171
G1 X21.16403 Y186.50791 E0.312720
G1 X20.88443 Y186.01156 E0.018898
G1 X30.72949 Y188.64953 E0.338099
G1 X31.18889 Y188.35119 E0.018171
G1 X20.60838 Y185.51615 E0.363356
G1 X20.33583 Y185.02168 E0.018729
G1 X31.64830 Y188.05285 E0.388493
G1 X32.10771 Y187.75451 E0.018171
G1 X20.06674 Y184.52814 E0.413511
G1 X19.80106 Y184.03551 E0.018567
G1 X32.56711 Y187.45616 E0.438412
G1 X33.02652 Y187.15782 E0.018171
G1 X19.53874 Y183.54378 E0.463198
G1 X19.27975 Y183.05295 E0.018409
G1 X33.48593 Y186.85948 E0.487869
G1 X33.94533 Y186.56114 E0.018171
G1 X19.02403 Y182.56299 E0.512428
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X29.87383 Y185.04874 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.65348 Y186.06149 E0.129801
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.72849 Y184.47390 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.86029 Y182.09767 E0.304552
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.44961 Y184.78158 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.33233 Y185.55400 E0.098998
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.36343 Y183.95464 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.40235 Y181.82148 E0.273399
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.82914 Y184.46183 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X33.01572 Y185.04773 E0.075092
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
G1 X32.70357 Y184.54265 E0.055216
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
G1 X32.39586 Y184.03876 E0.038451
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
G1 X32.09247 Y183.53603 E0.024467
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
G1 X31.79334 Y183.03443 E0.013268
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
G1 X31.49840 Y182.53396 E0.005195
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.73023 Y181.52429 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X22.65473 Y180.16431 E0.174303
G1 X23.19679 Y179.88811 E0.020181
G1 X28.11550 Y181.20608 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.79493 Y181.50259 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X30.92082 Y181.53632 E0.004323
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.70387 Y180.94229 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X23.73885 Y179.61192 E0.170509
G1 X24.28091 Y179.33573 E0.020181
G1 X30.63807 Y181.03912 E0.218317
G1 X30.35926 Y180.54297 E0.018879
G1 X24.82298 Y179.05953 E0.190127
G1 X25.36504 Y178.78334 E0.020181
G1 X30.08433 Y180.04787 E0.162070
G1 X29.81323 Y179.55378 E0.018695
G1 X25.90710 Y178.50714 E0.134144
G1 X26.44916 Y178.23095 E0.020181
G1 X29.54589 Y179.06071 E0.106348
G1 X29.28228 Y178.56864 E0.018518
G1 X26.99123 Y177.95475 E0.078679
G1 X27.53329 Y177.67856 E0.020181
G1 X29.02233 Y178.07755 E0.051137
G1 X28.76600 Y177.58742 E0.018348
G1 X28.07535 Y177.40236 E0.023718
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.45033 Y75.02438 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X18.70380 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X34.07899 Y65.27526 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.90495 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X19.05675 Y69.37404 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X19.25175 Y70.10179 E0.024992
G1 X19.73983 Y70.35048 E0.018171
G1 X19.33540 Y68.84113 E0.051834
G1 X19.61516 Y68.31239 E0.019843
G1 X20.22790 Y70.59916 E0.078533
G1 X20.71598 Y70.84785 E0.018171
G1 X19.89603 Y67.78776 E0.105090
G1 X20.17798 Y67.26718 E0.019639
G1 X21.20405 Y71.09654 E0.131508
G1 X21.69213 Y71.34522 E0.018171
G1 X20.46100 Y66.75057 E0.157789
G1 X20.74506 Y66.23787 E0.019443
G1 X22.18021 Y71.59391 E0.183937
G1 X22.66828 Y71.84260 E0.018171
G1 X21.03016 Y65.72906 E0.209951
G1 X21.31629 Y65.22405 E0.019254
G1 X23.15636 Y72.09128 E0.235835
G1 X23.64443 Y72.33997 E0.018171
G1 X21.60341 Y64.72277 E0.261590
G1 X21.89153 Y64.22522 E0.019072
G1 X24.13251 Y72.58866 E0.287217
G1 X24.62058 Y72.83734 E0.018171
G1 X22.18062 Y63.73129 E0.312720
G1 X22.47068 Y63.24098 E0.018898
G1 X25.10866 Y73.08603 E0.338099
G1 X25.59673 Y73.33472 E0.018171
G1 X22.76169 Y62.75421 E0.363356
G1 X23.05364 Y62.27094 E0.018729
G1 X26.08481 Y73.58340 E0.388493
G1 X26.57288 Y73.83209 E0.018171
G1 X23.34651 Y61.79112 E0.413511
G1 X23.64030 Y61.31472 E0.018567
G1 X27.06096 Y74.08078 E0.438412
G1 X27.54903 Y74.32946 E0.018171
G1 X23.93499 Y60.84168 E0.463198
G1 X24.23057 Y60.37197 E0.018409
G1 X28.03711 Y74.57815 E0.487869
G1 X28.52518 Y74.82684 E0.018171
G1 X24.52703 Y59.90553 E0.512428
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.79920 Y70.54461 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.81196 Y74.32426 E0.129801
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.22436 Y68.39928 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X24.84814 Y59.53107 E0.304552
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.31846 Y70.90967 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.09088 Y73.79239 E0.098998
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X27.49152 Y67.82349 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X25.35836 Y59.86242 E0.273399
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.78513 Y71.07848 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.37103 Y73.26506 E0.075092
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
G1 X29.65237 Y72.74220 E0.055216
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
G1 X29.93489 Y72.22377 E0.038451
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
G1 X30.21858 Y71.70966 E0.024467
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
G1 X30.50340 Y71.19981 E0.013268
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
G1 X30.78935 Y70.69414 E0.005195
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X29.77967 Y66.92598 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X28.41970 Y61.85047 E0.174303
G1 X28.92992 Y62.18181 E0.020181
G1 X30.24788 Y67.10052 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X31.33081 Y69.56923 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X31.36454 Y69.69513 E0.004323
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X30.77051 Y67.47818 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X29.44014 Y62.51316 E0.170509
G1 X29.95036 Y62.84450 E0.020181
G1 X31.65376 Y69.20165 E0.218317
G1 X31.94403 Y68.71212 E0.018879
G1 X30.46059 Y63.17584 E0.190127
G1 X30.97081 Y63.50719 E0.020181
G1 X32.23534 Y68.22648 E0.162070
G1 X32.52768 Y67.74465 E0.018695
G1 X31.48103 Y63.83853 E0.134144
G1 X31.99126 Y64.16987 E0.020181
G1 X32.82102 Y67.26660 E0.106348
G1 X33.11536 Y66.79226 E0.018518
G1 X32.50148 Y64.50121 E0.078679
G1 X33.01170 Y64.83256 E0.020181
G1 X33.41069 Y66.32160 E0.051137
G1 X33.70698 Y65.85455 E0.018348
G1 X33.52192 Y65.16390 E0.023718
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X122.37134 Y14.29965 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X121.79885 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X133.62866 Y14.29965 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X134.20115 Y3.37586 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X122.56790 Y3.33940 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X122.03515 Y3.87215 E0.024992
G1 X122.06382 Y4.41918 E0.018171
G1 X123.16873 Y3.31426 E0.051834
G1 X123.76652 Y3.29217 E0.019843
G1 X122.09248 Y4.96621 E0.078533
G1 X122.12115 Y5.51324 E0.018171
G1 X124.36129 Y3.27310 E0.105090
G1 X124.95310 Y3.25699 E0.019639
G1 X122.14982 Y6.06027 E0.131508
G1 X122.17849 Y6.60730 E0.018171
G1 X125.54201 Y3.24378 E0.157789
G1 X126.12805 Y3.23343 E0.019443
G1 X122.20716 Y7.15432 E0.183937
G1 X122.23583 Y7.70135 E0.018171
G1 X126.71124 Y3.22594 E0.209951
G1 X127.29166 Y3.22122 E0.019254
G1 X122.26450 Y8.24838 E0.235835
G1 X122.29316 Y8.79541 E0.018171
G1 X127.86934 Y3.21923 E0.261590
G1 X128.44429 Y3.21998 E0.019072
G1 X122.32183 Y9.34244 E0.287217
G1 X122.35050 Y9.88947 E0.018171
G1 X129.01660 Y3.22338 E0.312720
G1 X129.58625 Y3.22942 E0.018898
G1 X122.37917 Y10.43650 E0.338099
G1 X122.40784 Y10.98353 E0.018171
G1 X130.15331 Y3.23805 E0.363356
G1 X130.71781 Y3.24925 E0.018729
G1 X122.43651 Y11.53056 E0.388493
G1 X122.46518 Y12.07758 E0.018171
G1 X131.27978 Y3.26298 E0.413511
G1 X131.83925 Y3.27921 E0.018567
G1 X122.49384 Y12.62461 E0.438412
G1 X122.52251 Y13.17164 E0.018171
G1 X132.39626 Y3.29790 E0.463198
G1 X132.95082 Y3.31903 E0.018409
G1 X122.55118 Y13.71867 E0.487869
G1 X122.57985 Y14.26570 E0.018171
G1 X133.50300 Y3.34255 E0.512428
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X125.92538 Y11.49587 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.15848 Y14.26277 E0.129801
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X127.49587 Y9.92538 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.98785 Y3.43340 E0.304552
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X125.86885 Y12.12809 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X123.75856 Y14.23839 E0.098998
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X128.12809 Y9.86885 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.95601 Y4.04094 E0.273399
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X125.95600 Y12.61665 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X124.35531 Y14.21733 E0.075092
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
G1 X124.94879 Y14.19955 E0.055216
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
G1 X125.53903 Y14.18501 E0.038451
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
G1 X126.12610 Y14.17363 E0.024467
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
G1 X126.71006 Y14.16537 E0.013268
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
G1 X127.29095 Y14.16018 E0.005195
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X130.04944 Y11.40169 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.76497 Y7.68616 E0.174303
G1 X133.73313 Y8.29370 E0.020181
G1 X130.13239 Y11.89444 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X128.53588 Y14.06664 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X128.44372 Y14.15880 E0.004323
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X130.06664 Y12.53588 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X133.70129 Y8.90124 E0.170509
G1 X133.66945 Y9.50877 E0.020181
G1 X129.01569 Y14.16253 E0.218317
G1 X129.58477 Y14.16915 E0.018879
G1 X133.63761 Y10.11631 E0.190127
G1 X133.60577 Y10.72385 E0.020181
G1 X130.15101 Y14.17861 E0.162070
G1 X130.71445 Y14.19087 E0.018695
G1 X133.57393 Y11.33139 E0.134144
G1 X133.54209 Y11.93892 E0.020181
G1 X131.27513 Y14.20588 E0.106348
G1 X131.83308 Y14.22363 E0.018518
G1 X133.51025 Y12.54646 E0.078679
G1 X133.47841 Y13.15400 E0.020181
G1 X132.38836 Y14.24405 E0.051137
G1 X132.94098 Y14.26713 E0.018348
G1 X133.44657 Y13.76154 E0.023718
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X221.92101 Y65.27526 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X231.09505 Y59.31757 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.54967 Y75.02438 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.29620 Y70.05828 E0.362859
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X231.51115 Y59.96536 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X230.78339 Y59.77036 E0.024992
G1 X230.32399 Y60.06870 E0.018171
G1 X231.83333 Y60.47313 E0.051834
G1 X232.15136 Y60.97979 E0.019843
G1 X229.86458 Y60.36705 E0.078533
G1 X229.40517 Y60.66539 E0.018171
G1 X232.46526 Y61.48534 E0.105090
G1 X232.77512 Y61.98980 E0.019639
G1 X228.94577 Y60.96373 E0.131508
G1 X228.48636 Y61.26207 E0.018171
G1 X233.08101 Y62.49320 E0.157789
G1 X233.38299 Y62.99556 E0.019443
G1 X228.02695 Y61.56041 E0.183937
G1 X227.56755 Y61.85876 E0.018171
G1 X233.68108 Y63.49687 E0.209951
G1 X233.97538 Y63.99717 E0.019254
G1 X227.10814 Y62.15710 E0.235835
G1 X226.64873 Y62.45544 E0.018171
G1 X234.26594 Y64.49646 E0.261590
G1 X234.55276 Y64.99476 E0.019072
G1 X226.18933 Y62.75378 E0.287217
G1 X225.72992 Y63.05213 E0.018171
G1 X234.83597 Y65.49209 E0.312720
G1 X235.11557 Y65.98844 E0.018898
G1 X225.27051 Y63.35047 E0.338099
G1 X224.81111 Y63.64881 E0.018171
G1 X235.39162 Y66.48385 E0.363356
G1 X235.66417 Y66.97832 E0.018729
G1 X224.35170 Y63.94715 E0.388493
G1 X223.89229 Y64.24549 E0.018171
G1 X235.93326 Y67.47186 E0.413511
G1 X236.19894 Y67.96449 E0.018567
G1 X223.43289 Y64.54384 E0.438412
G1 X222.97348 Y64.84218 E0.018171
G1 X236.46126 Y68.45622 E0.463198
G1 X236.72025 Y68.94705 E0.018409
G1 X222.51407 Y65.14052 E0.487869
G1 X222.05467 Y65.43886 E0.018171
G1 X236.97597 Y69.43701 E0.512428
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X226.12617 Y66.95126 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.34652 Y65.93851 E0.129801
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.27151 Y67.52610 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X237.13971 Y69.90233 E0.304552
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.55039 Y67.21842 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.66767 Y66.44600 E0.098998
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.63657 Y68.04536 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X236.59765 Y70.17852 E0.273399
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.17086 Y67.53817 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X222.98428 Y66.95227 E0.075092
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
G1 X223.29643 Y67.45735 E0.055216
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
G1 X223.60414 Y67.96124 E0.038451
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
G1 X223.90753 Y68.46397 E0.024467
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
G1 X224.20666 Y68.96557 E0.013268
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
G1 X224.50160 Y69.46604 E0.005195
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X228.26977 Y70.47571 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X233.34527 Y71.83569 E0.174303
G1 X232.80321 Y72.11189 E0.020181
G1 X227.88450 Y70.79392 E0.168918
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X225.20507 Y70.49741 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X225.07918 Y70.46368 E0.004323
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.29613 Y71.05771 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G1 X232.26115 Y72.38808 E0.170509
G1 X231.71909 Y72.66427 E0.020181
G1 X225.36193 Y70.96088 E0.218317
G1 X225.64074 Y71.45703 E0.018879
G1 X231.17702 Y72.94047 E0.190127
G1 X230.63496 Y73.21666 E0.020181
G1 X225.91567 Y71.95213 E0.162070
G1 X226.18677 Y72.44622 E0.018695
G1 X230.09290 Y73.49286 E0.134144
G1 X229.55084 Y73.76905 E0.020181
G1 X226.45411 Y72.93929 E0.106348
G1 X226.71772 Y73.43136 E0.018518
G1 X229.00877 Y74.04525 E0.078679
G1 X228.46671 Y74.32144 E0.020181
G1 X226.97767 Y73.92245 E0.051137
G1 X227.23400 Y74.41258 E0.018348
G1 X227.92465 Y74.59764 E0.023718
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X250.75584 Y126.00000 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.50000
M204 S1000
G1 F3000
G1 X239.71377 Y131.85467 E0.465510
G1 X250.08337 Y138.83148 E0.465510
G1 X238.48981 Y143.49987 E0.465510
G1 X248.07333 Y151.52237 E0.465510
G1 X236.05530 Y154.95333 E0.465510
G1 X244.74774 Y163.93364 E0.465510
G1 X232.43692 Y166.08958 E0.465510
G1 X240.14304 Y175.92930 E0.465510
G1 X227.67430 Y176.78659 E0.465510
G1 X227.92217 Y177.18225 E0.017390
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X222.28621 Y186.94402 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X221.81963 Y186.92718 E0.017390
G1 X227.31156 Y198.15407 E0.465510
G1 X214.93705 Y196.40023 E0.465510
G1 X219.22537 Y208.13969 E0.465510
G1 X207.10197 Y205.10197 E0.465510
G1 X210.13969 Y217.22537 E0.465510
G1 X198.40023 Y212.93705 E0.465510
G1 X200.15407 Y225.31156 E0.465510
G1 X188.92718 Y219.81963 E0.465510
G1 X189.37792 Y232.30968 E0.465510
G1 X178.78659 Y225.67430 E0.465510
G1 X177.92930 Y238.14304 E0.465510
G1 X168.08958 Y230.43692 E0.465510
G1 X165.93364 Y242.74774 E0.465510
G1 X156.95333 Y234.05530 E0.465510
G1 X153.52237 Y246.07333 E0.465510
G1 X145.49987 Y236.48981 E0.465510
G1 X140.83148 Y248.08337 E0.465510
G1 X133.85467 Y237.71377 E0.465510
G1 X133.63596 Y238.12627 E0.017390
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X122.36404 Y238.12627 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X122.14533 Y237.71377 E0.017390
G1 X115.16852 Y248.08337 E0.465510
G1 X110.50013 Y236.48981 E0.465510
G1 X102.47763 Y246.07333 E0.465510
G1 X99.04667 Y234.05530 E0.465510
G1 X90.06636 Y242.74774 E0.465510
G1 X87.91042 Y230.43692 E0.465510
G1 X78.07070 Y238.14304 E0.465510
G1 X77.21341 Y225.67430 E0.465510
G1 X66.62208 Y232.30968 E0.465510
G1 X67.07282 Y219.81963 E0.465510
G1 X55.84593 Y225.31156 E0.465510
G1 X57.59977 Y212.93705 E0.465510
G1 X45.86031 Y217.22537 E0.465510
G1 X48.89803 Y205.10197 E0.465510
G1 X36.77463 Y208.13969 E0.465510
G1 X41.06295 Y196.40023 E0.465510
G1 X28.68844 Y198.15407 E0.465510
G1 X34.18037 Y186.92718 E0.465510
G1 X33.71379 Y186.94402 E0.017390
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X28.07783 Y177.18225 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X28.32570 Y176.78659 E0.017390
G1 X15.85696 Y175.92930 E0.465510
G1 X23.56308 Y166.08958 E0.465510
G1 X11.25226 Y163.93364 E0.465510
G1 X19.94470 Y154.95333 E0.465510
G1 X7.92667 Y151.52237 E0.465510
G1 X17.51019 Y143.49987 E0.465510
G1 X5.91663 Y138.83148 E0.465510
G1 X16.28623 Y131.85467 E0.465510
G1 X5.24416 Y126.00000 E0.465510
G1 X16.28623 Y120.14533 E0.465510
G1 X5.91663 Y113.16852 E0.465510
G1 X17.51019 Y108.50013 E0.465510
G1 X7.92667 Y100.47763 E0.465510
G1 X19.94470 Y97.04667 E0.465510
G1 X11.25226 Y88.06636 E0.465510
G1 X23.56308 Y85.91042 E0.465510
G1 X15.85696 Y76.07070 E0.465510
G1 X28.32570 Y75.21341 E0.465510
G1 X28.07783 Y74.81775 E0.017390
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X33.71379 Y65.05598 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X34.18037 Y65.07282 E0.017390
G1 X28.68844 Y53.84593 E0.465510
G1 X41.06295 Y55.59977 E0.465510
G1 X36.77463 Y43.86031 E0.465510
G1 X48.89803 Y46.89803 E0.465510
G1 X45.86031 Y34.77463 E0.465510
G1 X57.59977 Y39.06295 E0.465510
G1 X55.84593 Y26.68844 E0.465510
G1 X67.07282 Y32.18037 E0.465510
G1 X66.62208 Y19.69032 E0.465510
G1 X77.21341 Y26.32570 E0.465510
G1 X78.07070 Y13.85696 E0.465510
G1 X87.91042 Y21.56308 E0.465510
G1 X90.06636 Y9.25226 E0.465510
G1 X99.04667 Y17.94470 E0.465510
G1 X102.47763 Y5.92667 E0.465510
G1 X110.50013 Y15.51019 E0.465510
G1 X115.16852 Y3.91663 E0.465510
G1 X122.14533 Y14.28623 E0.465510
G1 X122.36404 Y13.87373 E0.017390
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X133.63596 Y13.87373 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X133.85467 Y14.28623 E0.017390
G1 X140.83148 Y3.91663 E0.465510
G1 X145.49987 Y15.51019 E0.465510
G1 X153.52237 Y5.92667 E0.465510
G1 X156.95333 Y17.94470 E0.465510
G1 X165.93364 Y9.25226 E0.465510
G1 X168.08958 Y21.56308 E0.465510
G1 X177.92930 Y13.85696 E0.465510
G1 X178.78659 Y26.32570 E0.465510
G1 X189.37792 Y19.69032 E0.465510
G1 X188.92718 Y32.18037 E0.465510
G1 X200.15407 Y26.68844 E0.465510
G1 X198.40023 Y39.06295 E0.465510
G1 X210.13969 Y34.77463 E0.465510
G1 X207.10197 Y46.89803 E0.465510
G1 X219.22537 Y43.86031 E0.465510
G1 X214.93705 Y55.59977 E0.465510
G1 X227.31156 Y53.84593 E0.465510
G1 X221.81963 Y65.07282 E0.465510
G1 X222.28621 Y65.05598 E0.017390
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X227.92217 Y74.81775 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
M204 S1000
G1 F3000
G1 X227.67430 Y75.21341 E0.017390
G1 X240.14304 Y76.07070 E0.465510
G1 X232.43692 Y85.91042 E0.465510
G1 X244.74774 Y88.06636 E0.465510
G1 X236.05530 Y97.04667 E0.465510
G1 X248.07333 Y100.47763 E0.465510
G1 X238.48981 Y108.50013 E0.465510
G1 X250.08337 Y113.16852 E0.465510
G1 X239.71377 Y120.14533 E0.465510
G1 X250.75584 Y126.00000 E0.465510
G1 E-0.8 F1800
G1 Z3.800 F1200
G1 X195.19562 Y229.96496 F12000
G1 Z3.400 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X24.03504 Y193.19562 I-67.19562 J-103.96496 E5.974872
G3 X60.80438 Y22.03504 I103.96496 J-67.19562 E5.974872
G3 X231.96496 Y58.80438 I67.19562 J103.96496 E5.974872
G3 X195.19562 Y229.96496 I-103.96496 J67.19562 E5.974872
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
; CONCENTRIC_SOLID_SKIN
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X19.98834 Y97.80067 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X99.80067 Y234.01166 I108.01166 J28.19933 E5.816723
G2 X236.01166 Y154.19933 I28.19933 J-108.01166 E5.816723
G2 X156.19933 Y17.98834 I-108.01166 J-28.19933 E5.816723
G2 X19.98834 Y97.80067 I-28.19933 J108.01166 E5.816723
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X20.38222 Y97.90350 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X99.90350 Y233.61778 I107.61778 J28.09650 E5.795511
G2 X235.61778 Y154.09650 I28.09650 J-107.61778 E5.795511
G2 X156.09650 Y18.38222 I-107.61778 J-28.09650 E5.795511
G2 X20.38222 Y97.90350 I-28.09650 J107.61778 E5.795511
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X8.99796 Y94.93133 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X159.06867 Y6.99796 I119.00204 J31.06867 E6.408584
G3 X247.00204 Y157.06867 I-31.06867 J119.00204 E6.408584
G3 X96.93133 Y245.00204 I-119.00204 J-31.06867 E6.408584
G3 X8.99796 Y94.93133 I31.06867 J-119.00204 E6.408584
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X8.60409 Y94.82850 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X159.17150 Y6.60409 I119.39591 J31.17150 E6.429796
G3 X247.39591 Y157.17150 I-31.17150 J119.39591 E6.429796
G3 X96.82850 Y245.39591 I-119.39591 J-31.17150 E6.429796
G3 X8.60409 Y94.82850 I31.17150 J-119.39591 E6.429796
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.86433 Y182.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X226.24062 Y184.86257 I1.86257 J0.48627 E0.100304
G2 X228.58946 Y183.48627 I0.48627 J-1.86257 E0.100304
G2 X227.21317 Y181.13743 I-1.86257 J-0.48627 E0.100304
G2 X224.86433 Y182.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.13743 Y239.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X127.51373 Y241.86257 I1.86257 J0.48627 E0.100304
G2 X129.86257 Y240.48627 I0.48627 J-1.86257 E0.100304
G2 X128.48627 Y238.13743 I-1.86257 J-0.48627 E0.100304
G2 X126.13743 Y239.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.41054 Y182.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X28.78683 Y184.86257 I1.86257 J0.48627 E0.100304
G2 X31.13567 Y183.48627 I0.48627 J-1.86257 E0.100304
G2 X29.75938 Y181.13743 I-1.86257 J-0.48627 E0.100304
G2 X27.41054 Y182.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.41054 Y68.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X28.78683 Y70.86257 I1.86257 J0.48627 E0.100304
G2 X31.13567 Y69.48627 I0.48627 J-1.86257 E0.100304
G2 X29.75938 Y67.13743 I-1.86257 J-0.48627 E0.100304
G2 X27.41054 Y68.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.13743 Y11.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X127.51373 Y13.86257 I1.86257 J0.48627 E0.100304
G2 X129.86257 Y12.48627 I0.48627 J-1.86257 E0.100304
G2 X128.48627 Y10.13743 I-1.86257 J-0.48627 E0.100304
G2 X126.13743 Y11.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.86433 Y68.51373 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X226.24062 Y70.86257 I1.86257 J0.48627 E0.100304
G2 X228.58946 Y69.48627 I0.48627 J-1.86257 E0.100304
G2 X227.21317 Y67.13743 I-1.86257 J-0.48627 E0.100304
G2 X224.86433 Y68.51373 I-0.48627 J1.86257 E0.100304
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.85727 Y181.92057 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.44813
M204 S500
G1 F1500
G3 X72.07943 Y222.85727 I-96.85727 J-55.92057 E5.800831
G3 X31.14273 Y70.07943 I55.92057 J-96.85727 E5.800831
G3 X183.92057 Y29.14273 I96.85727 J55.92057 E5.800831
G3 X224.85727 Y181.92057 I-55.92057 J96.85727 E5.800831
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.59922 Y183.16498 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X129.20671 Y238.23987 I-96.59922 J-57.16498 E3.801541
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.79329 Y238.23987 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X31.40078 Y183.16498 I1.20671 J-112.23987 E3.801541
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.19407 Y181.07489 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X30.19407 Y70.92511 I97.80593 J-55.07489 E3.801541
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X31.40078 Y68.83502 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X126.79329 Y13.76013 I96.59922 J57.16498 E3.801541
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.20671 Y13.76013 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X224.59922 Y68.83502 I-1.20671 J112.23987 E3.801541
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.80593 Y70.92511 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X225.80593 Y181.07489 I-97.80593 J55.07489 E3.801541
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.72661 Y183.74371 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X129.64421 Y238.63956 I-96.72661 J-57.74371 E3.786658
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.35579 Y238.63956 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X31.27339 Y183.74371 I1.64421 J-112.63956 E3.786658
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X29.62917 Y180.89585 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X29.62917 Y71.10415 I98.37083 J-54.89585 E3.786658
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X31.27339 Y68.25629 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X126.35579 Y13.36044 I96.72661 J57.74371 E3.786658
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.64421 Y13.36044 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X224.72661 Y68.25629 I-1.64421 J112.63956 E3.786658
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X226.37083 Y71.10415 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X226.37083 Y180.89585 I-98.37083 J54.89585 E3.786658
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X224.94297 Y184.17125 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X129.90630 Y239.04070 I-96.94297 J-58.17125 E3.783359
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.09370 Y239.04070 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X31.05703 Y184.17125 I1.90630 J-113.04070 E3.783359
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X29.15074 Y180.86945 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X29.15074 Y71.13055 I98.84926 J-54.86945 E3.783359
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X31.05703 Y67.82875 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X126.09370 Y12.95930 I96.94297 J58.17125 E3.783359
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.90630 Y12.95930 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X224.94297 Y67.82875 I-1.90630 J113.04070 E3.783359
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X226.84926 Y71.13055 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X226.84926 Y180.86945 I-98.84926 J54.86945 E3.783359
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.21467 Y184.50579 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X130.06017 Y239.44327 I-97.21467 J-58.50579 E3.787207
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X125.93983 Y239.44327 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X30.78533 Y184.50579 I2.06017 J-113.44327 E3.787207
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X28.72516 Y180.93748 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X28.72516 Y71.06252 I99.27484 J-54.93748 E3.787207
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.78533 Y67.49421 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X125.93983 Y12.55673 I97.21467 J58.50579 E3.787207
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X130.06017 Y12.55673 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X225.21467 Y67.49421 I-2.06017 J113.44327 E3.787207
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X227.27484 Y71.06252 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X227.27484 Y180.93748 I-99.27484 J54.93748 E3.787207
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.53035 Y184.76706 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X130.12859 Y239.84729 I-97.53035 J-58.76706 E3.796699
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X125.87141 Y239.84729 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X30.46965 Y184.76706 I2.12859 J-113.84729 E3.796699
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X28.34106 Y181.08023 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X28.34106 Y70.91977 I99.65894 J-55.08023 E3.796699
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.46965 Y67.23294 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X125.87141 Y12.15271 I97.53035 J58.76706 E3.796699
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X130.12859 Y12.15271 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X225.53035 Y67.23294 I-2.12859 J113.84729 E3.796699
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X227.65894 Y70.91977 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X227.65894 Y181.08023 I-99.65894 J55.08023 E3.796699
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X225.88626 Y184.96152 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X130.11904 Y240.25275 I-97.88626 J-58.96152 E3.811341
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X125.88096 Y240.25275 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X30.11374 Y184.96152 I2.11904 J-114.25275 E3.811341
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.99470 Y181.29123 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X27.99470 Y70.70877 I100.00530 J-55.29123 E3.811341
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X30.11374 Y67.03848 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X125.88096 Y11.74725 I97.88626 J58.96152 E3.811341
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X130.11904 Y11.74725 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X225.88626 Y67.03848 I-2.11904 J114.25275 E3.811341
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.00530 Y70.70877 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X228.00530 Y181.29123 I-100.00530 J55.29123 E3.811341
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X226.28339 Y185.08747 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X130.02956 Y240.65964 I-98.28339 J-59.08747 E3.831263
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X125.97044 Y240.65964 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X29.71661 Y185.08747 I2.02956 J-114.65964 E3.831263
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.68706 Y181.57217 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X27.68706 Y70.42783 I100.31294 J-55.57217 E3.831263
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X29.71661 Y66.91253 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X125.97044 Y11.34036 I98.28339 J59.08747 E3.831263
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X130.02956 Y11.34036 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X226.28339 Y66.91253 I-2.02956 J114.65964 E3.831263
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.31294 Y70.42783 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X228.31294 Y181.57217 I-100.31294 J55.57217 E3.831263
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X226.72799 Y185.13406 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X129.84761 Y241.06798 I-98.72799 J-59.13406 E3.857292
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.15239 Y241.06798 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X29.27201 Y185.13406 I1.84761 J-115.06798 E3.857292
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.42440 Y181.93392 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X27.42440 Y70.06608 I100.57560 J-55.93392 E3.857292
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X29.27201 Y66.86594 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X126.15239 Y10.93202 I98.72799 J59.13406 E3.857292
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.84761 Y10.93202 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X226.72799 Y66.86594 I-1.84761 J115.06798 E3.857292
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.57560 Y70.06608 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X228.57560 Y181.93392 I-100.57560 J55.93392 E3.857292
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X227.23686 Y185.07224 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X129.53963 Y241.47776 I-99.23686 J-59.07224 E3.891643
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X126.46037 Y241.47776 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X28.76314 Y185.07224 I1.53963 J-115.47776 E3.891643
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.22351 Y182.40552 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X27.22351 Y69.59448 I100.77649 J-56.40552 E3.891643
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X28.76314 Y66.92776 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X126.46037 Y10.52224 I99.23686 J59.07224 E3.891643
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X129.53963 Y10.52224 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X227.23686 Y66.92776 I-1.53963 J115.47776 E3.891643
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.77649 Y69.59448 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X228.77649 Y182.40552 I-100.77649 J56.40552 E3.891643
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X227.86631 Y184.80443 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X128.99298 Y241.88898 I-99.86631 J-58.80443 E3.941757
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X127.00702 Y241.88898 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X28.13369 Y184.80443 I0.99298 J-115.88898 E3.941757
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X27.14071 Y183.08455 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X27.14071 Y68.91545 I100.85929 J-57.08455 E3.941757
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X28.13369 Y67.19557 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X127.00702 Y10.11102 I99.86631 J58.80443 E3.941757
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X128.99298 Y10.11102 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X227.86631 Y67.19557 I-0.99298 J115.88898 E3.941757
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.85929 Y68.91545 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X228.85929 Y183.08455 I-100.85929 J57.08455 E3.941757
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X228.71740 Y184.14922 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X69.85078 Y226.71740 I-100.71740 J-58.14922 E6.032016
G3 X27.28260 Y67.85078 I58.14922 J-100.71740 E6.032016
G3 X186.14922 Y25.28260 I100.71740 J58.14922 E6.032016
G3 X228.71740 Y184.14922 I-58.14922 J100.71740 E6.032016
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X229.06832 Y184.35182 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X69.64818 Y227.06832 I-101.06832 J-58.35182 E6.053033
G3 X26.93168 Y67.64818 I58.35182 J-101.06832 E6.053033
G3 X186.35182 Y24.93168 I101.06832 J58.35182 E6.053033
G3 X229.06832 Y184.35182 I-58.35182 J101.06832 E6.053033
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X229.41924 Y184.55443 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X69.44557 Y227.41924 I-101.41924 J-58.55443 E6.074050
G3 X26.58076 Y67.44557 I58.55443 J-101.41924 E6.074050
G3 X186.55443 Y24.58076 I101.41924 J58.55443 E6.074050
G3 X229.41924 Y184.55443 I-58.55443 J101.41924 E6.074050
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X229.77017 Y184.75703 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X69.24297 Y227.77017 I-101.77017 J-58.75703 E6.095067
G3 X26.22983 Y67.24297 I58.75703 J-101.77017 E6.095067
G3 X186.75703 Y24.22983 I101.77017 J58.75703 E6.095067
G3 X229.77017 Y184.75703 I-58.75703 J101.77017 E6.095067
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X230.12109 Y184.95964 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X69.04036 Y228.12109 I-102.12109 J-58.95964 E6.116084
G3 X25.87891 Y67.04036 I58.95964 J-102.12109 E6.116084
G3 X186.95964 Y23.87891 I102.12109 J58.95964 E6.116084
G3 X230.12109 Y184.95964 I-58.95964 J102.12109 E6.116084
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X230.47201 Y185.16224 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X68.83776 Y228.47201 I-102.47201 J-59.16224 E6.137100
G3 X25.52799 Y66.83776 I59.16224 J-102.47201 E6.137100
G3 X187.16224 Y23.52799 I102.47201 J59.16224 E6.137100
G3 X230.47201 Y185.16224 I-59.16224 J102.47201 E6.137100
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X230.82293 Y185.36485 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X68.63515 Y228.82293 I-102.82293 J-59.36485 E6.158117
G3 X25.17707 Y66.63515 I59.36485 J-102.82293 E6.158117
G3 X187.36485 Y23.17707 I102.82293 J59.36485 E6.158117
G3 X230.82293 Y185.36485 I-59.36485 J102.82293 E6.158117
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X231.17385 Y185.56745 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X68.43255 Y229.17385 I-103.17385 J-59.56745 E6.179134
G3 X24.82615 Y66.43255 I59.56745 J-103.17385 E6.179134
G3 X187.56745 Y22.82615 I103.17385 J59.56745 E6.179134
G3 X231.17385 Y185.56745 I-59.56745 J103.17385 E6.179134
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X231.52477 Y185.77005 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X68.22995 Y229.52477 I-103.52477 J-59.77005 E6.200151
G3 X24.47523 Y66.22995 I59.77005 J-103.52477 E6.200151
G3 X187.77005 Y22.47523 I103.52477 J59.77005 E6.200151
G3 X231.52477 Y185.77005 I-59.77005 J103.52477 E6.200151
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X231.87569 Y185.97266 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X68.02734 Y229.87569 I-103.87569 J-59.97266 E6.221168
G3 X24.12431 Y66.02734 I59.97266 J-103.87569 E6.221168
G3 X187.97266 Y22.12431 I103.87569 J59.97266 E6.221168
G3 X231.87569 Y185.97266 I-59.97266 J103.87569 E6.221168
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X232.22661 Y186.17526 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X67.82474 Y230.22661 I-104.22661 J-60.17526 E6.242185
G3 X23.77339 Y65.82474 I60.17526 J-104.22661 E6.242185
G3 X188.17526 Y21.77339 I104.22661 J60.17526 E6.242185
G3 X232.22661 Y186.17526 I-60.17526 J104.22661 E6.242185
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X232.57753 Y186.37787 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X67.62213 Y230.57753 I-104.57753 J-60.37787 E6.263201
G3 X23.42247 Y65.62213 I60.37787 J-104.57753 E6.263201
G3 X188.37787 Y21.42247 I104.57753 J60.37787 E6.263201
G3 X232.57753 Y186.37787 I-60.37787 J104.57753 E6.263201
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X232.92845 Y186.58047 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X67.41953 Y230.92845 I-104.92845 J-60.58047 E6.284218
G3 X23.07155 Y65.41953 I60.58047 J-104.92845 E6.284218
G3 X188.58047 Y21.07155 I104.92845 J60.58047 E6.284218
G3 X232.92845 Y186.58047 I-60.58047 J104.92845 E6.284218
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X233.27937 Y186.78308 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X67.21692 Y231.27937 I-105.27937 J-60.78308 E6.305235
G3 X22.72063 Y65.21692 I60.78308 J-105.27937 E6.305235
G3 X188.78308 Y20.72063 I105.27937 J60.78308 E6.305235
G3 X233.27937 Y186.78308 I-60.78308 J105.27937 E6.305235
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X233.63030 Y186.98568 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X67.01432 Y231.63030 I-105.63030 J-60.98568 E6.326252
G3 X22.36970 Y65.01432 I60.98568 J-105.63030 E6.326252
G3 X188.98568 Y20.36970 I105.63030 J60.98568 E6.326252
G3 X233.63030 Y186.98568 I-60.98568 J105.63030 E6.326252
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X233.98122 Y187.18828 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X66.81172 Y231.98122 I-105.98122 J-61.18828 E6.347269
G3 X22.01878 Y64.81172 I61.18828 J-105.98122 E6.347269
G3 X189.18828 Y20.01878 I105.98122 J61.18828 E6.347269
G3 X233.98122 Y187.18828 I-61.18828 J105.98122 E6.347269
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X234.33214 Y187.39089 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
M204 S500
G1 F1500
G3 X66.60911 Y232.33214 I-106.33214 J-61.39089 E6.368286
G3 X21.66786 Y64.60911 I61.39089 J-106.33214 E6.368286
G3 X189.39089 Y19.66786 I106.33214 J61.39089 E6.368286
G3 X234.33214 Y187.39089 I-61.39089 J106.33214 E6.368286
G1 E-0.8 F1800
G1 Z4.000 F1200
G1 X8.22472 Y94.72946 F12000
G1 Z3.600 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X159.27054 Y6.22472 I119.77528 J31.27054 E5.974872
G3 X247.77528 Y157.27054 I-31.27054 J119.77528 E5.974872
G3 X96.72946 Y245.77528 I-119.77528 J-31.27054 E5.974872
G3 X8.22472 Y94.72946 I31.27054 J-119.77528 E5.974872
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
; CONCENTRIC_SOLID_SKIN
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X226.69281 Y73.83248 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X75.83248 Y27.30719 I-98.69281 J52.16752 E5.816723
G2 X29.30719 Y178.16752 I52.16752 J98.69281 E5.816723
G2 X180.16752 Y224.69281 I98.69281 J-52.16752 E5.816723
G2 X226.69281 Y73.83248 I-52.16752 J-98.69281 E5.816723
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X226.33292 Y74.02272 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X76.02272 Y27.66708 I-98.33292 J51.97728 E5.795511
G2 X29.66708 Y177.97728 I51.97728 J98.33292 E5.795511
G2 X179.97728 Y224.33292 I98.33292 J-51.97728 E5.795511
G2 X226.33292 Y74.02272 I-51.97728 J-98.33292 E5.795511
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X236.73498 Y68.52435 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X185.47565 Y234.73498 I-108.73498 J57.47565 E6.408584
G3 X19.26502 Y183.47565 I-57.47565 J-108.73498 E6.408584
G3 X70.52435 Y17.26502 I108.73498 J-57.47565 E6.408584
G3 X236.73498 Y68.52435 I57.47565 J108.73498 E6.408584
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X237.09488 Y68.33411 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X185.66589 Y235.09488 I-109.09488 J57.66589 E6.429796
G3 X18.90512 Y183.66589 I-57.66589 J-109.09488 E6.429796
G3 X70.33411 Y16.90512 I109.09488 J-57.66589 E6.429796
G3 X237.09488 Y68.33411 I57.66589 J109.09488 E6.429796
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.42877 Y182.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X225.82731 Y181.29813 I-1.70187 J0.89958 E0.100304
G2 X225.02502 Y183.89958 I0.89958 J1.70187 E0.100304
G2 X227.62648 Y184.70187 I1.70187 J-0.89958 E0.100304
G2 X228.42877 Y182.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.70187 Y239.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X127.10042 Y238.29813 I-1.70187 J0.89958 E0.100304
G2 X126.29813 Y240.89958 I0.89958 J1.70187 E0.100304
G2 X128.89958 Y241.70187 I1.70187 J-0.89958 E0.100304
G2 X129.70187 Y239.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.97498 Y182.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X28.37352 Y181.29813 I-1.70187 J0.89958 E0.100304
G2 X27.57123 Y183.89958 I0.89958 J1.70187 E0.100304
G2 X30.17269 Y184.70187 I1.70187 J-0.89958 E0.100304
G2 X30.97498 Y182.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.97498 Y68.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X28.37352 Y67.29813 I-1.70187 J0.89958 E0.100304
G2 X27.57123 Y69.89958 I0.89958 J1.70187 E0.100304
G2 X30.17269 Y70.70187 I1.70187 J-0.89958 E0.100304
G2 X30.97498 Y68.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.70187 Y11.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X127.10042 Y10.29813 I-1.70187 J0.89958 E0.100304
G2 X126.29813 Y12.89958 I0.89958 J1.70187 E0.100304
G2 X128.89958 Y13.70187 I1.70187 J-0.89958 E0.100304
G2 X129.70187 Y11.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.42877 Y68.10042 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X225.82731 Y67.29813 I-1.70187 J0.89958 E0.100304
G2 X225.02502 Y69.89958 I0.89958 J1.70187 E0.100304
G2 X227.62648 Y70.70187 I1.70187 J-0.89958 E0.100304
G2 X228.42877 Y68.10042 I-0.89958 J-1.70187 E0.100304
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.85727 Y181.92057 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.44813
M204 S500
G1 F3600
G3 X72.07943 Y222.85727 I-96.85727 J-55.92057 E5.800831
G3 X31.14273 Y70.07943 I55.92057 J-96.85727 E5.800831
G3 X183.92057 Y29.14273 I96.85727 J55.92057 E5.800831
G3 X224.85727 Y181.92057 I-55.92057 J96.85727 E5.800831
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.59922 Y183.16498 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.20671 Y238.23987 I-96.59922 J-57.16498 E3.801541
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.79329 Y238.23987 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.40078 Y183.16498 I1.20671 J-112.23987 E3.801541
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.19407 Y181.07489 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.19407 Y70.92511 I97.80593 J-55.07489 E3.801541
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X31.40078 Y68.83502 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.79329 Y13.76013 I96.59922 J57.16498 E3.801541
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.20671 Y13.76013 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.59922 Y68.83502 I-1.20671 J112.23987 E3.801541
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.80593 Y70.92511 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.80593 Y181.07489 I-97.80593 J55.07489 E3.801541
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.72661 Y183.74371 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.64421 Y238.63956 I-96.72661 J-57.74371 E3.786658
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.35579 Y238.63956 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.27339 Y183.74371 I1.64421 J-112.63956 E3.786658
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X29.62917 Y180.89585 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.62917 Y71.10415 I98.37083 J-54.89585 E3.786658
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X31.27339 Y68.25629 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.35579 Y13.36044 I96.72661 J57.74371 E3.786658
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.64421 Y13.36044 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.72661 Y68.25629 I-1.64421 J112.63956 E3.786658
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X226.37083 Y71.10415 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.37083 Y180.89585 I-98.37083 J54.89585 E3.786658
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X224.94297 Y184.17125 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.90630 Y239.04070 I-96.94297 J-58.17125 E3.783359
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.09370 Y239.04070 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.05703 Y184.17125 I1.90630 J-113.04070 E3.783359
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X29.15074 Y180.86945 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.15074 Y71.13055 I98.84926 J-54.86945 E3.783359
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X31.05703 Y67.82875 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.09370 Y12.95930 I96.94297 J58.17125 E3.783359
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.90630 Y12.95930 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.94297 Y67.82875 I-1.90630 J113.04070 E3.783359
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X226.84926 Y71.13055 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.84926 Y180.86945 I-98.84926 J54.86945 E3.783359
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.21467 Y184.50579 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.06017 Y239.44327 I-97.21467 J-58.50579 E3.787207
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X125.93983 Y239.44327 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.78533 Y184.50579 I2.06017 J-113.44327 E3.787207
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X28.72516 Y180.93748 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.72516 Y71.06252 I99.27484 J-54.93748 E3.787207
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.78533 Y67.49421 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.93983 Y12.55673 I97.21467 J58.50579 E3.787207
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X130.06017 Y12.55673 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.21467 Y67.49421 I-2.06017 J113.44327 E3.787207
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X227.27484 Y71.06252 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.27484 Y180.93748 I-99.27484 J54.93748 E3.787207
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.53035 Y184.76706 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.12859 Y239.84729 I-97.53035 J-58.76706 E3.796699
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X125.87141 Y239.84729 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.46965 Y184.76706 I2.12859 J-113.84729 E3.796699
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X28.34106 Y181.08023 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.34106 Y70.91977 I99.65894 J-55.08023 E3.796699
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.46965 Y67.23294 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.87141 Y12.15271 I97.53035 J58.76706 E3.796699
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X130.12859 Y12.15271 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.53035 Y67.23294 I-2.12859 J113.84729 E3.796699
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X227.65894 Y70.91977 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.65894 Y181.08023 I-99.65894 J55.08023 E3.796699
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X225.88626 Y184.96152 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.11904 Y240.25275 I-97.88626 J-58.96152 E3.811341
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X125.88096 Y240.25275 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.11374 Y184.96152 I2.11904 J-114.25275 E3.811341
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.99470 Y181.29123 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.99470 Y70.70877 I100.00530 J-55.29123 E3.811341
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X30.11374 Y67.03848 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.88096 Y11.74725 I97.88626 J58.96152 E3.811341
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X130.11904 Y11.74725 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.88626 Y67.03848 I-2.11904 J114.25275 E3.811341
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.00530 Y70.70877 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.00530 Y181.29123 I-100.00530 J55.29123 E3.811341
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X226.28339 Y185.08747 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.02956 Y240.65964 I-98.28339 J-59.08747 E3.831263
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X125.97044 Y240.65964 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.71661 Y185.08747 I2.02956 J-114.65964 E3.831263
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.68706 Y181.57217 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.68706 Y70.42783 I100.31294 J-55.57217 E3.831263
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X29.71661 Y66.91253 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.97044 Y11.34036 I98.28339 J59.08747 E3.831263
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X130.02956 Y11.34036 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.28339 Y66.91253 I-2.02956 J114.65964 E3.831263
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.31294 Y70.42783 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.31294 Y181.57217 I-100.31294 J55.57217 E3.831263
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X226.72799 Y185.13406 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.84761 Y241.06798 I-98.72799 J-59.13406 E3.857292
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.15239 Y241.06798 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.27201 Y185.13406 I1.84761 J-115.06798 E3.857292
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.42440 Y181.93392 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.42440 Y70.06608 I100.57560 J-55.93392 E3.857292
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X29.27201 Y66.86594 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.15239 Y10.93202 I98.72799 J59.13406 E3.857292
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.84761 Y10.93202 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.72799 Y66.86594 I-1.84761 J115.06798 E3.857292
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.57560 Y70.06608 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.57560 Y181.93392 I-100.57560 J55.93392 E3.857292
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X227.23686 Y185.07224 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.53963 Y241.47776 I-99.23686 J-59.07224 E3.891643
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X126.46037 Y241.47776 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.76314 Y185.07224 I1.53963 J-115.47776 E3.891643
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.22351 Y182.40552 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.22351 Y69.59448 I100.77649 J-56.40552 E3.891643
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X28.76314 Y66.92776 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.46037 Y10.52224 I99.23686 J59.07224 E3.891643
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X129.53963 Y10.52224 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.23686 Y66.92776 I-1.53963 J115.47776 E3.891643
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.77649 Y69.59448 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.77649 Y182.40552 I-100.77649 J56.40552 E3.891643
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X227.86631 Y184.80443 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X128.99298 Y241.88898 I-99.86631 J-58.80443 E3.941757
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X127.00702 Y241.88898 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.13369 Y184.80443 I0.99298 J-115.88898 E3.941757
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X27.14071 Y183.08455 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.14071 Y68.91545 I100.85929 J-57.08455 E3.941757
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X28.13369 Y67.19557 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X127.00702 Y10.11102 I99.86631 J58.80443 E3.941757
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X128.99298 Y10.11102 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.86631 Y67.19557 I-0.99298 J115.88898 E3.941757
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.85929 Y68.91545 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.85929 Y183.08455 I-100.85929 J57.08455 E3.941757
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X228.71740 Y184.14922 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.85078 Y226.71740 I-100.71740 J-58.14922 E6.032016
G3 X27.28260 Y67.85078 I58.14922 J-100.71740 E6.032016
G3 X186.14922 Y25.28260 I100.71740 J58.14922 E6.032016
G3 X228.71740 Y184.14922 I-58.14922 J100.71740 E6.032016
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X229.06832 Y184.35182 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.64818 Y227.06832 I-101.06832 J-58.35182 E6.053033
G3 X26.93168 Y67.64818 I58.35182 J-101.06832 E6.053033
G3 X186.35182 Y24.93168 I101.06832 J58.35182 E6.053033
G3 X229.06832 Y184.35182 I-58.35182 J101.06832 E6.053033
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X229.41924 Y184.55443 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.44557 Y227.41924 I-101.41924 J-58.55443 E6.074050
G3 X26.58076 Y67.44557 I58.55443 J-101.41924 E6.074050
G3 X186.55443 Y24.58076 I101.41924 J58.55443 E6.074050
G3 X229.41924 Y184.55443 I-58.55443 J101.41924 E6.074050
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X229.77017 Y184.75703 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.24297 Y227.77017 I-101.77017 J-58.75703 E6.095067
G3 X26.22983 Y67.24297 I58.75703 J-101.77017 E6.095067
G3 X186.75703 Y24.22983 I101.77017 J58.75703 E6.095067
G3 X229.77017 Y184.75703 I-58.75703 J101.77017 E6.095067
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X230.12109 Y184.95964 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.04036 Y228.12109 I-102.12109 J-58.95964 E6.116084
G3 X25.87891 Y67.04036 I58.95964 J-102.12109 E6.116084
G3 X186.95964 Y23.87891 I102.12109 J58.95964 E6.116084
G3 X230.12109 Y184.95964 I-58.95964 J102.12109 E6.116084
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X230.47201 Y185.16224 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.83776 Y228.47201 I-102.47201 J-59.16224 E6.137100
G3 X25.52799 Y66.83776 I59.16224 J-102.47201 E6.137100
G3 X187.16224 Y23.52799 I102.47201 J59.16224 E6.137100
G3 X230.47201 Y185.16224 I-59.16224 J102.47201 E6.137100
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X230.82293 Y185.36485 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.63515 Y228.82293 I-102.82293 J-59.36485 E6.158117
G3 X25.17707 Y66.63515 I59.36485 J-102.82293 E6.158117
G3 X187.36485 Y23.17707 I102.82293 J59.36485 E6.158117
G3 X230.82293 Y185.36485 I-59.36485 J102.82293 E6.158117
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X231.17385 Y185.56745 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.43255 Y229.17385 I-103.17385 J-59.56745 E6.179134
G3 X24.82615 Y66.43255 I59.56745 J-103.17385 E6.179134
G3 X187.56745 Y22.82615 I103.17385 J59.56745 E6.179134
G3 X231.17385 Y185.56745 I-59.56745 J103.17385 E6.179134
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X231.52477 Y185.77005 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.22995 Y229.52477 I-103.52477 J-59.77005 E6.200151
G3 X24.47523 Y66.22995 I59.77005 J-103.52477 E6.200151
G3 X187.77005 Y22.47523 I103.52477 J59.77005 E6.200151
G3 X231.52477 Y185.77005 I-59.77005 J103.52477 E6.200151
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X231.87569 Y185.97266 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.02734 Y229.87569 I-103.87569 J-59.97266 E6.221168
G3 X24.12431 Y66.02734 I59.97266 J-103.87569 E6.221168
G3 X187.97266 Y22.12431 I103.87569 J59.97266 E6.221168
G3 X231.87569 Y185.97266 I-59.97266 J103.87569 E6.221168
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X232.22661 Y186.17526 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.82474 Y230.22661 I-104.22661 J-60.17526 E6.242185
G3 X23.77339 Y65.82474 I60.17526 J-104.22661 E6.242185
G3 X188.17526 Y21.77339 I104.22661 J60.17526 E6.242185
G3 X232.22661 Y186.17526 I-60.17526 J104.22661 E6.242185
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X232.57753 Y186.37787 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.62213 Y230.57753 I-104.57753 J-60.37787 E6.263201
G3 X23.42247 Y65.62213 I60.37787 J-104.57753 E6.263201
G3 X188.37787 Y21.42247 I104.57753 J60.37787 E6.263201
G3 X232.57753 Y186.37787 I-60.37787 J104.57753 E6.263201
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X232.92845 Y186.58047 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.41953 Y230.92845 I-104.92845 J-60.58047 E6.284218
G3 X23.07155 Y65.41953 I60.58047 J-104.92845 E6.284218
G3 X188.58047 Y21.07155 I104.92845 J60.58047 E6.284218
G3 X232.92845 Y186.58047 I-60.58047 J104.92845 E6.284218
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X233.27937 Y186.78308 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.21692 Y231.27937 I-105.27937 J-60.78308 E6.305235
G3 X22.72063 Y65.21692 I60.78308 J-105.27937 E6.305235
G3 X188.78308 Y20.72063 I105.27937 J60.78308 E6.305235
G3 X233.27937 Y186.78308 I-60.78308 J105.27937 E6.305235
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X233.63030 Y186.98568 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.01432 Y231.63030 I-105.63030 J-60.98568 E6.326252
G3 X22.36970 Y65.01432 I60.98568 J-105.63030 E6.326252
G3 X188.98568 Y20.36970 I105.63030 J60.98568 E6.326252
G3 X233.63030 Y186.98568 I-60.98568 J105.63030 E6.326252
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X233.98122 Y187.18828 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X66.81172 Y231.98122 I-105.98122 J-61.18828 E6.347269
G3 X22.01878 Y64.81172 I61.18828 J-105.98122 E6.347269
G3 X189.18828 Y20.01878 I105.98122 J61.18828 E6.347269
G3 X233.98122 Y187.18828 I-61.18828 J105.98122 E6.347269
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X234.33214 Y187.39089 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X66.60911 Y232.33214 I-106.33214 J-61.39089 E6.368286
G3 X21.66786 Y64.60911 I61.39089 J-106.33214 E6.368286
G3 X189.39089 Y19.66786 I106.33214 J61.39089 E6.368286
G3 X234.33214 Y187.39089 I-61.39089 J106.33214 E6.368286
G1 E-0.8 F1800
G1 Z4.200 F1200
G1 X237.44151 Y68.15089 F12000
G1 Z3.800 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X185.84911 Y235.44151 I-109.44151 J57.84911 E5.974872
G3 X18.55849 Y183.84911 I-57.84911 J-109.44151 E5.974872
G3 X70.15089 Y16.55849 I109.44151 J-57.84911 E5.974872
G3 X237.44151 Y68.15089 I57.84911 J109.44151 E5.974872
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
; CONCENTRIC_SOLID_SKIN
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X90.46564 Y231.13274 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45000
M204 S1000
G1 F3600
G2 X233.13274 Y163.53436 I37.53436 J-105.13274 E5.816723
G2 X165.53436 Y20.86726 I-105.13274 J-37.53436 E5.816723
G2 X22.86726 Y88.46564 I-37.53436 J105.13274 E5.816723
G2 X90.46564 Y231.13274 I105.13274 J37.53436 E5.816723
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X90.60252 Y230.74936 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G2 X232.74936 Y163.39748 I37.39748 J-104.74936 E5.795511
G2 X165.39748 Y21.25064 I-104.74936 J-37.39748 E5.795511
G2 X23.25064 Y88.60252 I-37.39748 J104.74936 E5.795511
G2 X90.60252 Y230.74936 I104.74936 J37.39748 E5.795511
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X86.64646 Y241.83018 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X12.16982 Y84.64646 I41.35354 J-115.83018 E6.408584
G3 X169.35354 Y10.16982 I115.83018 J41.35354 E6.408584
G3 X243.83018 Y167.35354 I-41.35354 J115.83018 E6.408584
G3 X86.64646 Y241.83018 I-115.83018 J-41.35354 E6.408584
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X86.50958 Y242.21356 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F3600
G3 X11.78644 Y84.50958 I41.49042 J-116.21356 E6.429796
G3 X169.49042 Y9.78644 I116.21356 J41.49042 E6.429796
G3 X244.21356 Y167.49042 I-41.49042 J116.21356 E6.429796
G3 X86.50958 Y242.21356 I-116.21356 J-41.49042 E6.429796
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.07965 Y184.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X228.53982 Y183.64725 I0.64725 J-1.81292 E0.100304
G2 X227.37414 Y181.18708 I-1.81292 J-0.64725 E0.100304
G2 X224.91397 Y182.35275 I-0.64725 J1.81292 E0.100304
G2 X226.07965 Y184.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X127.35275 Y241.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.81292 Y240.64725 I0.64725 J-1.81292 E0.100304
G2 X128.64725 Y238.18708 I-1.81292 J-0.64725 E0.100304
G2 X126.18708 Y239.35275 I-0.64725 J1.81292 E0.100304
G2 X127.35275 Y241.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.62586 Y184.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X31.08603 Y183.64725 I0.64725 J-1.81292 E0.100304
G2 X29.92035 Y181.18708 I-1.81292 J-0.64725 E0.100304
G2 X27.46018 Y182.35275 I-0.64725 J1.81292 E0.100304
G2 X28.62586 Y184.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.62586 Y70.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X31.08603 Y69.64725 I0.64725 J-1.81292 E0.100304
G2 X29.92035 Y67.18708 I-1.81292 J-0.64725 E0.100304
G2 X27.46018 Y68.35275 I-0.64725 J1.81292 E0.100304
G2 X28.62586 Y70.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X127.35275 Y13.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X129.81292 Y12.64725 I0.64725 J-1.81292 E0.100304
G2 X128.64725 Y10.18708 I-1.81292 J-0.64725 E0.100304
G2 X126.18708 Y11.35275 I-0.64725 J1.81292 E0.100304
G2 X127.35275 Y13.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.07965 Y70.81292 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S1000
G1 F2400
G2 X228.53982 Y69.64725 I0.64725 J-1.81292 E0.100304
G2 X227.37414 Y67.18708 I-1.81292 J-0.64725 E0.100304
G2 X224.91397 Y68.35275 I-0.64725 J1.81292 E0.100304
G2 X226.07965 Y70.81292 I1.81292 J0.64725 E0.100304
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.85727 Y181.92057 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.44813
M204 S500
G1 F3600
G3 X72.07943 Y222.85727 I-96.85727 J-55.92057 E5.800831
G3 X31.14273 Y70.07943 I55.92057 J-96.85727 E5.800831
G3 X183.92057 Y29.14273 I96.85727 J55.92057 E5.800831
G3 X224.85727 Y181.92057 I-55.92057 J96.85727 E5.800831
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.59922 Y183.16498 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.20671 Y238.23987 I-96.59922 J-57.16498 E3.801541
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.79329 Y238.23987 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.40078 Y183.16498 I1.20671 J-112.23987 E3.801541
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.19407 Y181.07489 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.19407 Y70.92511 I97.80593 J-55.07489 E3.801541
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X31.40078 Y68.83502 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.79329 Y13.76013 I96.59922 J57.16498 E3.801541
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.20671 Y13.76013 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.59922 Y68.83502 I-1.20671 J112.23987 E3.801541
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.80593 Y70.92511 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.80593 Y181.07489 I-97.80593 J55.07489 E3.801541
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.72661 Y183.74371 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.64421 Y238.63956 I-96.72661 J-57.74371 E3.786658
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.35579 Y238.63956 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.27339 Y183.74371 I1.64421 J-112.63956 E3.786658
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X29.62917 Y180.89585 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.62917 Y71.10415 I98.37083 J-54.89585 E3.786658
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X31.27339 Y68.25629 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.35579 Y13.36044 I96.72661 J57.74371 E3.786658
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.64421 Y13.36044 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.72661 Y68.25629 I-1.64421 J112.63956 E3.786658
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.37083 Y71.10415 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.37083 Y180.89585 I-98.37083 J54.89585 E3.786658
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X224.94297 Y184.17125 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.90630 Y239.04070 I-96.94297 J-58.17125 E3.783359
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.09370 Y239.04070 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X31.05703 Y184.17125 I1.90630 J-113.04070 E3.783359
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X29.15074 Y180.86945 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.15074 Y71.13055 I98.84926 J-54.86945 E3.783359
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X31.05703 Y67.82875 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.09370 Y12.95930 I96.94297 J58.17125 E3.783359
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.90630 Y12.95930 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X224.94297 Y67.82875 I-1.90630 J113.04070 E3.783359
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.84926 Y71.13055 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.84926 Y180.86945 I-98.84926 J54.86945 E3.783359
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.21467 Y184.50579 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.06017 Y239.44327 I-97.21467 J-58.50579 E3.787207
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X125.93983 Y239.44327 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.78533 Y184.50579 I2.06017 J-113.44327 E3.787207
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.72516 Y180.93748 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.72516 Y71.06252 I99.27484 J-54.93748 E3.787207
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.78533 Y67.49421 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.93983 Y12.55673 I97.21467 J58.50579 E3.787207
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X130.06017 Y12.55673 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.21467 Y67.49421 I-2.06017 J113.44327 E3.787207
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X227.27484 Y71.06252 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.27484 Y180.93748 I-99.27484 J54.93748 E3.787207
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.53035 Y184.76706 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.12859 Y239.84729 I-97.53035 J-58.76706 E3.796699
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X125.87141 Y239.84729 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.46965 Y184.76706 I2.12859 J-113.84729 E3.796699
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.34106 Y181.08023 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.34106 Y70.91977 I99.65894 J-55.08023 E3.796699
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.46965 Y67.23294 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.87141 Y12.15271 I97.53035 J58.76706 E3.796699
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X130.12859 Y12.15271 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.53035 Y67.23294 I-2.12859 J113.84729 E3.796699
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X227.65894 Y70.91977 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.65894 Y181.08023 I-99.65894 J55.08023 E3.796699
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X225.88626 Y184.96152 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.11904 Y240.25275 I-97.88626 J-58.96152 E3.811341
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X125.88096 Y240.25275 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X30.11374 Y184.96152 I2.11904 J-114.25275 E3.811341
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.99470 Y181.29123 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.99470 Y70.70877 I100.00530 J-55.29123 E3.811341
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X30.11374 Y67.03848 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.88096 Y11.74725 I97.88626 J58.96152 E3.811341
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X130.11904 Y11.74725 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X225.88626 Y67.03848 I-2.11904 J114.25275 E3.811341
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.00530 Y70.70877 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.00530 Y181.29123 I-100.00530 J55.29123 E3.811341
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.28339 Y185.08747 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X130.02956 Y240.65964 I-98.28339 J-59.08747 E3.831263
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X125.97044 Y240.65964 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.71661 Y185.08747 I2.02956 J-114.65964 E3.831263
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.68706 Y181.57217 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.68706 Y70.42783 I100.31294 J-55.57217 E3.831263
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X29.71661 Y66.91253 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X125.97044 Y11.34036 I98.28339 J59.08747 E3.831263
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X130.02956 Y11.34036 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.28339 Y66.91253 I-2.02956 J114.65964 E3.831263
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.31294 Y70.42783 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.31294 Y181.57217 I-100.31294 J55.57217 E3.831263
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X226.72799 Y185.13406 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.84761 Y241.06798 I-98.72799 J-59.13406 E3.857292
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.15239 Y241.06798 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X29.27201 Y185.13406 I1.84761 J-115.06798 E3.857292
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.42440 Y181.93392 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.42440 Y70.06608 I100.57560 J-55.93392 E3.857292
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X29.27201 Y66.86594 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.15239 Y10.93202 I98.72799 J59.13406 E3.857292
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.84761 Y10.93202 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X226.72799 Y66.86594 I-1.84761 J115.06798 E3.857292
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.57560 Y70.06608 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.57560 Y181.93392 I-100.57560 J55.93392 E3.857292
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X227.23686 Y185.07224 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X129.53963 Y241.47776 I-99.23686 J-59.07224 E3.891643
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X126.46037 Y241.47776 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.76314 Y185.07224 I1.53963 J-115.47776 E3.891643
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.22351 Y182.40552 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.22351 Y69.59448 I100.77649 J-56.40552 E3.891643
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.76314 Y66.92776 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X126.46037 Y10.52224 I99.23686 J59.07224 E3.891643
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X129.53963 Y10.52224 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.23686 Y66.92776 I-1.53963 J115.47776 E3.891643
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.77649 Y69.59448 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.77649 Y182.40552 I-100.77649 J56.40552 E3.891643
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X227.86631 Y184.80443 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X128.99298 Y241.88898 I-99.86631 J-58.80443 E3.941757
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X127.00702 Y241.88898 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X28.13369 Y184.80443 I0.99298 J-115.88898 E3.941757
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X27.14071 Y183.08455 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X27.14071 Y68.91545 I100.85929 J-57.08455 E3.941757
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X28.13369 Y67.19557 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X127.00702 Y10.11102 I99.86631 J58.80443 E3.941757
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X128.99298 Y10.11102 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X227.86631 Y67.19557 I-0.99298 J115.88898 E3.941757
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.85929 Y68.91545 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X228.85929 Y183.08455 I-100.85929 J57.08455 E3.941757
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X228.71740 Y184.14922 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.85078 Y226.71740 I-100.71740 J-58.14922 E6.032016
G3 X27.28260 Y67.85078 I58.14922 J-100.71740 E6.032016
G3 X186.14922 Y25.28260 I100.71740 J58.14922 E6.032016
G3 X228.71740 Y184.14922 I-58.14922 J100.71740 E6.032016
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X229.06832 Y184.35182 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.64818 Y227.06832 I-101.06832 J-58.35182 E6.053033
G3 X26.93168 Y67.64818 I58.35182 J-101.06832 E6.053033
G3 X186.35182 Y24.93168 I101.06832 J58.35182 E6.053033
G3 X229.06832 Y184.35182 I-58.35182 J101.06832 E6.053033
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X229.41924 Y184.55443 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.44557 Y227.41924 I-101.41924 J-58.55443 E6.074050
G3 X26.58076 Y67.44557 I58.55443 J-101.41924 E6.074050
G3 X186.55443 Y24.58076 I101.41924 J58.55443 E6.074050
G3 X229.41924 Y184.55443 I-58.55443 J101.41924 E6.074050
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X229.77017 Y184.75703 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.24297 Y227.77017 I-101.77017 J-58.75703 E6.095067
G3 X26.22983 Y67.24297 I58.75703 J-101.77017 E6.095067
G3 X186.75703 Y24.22983 I101.77017 J58.75703 E6.095067
G3 X229.77017 Y184.75703 I-58.75703 J101.77017 E6.095067
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X230.12109 Y184.95964 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X69.04036 Y228.12109 I-102.12109 J-58.95964 E6.116084
G3 X25.87891 Y67.04036 I58.95964 J-102.12109 E6.116084
G3 X186.95964 Y23.87891 I102.12109 J58.95964 E6.116084
G3 X230.12109 Y184.95964 I-58.95964 J102.12109 E6.116084
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X230.47201 Y185.16224 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.83776 Y228.47201 I-102.47201 J-59.16224 E6.137100
G3 X25.52799 Y66.83776 I59.16224 J-102.47201 E6.137100
G3 X187.16224 Y23.52799 I102.47201 J59.16224 E6.137100
G3 X230.47201 Y185.16224 I-59.16224 J102.47201 E6.137100
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X230.82293 Y185.36485 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.63515 Y228.82293 I-102.82293 J-59.36485 E6.158117
G3 X25.17707 Y66.63515 I59.36485 J-102.82293 E6.158117
G3 X187.36485 Y23.17707 I102.82293 J59.36485 E6.158117
G3 X230.82293 Y185.36485 I-59.36485 J102.82293 E6.158117
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X231.17385 Y185.56745 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.43255 Y229.17385 I-103.17385 J-59.56745 E6.179134
G3 X24.82615 Y66.43255 I59.56745 J-103.17385 E6.179134
G3 X187.56745 Y22.82615 I103.17385 J59.56745 E6.179134
G3 X231.17385 Y185.56745 I-59.56745 J103.17385 E6.179134
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X231.52477 Y185.77005 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.22995 Y229.52477 I-103.52477 J-59.77005 E6.200151
G3 X24.47523 Y66.22995 I59.77005 J-103.52477 E6.200151
G3 X187.77005 Y22.47523 I103.52477 J59.77005 E6.200151
G3 X231.52477 Y185.77005 I-59.77005 J103.52477 E6.200151
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X231.87569 Y185.97266 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X68.02734 Y229.87569 I-103.87569 J-59.97266 E6.221168
G3 X24.12431 Y66.02734 I59.97266 J-103.87569 E6.221168
G3 X187.97266 Y22.12431 I103.87569 J59.97266 E6.221168
G3 X231.87569 Y185.97266 I-59.97266 J103.87569 E6.221168
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X232.22661 Y186.17526 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.82474 Y230.22661 I-104.22661 J-60.17526 E6.242185
G3 X23.77339 Y65.82474 I60.17526 J-104.22661 E6.242185
G3 X188.17526 Y21.77339 I104.22661 J60.17526 E6.242185
G3 X232.22661 Y186.17526 I-60.17526 J104.22661 E6.242185
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X232.57753 Y186.37787 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.62213 Y230.57753 I-104.57753 J-60.37787 E6.263201
G3 X23.42247 Y65.62213 I60.37787 J-104.57753 E6.263201
G3 X188.37787 Y21.42247 I104.57753 J60.37787 E6.263201
G3 X232.57753 Y186.37787 I-60.37787 J104.57753 E6.263201
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X232.92845 Y186.58047 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.41953 Y230.92845 I-104.92845 J-60.58047 E6.284218
G3 X23.07155 Y65.41953 I60.58047 J-104.92845 E6.284218
G3 X188.58047 Y21.07155 I104.92845 J60.58047 E6.284218
G3 X232.92845 Y186.58047 I-60.58047 J104.92845 E6.284218
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X233.27937 Y186.78308 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.21692 Y231.27937 I-105.27937 J-60.78308 E6.305235
G3 X22.72063 Y65.21692 I60.78308 J-105.27937 E6.305235
G3 X188.78308 Y20.72063 I105.27937 J60.78308 E6.305235
G3 X233.27937 Y186.78308 I-60.78308 J105.27937 E6.305235
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X233.63030 Y186.98568 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X67.01432 Y231.63030 I-105.63030 J-60.98568 E6.326252
G3 X22.36970 Y65.01432 I60.98568 J-105.63030 E6.326252
G3 X188.98568 Y20.36970 I105.63030 J60.98568 E6.326252
G3 X233.63030 Y186.98568 I-60.98568 J105.63030 E6.326252
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X233.98122 Y187.18828 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X66.81172 Y231.98122 I-105.98122 J-61.18828 E6.347269
G3 X22.01878 Y64.81172 I61.18828 J-105.98122 E6.347269
G3 X189.18828 Y20.01878 I105.98122 J61.18828 E6.347269
G3 X233.98122 Y187.18828 I-61.18828 J105.98122 E6.347269
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X234.33214 Y187.39089 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
M204 S500
G1 F3600
G3 X66.60911 Y232.33214 I-106.33214 J-61.39089 E6.368286
G3 X21.66786 Y64.60911 I61.39089 J-106.33214 E6.368286
G3 X189.39089 Y19.66786 I106.33214 J61.39089 E6.368286
G3 X234.33214 Y187.39089 I-61.39089 J106.33214 E6.368286
G1 E-0.8 F1800
G1 Z4.400 F1200
G1 X86.37775 Y242.58281 F12000
G1 Z4.000 F1200
G1 E0.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42000
M204 S500
G1 F2400
; ANALYTIC_ROLLING_SURFACE_START
G3 X11.41719 Y84.37775 I41.62225 J-116.58281 E5.974872
G3 X169.62225 Y9.41719 I116.58281 J41.62225 E5.974872
G3 X244.58281 Y167.62225 I-41.62225 J116.58281 E5.974872
G3 X86.37775 Y242.58281 I-116.58281 J-41.62225 E5.974872
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

