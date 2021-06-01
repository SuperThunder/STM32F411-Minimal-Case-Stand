//include our parameters file
//"include <filename> acts as if the contents of the included file were written in the including file"
//allowing us to use the variables as if they were defined here
include <BlackPill_F411_ProtoCase_params.scad>

//The case
translate([0,0,full_height/2]) blackpill_f411_protocase();

//The legs. Rotate 90 degrees in the slicer before printing.
translate([45, 0, full_height/2]) blackpill_f411_protocase_leg();

module blackpill_f411_protocase()
{
    pin_width_margin = 0.3; //0.3 larger on each side
    pin_length_margin = 0.4;
    
    union()
    {
        difference()
        {
            //main box
            cube([full_length, full_width, full_height], center=true);
            
            //main cutout for board
            translate([0,0,base_thickness]) cube([inner_length, inner_width, inner_height], center=true);
            
            //cutout for left row of pins
            //The cutout are little larger than the actual dimensions to give some margin for printing error
            translate([-(board_length-pin_row_length-pin_length_margin)/2+1.6,-pin_row_width_separation/2-pin_row_width/2-pin_width_margin,-base_thickness]) cube([pin_row_length+pin_length_margin*2, pin_row_width+pin_width_margin*2, inner_height], center=true);
            
            //cutout for right row of pins
            translate([-(board_length-pin_row_length-pin_length_margin)/2+1.6,pin_row_width_separation/2+pin_row_width/2+pin_width_margin,-base_thickness]) cube([pin_row_length+pin_length_margin*2, pin_row_width+pin_width_margin*2, inner_height], center=true);
            
            //USB cutout
            translate([full_length/2,0,base_thickness]) cube([wall_thickness*2, usb_width, inner_height], center=true);
            
            //SWD cutout
            translate([-full_length/2,0,base_thickness]) cube([wall_thickness*2, swd_width, inner_height], center=true);
        }
        
        //top mount points for legs
        translate([full_length/2+10/2,0,-pcb_max_clearance_bottom/2]) leg_mount_points(4,10, 4);
        
        //bottom mount points for legs
        translate([-full_length/2-10/2,0,-pcb_max_clearance_bottom/2]) leg_mount_points(4,10,4);
        
        //top ledge
        translate([inner_length/2-wall_thickness*2, 0, -pcb_max_clearance_bottom/2-0.35]) cube([wall_thickness*3, inner_length/5, pcb_max_clearance_bottom], center=true);
        
        //bottom ledge
        translate([-inner_length/2 + swd_joint_dist_from_bottom, 0, -pcb_max_clearance_bottom/2 - 0.35]) cube([wall_thickness*2, inner_length/5, pcb_max_clearance_bottom], center=true);
        
    }
   
    
}

module leg_mount_points(mount_width, mount_length, mount_height)
{
    
    translate([0, 0, 0]) union()
    {
        //left
        translate([0,full_width/2-mount_width/2,-mount_height/2+base_thickness/2-0.35]) cube([mount_length, mount_width, mount_height],center=true);
        
        //right
         translate([0,-full_width/2+mount_width/2,-mount_height/2+base_thickness/2-0.35]) cube([mount_length, mount_width, mount_height],center=true);
    }
}


module blackpill_f411_protocase_leg()
{   
    port_cutout_height = 5.1;
    
    mount_height = 4 + 0.2;
    mount_width = 5;
    mount_length = 4 + 0.4;
    
    frame_w = full_width*1.2;
    frame_h = full_height+base_thickness/2;
    
    union()
    {
        //portion that couples with case
        difference()
        {
            //start with a general size of the portion that couples to the case
            cube([4, frame_w, frame_h], center=true);
            
            //mount points to case
            translate([0,0,0]) leg_mount_points(mount_length, mount_width, mount_height);
            
            //port cutout
            translate([0,0,1+port_cutout_height/2]) cube([4,swd_width,port_cutout_height*2], center=true);
        }
        
        //legs
        translate([0, -frame_w/3-5, 0]) diag_leg();
        
        translate([0, frame_w/3+5, 0]) mirror([0,1,0]) diag_leg();
        
        //upper bar and board retainer
        retainer_w = (full_width - swd_width)/2;
        retainer_h = 2;
        //left
        //translate([0,-(full_width*1.2)/3,5]) cube([4, 6, 2], center=true);
        //translate([-5, -(full_width)/2+retainer_w/2, frame_h/2+retainer_h/2]) cube([full_length/4, retainer_w, retainer_h],center=true);
        
        //right
        //translate([0,full_width/3+0.93,5]) cube([4, 6, 2], center=true);
        //translate([-5, (full_width)/2-retainer_w/2, frame_h/2+retainer_h/2]) cube([full_length/4, retainer_w, retainer_h], center=true);
    }
    
}

module diag_leg()
{
    cube_dim = 4;
    vertical_drop = 30;
    horizontal_dist = 10;
    
    union()
    {
        hull()
        {   
            cube([cube_dim, cube_dim, cube_dim], center=true);
            
            translate([0, -horizontal_dist, -vertical_drop]) cube([cube_dim, cube_dim, cube_dim], center=true);
         
        }
        
        //foot
        //translate([cube_dim/2, -horizontal_dist-cube_dim/2, -vertical_drop]) cube([2*cube_dim, 3*cube_dim, cube_dim], center=true);
        translate([-cube_dim/2, -horizontal_dist-cube_dim/2, -vertical_drop]) cube([2*cube_dim, 2*cube_dim, cube_dim], center=true);
        
        //retaining strips for board
        //left
        
        //right
        
    }
    
}