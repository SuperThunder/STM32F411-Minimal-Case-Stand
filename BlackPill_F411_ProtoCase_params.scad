//Board parameters
board_length = 52.8;
board_width = 20.7;
pcb_thickness = 1.5;
pcb_max_clearance_top = 4.0; //max height of components on top of PCB
pcb_max_clearance_bottom = 1.1; //height of components on bottom of PCB
pcb_wall_margin = 0.15; //margin from edge of PCB to any walls

pin_row_length = 50.7;
pin_row_width = 2.4;
pin_length = 0.5;
pin_width = 0.6;
pin_plastic_height = 2.8;
pin_row_width_separation = 12.6;
pin_row_dist_from_bottom = 2;

wall_thickness = 1.6;
base_thickness = 1.6;

//ledge_protrusion = 3.0;

swd_header_protrusion = 3.0;
swd_joint_dist_from_bottom = 1.5;
swd_width = 12.0;

usb_width = 11;


//Calculated parameters
inner_height = pcb_thickness + pcb_max_clearance_top + pcb_max_clearance_bottom;
inner_length = board_length + pcb_wall_margin*2;
inner_width = board_width + pcb_wall_margin*2;

full_length = inner_length + wall_thickness*2;
full_width =  inner_width + wall_thickness*2;
full_height = base_thickness + inner_height;